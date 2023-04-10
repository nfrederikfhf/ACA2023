package utilities
import chisel3._
import chisel3.util._
import chiseltest._
import com.carlosedp.riscvassembler.RISCVAssembler
import utilities._

object InstMemFiller {
  def FillInstructionMemory(inputString: String, clock: Clock, interface: memoryInterface): Unit = {
    /**
    * This function fills the instruction memory with the instructions given in the inputString.
    * The inputString should be a string containing the instructions in the RISC-V assembly language.
    * @param inputString: String containing the instructions in the RISC-V assembly language.
    * @param clock: Clock of the instruction memory.
    * @param interface: Interface of the instruction memory.
     */

    val instructions = RISCVAssembler.fromString(inputString.stripMargin)  // Remove the leading whitespace
    val instructionArray = instructions.split("\n") // Split the instructions into an array
    val amountOfInstructions = instructionArray.length // Get the amount of instructions
    interface.write.ready.poke(true.B) // Set the ready signal to true
    for (i <- 0 until amountOfInstructions) { // Loop through the instructions
      val inst = "h" + instructionArray(i) // Prefix instruction with "h" to make it a hex string
      interface.write.data.poke(inst.U(32.W))
      clock.step(1)
    }
    interface.write.ready.poke(false.B)
    clock.step(1)
  }
}