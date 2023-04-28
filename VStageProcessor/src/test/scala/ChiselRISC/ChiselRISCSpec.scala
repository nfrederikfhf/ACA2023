package ChiselRISC

import utilities.helperFunctions.FillInstructionMemory
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ChiselRISCSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "execute an ADDI instruction correctly" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input = """addi x1, x1, 1"""
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
    }
  }


  it should "execute an ADD instruction correctly" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """addi x1, x1, 1
          addi x2, x2, 1
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(6)

      val input2 = "add x3, x1, x2"
      FillInstructionMemory(input2, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)

      // Check the result
      dut.io.debug.get.out.expect(2.U)
    }
  }

  it should "execute an ADD instruction correctly with forwarding" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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

    }
  }

  it should "execute an store and load instruction correctly" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut  =>
      // add value in register
      val addi = "addi x1, x1, 1"
      FillInstructionMemory(addi, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
      dut.io.startPipeline.poke(false.B)
      val store = "sw x1, 4(x2)"
      FillInstructionMemory(store, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(3)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(1.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(4.U)
      dut.clock.step(1)
      dut.io.startPipeline.poke(false.B)
      val load = "lw x3, 4(x2)"
      FillInstructionMemory(load, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
      dut.io.startPipeline.poke(false.B)
    }
  }

  it should "execute JAL/JALR instructions" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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
      dut.io.debug.get.pc.expect(16.U)
      dut.io.debug.get.regFile(1).expect(4.U)
      dut.clock.step(5)
      dut.io.debug.get.pc.expect(2004.U)
      dut.io.debug.get.regFile(2).expect(20.U)
    }
  }

  it should "execute JAL an instruction and skip JALR instruction" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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
      dut.io.debug.get.pc.expect(32.U)
      dut.io.debug.get.regFile(2).expect(0.U)
    }
  }

  it should "execute branch instructions" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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
          addi x4, x0, 42
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
        dut.io.debug.get.pc.expect(48.U)
        dut.io.debug.get.regFile(4).expect(42.U)


    }
  }

  it should "execute branch instructions - alternative" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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
      dut.io.debug.get.pc.expect(44.U)
      dut.clock.step(3)
      dut.io.debug.get.pc.expect(52.U)
    }
  }

  it should "execute the LW instruction" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
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


}
