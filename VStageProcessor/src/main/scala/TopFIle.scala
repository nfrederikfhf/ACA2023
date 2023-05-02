import chisel3._
import ChiselRISC._

import chisel3.stage.ChiselStage

object TopFIle extends App {
    (new ChiselStage).emitVerilog(new ChiselRISC(false,"InputHex.MEM"), args)
}

