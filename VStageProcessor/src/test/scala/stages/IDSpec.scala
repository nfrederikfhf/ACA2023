package stages

import chisel3._
import chiseltest._
import com.carlosedp.riscvassembler.RISCVAssembler
import stages._
import org.scalatest.flatspec.AnyFlatSpec
import utilities.ALUOp

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
    test(new ID(datawidth = 32, addrWidth = 5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Set up input
      dut.io.in.inst.poke("h01000193".U ) // addi x3, x0, 16
      dut.io.in.pc.poke(0.U(32.W))

      // Set up register file
      //dut.regfile.io.rdAddr1.poke(0.U(5.W)) // x0
      //dut.regfile.io.rdAddr2.poke(0.U(5.W)) // x0
      dut.io.test.startTest.poke(true.B)
      dut.clock.step()
      dut.io.test.wren.poke(true.B)
      dut.io.test.wrAddr.poke(0.U(5.W)) // x0
      dut.io.test.wrData.poke(0.U(32.W))
      dut.io.test.startTest.poke(false.B)
      dut.clock.step()

      // Check output
      dut.io.out.val1.expect(0.U)
      dut.io.out.val2.expect(0.U)
      dut.io.out.rd.expect(3.U)
      dut.io.out.ctrl.useALU.expect(true.B)
      dut.io.out.ctrl.useImm.expect(true.B)
      dut.io.out.imm.expect(16.U)
      dut.io.out.pc.expect(0.U)
      dut.io.out.rs1.expect(0.U)
      dut.io.out.rs2.expect(16.U)
      dut.io.out.aluOp.expect(ALUOp.ADD.litValue)
    }
  }

  it should "output correct values for the LW instruction" in {
    test(new ID(32,5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Set up input
      dut.io.in.inst.poke("h00412383".U) // lw x7, 4(x2)
      dut.io.in.pc.poke(0.U(32.W))
      dut.io.test.startTest.poke(true.B)
      dut.clock.step()
      /*for (i <- 0 until 5) {
        dut.io.test.wren.poke(true.B)
        dut.io.test.wrAddr.poke(i.U(5.W))
        dut.io.test.wrData.poke(i.U(32.W))
      }*/
      dut.clock.step()
      dut.io.test.startTest.poke(false.B)
      dut.io.test.wren.poke(false.B)
      dut.io.out.ctrl.useALU.expect(false.B)
      dut.io.out.ctrl.useImm.expect(true.B)
      dut.io.out.ctrl.load.expect(true.B)
      dut.io.out.imm.expect(4.U)
      dut.io.out.rd.expect(7.U)
      dut.io.out.rs1.expect(2.U)

    }
  }

  it should "output correct values for the ADD instruction" in {
    test(new ID(32, 5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.in.inst.poke("h002081b3".U(32.W)) // add x3, x1, x2
      dut.io.in.pc.poke(0.U(32.W))
      dut.clock.step(1)
      dut.io.out.ctrl.useALU.expect(true.B)
      dut.io.out.ctrl.useImm.expect(false.B)
      dut.io.out.aluOp.expect(ALUOp.ADD.litValue)
      dut.io.out.rs1.expect(1.U)
      dut.io.out.rs2.expect(2.U)
      dut.io.out.rd.expect(3.U)
    }
  }

  it should "output correct values for the ADDI with ASM instruction" in {
    test(new ID(32, 5)) { dut =>
      val input =
        """addi x3, x0, 16""".stripMargin

      val binaryOutput = RISCVAssembler.binOutput(input)
      println(binaryOutput)
      val inst = "b" + binaryOutput // prefix binary with b to convert to binary
      dut.io.in.inst.poke(inst.U(32.W))
      dut.clock.step(1)
      dut.io.out.val1.expect(0.U)
      dut.io.out.val2.expect(0.U)
      dut.io.out.rd.expect(3.U)
      dut.io.out.ctrl.useALU.expect(true.B)
      dut.io.out.ctrl.useImm.expect(true.B)
      dut.io.out.imm.expect(16.U)
      dut.io.out.pc.expect(0.U)
      dut.io.out.rs1.expect(0.U)
      dut.io.out.rs2.expect(16.U)
      dut.io.out.aluOp.expect(ALUOp.ADD.litValue)



    }
  }

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
