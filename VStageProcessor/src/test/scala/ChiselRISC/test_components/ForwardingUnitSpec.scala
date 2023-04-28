package ChiselRISC.test_components

import chisel3._
import chiseltest._
import ChiselRISC.components._
import ChiselRISC.utilities._
import org.scalatest.flatspec.AnyFlatSpec

class ForwardingUnitSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "forward from MEM to EX" in {
    test(new ForwardingUnit(32, 5)) { dut =>
      dut.io.id_rs1.poke(1.U)
      dut.io.id_rs2.poke(2.U)
      dut.io.id_val1.poke(3.U)
      dut.io.id_val2.poke(4.U)
      dut.io.mem_fwd.rd.poke(1.U)
      dut.io.mem_fwd.writeEnable.poke(true.B)
      dut.io.mem_fwd.stageOutput.poke(5.U)
      dut.io.val1.expect(5.U)
      dut.io.val2.expect(4.U)
    }
  }

  it should "forward from WB to EX" in {
    test(new ForwardingUnit(32, 5)) { dut =>
      dut.io.id_rs1.poke(1.U)
      dut.io.id_rs2.poke(2.U)
      dut.io.id_val1.poke(3.U)
      dut.io.id_val2.poke(4.U)
      dut.io.wb_fwd.rd.poke(1.U)
      dut.io.wb_fwd.writeEnable.poke(true.B)
      dut.io.wb_fwd.stageOutput.poke(5.U)
      dut.io.val1.expect(5.U)
      dut.io.val2.expect(4.U)
    }
  }

  it should "not forward from when none of the registers equal rd" in {
    test(new ForwardingUnit(32, 5)) { dut =>
      dut.io.id_rs1.poke(3.U)
      dut.io.id_rs2.poke(2.U)
      dut.io.id_val1.poke(3.U)
      dut.io.id_val2.poke(4.U)
      dut.io.mem_fwd.rd.poke(1.U)
      dut.io.mem_fwd.writeEnable.poke(true.B)
      dut.io.mem_fwd.stageOutput.poke(5.U)
      dut.io.val1.expect(3.U)
      dut.io.val2.expect(4.U)
    }
  }
}
