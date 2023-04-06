package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.ALU

class EX(datawidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new ID_EX_IO(datawidth, addrWidth))
    val out = new EX_MEM_IO(datawidth, addrWidth)
    val PCout = Output(UInt(datawidth.W))
  })
  // Creating the modules
  val ALU = Module(new ALU(datawidth, addrWidth))

  // Initialise signals
  io.out.aluOut := RegInit(0.U(datawidth.W))
  io.out.ctrl.load := RegInit(false.B)
  io.out.ctrl.store := RegInit(false.B)
  io.out.imm := RegInit(0.U(datawidth.W))
  io.PCout := RegInit(0.U(datawidth.W))

  // Connecting the I/O through
  ALU.io.aluOp := io.in.aluOp
  io.out.aluOut := ALU.io.aluOut
  io.out.ctrl.load := io.in.ctrl.load
  io.out.ctrl.store := io.in.ctrl.store
  io.out.imm := io.in.imm
  io.out.rd := io.in.rd


  // Muxes
  val mux1 = Mux(io.in.ctrl.branch, io.in.pc, io.in.val1)
  val mux2 = Mux(io.in.ctrl.useImm, io.in.imm, io.in.val2)

  when(io.in.ctrl.useALU) {
    ALU.io.val1 := RegNext(mux1)
    ALU.io.val2 := RegNext(mux2)
  }.otherwise {
    ALU.io.val1 := 0.U
    ALU.io.val2 := 0.U
  }

  //-------output-------------
//  ALU.io.val1 := RegNext(mux1)
//  ALU.io.val2 := RegNext(mux2)
  io.PCout := RegNext(io.in.pc + (mux2 << 1))
}
