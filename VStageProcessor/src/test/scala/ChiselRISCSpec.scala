import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3._

import components._
import stages._
import utilities._
class ChiselRISCSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "execute an ADD instruction correctly" in {
    test(new ChiselRISC).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      // Instantiate data

      // Fill the instruction memory
      dut.io.test.writeToMem.poke(true.B)
      dut.io.test.testData.poke("h00500093".U(32.W)) // addi x1, x0, 5

      dut.clock.step(1)

      // Execute the ADD instruction
      dut.io.test.writeToMem.poke(false.B)
      dut.io.startPipeline.poke(true.B)

      for(i <- 0 until 5) {
        dut.clock.step(1)
      }

      // Check the result
      dut.io.out.expect(5.U)


    }
  }

}
