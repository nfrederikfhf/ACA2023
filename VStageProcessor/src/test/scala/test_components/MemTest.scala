package test_components
import chisel3._
import chiseltest._
import components.memory.DualReadMem
import org.scalatest.flatspec.AnyFlatSpec
class MemTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if address 0x0000 0000 is always 0" in {
    test(new DualReadMem(32, 32)) { dut =>
      dut.io.wrAddr.poke(0.U)
      dut.io.wren.poke(true.B)
      dut.io.wrData.poke("h_dead_beef".U)
      dut.clock.step(1)
      dut.io.rdAddr1.poke(0.U)
      dut.io.rden.poke(true.B)
      dut.clock.step(1)
      dut.io.rdData1.expect(0.U)
    }
  }
  it should "Write and read from memory address 0x0000 0001" in {
    test(new DualReadMem(32, 32)) { dut =>
      println("addr 0x0000 0001 is: " + dut.io.rdData1.peek())
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke(1234.U)
      println("addr 0x0000 0001 is: " + dut.io.rdData1.peek())
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(1.U)
      dut.clock.step(1)
      println("addr 0x0000 0001 is: " + dut.io.rdData1.peek())
      dut.io.rdData1.expect(1234.U)
    }
  }
}
