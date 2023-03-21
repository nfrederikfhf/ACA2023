package components

import Chisel.DecoupledIO
import chisel3._

class ProgramCounter(bitWidth: Int) extends Module{
  val io = IO(new Bundle {
    val data_rd = Flipped(DecoupledIO(UInt(bitWidth.W)))
    val data_wr = new DecoupledIO(UInt(bitWidth.W))
  })
  //Init signals
  io.data_wr.valid := WireInit(false.B)
  io.data_wr.bits := WireInit(0.U(bitWidth.W))
  io.data_rd.ready := WireInit(false.B)
  val reg = RegInit(0.U(bitWidth.W))

  when(io.data_wr.ready){
    io.data_wr.valid := true.B
    io.data_wr.bits := reg
  }.otherwise{
    io.data_wr.valid := false.B
    io.data_wr.bits := 0.U
  }
  when(io.data_rd.valid){
    reg := io.data_rd.bits
  }






}
