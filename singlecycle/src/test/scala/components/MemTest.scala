package components

import chisel3._
import chiseltest._
import components.DualReadMem
import org.scalatest.flatspec.AnyFlatSpec

class MemTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if address 0x0000 0000 is always 0" in {
    test(new DualReadMem()) { dut =>
      dut.io.writeAddress.poke(0.U)
      dut.io.writeData.poke("h_dead_beef".U)
      dut.clock.step(1)
      dut.io.readAddress1.poke(0.U)
      dut.clock.step(1)
      dut.io.readData1.expect(0.U)
    }
  }
  it should "Write and read from memory address 0x0000 0001" in {
    test(new DualReadMem()) { dut =>
      println("addr 0x0000 0001 is: " + dut.io.readData1.peek())
      dut.io.writeEnable.poke(true)
      dut.io.writeAddress.poke(1.U)
      dut.io.writeData.poke(1234.U)
      println("addr 0x0000 0001 is: " + dut.io.readData1.peek())
      dut.clock.step(1)
      dut.io.writeEnable.poke(false)
      dut.io.readEnable1.poke(true)
      dut.io.readAddress1.poke(1.U)
      dut.clock.step(1)
      println("addr 0x0000 0001 is: " + dut.io.readData1.peek())
      dut.io.readData1.expect(1234.U)
    }
  }
}
