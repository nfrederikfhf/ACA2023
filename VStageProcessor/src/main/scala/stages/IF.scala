package stages
import chisel3._
import chisel3.util._
import components._
import components.memory._

class IF(datawidth: Int) extends Module {
  val io = IO(new Bundle {
    val inst = Decoupled(UInt(datawidth.W))
    val addrOut = Input(UInt(datawidth.W))
    val addToPC = Input(Bool())
    val dataIn = Output(UInt(datawidth.W))

  })

  val PC = Module(new ProgramCounter(32))
  val InstMem = Module(new InstructionMemory(1024, 32))

  // Connect the components
  PC.io.data_rd.ready := WireInit(false.B)
  PC.io.data_rd.bits := WireInit(0.U(datawidth.W))
  InstMem.io.rdAdd.ready := WireInit(false.B)
  InstMem.io.rdAdd.bits := WireInit(0.U(datawidth.W))

  //Init signals
  io.inst.valid := WireInit(false.B)
  io.inst.bits := WireInit(0.U(datawidth.W))

  // MUX for selecting the next address
  val addMux = Mux(io.addToPC === true.B, io.addrOut, PC.io.data_wr.bits + 4.U)

//  when(stepEn){ // When the controller informs the processor to step
//    PC.io.data_rd.valid := true.B
//    PC.io.data_rd.bits := addMux // Calculate the next address
//  }

  when(PC.io.data_wr.valid){ // When the next address is calculated
    InstMem.io.rdAdd.valid := true.B
    InstMem.io.rdAdd.bits := PC.io.data_wr.bits // Read the instruction from the memory
  }

}
