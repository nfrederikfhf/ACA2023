package ChiselRISC.stages
import chisel3._
import chiseltest._
import ChiselRISC.stages._
import org.scalatest.flatspec.AnyFlatSpec
class IFSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "check instruction can be fetched" in {
    test(new IF(32, 100)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val inst1 = "h00108093".U // addi x1, x1, 1
      val inst2 = "h00110113".U // addi x2, x2, 1
      val inst3 = "h002081b3".U // add x3, x1, x2
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.writeData.poke(inst1)
      dut.clock.step(1)
      dut.io.memIO.writeData.poke(inst2)
      dut.clock.step(1)
      dut.io.memIO.writeData.poke(inst3)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(false.B)
      dut.io.startPC.poke(true.B)
      dut.clock.step(1)
      dut.io.out.inst.expect(inst1)
      dut.io.out.pc.expect(0.U)
      dut.clock.step(1)
      dut.io.out.inst.expect(inst2)
      dut.io.out.pc.expect(4.U)
      dut.clock.step(1)
      dut.io.out.inst.expect(inst3)
      dut.io.out.pc.expect(8.U)
    }
  }
}
