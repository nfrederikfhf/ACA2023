package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities.IF_ID_IO

class IF(datawidth: Int, depth: Int) extends Module {
  val io = IO(new Bundle {
    val out = new IF_ID_IO(datawidth)
    val addrOut = Input(UInt(datawidth.W)) //ALU calculated Addr
    val addToPC = Input(Bool())
    //val writeMem = Flipped(new DecoupledIO(UInt(datawidth.W))) // testing
  })

  val PC = Module(new ProgramCounter(datawidth))
  val instMem = Module(new InstructionMemory(depth, datawidth))

  // Initialise the register outputs
  io.out.inst := RegInit(0.U(datawidth.W))
  io.out.pc := RegInit(0.U(datawidth.W))

  //Init signals
  PC.io.memIO.Response.ready := WireInit(false.B)
  PC.io.memIO.Response.nonEmpty := WireInit(false.B)
  PC.io.memIO.Response.data := WireInit(0.U(datawidth.W))
  instMem.io.memIO.Request.valid := WireInit(false.B)
  instMem.io.memIO.Request.addr := WireInit(0.U(datawidth.W))
  instMem.io.memIO.Request.writeData := WireInit(0.U(datawidth.W))
  instMem.io.memIO.Request.store := WireInit(false.B)
  instMem.io.writeMem.valid := WireInit(false.B)
  instMem.io.writeMem.bits := WireInit(0.U(datawidth.W))

  instMem.io.memIO <> PC.io.memIO

  val pcAddrNext = WireInit(0.U(datawidth.W))
  val pcAddr = pcAddrNext

  val addMux = Mux(io.addToPC === true.B, io.addrOut, pcAddr)
  PC.io.in := addMux

  io.out.inst := instMem.io.memIO.Response.data
  //PC.io.memIO.Response.ready := !PC.io.memIO.Response.ready
 //

  pcAddrNext := PC.io.memIO.Request.addr + 4.U




//
//  // Connect the components
//  PC.io.in := WireInit(0.U(datawidth.W))
//  InstMem.io.out <> io.out
//  InstMem.io.writeMem.valid := io.writeMem.valid
//  InstMem.io.writeMem.bits := io.writeMem.bits
//
//  // Initialise the register outputs
//  io.out.inst := RegInit(0.U(datawidth.W))
//  io.out.pc := RegInit(0.U(datawidth.W))
//
//  // MUX for selecting the next address
//  val addMux = Mux(io.addToPC === true.B, io.addrOut, PC.io.memIO.Request.writeData + 4.U)
//  PC.io.in := addMux
//
//
//
//  PC.io.memIO.Response.ready := true.B
//  InstMem.io.memIO.Request.valid := PC.io.memIO.Request.valid
//  InstMem.io.memIO.Request.addr := PC.io.memIO.Request.writeData // Read the instruction from the memory


//  when(InstMem.io.memIO.Response.nonEmpty){ // When the next address is calculated
//    PC.io.memIO.Response.ready := true.B
//    InstMem.io.memIO.Request.valid := PC.io.memIO.Request.valid
//    InstMem.io.memIO.Request.addr := PC.io.memIO.Request.writeData // Read the instruction from the memory
//  }
}
