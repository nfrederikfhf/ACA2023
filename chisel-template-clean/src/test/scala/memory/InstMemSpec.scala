package memory

import chisel3._
import chiseltest._
import memory.InstructionMemory
import org.scalatest.flatspec.AnyFlatSpec

class InstMemSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "store and retrieve instructions correctly" in {
    test(new InstructionMemory(1000, 32)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Write some data to the memory
      for (i <- 0 until dut.actualDepth) {
        dut.io.writeMem.valid.poke(true.B)
        dut.io.writeMem.bits.poke(i.U(dut.bitwidth.W))
        dut.clock.step(1)
        dut.io.writeMem.valid.poke(false.B)
        dut.clock.step(1)
      }

      // Read some data from the memory
      for (i <- 0 until dut.actualDepth) {
        dut.io.inst.ready.poke(true.B)
        dut.io.rdAdd.ready.expect(true.B)
        dut.io.rdAdd.bits.poke((i.U(dut.bitwidth.W)))
        dut.clock.step(1)
        dut.io.rdAdd.valid.poke(true.B)
        dut.io.inst.ready.poke(true.B)
        dut.io.inst.valid.expect(true.B)
        dut.io.inst.bits.expect(i.U(dut.bitwidth.W))
        dut.clock.step(1)
        dut.io.rdAdd.valid.poke(false.B)
        dut.io.inst.valid.expect(false.B)
        dut.io.inst.bits.expect(0.U(dut.bitwidth.W))
        dut.clock.step(1)
      }

    }
  }
  it should "not allow reading from empty memory" in {
    test(new InstructionMemory(1000,32) {dut =>
      // Try to read from an empty memory
      dut.io.inst.ready.poke(true.B)
      dut.io.rdAdd.bits.poke((1.U(dut.bitwidth.W)))
      dut.clock.step(1)
      dut.io.rdAdd.ready.expect(false.B)
    })
  }
}