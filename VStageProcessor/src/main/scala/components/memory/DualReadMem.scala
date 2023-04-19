package components.memory

import chisel3._
import chisel3.util.log2Ceil

class DualReadMem(addrWidth: Int, dataWidth: Int, depth: Int) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {

    val rden: Bool = Input(Bool())
    //ReadPort 1
    val rdAddr1: UInt = Input(UInt(addrWidth.W))
    val rdData1: UInt = Output(UInt(dataWidth.W))
    //ReadPort 2
    val rdAddr2: UInt = Input(UInt(addrWidth.W))
    val rdData2: UInt = Output(UInt(dataWidth.W))
    //Write
    val wrAddr: UInt = Input(UInt(addrWidth.W))
    val wrData: UInt = Input(UInt(dataWidth.W))
    val wren: Bool = Input(Bool())
  })
  //Init
  io.rdData1 := WireInit(0.U(dataWidth.W))
  io.rdData2 := WireInit(0.U(dataWidth.W))
  // Divide by four to get the correct address due to pc+4 addressing
  val readAddress1 = WireInit(0.U(addrWidth.W))
  val readAddress2 = WireInit(0.U(addrWidth.W))
  val writeAddress = WireInit(0.U(addrWidth.W))


  val mem: SyncReadMem[UInt] = SyncReadMem(actualDepth, UInt(dataWidth.W))
  when (io.rdAddr1 === 0.U){
    io.rdData1 := 0.U
  }.elsewhen(io.rden){
    readAddress1 := io.rdAddr1 >> 2
    io.rdData1 := mem.read(readAddress1)
  }.otherwise{
      io.rdData1 := 0.U
  }

  when (io.rdAddr2 === 0.U) {
    io.rdData2 := 0.U
  }.elsewhen(io.rden) {
    readAddress2 := io.rdAddr2 >> 2
    io.rdData2 := mem.read(readAddress2)
  }.otherwise{
      io.rdData2 := 0.U
  }

  when (io.wren){
    writeAddress := io.wrAddr >> 2
    mem.write(writeAddress, io.wrData)
  }
}
