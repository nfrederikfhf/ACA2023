package test_components
import chisel3._
import chiseltest._
import components._
import utilities._
import org.scalatest.flatspec.AnyFlatSpec
class DecoderSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if decoder sets correct control values for BEQ instruction" in {
    test(new Decoder(32, 5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.inInst.poke("h10812063".U)
      dut.io.ctrl.useImm.expect(true.B)
      dut.io.ctrl.branch.expect(true.B)
      dut.io.ctrl.load.expect(false.B)
      dut.io.ctrl.store.expect(false.B)
      dut.io.ctrl.useALU.expect(false.B)
      dut.io.ctrl.addToPC.expect(false.B)
    }
  }

  it should "decode an ADDI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00A38393".U) // ADDI x7, x7, 10
      dut.clock.step(1)
      dut.io.ctrl.useALU.expect(true.B)
      dut.io.ctrl.useImm.expect(true.B)
      dut.io.aluOp.expect(1.U)
      dut.io.rs1.expect(7.U)
      dut.io.rs2.expect(10.U)
      dut.io.rd.expect(7.U)
    }
  }

}