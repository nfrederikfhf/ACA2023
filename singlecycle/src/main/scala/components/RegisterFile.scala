package components

import chisel3._
import common.Params
import common.Params.{bitWidth, registerAddressLen}


class RegisterFile extends Module {
  val io = IO(new Bundle {
    // Read
    val sourceRegister1: UInt = Input(UInt(registerAddressLen.W))
    val sourceRegister2: UInt = Input(UInt(registerAddressLen.W))

    // Write
    val writeEnable: Bool = Input(Bool())
    val writeData: UInt = Input(UInt(bitWidth.W))
    val destinationRegister: UInt = Input(UInt(registerAddressLen.W))

    // Output register values
    val out1: UInt = Output(UInt(bitWidth.W))
    val out2: UInt = Output(UInt(bitWidth.W))
  })

  val registers = RegInit(VecInit(Seq.fill(Params.registers)(0.S(bitWidth.W))))
  registers(0) := 0.S // Register x0 is always 0

  io.out1 := registers(io.sourceRegister1)
  io.out2 := registers(io.sourceRegister2)

  when(io.writeEnable) {
    when(io.destinationRegister === 0.U) {
      registers(io.destinationRegister) := 0.S
    }.otherwise {
      registers(io.destinationRegister) := io.writeData
    }
  }
}
