package stages

import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec

class IDSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if decoder spits out correct " in {
    test(new ID(32, 5)) { dut =>
      dut.io.in.inst.poke(0.U(32.W))
      dut.io.in.pc.poke(0.U(32.W))

      // Check that the output registers are initialized to 0
      dut.io.out.val1.expect(0.U)
      dut.io.out.val2.expect(0.U)
      dut.io.out.rd.expect(0.U)
      dut.io.out.ctrl.useALU.expect(false.B)
      dut.io.out.imm.expect(0.U)
      dut.io.out.pc.expect(0.U)
    }
  }

  it should "output correct values for ADDI instruction" in {
    test(new ID(datawidth = 32, addrWidth = 5)) { dut =>
      // Set up input
      dut.io.in.inst.poke("b00000000001000000001100010010011".U ) // ADDI x3, x0, 16
      dut.io.in.pc.poke(0.U(32.W))

      // Set up register file
      dut.regfile.io.rdAddr1.poke(0.U(5.W)) // x0
      dut.regfile.io.rdAddr2.poke(0.U(5.W)) // x0
      dut.regfile.io.wrAddr.poke(0.U(5.W)) // x0
      dut.regfile.io.wrData.poke(0.U(32.W))
      dut.regfile.io.wren.poke(false.B)

      // Check output
      dut.io.out.val1.expect(0.U)
      dut.io.out.val2.expect(0.U)
      dut.io.out.rd.expect(3.U)
      dut.io.out.ctrl.useALU.expect(true.B)
      dut.io.out.ctrl.useImm.expect(true.B)
      dut.io.out.imm.expect(16.U)
      dut.io.out.pc.expect(0.U)
    }
  }

//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32,5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }
//
//  it should "output correct values for the LUI instruction" in {
//    test(new ID(32, 5)) { dut =>
//
//    }
//  }

}
