package stages
import chisel3._
import chisel3.util._
import components._
import components.memory._
import utilities.IF_ID_IO

class IF(datawidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = new IF_ID_IO(datawidth)
    val addrOut = Input(UInt(datawidth.W))
    val addToPC = Input(Bool())
  })

  val PC = Module(new ProgramCounter(32))
  val InstMem = Module(new InstructionMemory(1024, 32))

  // Connect the components
  PC.io.in.pc := WireInit(0.U(datawidth.W))


  //Init signals
  PC.io.step := WireInit(false.B)


  // MUX for selecting the next address
  val addMux = Mux(io.addToPC === true.B, io.addrOut, PC.io.out.pc + 4.U)

//  when(stepEn){ // When the controller informs the processor to step
//    PC.io.data_rd.valid := true.B
//    PC.io.data_rd.bits := addMux // Calculate the next address
//  }

  when(PC.io.memIO.Request.valid && InstMem.io.memIO.Response.nonEmpty){ // When the next address is calculated
    PC.io.memIO.Response.ready := true.B
    InstMem.io.memIO.Request.addr := PC.io.out.pc// Read the instruction from the memory
  }

}
