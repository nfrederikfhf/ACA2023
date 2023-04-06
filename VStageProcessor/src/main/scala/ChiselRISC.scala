import chisel3._
import chisel3.util._
import components._
import stages._
import utilities._

class ChiselRISC extends Module{
  val io = IO(new Bundle{
    val reset = Input(Bool())
    val out = Output(UInt(32.W))
    val test = new Bundle{
      val testData = Input(UInt(32.W))
      val writeToMem = Input(Bool())
    }
    val startPipeline = Input(Bool())
  })
  // Pipeline stages

  val IF = Module(new IF(32, 100))
  val ID = Module(new ID(32, 5))
  val EX = Module(new EX(32, 5))
  val MEM = Module(new MEM(32, 5))
  val WB = Module(new WB(32, 5))

  /* TODO: Add the rest of the pipeline stages */
  // Connect the pipeline stages
  IF.io.out <> ID.io.in
  ID.io.out <> EX.io.in
  EX.io.out <> MEM.io.in
  MEM.io.out <> WB.io.in
  WB.io.out <> ID.io.wbIn

  // Initialise signals
  ID.io.test.startTest := WireInit(false.B)
  ID.io.test.wrAddr := WireInit(0.U(5.W))
  ID.io.test.wrData := WireInit(0.U(32.W))
  IF.io.addrOut := WireInit(0.U(32.W))
  IF.io.branch := WireInit(false.B)
  ID.io.test.wren := WireInit(false.B)
  IF.io.startPC := io.startPipeline

  // Connect the testing wires
  IF.io.writeToMem := io.test.writeToMem
  IF.io.testData := io.test.testData



  io.out := WB.io.out.muxOut
}