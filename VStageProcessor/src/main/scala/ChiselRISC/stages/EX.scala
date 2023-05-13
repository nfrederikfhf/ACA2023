package ChiselRISC.stages
import chisel3._
import ChiselRISC.utilities._
import chisel3.util._
import ChiselRISC.components.memory.RegisterFile
import ChiselRISC.components.{ADDER, ALU, ForwardingUnit}
import ChiselRISC.utilities.Funct3._

class EX(datawidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new ID_EX_IO(datawidth, addrWidth))
    val out = new EX_MEM_IO(datawidth, addrWidth)
    val PCout = Output(UInt(datawidth.W))
    val hazardAluOut = Output(UInt(datawidth.W))
    val changePC = Output(Bool())
    val newPCValue = Output(UInt(datawidth.W))
//    branch prediction
    val BRpredictionIn = Input(Bool())
    val BRbranching = Output(Bool())
    val BRbranchResult = Output(Bool())
    val BRbranchPC = Output(UInt(datawidth.W))
    val misprediction = Output(Bool())
  })

  // Creating the ALU
  val ALU = Module(new ALU(datawidth, addrWidth))

  // Initialise signals
  io.PCout := RegInit(0.U(datawidth.W))
  val outReg = RegEnable(io.out, !io.stallReg)
  io.hazardAluOut := WireDefault(ALU.io.aluOut)
  ALU.io.val1 := WireInit(0.U(datawidth.W))
  ALU.io.val2 := WireInit(0.U(datawidth.W))
  io.BRbranchResult := WireInit(0.U(datawidth.W))
  io.BRbranchPC := WireInit(0.U(datawidth.W))
  io.misprediction := WireInit(false.B)
  io.BRbranching := WireInit(false.B)

  // Connecting the I/O through
  ALU.io.aluOp := io.in.aluOp
  outReg.aluOut := Mux(io.in.ctrl.jump, io.in.pc + 4.U, ALU.io.aluOut)
  outReg.ctrl.load := io.in.ctrl.load
  outReg.ctrl.store := io.in.ctrl.store
  outReg.rd := io.in.rd
  outReg.ctrl.writeEnable := !(io.in.ctrl.branch || io.in.ctrl.store)
  outReg.memOp := io.in.memOp
  io.BRbranching := io.in.ctrl.branch
  io.BRbranchPC := io.in.pc

  // Mux for deciding whether to use immediate value
  val useImm = Mux(io.in.ctrl.useImm, io.in.imm, io.in.val2)

  // Jumping and branching
  val aluResult = Mux(ALU.io.aluOut === 0.U, false.B, true.B)
  val misprediction = Mux(io.in.ctrl.branch, !(aluResult === io.BRpredictionIn), false.B)
  val changePC = io.in.ctrl.jump || misprediction
  val newPCValue = Cat((Mux(misprediction && !aluResult, io.in.pc.asSInt + 4.asSInt, Mux(io.in.ctrl.changePC, io.in.val1.asSInt, io.in.pc.asSInt) + io.in.imm.asSInt))(datawidth - 1, 1), 0.U(1.W))


  // Loading
  when(io.in.memOp === LW) { // Load word
    outReg.wrData := io.in.val2
  }
  when(io.in.memOp === LH) { // Load halfword
    outReg.wrData := Cat(Fill(16, io.in.val2(15)), io.in.val2(15, 0))
  }
  when(io.in.memOp === LHU) { // Load halfword unsigned
    outReg.wrData := Cat(Fill(16, 0.U), io.in.val2(15, 0))
  }
  when(io.in.memOp === LB) { // Load byte
    outReg.wrData := Cat(Fill(24, io.in.val2(7)), io.in.val2(7, 0))
  }
  when(io.in.memOp === LBU) { // Load byte unsigned
    outReg.wrData := Cat(Fill(24, 0.U), io.in.val2(7, 0))
  }

  // Storing
  when(io.in.memOp === SW){ // Store word
    outReg.wrData := io.in.val2
 }
  when(io.in.memOp === SH){ // Store halfword
    outReg.wrData := Cat(Fill(16,0.U), io.in.val2(15, 0))
  }
  when(io.in.memOp === SB) { // Store byte
    outReg.wrData := Cat(Fill(24,0.U), io.in.val2(7, 0))
  }

  when(io.in.ctrl.useALU) { // ALU operations
    ALU.io.val1 := io.in.val1
    ALU.io.val2 := useImm
  }

  when(io.in.ctrl.branch) {
    when(ALU.io.aluOut === 0.U) {
      io.BRbranchResult := false.B
    } .otherwise {
      io.BRbranchResult := true.B
    }
    when(!(io.BRpredictionIn === io.BRbranchResult)){
      io.misprediction := true.B
    }
  }

  //-------output-------------
  io.out.aluOut := outReg.aluOut
  io.out.ctrl.load := outReg.ctrl.load
  io.out.ctrl.store := outReg.ctrl.store
  io.out.ctrl.writeEnable := outReg.ctrl.writeEnable
  io.out.rd := outReg.rd
  io.out.wrData := outReg.wrData
  io.out.memOp := outReg.memOp
  io.PCout := RegNext(io.in.pc + (useImm << 1))
  io.changePC := RegNext(changePC)
  io.newPCValue := RegNext(newPCValue)
}
