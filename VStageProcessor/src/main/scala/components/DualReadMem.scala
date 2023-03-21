package components

import chisel3._
import chisel3.util.log2Ceil

class DualReadMem(addressSize: Int, bitWidth: Int) extends Module {
  val io = IO(new Bundle {

    val rden: Bool = Input(Bool())
    //ReadPort 1
    val rdAddr1: UInt = Input(UInt(addressSize.W))
    val rdData1: UInt = Output(UInt(bitWidth.W))
    //ReadPort 2
    val rdAddr2: UInt = Input(UInt(addressSize.W))
    val rdData2: UInt = Output(UInt(bitWidth.W))
    //Write
    val wrAddr: UInt = Input(UInt(addressSize.W))
    val wrData: UInt = Input(UInt(bitWidth.W))
    val wren: Bool = Input(Bool())
  })
  //Init
  io.rdData1 := WireInit(0.U(bitWidth.W))
  io.rdData2 := WireInit(0.U(bitWidth.W))


  val mem: SyncReadMem[UInt] = SyncReadMem(addressSize, UInt(bitWidth.W))
  when (io.rdAddr1 === 0.U){
    io.rdData1 := 0.U
  }
    .otherwise{
      io.rdData1 := mem.read(io.rdAddr1, io.rden)
    }
  when (io.rdAddr2 === 0.U) {
    io.rdData2 := 0.U
  }
    .otherwise{
      io.rdData2 := mem.read(io.rdAddr2, io.rden)
    }

  when (io.wren){
    mem.write(io.wrAddr, io.wrData)
  }
}
