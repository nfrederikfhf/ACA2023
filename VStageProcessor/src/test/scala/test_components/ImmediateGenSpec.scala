package test_components
import chisel3.util._
import chisel3._
import chiseltest._
import components.ImmGenerator
import components.memory.InstructionMemory
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.must.Matchers
// TODO: Add more complex tests for the immediate generator
class ImmediateGenSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "generate the correct immediate value for the LUI instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.imm.poke("b10000001000000000000000000110111".U) // LUI instruction
      dut.clock.step(1)
      dut.io.immediate.expect("b10000001000000000000000000000000".U)
    }
  }

  it should "generate the correct immediate value for the ADDI and an unknown instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.imm.poke("b00000000000010110000111110010011".U) // OP.ADDI
      dut.clock.step(1)
      dut.io.immediate.expect("b00000000000000000000000000000000".U)

      dut.io.imm.poke("hfeedf00f".U) // OP.UNKNOWN (should default to immI)
      dut.clock.step(1)
      dut.io.immediate.expect("b11111111111111111111111111101110".U)
    }
  }

  it should "generate the correct immediate value for the AUIPC instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.imm.poke("hA1234517".U) // Set opcode to 0010111 (AUIPC)
      dut.clock.step(1)
      dut.io.immediate.expect("hA1234000".U)
    }
  }

  it should "generate the correct immediate value for the JAL instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      // Set the input to the ImmGenerator module
      dut.io.imm.poke("b00000000010011010010000001101111".U)
      dut.clock.step(1)
      dut.io.immediate.expect("b00000000000011010010000000000100".U)
    }
  }

}
