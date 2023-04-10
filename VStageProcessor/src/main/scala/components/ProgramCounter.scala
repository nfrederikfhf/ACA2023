package components

import Chisel.DecoupledIO
import chisel3._
import utilities._
class ProgramCounter(bitWidth: Int) extends Module{
  val io = IO(new Bundle {
    val memIO = new memoryInterface(bitWidth)
    val in = Input(UInt(bitWidth.W))
    //val step = Input(Bool())
  })
  //Init signals
  io.memIO.Request.valid := WireInit(false.B)
  io.memIO.Request.addr := WireInit(0.U(bitWidth.W))
  io.memIO.Request.writeData := WireInit(0.U(bitWidth.W))
  io.memIO.Request.store := WireInit(false.B)
  io.memIO.write.ready := WireInit(false.B)
  io.memIO.write.data := WireInit(0.U(bitWidth.W))

  val reg = RegInit(0.U(bitWidth.W))

  when(io.memIO.Response.ready){
    io.memIO.Request.valid := true.B
  }.otherwise{
    io.memIO.Request.valid := false.B
  }
    io.memIO.Request.addr := reg
    reg := io.in
}
