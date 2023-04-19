package test_components

import chisel3._
import chiseltest._
import components.{HazardControl}
import org.scalatest.flatspec.AnyFlatSpec

class HazardDetectionTest extends AnyFlatSpec with ChiselScalatestTester {
  it should "stall IF and flush ID if EXrd and IDrs1 is the same" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXrd.poke(3.U(5.W))
      dut.io.IDrs1.poke(3.U(5.W))
      dut.io.EXctrlLoad.poke(true.B)
      dut.io.IFStall.expect(true.B)
      dut.io.IDFlush.expect(true.B)
      dut.io.IFFlush.expect(false.B)
    }
  }

  it should "stall IF and flush ID if EXrd and IDrs2 is the same" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXrd.poke(3.U(5.W))
      dut.io.IDrs2.poke(3.U(5.W))
      dut.io.EXctrlLoad.poke(true.B)
      dut.io.IFStall.expect(true.B)
      dut.io.IDFlush.expect(true.B)
      dut.io.IFFlush.expect(false.B)
    }
  }
  it should "use-load hazard should not trigger if Exrd is 0 (nop)" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXrd.poke(0.U(5.W))
      dut.io.IDrs2.poke(3.U(5.W))
      dut.io.EXctrlLoad.poke(true.B)
      dut.io.IFStall.expect(false.B)
      dut.io.IDFlush.expect(false.B)
      dut.io.IFFlush.expect(false.B)
    }
  }
  it should "Flush and stall everything if we get a jump instruction" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXctrlJump.poke(true.B)
      dut.io.IFFlush.expect(true.B)
      dut.io.IFStall.expect(true.B)
      dut.io.IDFlush.expect(true.B)
    }
  }

  it should "Flush and stall everything if we get a taken branch instruction" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXaluOut.poke(1.U(5.W))
      dut.io.EXctrlBranch.poke(true.B)
      dut.io.IFFlush.expect(true.B)
      dut.io.IFStall.expect(true.B)
      dut.io.IDFlush.expect(true.B)
    }
  }

  it should "not flush and stall if we get an untaken branch instruction" in {
    test(new HazardControl(32, 5)) { dut =>
      dut.io.EXaluOut.poke(0.U(5.W))
      dut.io.EXctrlBranch.poke(true.B)
      dut.io.IFFlush.expect(false.B)
      dut.io.IFStall.expect(false.B)
      dut.io.IDFlush.expect(false.B)
    }
  }

}