package components

import chisel3._
import chisel3.util._
import common.Params._
import components.Instruction._

class ALU() extends Module {
  val io = IO(new Bundle {
    val instruction = Input(Instruction())

    val a: UInt = Input(UInt(bitWidth.W))
    val b: UInt = Input(UInt(bitWidth.W))

    val result = Output(UInt(bitWidth.W))
  })

  val out = WireDefault(0.U(bitWidth.W))

  switch(io.instruction) {
    // Arithmetic
    is(ADD)(out := io.a + io.b)
    is(SUB)(out := io.a - io.b)
    // Shifts
    is(SLL)(out := io.a << io.b(4, 0).asUInt)
    is(SRL)(out := io.a >> io.b(4, 0).asUInt)
    is(SRA)(out := (io.a.asSInt >> io.b(4, 0).asUInt).asUInt) // Signed
    // Logical
    is(AND)(out := io.a & io.b)
    is(OR)(out := io.a | io.b)
    is(XOR)(out := io.a ^ io.b)
    // Compare
    is(SLTU)(out := Mux(io.a < io.b, 1.U, 0.U))
    is(SLT)(out := Mux(io.a.asSInt < io.b.asSInt, 1.U, 0.U)) // Signed
    is(EQ)(out := Mux(io.a === io.b, 1.U, 0.U))
    is(NEQ)(out := Mux(io.a =/= io.b, 1.U, 0.U))
    is(GTE)(out := Mux(io.a.asSInt >= io.b.asSInt, 1.U, 0.U))
    is(GTEU)(out := Mux(io.a >= io.b, 1.U, 0.U))
  }

  io.result := out
}
