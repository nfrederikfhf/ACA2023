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
    test(new ImmGenerator(32)) { dut =>
      dut.io.immIn.poke("b10000001000000000000000000110111".U) // LUI instruction
      dut.clock.step(1)
      dut.io.immOut.expect("b10000001000000000000000000000000".U)
    }
  }

  it should "generate the correct immediate value for the ADDI and an unknown instruction" in {
    test(new ImmGenerator(32)) { dut =>

      dut.io.immIn.poke("b00000000000010110000111110010011".U) // OP.ADDI
      dut.clock.step(1)
      dut.io.immOut.expect("b00000000000000000000000000000000".U)

      dut.io.immIn.poke("hfeedf00f".U) // OP.UNKNOWN (should default to immI)
      dut.clock.step(1)
      dut.io.immOut.expect("b11111111111111111111111111101110".U)
    }
  }

  it should "generate the correct immediate value for the AUIPC instruction" in {
    test(new ImmGenerator(32)) { dut =>

      dut.io.immIn.poke("hA1234517".U) // Set opcode to 0010111 (AUIPC)
      dut.clock.step(1)
      dut.io.immOut.expect("hA1234000".U)
    }
  }

  it should "generate the correct immediate value for the JAL instruction" in {
    test(new ImmGenerator(32)) { dut =>

      // Set the input to the ImmGenerator module
      dut.io.immIn.poke("b00000000010011010010000001101111".U)
      dut.clock.step(1)
      dut.io.immOut.expect("b00000000000011010010000000000100".U)
    }
  }

  it should "generate the correct immediate value for the SW instruction" in {
    test(new ImmGenerator(32)) { dut =>
      dut.io.immIn.poke("h81234523".U) // opcode=SW
      dut.clock.step(1)
      dut.io.immOut.expect("hFFFFF80A".U)  // Expected negative value

      dut.io.immIn.poke("h1234523".U) // opcode=SW
      dut.clock.step(1)
      dut.io.immOut.expect("h000000A".U) // Expected positive value



    }
  }

  it should "generate the correct immediate value for the BR instruction" in {
    test(new ImmGenerator(32)) { dut =>
      dut.io.immIn.poke("h10812063".U) // opcode=BEQ
      dut.clock.step(1)
      dut.io.immOut.expect("h0000100".U) // Expected positive value

      dut.io.immIn.poke("h90812063".U) // opcode=BEQ
      dut.clock.step(1)
      dut.io.immOut.expect("hFFFFF100".U) // Expected negative value
    }
  }

}
