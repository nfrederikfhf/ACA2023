package components

import chisel3._
import chisel3.util._
import common.Params._
import components.Instruction._
import components.InstructionType._

class InstructionDecoder extends Module  {
  val io = IO(new Bundle {
    val instructionIn: UInt = Input(UInt(instructionLen.W))
    val decodedInstruction = Output(Instruction()) // Instruction is the decoded instruction

    val sourceRegister1: UInt = Output(UInt(registerAddressLen.W))
    val sourceRegister2: UInt = Output(UInt(registerAddressLen.W))
    val destinationRegister: UInt = Output(UInt(registerAddressLen.W))

    val useImmediate: Bool = Output(Bool())
    val immediate: SInt = Output(SInt(bitWidth.W))

    val useALU: Bool = Output(Bool())
    val branch: Bool = Output(Bool()) // jump and link
    val jump: Bool = Output(Bool())

    val load: Bool = Output(Bool())
    val store: Bool = Output(Bool())
  })

  // Source of the following code snippet: https://github.com/carlosedp/chiselv/blob/main/chiselv/src/Decoder.scala
  // TODO please rewrite it if you can
  val lookup = ListLookup(io.instructionIn,
    List(IN_ERR, ERR_INST, false.B, false.B, false.B, false.B, false.B, false.B), // Default values
    Array(
      /*                                                inst_type,     inst   to_alu   branch   use_imm   jump      is_load   is_store */
      // Arithmetic
      BitPat("b0000000??????????000?????0110011") -> List(INST_R, ADD, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????000?????0010011") -> List(INST_I, ADDI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0100000??????????000?????0110011") -> List(INST_R, SUB, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????????????0110111") -> List(INST_U, LUI, false.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????????????0010111") -> List(INST_U, AUIPC, false.B, false.B, true.B, false.B, false.B, false.B),
      // Shifts
      BitPat("b0000000??????????001?????0110011") -> List(INST_R, SLL, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b0000000??????????001?????0010011") -> List(INST_I, SLLI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0000000??????????101?????0110011") -> List(INST_R, SRL, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b0000000??????????101?????0010011") -> List(INST_I, SRLI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0100000??????????101?????0110011") -> List(INST_R, SRA, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b0100000??????????101?????0010011") -> List(INST_I, SRAI, true.B, false.B, true.B, false.B, false.B, false.B),
      // Logical
      BitPat("b0000000??????????100?????0110011") -> List(INST_R, XOR, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????100?????0010011") -> List(INST_I, XORI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0000000??????????110?????0110011") -> List(INST_R, OR, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????110?????0010011") -> List(INST_I, ORI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0000000??????????111?????0110011") -> List(INST_R, AND, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????111?????0010011") -> List(INST_I, ANDI, true.B, false.B, true.B, false.B, false.B, false.B),
      // Compare
      BitPat("b0000000??????????010?????0110011") -> List(INST_R, SLT, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????010?????0010011") -> List(INST_I, SLTI, true.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b0000000??????????011?????0110011") -> List(INST_R, SLTU, true.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????011?????0010011") -> List(INST_I, SLTIU, true.B, false.B, true.B, false.B, false.B, false.B),
      // Branches
      BitPat("b?????????????????000?????1100011") -> List(INST_B, BEQ, false.B, true.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????001?????1100011") -> List(INST_B, BNE, false.B, true.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????100?????1100011") -> List(INST_B, BLT, false.B, true.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????101?????1100011") -> List(INST_B, BGE, false.B, true.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????110?????1100011") -> List(INST_B, BLTU, false.B, true.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????111?????1100011") -> List(INST_B, BGEU, false.B, true.B, true.B, false.B, false.B, false.B),
      // Jump & link
      BitPat("b?????????????????????????1101111") -> List(INST_J, JAL, false.B, false.B, true.B, true.B, false.B, false.B),
      BitPat("b?????????????????000?????1100111") -> List(INST_I, JALR, false.B, false.B, true.B, true.B, false.B, false.B),
      // Sync
      BitPat("b0000????????00000000000000001111") -> List(INST_I, FENCE, false.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b00000000000000000000001000001111") -> List(INST_I, FENCEI, false.B, false.B, true.B, false.B, false.B, false.B),
      // Environment
      BitPat("b00000000000000000000000001110011") -> List(INST_I, ECALL, false.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b00000000000100000000000001110011") -> List(INST_I, EBREAK, false.B, false.B, false.B, false.B, false.B, false.B),
      // CSR
      BitPat("b?????????????????001?????1110011") -> List(INST_I, CSRRW, false.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????010?????1110011") -> List(INST_I, CSRRS, false.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????011?????1110011") -> List(INST_I, CSRRC, false.B, false.B, false.B, false.B, false.B, false.B),
      BitPat("b?????????????????101?????1110011") -> List(INST_I, CSRRWI, false.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????110?????1110011") -> List(INST_I, CSRRSI, false.B, false.B, true.B, false.B, false.B, false.B),
      BitPat("b?????????????????111?????1110011") -> List(INST_I, CSRRCI, false.B, false.B, true.B, false.B, false.B, false.B),
      // Loads
      BitPat("b?????????????????000?????0000011") -> List(INST_I, LB, false.B, false.B, true.B, false.B, true.B, false.B),
      BitPat("b?????????????????001?????0000011") -> List(INST_I, LH, false.B, false.B, true.B, false.B, true.B, false.B),
      BitPat("b?????????????????100?????0000011") -> List(INST_I, LBU, false.B, false.B, true.B, false.B, true.B, false.B),
      BitPat("b?????????????????101?????0000011") -> List(INST_I, LHU, false.B, false.B, true.B, false.B, true.B, false.B),
      BitPat("b?????????????????010?????0000011") -> List(INST_I, LW, false.B, false.B, true.B, false.B, true.B, false.B),
      // Stores
      BitPat("b?????????????????000?????0100011") -> List(INST_S, SB, false.B, false.B, true.B, false.B, false.B, true.B),
      BitPat("b?????????????????001?????0100011") -> List(INST_S, SH, false.B, false.B, true.B, false.B, false.B, true.B),
      BitPat("b?????????????????010?????0100011") -> List(INST_S, SW, false.B, false.B, true.B, false.B, false.B, true.B),
    )
  )

  io.destinationRegister := 0.U
  io.sourceRegister1 := 0.U
  io.sourceRegister2 := 0.U
  io.immediate := 0.S
  
  io.decodedInstruction := lookup(1)
  io.useALU := lookup(2)
  io.branch := lookup(3)
  io.useImmediate := lookup(4)
  io.jump := lookup(5)
  io.load := lookup(6)
  io.store := lookup(7)

  // TODO I am not sure if it is the best way to do this


  switch(lookup.head) {
    is(INST_R) {
      io.destinationRegister := io.instructionIn(11, 7)
      io.sourceRegister1 := io.instructionIn(19, 15)
      io.sourceRegister2 := io.instructionIn(24, 20)
    }
    is(INST_I) {
      io.destinationRegister := io.instructionIn(11, 7)
      io.sourceRegister1 := io.instructionIn(19, 15)
      io.immediate := Cat(Fill(20, io.instructionIn(31)), io.instructionIn(31, 20)).asSInt
    }
    is(INST_S) {
      io.sourceRegister1 := io.instructionIn(19, 15)
      io.sourceRegister2 := io.instructionIn(24, 20)
      io.immediate := Cat(Fill(20, io.instructionIn(31)), io.instructionIn(31, 25), io.instructionIn(11, 7)).asSInt
    }
    is(INST_B) {
      io.sourceRegister1 := io.instructionIn(19, 15)
      io.sourceRegister2 := io.instructionIn(24, 20)
      io.immediate := Cat(Fill(19, io.instructionIn(31)), io.instructionIn(31), io.instructionIn(7), io.instructionIn(30, 25), io.instructionIn(11, 8), 0.U(1.W)).asSInt
    }
    is(INST_U) {
      io.destinationRegister := io.instructionIn(11, 7)
      io.immediate := Cat(io.instructionIn(31, 12), Fill(12, 0.U)).asSInt
    }
    is(INST_J) {
      io.destinationRegister := io.instructionIn(11, 7)
      io.immediate := Cat(Fill(11, io.instructionIn(31)), io.instructionIn(31), io.instructionIn(19, 12), io.instructionIn(20), io.instructionIn(30, 25), io.instructionIn(24, 21), 0.U(1.W)).asSInt
    }
    // INST_Z is not covered
  }
}

