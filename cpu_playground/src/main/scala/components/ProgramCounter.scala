package components

import Chisel.DecoupledIO
import chisel3._

class ProgramCounter(bitWidth: Int) extends Module{
  val io = IO(new Bundle {
    val data_rd = Input(UInt(bitWidth.W))
    val data_wr = new DecoupledIO(UInt(bitWidth.W))
    val data_rdEnable = Input(Bool())
  })
  //Init signals
  io.data_wr.valid := WireInit(false.B)
  io.data_wr.bits := WireInit(0.U(bitWidth.W))
  val reg = RegInit(0.U(bitWidth.W))

  when(io.data_wr.ready){
    io.data_wr.valid := true.B
    io.data_wr.bits := reg
  }.otherwise{
    io.data_wr.valid := false.B
    io.data_wr.bits := 0.U
  }
  when(io.data_rdEnable){
    reg := io.data_rd
  }






}
