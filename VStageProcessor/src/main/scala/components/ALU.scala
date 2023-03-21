// See README.md for license details.

package components

import chisel3._
import chisel3.util._

class ALU (bitWidth: Int = 32) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(bitWidth.W))
    val b = Input(UInt(bitWidth.W))
    //val operation = Input(Instruction())
    val output = WireDefault(UInt(bitWidth.W))
  })

  /*switch(io.operation){
    // arithmetics
    is(ADD) {io.output := io.a + io.b}
    is(SUB) {io.output := io.a + io.b}
    // logicals
    is(AND) {io.output := io.a & io.b}
    is(OR) {io.output := io.a | io.b}
    is(XOR) {io.output := io.a ^ io.b}
    // shifts
    is(SRA) {io.output := (io.a.asSInt >> io.b(4,0).asUInt).asUInt}
    is(SRL) {io.output := io.a >> io.b(4,0)}
    is(SLL) {io.output := io.a << io.b(4,0)}
    // comparisons
    is(SLT) {io.output := Mux(io.a.asSInt < io.b.asSInt, 1.U, 0.U)}
    is(SLTU) {io.output := Mux(io.a < io.b, 1.U, 0.U)}
    is(EQ) {io.output := Mux(io.a === io.b, 1.U, 0.U)}
    is(NEQ) {io.output := Mux(io.a =/= io.b, 1.U, 0.U)}
    is(GTE) {io.output := Mux(io.a.asSInt > io.b.asSInt, 1.U, 0.U)}
    is(GTEU) {io.output := Mux(io.a > io.b, 1.U, 0.U)}
  }*/

  match a
}
