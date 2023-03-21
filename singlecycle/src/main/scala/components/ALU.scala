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

    val result = WireDefault(0.U(bitWidth.W))
  })

  switch(io.instruction) {
    // Arithmetic
    is(ADD)(io.result := io.a + io.b)
    is(SUB)(io.result := io.a - io.b)
    // Shifts
    is(SLL)(io.result := io.a << io.b(4, 0).asUInt)
    is(SRL)(io.result := io.a >> io.b(4, 0).asUInt)
    is(SRA)(io.result := (io.a.asSInt >> io.b(4, 0).asUInt).asUInt) // Signed
    // Logical
    is(AND)(io.result := io.a & io.b)
    is(OR)(io.result := io.a | io.b)
    is(XOR)(io.result := io.a ^ io.b)
    // Compare
    is(SLTU)(io.result := Mux(io.a < io.b, 1.U, 0.U))
    is(SLT)(io.result := Mux(io.a.asSInt < io.b.asSInt, 1.U, 0.U)) // Signed
    is(EQ)(io.result := Mux(io.a === io.b, 1.U, 0.U))
    is(NEQ)(io.result := Mux(io.a =/= io.b, 1.U, 0.U))
    is(GTE)(io.result := Mux(io.a.asSInt >= io.b.asSInt, 1.U, 0.U))
    is(GTEU)(io.result := Mux(io.a >= io.b, 1.U, 0.U))
  }
}
