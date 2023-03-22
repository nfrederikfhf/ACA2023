package components
import chisel3._
import chisel3.util._

class ImmGenerator(dataWidth: Int) extends Module{
  val io = IO(new Bundle{
    val imm = Input(UInt(dataWidth.W))
    val immediate = Output(SInt(dataWidth.W))
  })
  // Seperate the instruction into different parts corresponding to the RISC-V 32I ISA and sign-extend
  val (opcode,_) = OP.safe(io.imm(6,0))
  //val funct3 = io.imm(14,12)
  //val funct7 = io.imm(31,25)
  val immI = Cat(Fill(20, io.imm(31)),io.imm(31,20)).asSInt
  val immS = Cat(Fill(20, io.imm(31)),io.imm(31,25),io.imm(11,7)).asSInt
  val immB = Cat(Fill(19,io.imm(31)),io.imm(7),io.imm(30,25),io.imm(11,8), 0.U).asSInt
  val immU = Cat(io.imm(31,12), Fill(12, 0.U)).asSInt
  val immJ = Cat(Fill(11,io.imm(31)),io.imm(19,12),io.imm(20),io.imm(30,21),0.U).asSInt

  val imm = WireDefault(immI) // Default immediate value is immI

  switch(opcode){ // Select the immediate value based on the opcode
    is(OP.LUI){
      imm := immU
    }
    is(OP.AUIPC){
      imm := immU
    }
    is(OP.JAL){
      imm := immJ
    }
    is(OP.ST){
      imm:= immS
    }
    is(OP.BR){
      imm := immB
    }
  }

  io.immediate := imm
}
