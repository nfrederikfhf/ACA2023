package ChiselRISC

import components.{ForwardingUnit, HazardControl}
import stages._
import utilities.{debugIO, writeToInstMem}
import chisel3._
import periph._

class VStageProcessor(simulation: Boolean = false, init: Seq[BigInt] = Seq(BigInt(0))) extends Module {
  val io = IO(new Bundle {
    val memIO = new writeToInstMem(32)
    val debug = if (simulation) Some(new debugIO(32, 5)) else None
    val startPipeline = Input(Bool())
    //    val start = Input(Bool())
    val add = Input(Bool())
    val branchInst = Input(Bool())
    val jumpInst = Input(Bool())
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
    val useImm = Output(Bool())
    val useAlu = Output(Bool())
    val branch = Output(Bool())
    val jump = Output(Bool())
    val load = Output(Bool())
    val store = Output(Bool())
    val changePC = Output(Bool())
    val writeEnable = Output(Bool())
    //    val val1 = Output(Bool())
    //    val val2 = Output(Bool())
  })

  //Pipeline stages
  val IF = Module(new IF(32, 100, init))
  val ID = Module(new ID(32, 5, simulation))
  val EX = Module(new EX(32, 5))
  val MEM = Module(new MEM(32, 5, 1000, simulation))
  val WB = Module(new WB(32, 5))

  //Forwarding and Hazard Control units
  val forwardingUnit = Module(new ForwardingUnit(32, 5))
  val hazardControl = Module(new HazardControl(32, 5))

  //Pipeline connections
  IF.io.out <> ID.io.in
  ID.io.out <> EX.io.in
  EX.io.out <> MEM.io.in
  MEM.io.out <> WB.io.in
  WB.io.out <> ID.io.wbIn

  // Forwarding
  forwardingUnit.io.mem_fwd <> MEM.io.mem_fwd
  forwardingUnit.io.wb_fwd <> WB.io.wb_fwd
  // ID values and registers
  forwardingUnit.io.id_rs1 := ID.io.out.rs1
  forwardingUnit.io.id_rs2 := ID.io.out.rs2
  forwardingUnit.io.id_val1 := ID.io.out.val1
  forwardingUnit.io.id_val2 := ID.io.out.val2
  // Forwarded input
  EX.io.in.val1 := forwardingUnit.io.val1
  EX.io.in.val2 := forwardingUnit.io.val2
  IF.io.changePC := EX.io.changePC
  IF.io.newPCValue := EX.io.newPCValue

  // Hazard Control
  hazardControl.io.EXaluOut := EX.io.hazardAluOut
  hazardControl.io.EXrd := EX.io.in.rd
  hazardControl.io.EXctrlLoad := EX.io.in.ctrl.load
  hazardControl.io.EXctrlBranch := EX.io.in.ctrl.branch
  hazardControl.io.EXctrlJump := EX.io.in.ctrl.jump
  hazardControl.io.IDrs1 := ID.io.out.rs1
  hazardControl.io.IDrs2 := ID.io.out.rs2

  // Control signals
  IF.io.flush := hazardControl.io.IFFlush
  ID.io.flush := hazardControl.io.IDFlush
  // Stall signals for the whole pipeline
  IF.io.stallReg := hazardControl.io.IFStall
  ID.io.stallReg := hazardControl.io.IFStall
  EX.io.stallReg := hazardControl.io.IFStall
  MEM.io.stallReg := hazardControl.io.IFStall

  // Test write interface
    IF.io.memIO.ready := io.memIO.ready
    IF.io.memIO.writeData := io.memIO.data

//  IF.io.memIO.ready := WireInit(false.B)
//  IF.io.memIO.writeData := WireInit(0.U(32.W))
  IF.io.startPC := io.startPipeline
  // Seven Segment Display
  //  val sevenSegmentDisplay = Module(new SevenSegment(1000000))
  //  io.seg := sevenSegmentDisplay.io.seg
  //  io.an := sevenSegmentDisplay.io.an
  //  sevenSegmentDisplay.io.in := WireInit("b1111111".U)
  val sevenSegmentDisplay = Module(new SevenSegment(100000))
  io.seg := sevenSegmentDisplay.io.seg
  io.an := sevenSegmentDisplay.io.an
  sevenSegmentDisplay.io.val1 := ID.io.out.val1
  sevenSegmentDisplay.io.rd := ID.io.out.val2
  //  io.val1 := RegInit(false.B)
  //  io.val2 := RegInit(false.B)
  // Force write instructions to memory - Since for some reason filling memory does not work
  when(io.add) {
    IF.io.startPC := true.B
    IF.io.memIO.ready := true.B
    IF.io.memIO.writeData := "h00108093".U // addi x1, 1
  }

  when(io.branchInst) {
    IF.io.startPC := true.B
    IF.io.memIO.ready := true.B
    IF.io.memIO.writeData := "h00310863".U
  }

  //  when(io.branchInst) {
  //    IF.io.startPC := true.B
  //    IF.io.memIO.ready := true.B
  //    IF.io.memIO.writeData := "h00210113".U // addi x2, 2
  //  }

  //  when(io.jumpInst) {
  //    IF.io.startPC := true.B
  //    IF.io.memIO.ready := true.B
  //    IF.io.memIO.writeData := "h002081B3".U // add x3, x1,x2
  //  }

  when(io.jumpInst) {
    IF.io.startPC := true.B
    IF.io.memIO.ready := true.B
    IF.io.memIO.writeData := "h0280006f".U
  }

  //  when(io.start) {
  //    IF.io.startPC := true.B
  //  }

  //  when(io.read){
  //    IF.io.startPC := true.B
  //    sevenSegmentDisplay.io.in :=  RegNext(EX.io.out.aluOut(15,0))
  //  }
  // FPGA debugging LEDS
  io.useImm := ID.io.out.ctrl.useImm
  io.useAlu := ID.io.out.ctrl.useALU
  io.branch := ID.io.out.ctrl.branch
  io.jump := ID.io.out.ctrl.jump
  io.load := ID.io.out.ctrl.load
  io.store := ID.io.out.ctrl.store
  io.changePC := ID.io.out.ctrl.changePC
  io.writeEnable := WB.io.in.writeEnable


  if (simulation) { // Connect the simulation wires
    //----- Debug bus--------------------------------
    io.debug.get.out := WB.io.out.muxOut
    io.debug.get.pc := ID.io.debug.get.pc
    io.debug.get.inst := ID.io.debug.get.inst
    io.debug.get.regFile := ID.io.debug.get.regFile
    io.debug.get.memoryIO <> MEM.io.debug.get.memoryIO
  }
}
