package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.{ALU, ForwardingUnit}

class EX(datawidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new ID_EX_IO(datawidth, addrWidth))
    val out = new EX_MEM_IO(datawidth, addrWidth)
    val PCout = Output(UInt(datawidth.W))
    val hazardAluOut = Output(UInt(datawidth.W))
  })
  // Creating the modules
  val ALU = Module(new ALU(datawidth, addrWidth))


  // Initialise signals
  io.PCout := RegInit(0.U(datawidth.W))
  val outReg = RegEnable(io.out, !io.stallReg)
  io.hazardAluOut := WireDefault(ALU.io.aluOut)

  // Connecting the I/O through
  ALU.io.aluOp := io.in.aluOp
  outReg.aluOut := ALU.io.aluOut
  outReg.ctrl.load := io.in.ctrl.load
  outReg.ctrl.store := io.in.ctrl.store
  outReg.rd := io.in.rd
  outReg.wrData := io.in.val2
  outReg.ctrl.writeEnable := !(io.in.ctrl.branch || io.in.ctrl.store)


  // Muxes
  val mux1 = Mux(io.in.ctrl.branch, io.in.pc, io.in.val1)
  val mux2 = Mux(io.in.ctrl.useImm, io.in.imm, io.in.val2)

  when(io.in.ctrl.useALU) {
    ALU.io.val1 := mux1
    ALU.io.val2 := mux2
  }.otherwise {
    ALU.io.val1 := 0.U
    ALU.io.val2 := 0.U
  }

  //-------output-------------
  io.out.aluOut := outReg.aluOut
  io.out.ctrl.load := outReg.ctrl.load
  io.out.ctrl.store := outReg.ctrl.store
//  io.out.imm := outReg.imm
  io.out.ctrl.writeEnable := outReg.ctrl.writeEnable
  io.out.rd := outReg.rd
  io.out.wrData := outReg.wrData
  io.PCout := RegNext(io.in.pc + (mux2 << 1))
}
