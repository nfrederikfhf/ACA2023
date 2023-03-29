// See README.md for license details.

package components

import chisel3._
import chisel3.util._
import utilities.Funct7._
import utilities._

class ALU (bitWidth: Int = 32, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
//    val a = Input(UInt(bitWidth.W))
//    val b = Input(UInt(bitWidth.W))
    //val operation = Input(Funct7)
    val output = WireDefault(UInt(bitWidth.W))
    val in = Flipped(new ID_EX_IO(bitWidth, addrWidth))
    val out = new EX_MEM_IO(bitWidth, addrWidth)
  })

  val (op,_) = ALUOp.safe(io.in.ALUOp)

  switch(op){
    // arithmetics
    is(ALUOp.ADD) {io.out.aluOut := io.in.val1 + io.in.val2}
    is(SUB) {io.output := io.in.val1 + io.in.val2}
    // logicals
    is(AND) {io.output := io.in.val1 & io.in.val2}
    is(OR) {io.output := io.in.val1 | io.in.val2}
    is(XOR) {io.output := io.in.val1 ^ io.in.val2}
    // shifts
    is(SRA) {io.output := (io.in.val1.asSInt >> io.in.val2(4,0).asUInt).asUInt}
    is(SRL) {io.output := io.in.val1 >> io.in.val2(4,0)}
    is(SLL) {io.output := io.in.val1 << io.in.val2(4,0)}
    // comparisons
    is(SLT) {io.output := Mux(io.in.val1.asSInt < io.in.val2.asSInt, 1.U, 0.U)}
    is(SLTU) {io.output := Mux(io.in.val1 < io.in.val2, 1.U, 0.U)}
//    is(EQ) {io.output := Mux(io.a === io.b, 1.U, 0.U)}
//    is(NEQ) {io.output := Mux(io.a =/= io.b, 1.U, 0.U)}
//    is(GTE) {io.output := Mux(io.a.asSInt > io.b.asSInt, 1.U, 0.U)}
//    is(GTEU) {io.output := Mux(io.a > io.b, 1.U, 0.U)}
  }

  //match a
}
