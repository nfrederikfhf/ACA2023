package test_components
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
  it should "generate the correct immediate value for the SLTI instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>

      dut.io.imm.poke(0x00001593.U) // SLTI x1, x0, 21
      dut.clock.step(1)
      dut.io.immediate.expect(21.U)
    }
  }


}
