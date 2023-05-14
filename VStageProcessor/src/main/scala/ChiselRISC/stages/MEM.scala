package ChiselRISC.stages
import chisel3.{util, _}
import chisel3.util._
import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.utilities._

class MEM(dataWidth: Int, addrWidth: Int, depth: Int, simulation: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new EX_MEM_IO(dataWidth, addrWidth))
    val out = new MEM_WB_IO(dataWidth, addrWidth)
    val debug = if(simulation) Some(new debugIO(dataWidth, addrWidth)) else None
    val mem_fwd = new forwardingIO(dataWidth, addrWidth)
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
  //val MEM = Module(new DualReadMem(addrWidth, dataWidth, depth))
  val MEM = Module(new SyncBankMemory(dataWidth, depth, 4))

  // Init the unused side of the Dual memory
  MEM.io.rdAddr2 := DontCare

  // Connecting the I/O through
  MEM.io.wren := io.in.ctrl.store
  MEM.io.rden := io.in.ctrl.load
  MEM.io.rdAddr1 := io.in.aluOut
  MEM.io.wrAddr := io.in.aluOut
  MEM.io.wrData := io.in.wrData
  MEM.io.memOp := io.in.memOp

  if(simulation){ // Debugging
    io.debug.get.regFile := DontCare // Only used in ID
    io.debug.get.inst := DontCare
    io.debug.get.pc := DontCare
    io.debug.get.out := DontCare
    io.debug.get.memoryIO.wren := MEM.io.wren
    io.debug.get.memoryIO.rden := MEM.io.rden
    io.debug.get.memoryIO.rdAddr1 := MEM.io.rdAddr1
    io.debug.get.memoryIO.wrAddr := MEM.io.wrAddr
    io.debug.get.memoryIO.wrData := MEM.io.wrData
  }

  // ---------- output---------------
  io.out.rd := outReg.rd
  io.out.aluOut := outReg.aluOut
  io.out.load := outReg.load
  io.out.writeEnable := outReg.writeEnable
  io.out.memOut := MEM.io.rdData1

  //------------ Forwarding----------------
  io.mem_fwd.rd := Mux(io.in.ctrl.load, 0.U ,io.in.rd) // Dont allow for forwarding on load
  io.mem_fwd.stageOutput := Mux(io.in.ctrl.load, 0.U, io.in.aluOut)
  io.mem_fwd.writeEnable := Mux(io.in.ctrl.load, false.B, io.in.ctrl.writeEnable)
}