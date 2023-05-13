package ChiselRISC.Individual

import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.periph.SevenSegment
import ChiselRISC.stages._
import ChiselRISC.utilities.Binaries.loadWords
import ChiselRISC.utilities._
import chisel3._
import chisel3.util._


class IFTest() extends Module {
  val io = IO(new Bundle {
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
    val start = Input(Bool())
    val add = Input(Bool())
    val stageOut = Output(new EX_MEM_IO(32, 5))
  })
  val IF = Module(new IF(32, 16, loadWords("C:\\Users\\Watos\\Documents\\Github\\ACA2023\\VStageProcessor\\asm\\Input2.bin")))
  val ID = Module(new ID(32, 5, false))
  val EX = Module(new EX(32, 5))

  IF.io.memIO.ready := WireInit(false.B)
  IF.io.memIO.writeData := WireInit(0.U(32.W))
  IF.io.startPC := WireInit(false.B)
  IF.io.changePC := WireInit(false.B)
  IF.io.newPCValue := WireInit(0.U(32.W))
  IF.io.flush := WireInit(false.B)
  IF.io.stallReg := WireInit(false.B)

  when(io.add) {
    IF.io.startPC := true.B
    IF.io.memIO.ready := true.B
    IF.io.memIO.writeData := "h00210113".U
  }

  when(io.start){
    IF.io.startPC := true.B
  }
  //io.stageOut := IF.io.out.inst
  ID.io.in.inst := IF.io.out.inst
  ID.io.in.pc := IF.io.out.pc
  EX.io.in.aluOp := ID.io.out.aluOp
  EX.io.in.rs1 := ID.io.out.rs1
  EX.io.in.rs2 := ID.io.out.rs2
  EX.io.in.val1 := ID.io.out.val1
  EX.io.in.val2 := ID.io.out.val2
  EX.io.in.memOp := ID.io.out.memOp
  EX.io.in.rd := ID.io.out.rd
  EX.io.in.imm := ID.io.out.imm
  EX.io.in.pc := ID.io.out.pc
  EX.io.in.ctrl := ID.io.out.ctrl

  io.stageOut.aluOut := EX.io.out.aluOut
  io.stageOut.rd := EX.io.out.rd
  io.stageOut.ctrl := EX.io.out.ctrl
  io.stageOut.wrData := EX.io.out.wrData

  ID.io.stallReg := WireInit(false.B)
  EX.io.stallReg := WireInit(false.B)
  ID.io.flush := WireInit(false.B)
  ID.io.wbIn.muxOut := WireInit(0.U(32.W))
  ID.io.wbIn.rd := WireInit(0.U(5.W))
  ID.io.wbIn.writeEnable := WireInit(false.B)



  val sevenSegmentDisplay = Module(new SevenSegment(200))
  sevenSegmentDisplay.io.rd := ID.io.out.aluOp
  io.seg := sevenSegmentDisplay.io.seg
  io.an := sevenSegmentDisplay.io.an
}
