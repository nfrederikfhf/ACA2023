package components

import chisel3._
import common.Params._

class ProgramCounter {
  val io = IO(new Bundle {
    val enable = Input(Bool()) // 1 => Increment PC, 0 => Hold PC

    val writeEnable = Input(Bool())
    val writeAdd = Input(Bool()) // 1 => Add dataIn to PC, 0 => Set dataIn to PC
    val dataIn = Input(UInt(bitWidth.W))

    val counter = Output(UInt(bitWidth.W))
  })

  io.counter := RegInit(0.U(bitWidth.W))

  when(io.writeEnable) {
    io.counter := Mux(io.writeAdd,
      (io.counter.asSInt + io.dataIn.asSInt).asUInt,
      io.dataIn)
  }
  when(io.enable) {
    io.counter := io.counter + 4.U // TODO replace with instructionLen (in bytes)
  }
}
