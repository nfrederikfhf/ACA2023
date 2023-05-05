package ChiselRISC.stages

import chisel3.{util, _}
import chisel3.util._
import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.utilities._

class IF(datawidth: Int, depth: Int, init: Seq[BigInt] = Seq(BigInt(0))) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val flush = Input(Bool())
    val out = new IF_ID_IO(datawidth)
    val newPCValue = Input(UInt(datawidth.W)) //ALU calculated Addr
    val changePC = Input(Bool())
    val memIO = new Bundle {
      val ready = Input(Bool())
      val writeData = Input(UInt(datawidth.W))
    }
    val startPC = Input(Bool())
  })
  // ----- Testing ------------
  val PC = Module(new ProgramCounter(datawidth))
  val instMem = Module(new InstructionMemoryFPGA(depth, datawidth, init))
  //val instMem = Module(new InstructionMemory(depth, datawidth))
  val pc = WireDefault(PC.io.memIO.addr)

  val outReg = RegEnable(io.out, !io.stallReg)
  PC.io.memIO.nonEmpty := DontCare
  PC.io.memIO.ready := WireInit(false.B)
  PC.io.in := WireInit(0.U(datawidth.W))

  // Instruction memory
  //instMem.io.memIO.addr := WireInit(0.U(datawidth.W))
  //instMem.io.memIO.valid := WireInit(false.B)
  instMem.io.writer.ready := WireInit(false.B)
  instMem.io.writer.data := WireInit(0.U(datawidth.W))

  // Connecting the PC to the Instmem
  instMem.io.writer.ready := io.memIO.ready
  instMem.io.writer.data := io.memIO.writeData
  instMem.io.memIO.valid := WireInit(false.B)

  val addr = Mux(io.changePC, io.newPCValue, pc)

  when(io.startPC && !instMem.io.memIO.nonEmpty) {
    instMem.io.memIO.valid := true.B
  }
  // Program counter
  when(!instMem.io.memIO.nonEmpty && io.startPC) {
    PC.io.memIO.ready := true.B
    PC.io.in := MuxCase(pc + 4.U, Seq(
      (io.changePC, io.newPCValue),
      (io.stallReg, pc)
    ))
  }.otherwise {
    PC.io.memIO.ready := false.B
    PC.io.in := addr
  }

  instMem.io.memIO.addr := addr

  //val muxOutPC = addr
  val muxOutInst = Mux(io.flush, 0.U, instMem.io.memOut)



  outReg.inst := muxOutInst
  outReg.pc := addr
  io.out.inst := outReg.inst
  io.out.pc := outReg.pc

}
