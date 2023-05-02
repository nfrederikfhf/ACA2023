import chisel3._
import ChiselRISC._

import chisel3.stage.ChiselStage

object TopFIle extends App {
    (new ChiselStage).emitVerilog(new ChiselRISC(false,"C:/Users/frede/Desktop/UNI/MSc/02211 - Advanced Computer Architecture/ACA2023/VStageProcessor/InputHex.MEM"), args)
}

