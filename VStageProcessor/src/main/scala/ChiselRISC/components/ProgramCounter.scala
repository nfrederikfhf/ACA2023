package ChiselRISC.components

import Chisel.DecoupledIO
import chisel3._
import ChiselRISC.utilities._
class ProgramCounter(bitWidth: Int) extends Module{
  val io = IO(new Bundle {
    val memIO = new memoryInterfaceLight(bitWidth)
    val in = Input(UInt(bitWidth.W))
  })
  //Init signals
  io.memIO.valid := WireInit(false.B)
  io.memIO.nonEmpty := DontCare
  io.memIO.writeData := DontCare
  io.memIO.write := DontCare
  io.memIO.addr := WireInit(0.U(bitWidth.W))


  val reg = RegInit(0.U(bitWidth.W))

  when(io.memIO.ready){
    io.memIO.valid := true.B
  }.otherwise{
    io.memIO.valid := false.B
  }
    io.memIO.addr := reg
    reg := io.in
}
