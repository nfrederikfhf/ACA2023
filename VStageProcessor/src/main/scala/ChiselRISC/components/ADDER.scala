package ChiselRISC.components

import chisel3._

class ADDER (bitWidth: Int = 32, addrWidth: Int = 4) extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(bitWidth.W))
    val output = WireDefault(UInt(bitWidth.W))
  })

  io.output := io.pc + addrWidth.U
}
