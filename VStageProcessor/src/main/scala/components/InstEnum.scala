package components
import chisel3._
import chisel3.experimental.ChiselEnum

class OP extends ChiselEnum {
  val LD = Value("b0000011".U)
  val ST = Value("b0100011".U)
  val AR = Value("b0110011".U)
  val BR = Value("b1100011".U)
  val IM = Value("b0010011".U)
  val LUI = Value("b0110111".U)
  val AUIPC = Value("b0010111".U)
  val JAL = Value("b1101111".U)
  val JALR = Value("b1100111".U)
}

class funct3 extends ChiselEnum {
  val JALR, BEQ, LB, SB, ADDI, ADD, SUB = Value("b000".U)
  val BNE, LH, SH, SLLI, SLL = Value("b001".U)
  val LW, SW, SLTI, SLT = Value("b010".U)
  val SLTIU, SLTU = Value("b011".U)
  val BLE, LBU, XORI, XOR = Value("b100".U)
  val BGE, LHU, SRLI, SRAI, SRL, SRA = Value("b101".U)
  val BLTU, ORI, OR = Value("b110".U)
  val BGEU, ANDI, AND = Value("b111".U)
}

class funct7 extends ChiselEnum {
  val SLLI, SRLI, ADD, SLL, SLT, SLTU, XOR, SRL, AND, OR = Value("b0000000".U)
  val SRAI, SUB, SRA = Value("b0100000".U)

}