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
      dut.clock.step(5)
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
      dut.clock.step(2)
      dut.io.startPipeline.poke(false.B)
      dut.clock.step(4)

      val input2 = "add x3, x1, x2"
      FillInstructionMemory(input2, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(5)

      // Check the result
      dut.io.debug.get.out.expect(2.U)

    }
  }

  it should "not execute an ADD instruction correctly until forwarding and stalling is implemented" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """addi x1, x1, 1
          addi x2, x2, 1
          add x3, x1, x2
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(7)

      // Check the result
      dut.io.debug.get.out.expect(0.U)

    }
  }

  it should "execute an store and load instruction correctly" in {
    test(new ChiselRISC(true)).withAnnotations(Seq(WriteVcdAnnotation)) { dut  =>
      // add value in register
      val addi = "addi x1, x1, 1"
      FillInstructionMemory(addi, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(1)
      dut.io.startPipeline.poke(false.B)
      dut.clock.step(4)
      dut.io.debug.get.out.expect(1.U)
      val store = "sw x1, 0(x2)"
      FillInstructionMemory(store, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(4)
      dut.io.debug.get.memoryIO.wren.expect(true.B)
      dut.io.debug.get.memoryIO.wrData.expect(1.U)
      dut.io.debug.get.memoryIO.wrAddr.expect(0.U)
      dut.clock.step(1)
    }
  }



}
