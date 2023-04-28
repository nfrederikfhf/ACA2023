package ChiselRISC

import components.{ForwardingUnit, HazardControl}
import stages._
import utilities.{debugIO, memoryInterface, memoryInterfaceLight}
import chisel3._



class ChiselRISC(simulation: Boolean = false) extends Module{
  val io = IO(new Bundle{
    val memIO = Flipped(new memoryInterfaceLight(32))
    val startPipeline = Input(Bool())
    val debug = if(simulation) Some(new debugIO(32, 5)) else None
    val WB_out = Output(UInt(32.W))
  })
  // Pipeline ChiselRISC.stages
  val IF = Module(new IF(32, 100, simulation))
  val ID = Module(new ID(32, 5, simulation))
  val EX = Module(new EX(32, 5))
  val MEM = Module(new MEM(32, 5, 100, simulation))
  val WB = Module(new WB(32, 5))
  // Forwarding and Hazard Control units
  val forwardingUnit = Module(new ForwardingUnit(32, 5))
  val hazardControl = Module(new HazardControl(32, 5))
  // Connect the pipeline ChiselRISC.stages
  IF.io.out <> ID.io.in
  IF.io.changePC := EX.io.changePC
  IF.io.newPCValue := EX.io.newPCValue
  EX.io.in.pc := ID.io.out.pc
  EX.io.in.rs1 := ID.io.out.rs1
  EX.io.in.rs2 := ID.io.out.rs2
  EX.io.in.rd := ID.io.out.rd
  EX.io.in.imm := ID.io.out.imm
  EX.io.in.aluOp := ID.io.out.aluOp
  EX.io.in.ctrl := ID.io.out.ctrl
  EX.io.in.memOp := ID.io.out.memOp
  EX.io.out <> MEM.io.in
  MEM.io.out <> WB.io.in
  WB.io.out <> ID.io.wbIn
  ID.io.stallReg := IF.io.stallReg
  EX.io.stallReg := ID.io.stallReg
  MEM.io.stallReg := EX.io.stallReg
  WB.io.stallReg := MEM.io.stallReg

  // Connect the forwarding unit
  forwardingUnit.io.id_rs1 := ID.io.out.rs1
  forwardingUnit.io.id_rs2 := ID.io.out.rs2
  forwardingUnit.io.id_val1 := ID.io.out.val1
  forwardingUnit.io.id_val2 := ID.io.out.val2
  forwardingUnit.io.mem_fwd <> MEM.io.mem_fwd
  forwardingUnit.io.wb_fwd <> WB.io.wb_fwd
  EX.io.in.val1 := forwardingUnit.io.val1
  EX.io.in.val2 := forwardingUnit.io.val2

  // Connect the hazard control unit
  IF.io.flush := hazardControl.io.IFFlush
  ID.io.flush := hazardControl.io.IDFlush
  IF.io.stallReg := hazardControl.io.IFStall
  hazardControl.io.EXaluOut := EX.io.hazardAluOut
  hazardControl.io.EXctrlBranch := EX.io.in.ctrl.branch
  hazardControl.io.EXctrlJump := EX.io.in.ctrl.jump
  hazardControl.io.EXctrlLoad := EX.io.in.ctrl.load
  hazardControl.io.EXrd := EX.io.in.rd
  hazardControl.io.IDrs1 := ID.io.out.rs1
  hazardControl.io.IDrs2 := ID.io.out.rs2

  // Forward the data to MEM to avoid a one clock cylce delay

  //--------------Testing-----------------------
  io.memIO.valid := DontCare
  io.memIO.ready := DontCare
  io.memIO.nonEmpty := DontCare
  io.memIO.addr := DontCare
  IF.io.memIO.ready := io.memIO.write
  IF.io.memIO.writeData := io.memIO.writeData

  if(simulation){ // Connect the simulation wires
    IF.io.startPC.get := io.startPipeline
    //----- Debug bus--------------------------------
    io.debug.get.out := WB.io.out.muxOut
    io.debug.get.pc := ID.io.debug.get.pc
    io.debug.get.inst := ID.io.debug.get.inst
    io.debug.get.regFile := ID.io.debug.get.regFile
    io.debug.get.memoryIO <> MEM.io.debug.get.memoryIO
  }
  io.WB_out := WB.io.out.muxOut
}