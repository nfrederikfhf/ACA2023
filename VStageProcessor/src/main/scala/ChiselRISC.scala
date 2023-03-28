import chisel3._
import chisel3.util._
import components._
import components.memory._
import stages._
class ChiselRISC extends Module{
  // Pipeline stages

  val IF = Module(new IF(32, 100))
  /* TODO: Add the rest of the pipeline stages */
  // Connect the pipeline stages
  //InstructionMemory.io.rdAdd <> ProgramCounter.io.rdAdd
  /* TODO: Connect the rest of the pipeline stages */



}