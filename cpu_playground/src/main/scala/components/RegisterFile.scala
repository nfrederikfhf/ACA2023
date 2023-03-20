package components
import chisel3._
import chisel3.experimental.IO

class RegisterFile(addressSize: Int, bitWidth: Int) {
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

  val registers = RegInit(Vec(addressSize, UInt(bitWidth.W)))
  when(io.rdAddr1 === 0.U) {
    io.rdData1 := 0.U
  }
    .otherwise {
      io.rdData1 := registers(io.rdAddr1)
    }
  when(io.rdAddr2 === 0.U) {
    io.rdData2 := 0.U
  }
    .otherwise {
      io.rdData2 := registers(io.rdAddr2)
    }

  when(io.wren) {
    registers(io.wrAddr) := io.wrData
  }

}
