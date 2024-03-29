package ChiselRISC.stages

import chisel3._
import ChiselRISC.utilities._
import chisel3.util._
import ChiselRISC.components.memory.RegisterFile
import ChiselRISC.components.{ImmGenerator, Decoder}

class ID(datawidth: Int, addrWidth: Int, simulation: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val flush = Input(Bool())
    val in = Flipped(new IF_ID_IO(datawidth))
    val wbIn = Flipped(new WB_ID_IO(datawidth, addrWidth))
    val out = new ID_EX_IO(datawidth, addrWidth)
    val hazard_IDrs1 = Output(UInt(addrWidth.W))
    val hazard_IDrs2 = Output(UInt(addrWidth.W))
    val debug = if (simulation) Some(new debugIO(datawidth, addrWidth)) else None // Debugging
    val BRpredictionIn = Input(Bool())
    val BRpredictionOut = Output(Bool())
  })

  val immGenerator = Module(new ImmGenerator(datawidth))
  val decoder = Module(new Decoder(datawidth, addrWidth))
  val regfile = Module(new RegisterFile(addrWidth, datawidth, simulation))

  //Init
  regfile.io.wren := WireInit(false.B)
  regfile.io.wrAddr := WireInit(0.U(addrWidth.W))
  regfile.io.wrData := WireInit(0.U(datawidth.W))
  decoder.io.inInst := WireInit(0.U(datawidth.W))
  io.BRpredictionOut := RegNext(io.BRpredictionIn)

  if (simulation) { // Get the register file, instruction and pc
    io.debug.get.out := DontCare // Only used in WB
    io.debug.get.memoryIO := DontCare // Only used in MEM
    io.debug.get.regFile := regfile.io.regFile.get
    io.debug.get.inst := io.in.inst
    io.debug.get.pc := io.in.pc
  }

  // Connecting the signals through
  immGenerator.io.immIn := io.in.inst
  decoder.io.inInst := io.in.inst
  regfile.io.rdAddr1 := decoder.io.rs1
  regfile.io.rdAddr2 := decoder.io.rs2
  // Write back
  regfile.io.wren := io.wbIn.writeEnable
  regfile.io.wrAddr := io.wbIn.rd
  regfile.io.wrData := io.wbIn.muxOut
  //-----Hazard Signals--------------
  io.hazard_IDrs1 := decoder.io.rs1
  io.hazard_IDrs2 := decoder.io.rs1

  //-----Control signals-----
  //flushes all control signal registers
  io.out.ctrl.branch := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.branch))
  io.out.ctrl.load := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.load))
  io.out.ctrl.store := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.store))
  io.out.ctrl.jump := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.jump))
  io.out.ctrl.useALU := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.useALU))
  io.out.ctrl.usePC := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.usePC))
  io.out.ctrl.useImm := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.useImm))
  io.out.ctrl.changePC := RegNext(Mux(io.flush, 0.U, decoder.io.ctrlSignals.changePC))


  // Forwarding from WB to ID values, incase of read/write in the same clock cycle
  val val1 = Mux(io.wbIn.writeEnable && io.wbIn.rd === decoder.io.rs1, io.wbIn.muxOut, regfile.io.rdData1)
  val val2 = Mux(io.wbIn.writeEnable && io.wbIn.rd === decoder.io.rs2, io.wbIn.muxOut, regfile.io.rdData2)

  //-----ALU signals-----
  io.out.aluOp := RegEnable(Mux(io.flush, 0.U, decoder.io.aluOp), !io.stallReg) // ALU operation
  io.out.rd := RegEnable(Mux(io.flush, 0.U, decoder.io.rd), !io.stallReg) // Destination register address
  io.out.val1 := RegEnable(Mux(io.flush, 0.U, val1), !io.stallReg) // Value read from register
  io.out.val2 := RegEnable(Mux(io.flush, 0.U, val2), !io.stallReg) // Value read from register
  io.out.imm := RegEnable(Mux(io.flush, 0.U, immGenerator.io.immOut), !io.stallReg) // Immediate value
  io.out.pc := RegEnable(Mux(io.flush, 0.U, io.in.pc), !io.stallReg) // Program counter value
  io.out.rs1 := RegEnable(Mux(io.flush, 0.U, decoder.io.rs1), !io.stallReg) // rs1 address
  io.out.rs2 := RegEnable(Mux(io.flush, 0.U, decoder.io.rs2), !io.stallReg) // rs2 address
  io.out.memOp := RegEnable(Mux(io.flush, 0.U, decoder.io.memOp), !io.stallReg) // Memory operation
}
