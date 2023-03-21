package components

import chisel3._
import chisel3.experimental.IO

class ProgramCounter(bitWidth: Int) {
  val io = IO(new Bundle {
    val ready = Input(Bool)
    val valid = Output(Bool)
    val data_rd = Input(UInt(bitWidth.W))
    val data_wr = Input(UInt(bitWidth.W))
    val data_rdEnable = Input(Bool)
  })

  val reg = RegInit(0.U(bitWidth.W))

  when(io.ready){
    io.valid := true
    io.data_wr := reg
  }.otherwise{
    io.valid := false
    io.data_wr := 0.U
  }
  when(io.data_rdEnable){
    reg := io.data_rd
  }






}
