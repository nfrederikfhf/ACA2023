package ChiselRISC.test_components

import chisel3._
import chiseltest._
import ChiselRISC.components.BranchPredictor
import org.scalatest.flatspec.AnyFlatSpec

class BranchPredictorSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "update history and make prediction accordingly" in {
    test(new BranchPredictor()) { dut =>
      dut.io.EXbranching.poke(true.B)
      dut.io.EXbranchResult.poke(true.B)
      dut.io.EXbranchPC.poke(0.U(32.W))

      dut.io.pc.poke(0.U(32.W))
      dut.io.inst.poke("h02000063".U) //beq x0, x0, 32
      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()                    // (dont branch) 00 -> 01 (dont branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()                    // (dont branch) 01 -> 11 (do branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(true.B)
      dut.io.EXbranchResult.poke(false.B)
      dut.clock.step()                    // (do branch) 11 -> 10 (do branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(true.B)
      dut.clock.step()                    // (do branch) 10 -> 00 (dont branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.io.EXbranchResult.poke(true.B)
      dut.clock.step()                    // (dont branch) 00 -> 01 (dont branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
    }
  }

  it should "update history and make prediction accordingly with for PCs" in {
    test(new BranchPredictor()) { dut =>
      dut.io.pc.poke(0.U(32.W))
      dut.io.inst.poke("h02000063".U) //beq x0, x0, 32
      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.io.EXbranching.poke(true.B)
      dut.io.EXbranchResult.poke(true.B)
      dut.io.EXbranchPC.poke(0.U(32.W))
      dut.clock.step()                    // (dont branch) 00 -> 01 (dont branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()                    // (dont branch) 01 -> 11 (do branch)

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(true.B)
      dut.io.EXbranching.poke(false.B)
      dut.clock.step()

      dut.io.pc.poke(4.U(32.W))           // different history index (1)
      dut.io.targetPC.expect(36.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()

      dut.io.pc.poke((32*4).U(32.W))           // 32 entries * 4 pc step -> reached limit history index should be 0 again
      dut.io.targetPC.expect(((32*4)+32).U(32.W))
      dut.io.changePC.expect(true.B)
      dut.clock.step()

      dut.io.pc.poke(1.U(32.W))                 // index should be rounded to 4 (actually only rounded to 2)-> index = 0
      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(true.B)
    }
  }

  it should "not update history when EXbranching is false" in {
    test(new BranchPredictor()) { dut =>
      dut.io.EXbranching.poke(false.B)
      dut.io.EXbranchResult.poke(true.B)
      dut.io.EXbranchPC.poke(0.U(32.W))

      dut.io.pc.poke(0.U(32.W))
      dut.io.inst.poke("h02000063".U) //beq x0, x0, 32
      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()

      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
      dut.clock.step()
      //if history would update, then changePC would be true
      dut.io.targetPC.expect(32.U(32.W))
      dut.io.changePC.expect(false.B)
    }
  }

  it should "changePC should always be false when instruction is not branching" in {
    test(new BranchPredictor()) { dut =>
      dut.io.EXbranching.poke(true.B)
      dut.io.EXbranchResult.poke(true.B)
      dut.io.EXbranchPC.poke(0.U(32.W))
      dut.clock.step()                    // (dont branch) 00 -> 01 (dont branch)
      dut.clock.step()                    // (dont branch) 01 -> 11 (do branch)

      dut.io.pc.poke(0.U(32.W))
      dut.io.inst.poke("h00400093".U)     //addi x1, x0, 4
      dut.io.changePC.expect(false.B)
    }
  }
}
