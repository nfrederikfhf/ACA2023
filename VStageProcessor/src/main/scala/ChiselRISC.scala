import chisel3._
import chisel3.util._
import components._
import stages._
import utilities._

class ChiselRISC(simulation: Boolean = false) extends Module{
  val io = IO(new Bundle{
    val memIO = Flipped(new memoryInterface(32))
    val startPipeline = Input(Bool())
    val debug = if(simulation) Some(new debugIO(32, 5)) else None
  })
  // Pipeline stages

  val IF = Module(new IF(32, 100))
  val ID = Module(new ID(32, 5, simulation))
  val EX = Module(new EX(32, 5))
  val MEM = Module(new MEM(32, 5, simulation))
  val WB = Module(new WB(32, 5))

  // Connect the pipeline stages
  IF.io.out <> ID.io.in
  ID.io.out <> EX.io.in
  EX.io.out <> MEM.io.in
  MEM.io.out <> WB.io.in
  WB.io.out <> ID.io.wbIn
  ID.io.stallReg := IF.io.stallReg
  EX.io.stallReg := ID.io.stallReg
  MEM.io.stallReg := EX.io.stallReg
  WB.io.stallReg := MEM.io.stallReg

  // Initialise signals
  IF.io.addrOut := WireInit(0.U(32.W))
  IF.io.branch := WireInit(false.B)
  IF.io.stallReg := WireInit(false.B)
  IF.io.startPC := io.startPipeline
  IF.io.memIO.Request := DontCare
  IF.io.memIO.Response := DontCare
  // Connect the write to instruction memory wires
  io.memIO.Request := DontCare
  io.memIO.Response := DontCare
  IF.io.memIO.write.ready := io.memIO.write.ready
  IF.io.memIO.write.data := io.memIO.write.data

  if(simulation){ // Connect the debug signals
    io.debug.get.out := WB.io.out.muxOut
    io.debug.get.pc := ID.io.debug.get.pc
    io.debug.get.inst := ID.io.debug.get.inst
    io.debug.get.regFile := ID.io.debug.get.regFile
    io.debug.get.memoryIO <> MEM.io.debug.get.memoryIO
  }
}