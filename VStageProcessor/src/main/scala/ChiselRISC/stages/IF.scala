package ChiselRISC.stages

import chisel3.{util, _}
import chisel3.util._
import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.utilities._

class IF(datawidth: Int, depth: Int, simulation: Boolean = false) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val flush = Input(Bool())
    val out = new IF_ID_IO(datawidth)
    val newPCValue = Input(UInt(datawidth.W)) //ALU calculated Addr
    val changePC = Input(Bool())
    val memIO = Flipped(new memoryInterface(datawidth))
    val startPC = if(simulation) Some(Input(Bool())) else None
  })
  // ----- Testing ------------
  val PC = Module(new ProgramCounter(datawidth))
  val instMem = Module(new InstructionMemory(depth, datawidth))

  val outReg = RegEnable(io.out, !io.stallReg)

  //Init signals
  PC.io.memIO.Response.ready := WireInit(false.B)
  PC.io.memIO.Response.nonEmpty := WireInit(false.B)
  PC.io.memIO.Response.data := WireInit(0.U(datawidth.W))
  instMem.io.memIO.Request.valid := WireInit(false.B)
  instMem.io.memIO.Request.addr := WireInit(0.U(datawidth.W))
  instMem.io.memIO.Request.writeData := WireInit(0.U(datawidth.W))
  instMem.io.memIO.write.ready := WireInit(false.B)
  instMem.io.memIO.write.data := WireInit(0.U(datawidth.W))
  PC.io.in := WireInit(0.U(datawidth.W))
  instMem.io.memIO <> PC.io.memIO
  io.memIO.Request := DontCare
  io.memIO.Response := DontCare


  val pc = WireDefault(PC.io.memIO.Request.addr)


  val addMux = Mux(io.changePC, io.newPCValue, pc)

  instMem.io.memIO.write.ready := io.memIO.write.ready
  instMem.io.memIO.write.data := io.memIO.write.data

  if (simulation)
    Some(when(!instMem.io.memIO.Response.nonEmpty && io.startPC.get) { // For simulating and testing
      PC.io.memIO.Response.ready := true.B
      PC.io.in := Mux(io.changePC, io.newPCValue, pc + 4.U)
    }.otherwise {
      PC.io.memIO.Response.ready := false.B
      PC.io.in := addMux
    })
  else
    (when(!instMem.io.memIO.Response.nonEmpty) { // For FPGA implementation
      PC.io.memIO.Response.ready := true.B
      PC.io.in := Mux(io.changePC, io.newPCValue, pc + 4.U)
    }.otherwise {
      PC.io.memIO.Response.ready := false.B
      PC.io.in := addMux
    })

  val muxOutPC = Mux(io.stallReg, pc, addMux)
  val muxOutInst = Mux(io.flush, 0.U, instMem.io.memIO.Response.data)

  outReg.inst := muxOutInst
  outReg.pc := muxOutPC
  io.out.inst := outReg.inst
  io.out.pc := RegNext(Mux(io.stallReg, pc, addMux))

}
