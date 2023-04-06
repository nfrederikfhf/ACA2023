package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities._

class MEM(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new EX_MEM_IO(dataWidth, addrWidth))
    val out = new MEM_WB_IO(dataWidth, addrWidth)
  })
  // Initialise signals
  io.out.aluOut := RegInit(0.U(dataWidth.W))
  io.out.rd := RegInit(0.U(addrWidth.W))
  io.out.memOut := RegInit(0.U(dataWidth.W))
  io.out.writeEnable := RegInit(false.B)

  // Creating the dual read memory module
  val DRMEM = Module(new DualReadMem(addrWidth, dataWidth))

  // Init the unused side of the Dual memory
  DRMEM.io.rdAddr2 := WireInit(0.U(addrWidth.W))

  // Connecting the I/O through
  DRMEM.io.wren := io.in.ctrl.store
  DRMEM.io.rden := io.in.ctrl.load
  DRMEM.io.rdAddr1 := io.in.rd
  DRMEM.io.wrAddr := io.in.rd
  DRMEM.io.wrData := io.in.imm
  io.out.memOut := DRMEM.io.rdData1
  io.out.rd := io.in.rd
  io.out.writeEnable := io.in.ctrl.load
}