package utilities

import chisel3._
import chisel3.experimental.ChiselEnum

object OP extends ChiselEnum {
  val LD = Value("b0000011".U)
  val IM = Value("b0010011".U)
  val AUIPC = Value("b0010111".U)
  val ST = Value("b0100011".U)
  val AR = Value("b0110011".U)
  val LUI = Value("b0110111".U)
  val BR = Value("b1100011".U)
  val JALR = Value("b1100111".U)
  val JAL = Value("b1101111".U)
}

object Funct3 {
  val JALR, BEQ, LB, SB, ADDI, ADDSUB = "b000".U
  val BNE, LH, SH, SLLI, SLL = "b001".U
  val LW, SW, SLTI, SLT = "b010".U
  val SLTIU, SLTU = "b011".U
  val BLE, LBU, XORI, XOR = "b100".U
  val BGE, LHU, SRI, SR = "b101".U
  val BLTU, ORI, OR = "b110".U
  val BGEU, ANDI, AND = "b111".U
}

object Funct7 {
  val SLLI, SRLI, ADD, SLL, SLT, SLTU, XOR, SRL, AND, OR = "b0000000".U
  val SRAI, SUB, SRA = "b0100000".U
}

object ALUOp extends ChiselEnum {
  val ZERO = Value("b0000".U)
  val ADD = Value("b0001".U)
  val SUB = Value("b0010".U)
  val AND = Value("b0011".U)
  val OR  = Value("b0100".U)
  val XOR = Value("b0101".U)
  val SRA = Value("b0110".U)
  val SRL = Value("b0111".U)
  val SLL = Value("b1000".U)
  val SLT = Value("b1001".U)
  val SLTU = Value("b1010".U)
}