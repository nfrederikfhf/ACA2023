import chisel3._
import ChiselRISC._
import _root_.ChiselRISC.utilities.Binaries.loadWords
import chisel3.stage.ChiselStage

object TopFile extends App {
    (new ChiselStage).emitVerilog(new ChiselRISC(false,loadWords("/home/williammathiassen/Github/ACA2023/VStageProcessor/asm/Input2.bin")), args)
}

