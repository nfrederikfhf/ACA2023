package memory

import chisel3._
import chiseltest._
import com.carlosedp.riscvassembler.RISCVAssembler
import ChiselRISC.components.memory.InstructionMemoryCircBuf
import org.scalatest.flatspec.AnyFlatSpec
import ChiselRISC.utilities.helperFunctions.FillInstructionMemory
import ChiselRISC.utilities._

/**
 * This is a test suite for the InstructionMemory module.
 * It tests the functionality of the module by writing and reading data to and from the memory.
 */
class InstMemSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "store and retrieve instructions correctly" in {
    test(new InstructionMemoryCircBuf(100, 32)) { dut =>
      // Write some data to the memory
      for (i <- 0 until dut.actualDepth) {
        dut.io.writer.ready.poke(true.B)
        dut.io.writer.data.poke(i.U(32.W))
        dut.clock.step(1)
        dut.io.writer.ready.poke(false.B)
        dut.clock.step(1)
      }

      // Read some data from the memory
      for (i <- 0 until dut.actualDepth - 1) {
        var j = i * 4
        dut.io.memIO.nonEmpty.expect(false.B)
        dut.io.memIO.addr.poke((j.U(32.W)))
        dut.clock.step(1)
        dut.io.memIO.valid.poke(true.B)
        dut.io.memOut.expect(i.U(32.W))
        dut.clock.step(1)
        dut.io.memIO.valid.poke(false.B)
        dut.io.memOut.expect(0.U(32.W))
        dut.clock.step(1)
      }

    }
  }
  it should "not allow reading from empty memory" in {
    test(new InstructionMemoryCircBuf(100, 32)) { dut =>
      // Try to read from an empty memory
      dut.io.memIO.addr.poke((1.U(32.W)))
      dut.clock.step(1)
      dut.io.memIO.nonEmpty.expect(true.B)
    }
  }

  it should "fill instruction memory with a program and the expected output is correct" in {
    test(new InstructionMemoryCircBuf(100, 32)) { dut =>
      val input =
        """
                     addi x0, x0, 0
                     addi x1, x1, 1
                     addi x2, x2, 2
                  """
      val instructions = RISCVAssembler.fromString(input.stripMargin)
      val instructionsArray = instructions.split("\n")
      for (i <- 0 until instructionsArray.length) {
        instructionsArray(i) = "h" + instructionsArray(i)
      }
      FillInstructionMemory(input, dut.clock, dut.io.writer)
      dut.io.memIO.nonEmpty.expect(false.B)

      for (i <- 0 until instructionsArray.length) {
        var j = i * 4
        dut.io.memIO.nonEmpty.expect(false.B)
        dut.io.memIO.addr.poke((j.U(32.W)))
        dut.clock.step(1)
        dut.io.memIO.valid.poke(true.B)
        dut.io.memOut.expect(instructionsArray(i).U(32.W))
        dut.clock.step(1)
        dut.io.memIO.valid.poke(false.B)
        dut.io.memOut.expect(0.U(32.W))
        dut.clock.step(1)
      }
    }
  }

}