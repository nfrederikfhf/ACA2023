package ChiselRISC.stages

import chisel3.{util, _}
import chisel3.util._
import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.utilities._

class IF(datawidth: Int, depth: Int, simulation: Boolean = false, init: Seq[BigInt] = Seq(BigInt(0))) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val flush = Input(Bool())
    val out = new IF_ID_IO(datawidth)
    val newPCValue = Input(UInt(datawidth.W)) //ALU calculated Addr
    val changePC = Input(Bool())
    val memIO = new Bundle{
      val ready = Input(Bool())
      val writeData = Input(UInt(datawidth.W))
    }
    val startPC = Input(Bool())
  })
  // ----- Testing ------------
  val PC = Module(new ProgramCounter(datawidth))
  val instMem = Module(new InstructionMemoryFPGA(depth, datawidth, init))
  //val instMem = Module(new InstructionMemory(depth, datawidth))

  val outReg = RegEnable(io.out, !io.stallReg)

  //Init signals
//  PC.io.memIO.Response.ready := WireInit(false.B)
//  PC.io.memIO.Response.nonEmpty := WireInit(false.B)
//  PC.io.memIO.Response.data := WireInit(0.U(datawidth.W))
//  instMem.io.memIO.Request.valid := WireInit(false.B)
//  instMem.io.memIO.Request.addr := WireInit(0.U(datawidth.W))
//  instMem.io.memIO.Request.writeData := WireInit(0.U(datawidth.W))
//  instMem.io.memIO.write.ready := WireInit(false.B)
//  instMem.io.memIO.write.data := WireInit(0.U(datawidth.W))
  // Program counter
  PC.io.memIO.nonEmpty := DontCare
  PC.io.memIO.ready := WireInit(false.B)
  PC.io.in := WireInit(0.U(datawidth.W))
  // Instruction memory
  instMem.io.memIO.valid := WireInit(false.B)
  instMem.io.memIO.write := WireInit(false.B)
  //instMem.io.writeData := WireInit(0.U(datawidth.W))
  // Connecting the PC to the Instmem
  instMem.io.memIO.write := io.memIO.ready
  instMem.io.memIO.writeData := io.memIO.writeData
  instMem.io.memIO.valid := PC.io.memIO.valid
  instMem.io.memIO.addr := PC.io.memIO.addr
  //instMem.io.memIO <> PC.io.memIO


  val pc = WireDefault(PC.io.memIO.addr)


  val addMux = Mux(io.changePC, io.newPCValue, pc)


  when(!instMem.io.memIO.nonEmpty && io.startPC) { // For simulating and testing
    PC.io.memIO.ready := true.B
    PC.io.in:= Mux(io.changePC, io.newPCValue, pc + 4.U)
  }.otherwise {
    PC.io.memIO.ready := false.B
    PC.io.in := addMux
  }

  val muxOutPC = Mux(io.stallReg, pc, addMux)
  val muxOutInst = Mux(io.flush, 0.U, instMem.io.memOut)

  outReg.inst := muxOutInst
  outReg.pc := muxOutPC
  io.out.inst := outReg.inst
  io.out.pc := RegNext(Mux(io.stallReg, pc, addMux))

}
