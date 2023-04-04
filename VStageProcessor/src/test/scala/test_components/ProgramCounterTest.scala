package test_components
import chisel3._
import chiseltest._
import components.ProgramCounter
import org.scalatest.flatspec.AnyFlatSpec

class ProgramCounterTest extends AnyFlatSpec with ChiselScalatestTester{
  it should "(PC) take inputs and output the same address one cycle later" in {
    test(new ProgramCounter(32)) { dut =>
      dut.io.memIO.Request.addr.expect(0)
      dut.io.in.poke(4.U)
      dut.io.memIO.Response.ready.poke(false.B)
      dut.io.memIO.Request.valid.expect(false.B)
      dut.clock.step(1)
      dut.io.memIO.Response.ready.poke(true.B)
      dut.io.memIO.Request.valid.expect(true.B)
      dut.io.memIO.Request.addr.expect(4)
      dut.io.in.poke(8.U)
      dut.clock.step(1)
      dut.io.memIO.Response.ready.poke(true.B)
      dut.io.memIO.Request.valid.expect(true.B)
      dut.io.memIO.Request.addr.expect(8)
    }
  }
}
