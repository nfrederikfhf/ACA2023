package test_components
import chisel3._
import chiseltest._
import components.RegisterFile
import org.scalatest.flatspec.AnyFlatSpec

class RegisterFileTest extends AnyFlatSpec with ChiselScalatestTester{
  it should "check if address 0x0000 0000 is always 0" in {
    test(new RegisterFile(5, 32)) { dut =>
      dut.io.wrAddr.poke(0.U)
      dut.io.wren.poke(true)
      dut.io.wrData.poke("h_dead_beef".U)
      dut.clock.step(1)
      dut.io.rdAddr1.poke(0.U)
      dut.io.rden.poke(true)
      dut.clock.step(1)
      dut.io.rdData1.expect(0.U)
    }
  }
}
