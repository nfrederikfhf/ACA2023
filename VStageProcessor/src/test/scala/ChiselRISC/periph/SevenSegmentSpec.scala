package ChiselRISC.periph

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SevenSegmentSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "display correctly" in {
    test(new SevenSegment).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.in.poke(12345.U)
      dut.clock.step(100)
      dut.io.seg.expect("b0110000".U)
      dut.io.an.expect("b0111".U)
      dut.clock.step(200)
    }
  }
}
