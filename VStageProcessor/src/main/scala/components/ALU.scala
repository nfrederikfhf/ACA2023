// See README.md for license details.

package components

import chisel3._
import chisel3.util._
import utilities.Funct7._
import utilities._

class ALU (bitWidth: Int = 32, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
//    val output = WireDefault(UInt(bitWidth.W))
    val in = Flipped(new ID_EX_IO(bitWidth, addrWidth))
    val out = new EX_MEM_IO(bitWidth, addrWidth)
  })

  io.out.ctrl.load := false.B
  io.out.ctrl.store := false.B
  io.out.rd := 0.U(addrWidth.W)
  io.out.aluOut := WireDefault(0.U(bitWidth.W))

  val (op,_) = ALUOp.safe(io.in.ALUOp)

  switch(op){
    // arithmetics
    is(ALUOp.ADD) {io.out.aluOut := io.in.val1 + io.in.val2}
    is(ALUOp.SUB) {io.out.aluOut := io.in.val1 - io.in.val2}
//    // logicals
    is(ALUOp.AND) {io.out.aluOut := io.in.val1 & io.in.val2}
    is(ALUOp.OR) {io.out.aluOut := io.in.val1 | io.in.val2}
    is(ALUOp.XOR) {io.out.aluOut := io.in.val1 ^ io.in.val2}
    // shifts
    is(ALUOp.SRA) {io.out.aluOut := (io.in.val1.asSInt >> io.in.val2(4,0).asUInt).asUInt}
    is(ALUOp.SRL) {io.out.aluOut := io.in.val1 >> io.in.val2(4,0)}
    is(ALUOp.SLL) {io.out.aluOut := io.in.val1 << io.in.val2(4,0)}
    // comparisons
    is(ALUOp.SLT) {io.out.aluOut := Mux(io.in.val1.asSInt < io.in.val2.asSInt, 1.U, 0.U)}
    is(ALUOp.SLTU) {io.out.aluOut := Mux(io.in.val1 < io.in.val2, 1.U, 0.U)}
//    is(ALUOp.EQ) {io.output := Mux(io.a === io.b, 1.U, 0.U)}
//    is(ALUOp.NEQ) {io.output := Mux(io.a =/= io.b, 1.U, 0.U)}
//    is(ALUOp.GTE) {io.output := Mux(io.a.asSInt > io.b.asSInt, 1.U, 0.U)}
//    is(ALUOp.GTEU) {io.output := Mux(io.a > io.b, 1.U, 0.U)}
  }

  //match a
}
