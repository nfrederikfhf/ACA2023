package components

import chisel3._
import components.Instruction._

class SingleCycleProcessor extends Module {
  /*
   * Memory
   */
  val dualMemory = new DualReadMem()
  val memory = new DataMemory(dualMemory)

  //val controller = new Controller()

  /*
   * Program counter
   */
  val programCounter = new ProgramCounter()
  programCounter.io.writeEnable := false.B
  programCounter.io.writeAdd := false.B
  programCounter.io.dataIn := 0.U
  programCounter.io.enable := true.B

  /*
   * Instruction memory
   */
  val instructionMemory = new InstructionMemory(dualMemory)
  instructionMemory.io.readAddress := programCounter.io.counter

  /*
   * Instruction decoder
   */
  val decoder = new InstructionDecoder()
  decoder.io.instructionIn := instructionMemory.io.instruction

  /*
   * Register File
   */
  val registerFile = new RegisterFile()
  registerFile.io.sourceRegister1 := decoder.io.sourceRegister1
  registerFile.io.sourceRegister2 := decoder.io.sourceRegister2
  registerFile.io.destinationRegister := decoder.io.destinationRegister
  registerFile.io.writeEnable := 0.B // TODO implement

  /*
   * ALU
   */
  val alu = new ALU()

  when(decoder.io.useALU) {
    alu.io.instruction := decoder.io.decodedInstruction
    alu.io.a := registerFile.io.sourceRegister1
    alu.io.b := Mux(
      decoder.io.useImmediate,
      decoder.io.immediate,
      registerFile.io.sourceRegister2
    )
  }

  when(decoder.io.branch) {
    alu.io.a := registerFile.io.sourceRegister1
    alu.io.b := registerFile.io.sourceRegister2
    // TODO finish branching implementation
  }

  when(decoder.io.jump) {
    registerFile.io.writeEnable := true.B
    // TODO finish jumping implementation
  }

  when(decoder.io.load) {
    registerFile.io.writeData := memory.io.readData
  }

  when(decoder.io.store) {
    memory.io.writeData := registerFile.io.sourceRegister2
  }

  when(decoder.io.decodedInstruction === LUI) {
    registerFile.io.writeEnable := true.B
    registerFile.io.destinationRegister := decoder.io.immediate
  }

  when(decoder.io.decodedInstruction === AUIPC) {
    registerFile.io.writeEnable := true.B
    alu.io.instruction := ADD
    alu.io.a := programCounter.io.counter
    alu.io.b := decoder.io.immediate
    registerFile.io.writeData := alu.io.result
  }

  when(decoder.io.load || decoder.io.store) {
    alu.io.instruction := ADD
    alu.io.a := registerFile.io.sourceRegister1
    alu.io.b := decoder.io.immediate

    memory.io.writeAddress := alu.io.result
    memory.io.readAddress := alu.io.result
  }

  when(decoder.io.load) {
    registerFile.io.writeEnable := true.B
    registerFile.io.writeData := memory.io.readData
  }

  when(decoder.io.store) {
    memory.io.writeEnable := true.B
    memory.io.writeData := registerFile.io.sourceRegister2
  }
}
