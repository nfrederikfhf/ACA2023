import chisel3._
import chisel3.util._
import components._
import components.memory._
import stages._
class ChiselRISC extends Module{
  // Pipeline stages
  //val ProgramCounter = Module(new ProgramCounter())
  val InstructionMemory = Module(new InstructionMemory(1024, 32))
  val RegisterFile = Module(new RegisterFile(32, 32))
  val Decoder = Module(new Decoder(32,5))
  val IF = Module(new IF(32))
  Decoder.io.out.ctrl.addToPC := IF.io.addToPC
  /* TODO: Add the rest of the pipeline stages */
  // Connect the pipeline stages
  //InstructionMemory.io.rdAdd <> ProgramCounter.io.rdAdd
  /* TODO: Connect the rest of the pipeline stages */



}