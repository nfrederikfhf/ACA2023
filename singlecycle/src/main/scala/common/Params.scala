package common

import chisel3.util.log2Up

object Params {
  val bitWidth = 32
  val memoryAddressLen = bitWidth
  val instructionLen = bitWidth

  val registers = 32
  val registerAddressLen = log2Up(registers)
}
