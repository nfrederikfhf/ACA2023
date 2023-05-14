package ChiselRISC

import periph.SevenSegment
import components.{BranchPredictor, ForwardingUnit, HazardControl}
import stages._
import utilities.{debugIO, memoryInterface, memoryInterfaceLight}
import chisel3._
import chisel3.util.Counter


class VStageProcessorOLD(simulation: Boolean = false, init: Seq[BigInt] = Seq(BigInt(0))) extends Module {
  val io = IO(new Bundle {
    val memIO = Flipped(new memoryInterfaceLight(32))
//    val startPipeline = Input(Bool())
    val debug = if (simulation) Some(new debugIO(32, 5)) else None
    val WB_out = Output(UInt(32.W))
    //val seg = Output(UInt(7.W))
    //val an = Output(UInt(4.W))
    val led0 = Output(Bool())
    val add = Input(Bool())
  })
  // Init
  //io.seg := WireInit(0.U(7.W))
  //io.an := WireInit(0.U(4.W))

  // Pipeline ChiselRISC.stages
  val IF = Module(new IF(32, 100,  init))
  val ID = Module(new ID(32, 5, simulation))
  val EX = Module(new EX(32, 5))
  val MEM = Module(new MEM(32, 5, 1000, simulation))
  val WB = Module(new WB(32, 5))
  // Forwarding and Hazard Control units
  val forwardingUnit = Module(new ForwardingUnit(32, 5))
  val hazardControl = Module(new HazardControl(32, 5))
  val branchPredictor = Module(new BranchPredictor(32, 4))

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
  //hazardControl.io.EXaluOut := EX.io.hazardAluOut
  hazardControl.io.EXmisprediction := EX.io.misprediction
  hazardControl.io.EXctrlBranch := EX.io.in.ctrl.branch
  hazardControl.io.EXctrlJump := EX.io.in.ctrl.jump
  hazardControl.io.EXctrlLoad := EX.io.in.ctrl.load
  hazardControl.io.EXrd := EX.io.in.rd
  hazardControl.io.IDrs1 := ID.io.out.rs1
  hazardControl.io.IDrs2 := ID.io.out.rs2

  // Connect Branch Predictor
  branchPredictor.io.pc := IF.io.out.pc
  branchPredictor.io.inst := IF.io.out.inst
  branchPredictor.io.EXbranchPC := EX.io.BRbranchPC
  branchPredictor.io.EXbranchResult := EX.io.BRbranchResult
  branchPredictor.io.EXbranching := EX.io.BRbranching
  IF.io.BRchangePC := branchPredictor.io.changePC
  IF.io.BRnewPCValue := branchPredictor.io.targetPC
  ID.io.BRpredictionIn := branchPredictor.io.changePC
  EX.io.BRpredictionIn := ID.io.BRpredictionOut


  // Forward the data to MEM to avoid a one clock cycle delay

  //--------------Testing-----------------------
  io.memIO.valid := DontCare
  io.memIO.ready := DontCare
  io.memIO.nonEmpty := DontCare
  io.memIO.addr := DontCare
//  IF.io.memIO.ready := io.memIO.write
//  IF.io.memIO.writeData := io.memIO.writeData
  IF.io.memIO.ready := WireInit(false.B)
  IF.io.memIO.writeData := WireInit(0.U(32.W))
  IF.io.startPC := WireInit(true.B)

  when(io.add){
    IF.io.startPC := false.B
    ID.io.in.inst := "h00210113".U(32.W)
    ID.io.in.pc := 0.U(32.W)
    IF.io.memIO.writeData := "h00210113".U(32.W)
    IF.io.memIO.ready := true.B
  }
//  IF.io.memIO.ready := DontCare
//  IF.io.memIO.writeData := DontCare
  if (simulation) { // Connect the simulation wires
    //----- Debug bus--------------------------------
    io.debug.get.out := WB.io.out.muxOut
    io.debug.get.pc := ID.io.debug.get.pc
    io.debug.get.inst := ID.io.debug.get.inst
    io.debug.get.regFile := ID.io.debug.get.regFile
    io.debug.get.memoryIO <> MEM.io.debug.get.memoryIO
  }

  //------------------------------
  // Top file connection to Basys3
  //------------------------------
  // Life-blink LED
  val led = RegInit(false.B)
  val (_, ledCounterWrap) = Counter(true.B, 10000000)
  when(ledCounterWrap) {
    led := ~led
  }
  io.led0 := led
  //// Seven segment display
  //val sevenSeg = Module(new SevenSegment)
  //sevenSeg.io.in := RegNext(WB.io.out.muxOut(15, 0))
  //io.seg := sevenSeg.io.seg
  //io.an := sevenSeg.io.an
  io.WB_out :=  RegNext(WB.io.out.muxOut(15, 0))
}