package components.memory

import chisel3._
import chisel3.util.log2Ceil

class DualReadMem(addrWidth: Int, dataWidth: Int, depth: Int) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {
    // Read Enable
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
  val rdData1 = WireInit(UInt(dataWidth.W), DontCare) // To allow for reading next clock cycle
  val rdData2 = WireInit(UInt(dataWidth.W), DontCare)
  val readAddress1 = WireInit(UInt((addrWidth).W), DontCare) // To allow for reading next clock cycle
  val readAddress2 = WireInit(UInt(addrWidth.W), DontCare)
  val writeAddress = WireInit(0.U(addrWidth.W))

  // Instantiate the memory, syncronous read
  val mem: SyncReadMem[UInt] = SyncReadMem(actualDepth, UInt(dataWidth.W))

  when(io.rden) { // Calculate the address to read from
    // Divide by four to get the correct address due to pc+4 addressing
    readAddress1 := io.rdAddr1 >> 2
    readAddress2 := io.rdAddr2 >> 2
    rdData1 := mem.read(readAddress1)
    rdData2 := mem.read(readAddress2)
  }

  when(io.rden || RegNext(io.rden)) { // Only update the output if the read is enabled, or if it was enabled last cycle
    io.rdData1 := rdData1
    io.rdData2 := rdData2
  }

  when(io.wren) {
    writeAddress := io.wrAddr >> 2
    mem.write(writeAddress, io.wrData)
  }
}
