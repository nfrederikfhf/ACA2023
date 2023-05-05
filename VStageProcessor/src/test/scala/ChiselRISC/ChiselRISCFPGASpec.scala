package ChiselRISC
import utilities.Binaries.loadWords
import utilities.helperFunctions.{FillInstructionMemory, FillInstructionMemoryFromFile}
import chisel3._
import chiseltest._
import com.carlosedp.riscvassembler.RISCVAssembler
import org.scalatest.flatspec.AnyFlatSpec
class ChiselRISCFPGASpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "execute the program that is tested on the FPGA from the text file" in {
    test(new VStageProcessor(true, loadWords("C:\\Users\\Watos\\Documents\\Github\\ACA2023\\VStageProcessor\\asm\\Input.bin"))).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      //      val input = RISCVAssembler.fromFile("Input.asm")
      //      FillInstructionMemoryFromFile(input, dut.clock, dut.io.memIO)
      //Users\frede\Desktop\UNI\MSc\02211 - Advanced Computer Architecture\ACA2023\VStageProcessor\ shit doesnt work
      dut.io.debug.get.regFile(1).expect(0.U)
      dut.io.debug.get.regFile(2).expect(0.U)
      dut.io.debug.get.regFile(3).expect(0.U)
      dut.io.startPipeline.poke(true.B)
      dut.clock.step(6)
      dut.io.debug.get.regFile(1).expect(1.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(2).expect(2.U)
      dut.clock.step(1)
      dut.io.debug.get.regFile(3).expect(3.U)
      dut.clock.step(3)
    }
  }
}
