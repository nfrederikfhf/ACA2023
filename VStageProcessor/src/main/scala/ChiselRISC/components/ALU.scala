// See README.md for license details.

package ChiselRISC.components

import chisel3._
import chisel3.util._
import ChiselRISC.utilities.Funct7._
import ChiselRISC.utilities._

class ALU (bitWidth: Int = 32, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val aluOp = Input(UInt(4.W))
    val val1 = Input(UInt(bitWidth.W))
    val val2 = Input(UInt(bitWidth.W))
    val aluOut = Output(UInt(bitWidth.W))
  })
  io.aluOut := WireInit(0.U(bitWidth.W))

  val (op,_) = ALUOp.safe(io.aluOp)

  switch(op){
    // arithmetics
    is(ALUOp.ADD) {io.aluOut := io.val1 + io.val2}
    is(ALUOp.SUB) {io.aluOut := io.val1 - io.val2}
    // logicals
    is(ALUOp.AND) {io.aluOut := io.val1 & io.val2}
    is(ALUOp.OR) {io.aluOut := io.val1 | io.val2}
    is(ALUOp.XOR) {io.aluOut := io.val1 ^ io.val2}
    // shifts
    is(ALUOp.SRA) {io.aluOut := (io.val1.asSInt >> io.val2(4,0).asUInt).asUInt}
    is(ALUOp.SRL) {io.aluOut := io.val1 >> io.val2(4,0)}
    is(ALUOp.SLL) {io.aluOut := io.val1 << io.val2(4,0)}
    // comparisons
    is(ALUOp.SLT) {io.aluOut := Mux(io.val1.asSInt < io.val2.asSInt, 1.U, 0.U)}
    is(ALUOp.SLTU) {io.aluOut := Mux(io.val1 < io.val2, 1.U, 0.U)}
    is(ALUOp.BEQ) {io.aluOut := Mux(io.val1 === io.val2, 1.U, 0.U)}
    is(ALUOp.BLT) {io.aluOut := Mux(io.val1.asSInt < io.val2.asSInt, 1.U, 0.U)}       //same as SLT
    is(ALUOp.BGE) {io.aluOut := Mux(io.val1.asSInt >= io.val2.asSInt, 1.U, 0.U)}
    is(ALUOp.BNE) {io.aluOut := Mux(io.val1.asSInt =/= io.val2.asSInt, 1.U, 0.U)}
    is(ALUOp.BLTU) {io.aluOut := Mux(io.val1 < io.val2, 1.U, 0.U)}                    //same as SLTU
    is(ALUOp.BGEU) {io.aluOut := Mux(io.val1 >= io.val2, 1.U, 0.U)}
  }
}
