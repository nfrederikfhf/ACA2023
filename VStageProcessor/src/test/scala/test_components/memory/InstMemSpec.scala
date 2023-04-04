package memory

import chisel3._
import chiseltest._
import components.memory.InstructionMemory
import org.scalatest.flatspec.AnyFlatSpec
/**
* This is a test suite for the InstructionMemory module.
* It tests the functionality of the module by writing and reading data to and from the memory.
 */
class InstMemSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "store and retrieve instructions correctly" in {
    test(new InstructionMemory(1000, 32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Write some data to the memory
      for (i <- 0 until dut.actualDepth) {
        dut.io.writeMem.valid.poke(true.B)
        dut.io.writeMem.bits.poke(i.U(32.W))
        dut.clock.step(1)
        dut.io.writeMem.valid.poke(false.B)
        dut.clock.step(1)
      }

      // Read some data from the memory
      for (i <- 0 until dut.actualDepth) {
        var j= i * 4
        dut.io.memIO.Response.nonEmpty.expect(true.B)
        dut.io.memIO.Request.addr.poke((j.U(32.W)))
        dut.clock.step(1)
        dut.io.memIO.Request.valid.poke(true.B)
        dut.io.memIO.Response.data.expect(i.U(32.W))
        dut.clock.step(1)
        dut.io.memIO.Request.valid.poke(false.B)
        dut.io.memIO.Response.data.expect(0.U(32.W))
        dut.clock.step(1)
      }

    }
  }
  it should "not allow reading from empty memory" in {
    test(new InstructionMemory(1000,32) {dut =>
      // Try to read from an empty memory
      dut.io.memIO.Request.addr.poke((1.U(32.W)))
      dut.clock.step(1)
      dut.io.memIO.Response.ready.expect(false.B)
    })
  }
}