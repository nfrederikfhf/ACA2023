package components

import chisel3._
import common.Params.{instructionLen, memoryAddressLen, bitWidth}

class DualReadMem() extends Module {
  val io = IO(new Bundle {
    // Control
    val readEnable1: Bool = Input(Bool())
    val readEnable2: Bool = Input(Bool())
    val writeEnable: Bool = Input(Bool())

    // ReadPort 1
    val readAddress1: UInt = Input(UInt(memoryAddressLen.W))
    val readData1: UInt = Output(UInt(bitWidth.W))

    // ReadPort 2
    val readAddress2: UInt = Input(UInt(memoryAddressLen.W))
    val readData2: UInt = Output(UInt(bitWidth.W))

    // Write
    val writeAddress: UInt = Input(UInt(memoryAddressLen.W))
    val writeData: UInt = Input(UInt(bitWidth.W))
  })

  val mem: SyncReadMem[UInt] = SyncReadMem(memoryAddressLen, UInt(bitWidth.W))
  when(io.readAddress1 === 0.U) {
    io.readData1 := 0.U
  }.otherwise {
    io.readData1 := mem.read(io.readAddress1, io.readEnable1)
  }
  when(io.readAddress2 === 0.U) {
    io.readData2 := 0.U
  }.otherwise {
    io.readData2 := mem.read(io.readAddress2, io.readEnable2)
  }

  when(io.writeEnable) {
    mem.write(io.writeAddress, io.writeData)
  }
}


class InstructionMemory(mem: DualReadMem) extends Module {
  val io = IO(new Bundle {
    val readAddress: UInt = Input(UInt(memoryAddressLen.W))
    val instruction: UInt = Output(UInt(instructionLen.W))
  })

  mem.io.readEnable1 := true.B // TODO Is it okay?
  mem.io.readAddress1 := io.readAddress
  io.instruction := mem.io.readData1
}

class DataMemory(mem: DualReadMem) extends Module {
  val io = IO(new Bundle {
    val rdEn: Bool = Input(Bool())
    val readAddress: UInt = Input(UInt(memoryAddressLen.W))
    val readData: UInt = Output(UInt(bitWidth.W))

    val writeEnable: Bool = Input(Bool())
    val writeAddress: UInt = Input(UInt(memoryAddressLen.W))
    val writeData: UInt = Input(UInt(bitWidth.W))
  })

  mem.io.readEnable2 := io.rdEn
  mem.io.readAddress2 := io.readAddress
  io.readData := mem.io.readData2

  io.writeEnable := mem.io.writeEnable
  io.writeAddress := mem.io.writeAddress
  io.writeData := mem.io.writeData
}
