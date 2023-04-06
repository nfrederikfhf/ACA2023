package stages

import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec
import utilities.ALUOp

class IDtoEXSpec extends AnyFlatSpec with ChiselScalatestTester {
//  it should "propagate the ADD instruction correctly" in {
//    test(new ID(32, 5)) { dutID =>
//      test(new EX(32, 5)) { dutEX =>
//        dutID.io.in.inst.poke("h002081b3".U(32.W)) // add x3, x1, x2
//        dutID.io.in.pc.poke(0.U(32.W))
//        dutID.clock.step(1)
//        dutID.io.out.ctrl.useALU.expect(true.B)
//        dutID.io.out.ctrl.useImm.expect(false.B)
//        dutID.io.out.aluOp.expect(ALUOp.ADD.litValue)
//        dutID.io.out.rs1.expect(1.U)
//        dutID.io.out.rs2.expect(2.U)
//        dutID.io.out.rd.expect(3.U)
//
//        dutEX.io.in.ctrl.useALU.expect(true.B)
//        dutEX.mux1.expect(1.U)
//        dutEX.mux2.expect(2.U)
//
//      }
//    }
//  }

}
