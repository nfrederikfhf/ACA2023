package ChiselRISC.components
import chisel3._
import chisel3.util._
import ChiselRISC.utilities._
/* This module is used to generate the immediate values for the RISC-V 32I ISA
 * The immediate values are generated based on the opcode
 * The immediate values are sign-extended to 32 bits
 * @param dataWidth The width of the data bus
 */
class ImmGenerator(dataWidth: Int) extends Module{
  val io = IO(new Bundle{
    val immIn = Input(UInt(dataWidth.W))
    val immOut = Output(UInt(dataWidth.W))
  })
  // Seperate the instruction into different parts corresponding to the RISC-V 32I ISA and sign-extend
  val (opcode,_) = OP.safe(io.immIn(6,0))
  val immI = Cat(Fill(21, io.immIn(31)),io.immIn(30,20))
  val immS = Cat(Fill(21, io.immIn(31)),io.immIn(30,25),io.immIn(11,7))
  val immB = Cat(Fill(20,io.immIn(31)),io.immIn(7),io.immIn(30,25),io.immIn(11,8), 0.U)
  val immU = Cat(io.immIn(31,12), Fill(12, 0.U))
  val immJ = Cat(Fill(11,io.immIn(31)),io.immIn(19,12),io.immIn(20),io.immIn(30,21),0.U)

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

  io.immOut := imm
}
