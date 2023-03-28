package stages
import chisel3._
import chisel3.util._
import components._
import components.memory._
import utilities.IF_ID_IO

class IF(datawidth: Int, depth: Int) extends Module {
  val io = IO(new Bundle {
    val out = new IF_ID_IO(datawidth)
    val addrOut = Input(UInt(datawidth.W))
    val addToPC = Input(Bool())
  })

  val PC = Module(new ProgramCounter(datawidth))
  val InstMem = Module(new InstructionMemory(depth, datawidth))

  // Connect the components
  PC.io.in := WireInit(0.U(datawidth.W))
  InstMem.io.out <> io.out

  //Init signals
  PC.io.memIO.Response.ready := WireInit(false.B)
  InstMem.io.memIO.Request.addr := WireInit(0.U(datawidth.W))
  InstMem.io.memIO.Request.writeData := WireInit(0.U(datawidth.W))
  InstMem.io.memIO.Request.store := WireInit(false.B)
  InstMem.io.memIO.Response.ready := WireInit(false.B)
  // Initialise the register outputs
  io.out.inst := RegInit(0.U(datawidth.W))
  io.out.pc := RegInit(0.U(datawidth.W))

  // MUX for selecting the next address
  val addMux = Mux(io.addToPC === true.B, io.addrOut, PC.io.memIO.Request.writeData + 4.U)
  PC.io.in := addMux


  when(InstMem.io.memIO.Response.nonEmpty){ // When the next address is calculated
    PC.io.memIO.Response.ready := true.B
    InstMem.io.memIO.Request.valid := PC.io.memIO.Request.valid
    InstMem.io.memIO.Request.addr := PC.io.memIO.Request.writeData // Read the instruction from the memory
  }
}
