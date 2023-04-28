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
  })
  // Creating the modules
  val ALU = Module(new ALU(datawidth, addrWidth))

  // Initialise signals
  io.PCout := RegInit(0.U(datawidth.W))
  val outReg = RegEnable(io.out, !io.stallReg)
  io.hazardAluOut := WireDefault(ALU.io.aluOut)
  // Connecting the I/O through
  ALU.io.aluOp := io.in.aluOp
  outReg.aluOut := Mux(io.in.ctrl.jump, io.in.pc + 4.U, ALU.io.aluOut)
  outReg.ctrl.load := io.in.ctrl.load
  outReg.ctrl.store := io.in.ctrl.store
  outReg.rd := io.in.rd
  //outReg.wrData := io.in.val2
  outReg.ctrl.writeEnable := !(io.in.ctrl.branch || io.in.ctrl.store)


  // Muxes
  val mux2 = Mux(io.in.ctrl.useImm, io.in.imm, io.in.val2)

  // Jumping and branching
  val changePC = io.in.ctrl.jump || (io.in.ctrl.branch && ALU.io.aluOut === 1.U)
  val newPCValue = Cat((Mux(io.in.ctrl.changePC, io.in.val1, io.in.pc) + io.in.imm)(datawidth - 1, 1), 0.U(1.W))


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


  when(io.in.ctrl.useALU) {
    ALU.io.val1 := io.in.val1
    ALU.io.val2 := mux2
  }.otherwise {
    ALU.io.val1 := 0.U
    ALU.io.val2 := 0.U
  }

  //-------output-------------
  io.out.aluOut := outReg.aluOut
  io.out.ctrl.load := outReg.ctrl.load
  io.out.ctrl.store := outReg.ctrl.store
  io.out.ctrl.writeEnable := outReg.ctrl.writeEnable
  io.out.rd := outReg.rd
  io.out.wrData := outReg.wrData
  io.PCout := RegNext(io.in.pc + (mux2 << 1))
  io.changePC := RegNext(changePC)
  io.newPCValue := RegNext(newPCValue)
}