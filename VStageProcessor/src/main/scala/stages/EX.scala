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
    val PCout = Input(UInt(datawidth.W))
  })
  // Creating the modules
  val ALU = Module(new ALU(datawidth, addrWidth))

  // Initialise signals
  ALU.io.aluOut := WireInit(0.U(datawidth.W))
  io.out.aluOut := WireInit(0.U(datawidth.W))
  io.out.ctrl.load := WireInit(false.B)
  io.out.ctrl.store := WireInit(false.B)
  io.out.imm := WireInit(0.U(datawidth.W))


  // Connecting the I/O through
  ALU.io.aluOp := io.in.aluOp
  io.out.aluOut := ALU.io.aluOut
  io.out.ctrl.load := io.in.ctrl.load
  io.out.ctrl.store := io.in.ctrl.store
  io.out.imm := io.in.imm

  val mux1 = Mux(io.in.ctrl.addToPC, io.in.pc, io.in.val1)
  val mux2 = Mux(io.in.ctrl.useImm, io.in.imm, io.in.val2)

  ALU.io.val1 := mux1
  ALU.io.val2 := mux2

  io.PCout := io.in.pc + (mux2 << 1)

}
