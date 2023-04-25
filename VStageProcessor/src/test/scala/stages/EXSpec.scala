package stages

import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec
import utilities.ALUOp

class EXSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "Check R2R works as expected " in {
    test(new EX(32, 5)) { dut =>
      //dut.io.in.ctrl.useALU
      dut.io.in.val1.poke(96.U)
      dut.io.in.val2.poke(4.U)
      dut.io.in.aluOp.poke(ALUOp.ADD.litValue)
      dut.io.in.pc.poke(4.U)
      dut.io.in.imm.poke(0.U)
      dut.io.in.ctrl.useImm.poke(false.B)
      dut.io.in.ctrl.branch.poke(false.B)
      dut.io.in.ctrl.useALU.poke(true.B)
      dut.clock.step(1)
      dut.io.PCout.expect(12.U)
      dut.io.out.aluOut.expect(100.U)
      dut.io.out.ctrl.load.expect(false.B)
      dut.io.out.ctrl.store.expect(false.B)
    }
  }

  it should "Check Register Immediate Operation works" in {
    test(new EX(32, 5)) { dut =>
      dut.io.in.val1.poke(96.U)
      dut.io.in.val2.poke(0.U)
      dut.io.in.aluOp.poke(ALUOp.ADD.litValue)
      dut.io.in.pc.poke(4.U)
      dut.io.in.imm.poke(4.U)
      dut.io.in.ctrl.useImm.poke(true.B)
      dut.io.in.ctrl.branch.poke(false.B)
      dut.io.in.ctrl.useALU.poke(true.B)
      dut.clock.step(1)
      dut.io.PCout.expect(12.U)
      dut.io.out.aluOut.expect(100.U)
      dut.io.out.ctrl.load.expect(false.B)
      dut.io.out.ctrl.store.expect(false.B)
    }
  }

  //kind of redundant
  it should "Check Load Instruction" in {
    test(new EX(32, 5)) { dut =>
      dut.io.in.val1.poke(96.U)
      dut.io.in.val2.poke(0.U)
      dut.io.in.aluOp.poke(ALUOp.ADD.litValue)
      dut.io.in.pc.poke(4.U)
      dut.io.in.imm.poke(4.U)
      dut.io.in.ctrl.load.poke(true.B)
      dut.io.in.ctrl.useImm.poke(true.B)
      dut.io.in.ctrl.branch.poke(false.B)
      dut.io.in.ctrl.useALU.poke(true.B)
      dut.clock.step(1)
      dut.io.PCout.expect(12.U)
      dut.io.out.aluOut.expect(100.U)
      dut.io.out.ctrl.load.expect(true.B)
      dut.io.out.ctrl.store.expect(false.B)
    }
  }

  it should "Check Branch Mode working" in {
    test(new EX(32, 5)) { dut =>
      dut.io.in.val1.poke(96.U)
      dut.io.in.val2.poke(96.U)
      dut.io.in.aluOp.poke(ALUOp.BEQ.litValue)
      dut.io.in.pc.poke(4.U)
      dut.io.in.imm.poke(4.U)
      dut.io.in.ctrl.load.poke(false.B)
      dut.io.in.ctrl.useImm.poke(false.B)
      dut.io.in.ctrl.branch.poke(true.B)
      dut.io.in.ctrl.useALU.poke(false.B)
      dut.clock.step(1)
      dut.io.PCout.expect(196.U)
      dut.io.out.aluOut.expect(1.U)
      dut.io.out.ctrl.load.expect(false.B)
      dut.io.out.ctrl.store.expect(false.B)
    }
  }
}
