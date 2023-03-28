package test_components
import chisel3._
import chiseltest._
import components.ProgramCounter
import org.scalatest.flatspec.AnyFlatSpec

class ProgramCounterTest extends AnyFlatSpec with ChiselScalatestTester{
  it should "check if address 0x0000 0000 is always 0" in {
    test(new ProgramCounter(32)) { dut =>
      dut.io.in.poke(42.U)
      dut.io.memIO.Response.ready.poke(false.B)
      dut.io.memIO.Request.valid.expect(false.B)
      dut.clock.step(1)
      dut.io.memIO.Response.ready.poke(true.B)
      dut.io.memIO.Request.valid.expect(true.B)
      dut.io.memIO.Request.writeData.expect(42)

    }
  }
}
