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

  it should "generate the correct immediate value for the ST instruction" in {
    test(new ImmGenerator(32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.imm.poke("h0000_0000".U) // ST opcode with immediate value 0x00000000
      dut.io.immediate.expect("h0000_0000".U) // expected sign-extended immediate value 0x00000000
      dut.io.imm.poke("hFFFF_FFFF".U) // ST opcode with immediate value 0xFFFFFFFF
      dut.io.immediate.expect("hFFFF_FFFF".U) // expected sign-extended immediate value 0xFFFFFFFF


      dut.io.imm.poke("b00000110000011100000001000000000".U) // opcode=ST, rs1=6, rs2=7, offset=1234
      dut.clock.step(1)
      dut.io.immediate.expect("h000004D2".U) // positive offset=1234, sign-extended to 32 bits

      dut.io.imm.poke("b00000110000011100000001000000000".U) // opcode=ST, rs1=6, rs2=7, offset=-1234
      dut.clock.step(1)
      dut.io.immediate.expect("hFFFFFB2E".U) // negative offset=-1234, sign-extended to 32 bits



    }
  }

  it should "generate the correct immediate value for the BR instruction" in {
    test(new ImmGenerator(32)) { dut =>
      dut.io.imm.poke("b00011100001100000000010000000000".U) // opcode=BR, rs1=7, rs2=6, offset=1234
      dut.clock.step(1)
      dut.io.immediate.expect("h000004D2".U) // positive offset=1234, sign-extended to 32 bits

      dut.io.imm.poke("b00011100001100000000010000000000".U) // opcode=BR, rs1=7, rs2=6, offset=-1234
      dut.clock.step(1)
      dut.io.immediate.expect("hFFFFFB2E".U) // negative offset=-1234, sign-extended to 32 bits
    }
  }

}
