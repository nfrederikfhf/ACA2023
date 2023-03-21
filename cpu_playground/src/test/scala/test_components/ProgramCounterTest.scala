package test_components
import chisel3._
import chiseltest._
import components.ProgramCounter
import org.scalatest.flatspec.AnyFlatSpec

class ProgramCounterTest extends AnyFlatSpec with ChiselScalatestTester{
  it should "check if address 0x0000 0000 is always 0" in {
    test(new ProgramCounter(32)) { dut =>
      dut.io.data_rdEnable.poke(true.B)
      dut.io.data_rd.poke(42.U)
      dut.io.data_wr.ready.poke(false.B)
      dut.io.data_wr.valid.expect(false.B)
      dut.clock.step(1)
      dut.io.data_wr.ready.poke(true.B)
      dut.io.data_wr.valid.expect(true.B)
      dut.io.data_wr.bits.expect(42)

    }
  }
}
