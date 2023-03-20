package components

import chisel3._
import chisel3.util.Enum
import common.Params.{registerAddressLen, bitWidth}


class Controller extends Module {
  val empty :: one :: two :: Nil = Enum(3)
  val stateReg = RegInit(empty)

  val io = IO(new Bundle {

  })
}
