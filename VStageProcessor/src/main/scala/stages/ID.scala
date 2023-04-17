package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.{ImmGenerator, Decoder}

class ID(datawidth: Int, addrWidth: Int, simulation: Boolean = false) extends Module {
  /*
  * This stage is responsible for:
  * - Generating the immediate
  * - Decoding the instruction
  * - Reading the register file
  * - Writing the register file
  * - Writing the control signals
  * - Writing the ALU operation
  * @param datawidth: The width of the data bus
  * @param addrWidth: The width of the address bus
   */

  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new IF_ID_IO(datawidth))
    val wbIn = Flipped(new WB_ID_IO(datawidth, addrWidth))
    val out = new ID_EX_IO(datawidth, addrWidth)
    val debug = if(simulation) Some(new debugIO(datawidth, addrWidth)) else None // Debugging
  })

  val immGenerator = Module(new ImmGenerator(datawidth))
  val decoder = Module(new Decoder(datawidth, addrWidth))
  val regfile = Module(new RegisterFile(addrWidth, datawidth, simulation))

  //Init
  regfile.io.wren := WireInit(false.B)
  regfile.io.wrAddr := WireInit(0.U(addrWidth.W))
  regfile.io.wrData := WireInit(0.U(datawidth.W))
  decoder.io.inInst := WireInit(0.U(datawidth.W))
  if(simulation){ // Get the register file
    io.debug.get.out := DontCare // Only used in WB
    io.debug.get.memoryIO := DontCare // Only used in MEM
    io.debug.get.regFile := regfile.io.regFile.get
    io.debug.get.inst := io.in.inst
    io.debug.get.pc := io.in.pc
  }

  // Connecting the signals through
  immGenerator.io.immIn := io.in.inst
  decoder.io.inInst := io.in.inst
  regfile.io.rdAddr1 := decoder.io.rs1
  regfile.io.rdAddr2 := decoder.io.rs2
  // Write back
  regfile.io.wren := io.wbIn.writeEnable
  regfile.io.wrAddr := io.wbIn.rd
  regfile.io.wrData := io.wbIn.muxOut
  //-----Control signals-----
  io.out.ctrl <> RegEnable(decoder.io.ctrlSignals, !io.stallReg)
  //-----ALU signals-----
  io.out.aluOp := RegEnable(decoder.io.aluOp, !io.stallReg) // ALU operation
  io.out.rd := RegEnable(decoder.io.rd, !io.stallReg) // Destination register address
  io.out.val1 := RegEnable(regfile.io.rdData1, !io.stallReg) // Value read from register
  io.out.val2 := RegEnable(regfile.io.rdData2, !io.stallReg) // Value read from register
  io.out.imm := RegEnable(immGenerator.io.immOut, !io.stallReg) // Immediate value
  io.out.pc := RegEnable(io.in.pc, !io.stallReg) // Program counter value
  io.out.rs1 := RegEnable(decoder.io.rs1, !io.stallReg) // rs1 address
  io.out.rs2 := RegEnable(decoder.io.rs2, !io.stallReg) // rs2 address
}
