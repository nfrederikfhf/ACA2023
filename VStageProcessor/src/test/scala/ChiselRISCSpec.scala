import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._
import components._
import stages._
import utilities.helperFunctions.FillInstructionMemory
import utilities._

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
          jal x1, +12
          nop
          nop
          nop
          addi x2, x1, 1
          """ //jalr x2, x1, +2000
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.debug.get.pc.expect(0.U)
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(8)
      dut.io.debug.get.pc.expect(12.U)
      dut.io.debug.get.regFile(1).expect(4.U)
      dut.clock.step(1)
      dut.io.debug.get.pc.expect(2012.U)
      dut.io.debug.get.regFile(2).expect(16.U)
    }
  }



}
