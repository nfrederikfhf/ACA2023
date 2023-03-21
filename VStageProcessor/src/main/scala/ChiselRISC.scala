import chisel3._
import chisel3.util._
import memory.InstructionMemory

class ChiselRISC extends Module{
  // Pipeline stages
  //val ProgramCounter = Module(new ProgramCounter())
  val InstructionMemory = Module(new InstructionMemory(1024, 32))
  /* TODO: Add the rest of the pipeline stages */
  // Connect the pipeline stages
  //InstructionMemory.io.rdAdd <> ProgramCounter.io.rdAdd
  /* TODO: Connect the rest of the pipeline stages */



}