package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities._

class MEM(dataWidth: Int, addrWidth: Int, depth: Int, simulation: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new EX_MEM_IO(dataWidth, addrWidth))
    val out = new MEM_WB_IO(dataWidth, addrWidth)
    val debug = if(simulation) Some(new debugIO(dataWidth, addrWidth)) else None
  })

  // Initialise the register
  val outReg = RegEnable(io.out, !io.stallReg)

  //----- Connect the input  ------------
  outReg.rd := io.in.rd
  outReg.aluOut := io.in.aluOut
  outReg.writeEnable := io.in.ctrl.writeEnable
  outReg.load := io.in.ctrl.load
  outReg.memOut := DontCare

  // Creating the dual read memory module
  val DRMEM = Module(new DualReadMem(addrWidth, dataWidth, depth))

  // Init the unused side of the Dual memory
  DRMEM.io.rdAddr2 := DontCare

  // Connecting the I/O through
  DRMEM.io.wren := io.in.ctrl.store
  DRMEM.io.rden := io.in.ctrl.load
  DRMEM.io.rdAddr1 := io.in.aluOut
  DRMEM.io.wrAddr := io.in.aluOut
  DRMEM.io.wrData := io.in.wrData

  if(simulation){ // Debugging
    io.debug.get.regFile := DontCare // Only used in ID
    io.debug.get.inst := DontCare
    io.debug.get.pc := DontCare
    io.debug.get.out := DontCare
    io.debug.get.memoryIO.wren := DRMEM.io.wren
    io.debug.get.memoryIO.rden := DRMEM.io.rden
    io.debug.get.memoryIO.rdAddr1 := DRMEM.io.rdAddr1
    io.debug.get.memoryIO.wrAddr := DRMEM.io.wrAddr
    io.debug.get.memoryIO.wrData := DRMEM.io.wrData
  }

  // ---------- output---------------
  io.out.rd := outReg.rd
  io.out.aluOut := outReg.aluOut
  io.out.load := outReg.load
  io.out.writeEnable := outReg.writeEnable
  io.out.memOut := DRMEM.io.rdData1
}