package stages
import chisel3.{util, _}
import chisel3.util.{RegEnable, _}
import components._
import components.memory._
import utilities._

class IF(datawidth: Int, depth: Int) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val out = new IF_ID_IO(datawidth)
    val addrOut = Input(UInt(datawidth.W)) //ALU calculated Addr
    val branch = Input(Bool())
    val startPC = Input(Bool())
    val memIO = Flipped(new memoryInterface(datawidth))
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
  instMem.io.memIO.Request.store := WireInit(false.B)
  instMem.io.memIO.write.ready := WireInit(false.B)
  instMem.io.memIO.write.data := WireInit(0.U(datawidth.W))
  PC.io.in := WireInit(0.U(datawidth.W))
  instMem.io.memIO <> PC.io.memIO
  io.memIO.Request := DontCare
  io.memIO.Response := DontCare


  val pc = WireDefault(PC.io.memIO.Request.addr)
  // val pcNext = pc

  val addMux = Mux(io.branch === true.B, io.addrOut, pc)

  instMem.io.memIO.write.ready := io.memIO.write.ready
  instMem.io.memIO.write.data := io.memIO.write.data


  when(io.startPC) {
    PC.io.memIO.Response.ready := true.B
    PC.io.in := addMux + 4.U
  /// pcNext := addMux + 4.U
  }.otherwise {
    PC.io.memIO.Response.ready := false.B
    PC.io.in := pc
  }

  outReg.inst := instMem.io.memIO.Response.data
  outReg.pc := addMux
  io.out.inst := outReg.inst
  io.out.pc := outReg.pc

}
