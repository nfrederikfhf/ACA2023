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
      dut.clock.step(1)
      dut.clock.step(1)
      dut.clock.step(1)
      dut.io.out.expect(1.U)
    }
  }


  it should "execute an ADD instruction correctly" in {
    test(new ChiselRISC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data

      // Fill the instruction memory
      dut.io.test.writeToMem.poke(true.B)
      //dut.io.test.testData.poke("h00500093".U(32.W)) // addi x1, x0, 5

      dut.io.test.testData.poke("h00108093".U(32.W)) // addi x1, x1, 1
      dut.clock.step(1)
      dut.io.test.testData.poke("h00110113".U(32.W)) // addi x2, x2, 1
      dut.clock.step(1)
      dut.io.test.testData.poke("h002081b3".U(32.W)) // add x3, x1, x2
      dut.clock.step(1)
      // Execute the ADD instruction
      dut.io.test.writeToMem.poke(false.B)
      dut.io.startPipeline.poke(true.B)

      for (i <- 0 until 10) {
        dut.clock.step(1)
      }

      // Check the result
      dut.io.out.expect(2.U)

    }
  }

}
