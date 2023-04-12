package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities._

class MEM(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new EX_MEM_IO(dataWidth, addrWidth))
    val out = new MEM_WB_IO(dataWidth, addrWidth)
  })

  // Initialise the register
  val outReg = RegEnable(io.out, !io.stallReg)

  //----- Connect the input  ------------
  outReg.rd := io.in.rd
  outReg.aluOut := io.in.aluOut

  outReg.writeEnable := io.in.ctrl.store
  outReg.memOut := DontCare

  // Creating the dual read memory module
  val DRMEM = Module(new DualReadMem(addrWidth, dataWidth))

  // Init the unused side of the Dual memory
  DRMEM.io.rdAddr2 := DontCare

  // Connecting the I/O through
  DRMEM.io.wren := io.in.ctrl.store
  DRMEM.io.rden := io.in.ctrl.load
  DRMEM.io.rdAddr1 := io.in.rd
  DRMEM.io.wrAddr := io.in.rd
  DRMEM.io.wrData := io.in.imm

  // ---------- output---------------
  io.out.rd := outReg.rd
  io.out.aluOut := outReg.aluOut
  io.out.writeEnable := outReg.writeEnable
  io.out.memOut := DRMEM.io.rdData1
}