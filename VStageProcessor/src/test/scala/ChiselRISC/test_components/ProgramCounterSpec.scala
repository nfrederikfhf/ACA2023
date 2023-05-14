package ChiselRISC.test_components

import chisel3._
import chiseltest._
import ChiselRISC.components.ProgramCounter
import org.scalatest.flatspec.AnyFlatSpec

class ProgramCounterSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "(PC) take inputs and output the same address one cycle later" in {
    test(new ProgramCounter(32)) { dut =>
      dut.io.memIO.addr.expect(0)
      dut.io.in.poke(4.U)
      dut.io.memIO.ready.poke(false.B)
      dut.io.memIO.valid.expect(false.B)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.valid.expect(true.B)
      dut.io.memIO.addr.expect(4)
      dut.io.in.poke(8.U)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.valid.expect(true.B)
      dut.io.memIO.addr.expect(8)
    }
  }
}
