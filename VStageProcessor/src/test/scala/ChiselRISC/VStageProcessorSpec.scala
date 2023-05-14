package ChiselRISC

import utilities.helperFunctions.{FillInstructionMemory, FillInstructionMemoryFromFile}
import chisel3._
import chiseltest._
import com.carlosedp.riscvassembler.RISCVAssembler
import org.scalatest.flatspec.AnyFlatSpec

class VStageProcessorSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "execute an ADDI instruction correctly" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input = """addi x1, x1, 1"""
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
    }
  }


  it should "execute an ADD instruction correctly with forwarding" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """addi x1, x1, 1
          addi x2, x2, 1
          add x3, x1, x2
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(6)
      // Check the result
      dut.io.debug.get.out.expect(2.U)
      dut.clock.step(1)
      // Check the register
      dut.io.debug.get.regFile(3).expect(2.U)
    }
  }

  it should "execute an AUIPC instruction and LUI instruction correctly" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """lui x1, 0xf0f0
          nop
          auipc x2, 0xf0
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      // Check the result
      dut.io.debug.get.regFile(1).expect(0xf0f0000L.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(2).expect(0xf0008L.U) // rd <- pc + imm << 12
    }
  }

  it should "execute an store and load instruction correctly" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut  =>
      // add value in register
      val input =
      """
        addi x1, x1, 1
        sw x1, 4(x2)
        lw x3, 4(x2)
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(1.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(4.U)
      dut.clock.step(2)
      dut.io.debug.get.out.expect(1.U)
      dut.io.startPipeline.poke(false.B)
    }
  }

  it should "execute JAL/JALR instructions" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """
          jal x1, +16
          nop
          nop
          nop
          jalr x2, x1, +2000
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.pc.expect(0.U)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.pc.expect(20.U)
      dut.io.debug.get.regFile(1).expect(4.U)
      dut.clock.step(3)
      dut.io.debug.get.pc.expect(2008.U)
      dut.io.debug.get.regFile(2).expect(20.U)
    }
  }

  it should "execute JAL an instruction and skip JALR instruction" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Should skip the JALR instruction due to the JAL instruction
      val input =
        """
          jal x1, +32
          jalr x2, x1, +2000
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.pc.expect(0.U)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.pc.expect(32.U)
      dut.clock.step(2) //step 2 more for register rd writeback
      dut.io.debug.get.regFile(1).expect(4.U)
      dut.clock.step(4)
      dut.io.debug.get.pc.expect(56.U)
      dut.io.debug.get.regFile(2).expect(0.U)
    }
  }

  it should "execute an JAL instruction with a negative offset" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Should skip the JALR instruction due to the JAL instruction
      val input =
        """
          add x3, x1, x2
          addi x1, x1, 1
          addi x2, x2, 1
          jal x0, -12
          nop
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.pc.expect(0.U)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.pc.expect(16.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(1).expect(1.U)
      dut.io.debug.get.pc.expect(20.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(2).expect(1.U)
      dut.io.debug.get.pc.expect(0.U)
      dut.clock.step(5)
      dut.io.debug.get.pc.expect(20.U)
      dut.io.debug.get.regFile(3).expect(2.U)
    }
  }


  it should "execute branch instructions" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          addi x1, x0, 4
          addi x2, x0, 4
          addi x3, x0, 6
          beq x1, x2, +24
          jal x0, 0
          nop
          nop
          nop
          nop
          add x2, x1, x2
        """
        FillInstructionMemory(input, dut.clock, dut.io.memIO)
        dut.io.debug.get.regFile(1).expect(0.U)
        dut.io.debug.get.regFile(2).expect(0.U)
        dut.io.debug.get.regFile(3).expect(0.U)
        dut.io.startPipeline.poke(true.B)
        dut.clock.step(5)
        dut.io.debug.get.regFile(1).expect(4.U)
        dut.io.debug.get.pc.expect(16.U)
        dut.clock.step(1)
        dut.io.debug.get.regFile(2).expect(4.U)
        dut.io.debug.get.pc.expect(20.U)
        dut.clock.step(1)
        dut.io.debug.get.regFile(3).expect(6.U)
        dut.io.debug.get.pc.expect(36.U)
        dut.clock.step(5)
        dut.io.debug.get.pc.expect(56.U)
        dut.io.debug.get.regFile(2).expect(8.U)


    }
  }

  it should "execute branch instructions - alternative" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          addi x1, x0, 6
          addi x2, x0, 6
          addi x3, x0, 4
          beq x1, x2, +12
          nop
          nop
          bne x2, x3, +12
          nop
          nop
          blt x3, x2, +12
          nop
          nop
          bge x2, x3, +12
          nop
          nop
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(6.U)
      dut.io.debug.get.pc.expect(16.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(2).expect(6.U)
      dut.io.debug.get.pc.expect(20.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(3).expect(4.U)
      dut.io.debug.get.pc.expect(24.U)
      dut.clock.step(3)
      dut.io.debug.get.pc.expect(36.U)
      dut.clock.step(3)
      dut.io.debug.get.pc.expect(48.U)
      dut.clock.step(3)
      dut.io.debug.get.pc.expect(60.U)
    }
  }

  it should "execute the SW and LW instruction" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          lui x1, 0xf0f0f
          addi x1, x1, 240
          addi x2, x0, 10
          sw x1, 0(x2)
          lw x3, 0(x2)
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(0xf0f0f000L.U) // L is to assign scala to evaluate it as a long
      dut.clock.step(1)
      dut.io.debug.get.regFile(1).expect(0xf0f0f0f0L.U)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(0xf0f0f0f0L.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(10.U)
      dut.clock.step(1)
      dut.io.debug.get.memoryIO.rden.expect(true.B)
      dut.io.debug.get.memoryIO.rdAddr1.expect(10.U)
      dut.io.debug.get.regFile(2).expect(10.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(3).expect(0xf0f0f0f0L.U)
    }
  }

  it should "execute the SB and LB instruction" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          addi x1, x1, 240
          addi x2, x0, 10
          sb x1, 0(x2)
          lb x3, 0(x2)
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(240.U) // L is to assign scala to evaluate it as a long
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(0xF0.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(10.U)
      dut.clock.step(1)
      dut.io.debug.get.memoryIO.rden.expect(true.B)
      dut.io.debug.get.memoryIO.rdAddr1.expect(10.U)
      dut.io.debug.get.regFile(2).expect(10.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(3).expect(0xFFFFFFF0L.U)
    }
  }

  it should "execute the SH and LH instruction" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          lui x1, 0xf0f0f
          addi x1, x1, 240
          addi x2, x0, 10
          sh x1, 0(x2)
          lh x3, 0(x2)
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(0xf0f0f000L.U) // L is to assign scala to evaluate it as a long
      dut.clock.step(1)
      dut.io.debug.get.regFile(1).expect(0xf0f0f0f0L.U)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(0xf0f0.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(10.U)
      dut.clock.step(1)
      dut.io.debug.get.memoryIO.rden.expect(true.B)
      dut.io.debug.get.memoryIO.rdAddr1.expect(10.U)
      dut.io.debug.get.regFile(2).expect(10.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(3).expect(0xfffff0f0L.U)
    }
  }

  it should "execute the program that is tested on the FPGA" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input = RISCVAssembler.fromFile("Input.asm")
      FillInstructionMemoryFromFile(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(1).expect(1.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(2).expect(2.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(3).expect(3.U)
    }
  }


  it should "execute a program with different instructions" in {
    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input =
        """
          addi x1, x0, 42
          addi x2, x0, 69
          sub x3, x2, x1
          sb x3, 1(x3)
          lb x4, 1(x3)
          blt x2, x1, +24
          addi x4, x4, 1
          beq x3, x4, -8
          lui x6, 0xfffff
          addi x7, x0, 42
          beq x1, x7, +8
          jal x0, -8
          slti x8, x1, 3
          addi x8, x8, 84
        """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)
      dut.io.debug.get.regFile(1).expect(42.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(2).expect(69.U)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(27.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(28.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(3).expect(27.U)
      dut.io.debug.get.memoryIO.rden.expect(true.B)
      dut.io.debug.get.memoryIO.rdAddr1.expect(28.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(4).expect(27.U)
      dut.clock.step(2)
      dut.io.debug.get.regFile(4).expect(28.U)
      dut.clock.step(4)
      dut.io.debug.get.regFile(6).expect("hfffff000".U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(7).expect(42.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(8).expect(0.U)
      dut.clock.step(5)
      dut.io.debug.get.regFile(8).expect(84.U)
    }
  }

//  it should "Work in bruh2" in {
//    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
//      val input =
//        """
//          addi x1, x0, 1
//          sb x1, 1(x1)
//          lb x2, 1(x1)
//          addi x2, x2, 1
//          beq x2, x1, +4
//          nop
//          addi x4, x0, 42
//        """
//      FillInstructionMemory(input, dut.clock, dut.io.memIO)
//      dut.io.startPipeline.poke(true.B)
//      dut.clock.step(4)
//      dut.io.debug.get.memoryIO.wren.expect(true.B)
//      dut.io.debug.get.memoryIO.wrData.expect(1.U)
//      dut.io.debug.get.memoryIO.wrAddr.expect(2.U)
//      dut.clock.step(1)
//      dut.io.debug.get.regFile(1).expect(1.U)
//      dut.io.debug.get.memoryIO.rden.expect(true.B)
//      dut.io.debug.get.memoryIO.rdAddr1.expect(2.U)
//      dut.clock.step(2)
//      dut.io.debug.get.regFile(2).expect(1.U)
//      dut.clock.step(5)
//      dut.io.debug.get.regFile(2).expect(2.U)
//      dut.clock.step(1)
//    }
//  }
//
//  it should "Work in bruh3" in {
//    test(new VStageProcessor(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
//      val input =
//        """
//          addi x1, x0, 1
//          sb x1, 1(x1)
//          lb x2, 1(x1)
//          addi x2, x2, 1
//        """
//      FillInstructionMemory(input, dut.clock, dut.io.memIO)
//      dut.io.startPipeline.poke(true.B)
//      dut.clock.step(5)
//      dut.io.debug.get.regFile(1).expect(1.U)
//      dut.clock.step(5)
//      dut.io.debug.get.regFile(2).expect(2.U)
//    }
//  }
}
