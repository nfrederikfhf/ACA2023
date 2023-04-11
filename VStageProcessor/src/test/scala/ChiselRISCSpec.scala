import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._
import components._
import stages._
import utilities.helperFunctions.FillInstructionMemory
import utilities._

class ChiselRISCSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "execute an ADDI instruction correctly" in {
    test(new ChiselRISC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      val input = """addi x1, x1, 1"""
      FillInstructionMemory(input, dut.clock, dut.io.memIO)

      dut.io.startPipeline.poke(true.B)
      for (i <- 0 until 5) {
        dut.clock.step(1)
      }
      dut.io.out.expect(1.U)
    }
  }


  it should "execute an ADD instruction correctly" in {
    test(new ChiselRISC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data
      val input =
        """addi x1, x1, 1
          addi x2, x2, 1
          add x3, x1, x2
          """
      FillInstructionMemory(input, dut.clock, dut.io.memIO)
      dut.io.startPipeline.poke(true.B)

      for (i <- 0 until 10) {
        dut.clock.step(1)
      }

      // Check the result
      dut.io.out.expect(2.U)

    }
  }

}
