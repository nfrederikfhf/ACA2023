package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.{ImmGenerator, Decoder}

class ID(datawidth: Int, addrWidth: Int) extends Module {
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
    val test = new Bundle { // For testing purposes
      val wrAddr = Input(UInt(addrWidth.W))
      val wrData = Input(UInt(datawidth.W))
      val wren = Input(Bool())
      val startTest = Input(Bool())
    }
  })

  val immGenerator = Module(new ImmGenerator(datawidth))
  val decoder = Module(new Decoder(datawidth, addrWidth))
  val regfile = Module(new RegisterFile(addrWidth, datawidth))

  //Init
  regfile.io.wren := WireInit(false.B)
  regfile.io.wrAddr := WireInit(0.U(addrWidth.W))
  regfile.io.wrData := WireInit(0.U(datawidth.W))
  decoder.io.inInst := WireInit(0.U(datawidth.W))

  // Connecting the signals through
  immGenerator.io.immIn := io.in.inst
  decoder.io.inInst := io.in.inst
  regfile.io.rdAddr1 := decoder.io.rs1
  regfile.io.rdAddr2 := decoder.io.rs2
  regfile.io.wren := io.wbIn.writeEnable
  //-----Control signals-----
  io.out.ctrl <> RegEnable(decoder.io.ctrlSignals, !io.stallReg)
  //-----ALU signals-----
  io.out.aluOp := decoder.io.aluOp // ALU operation
  io.out.rs1 := decoder.io.rs1 // Register address
  io.out.rs2 := decoder.io.rs2 // Register address
  io.out.rd := decoder.io.rd // Destination register address
  io.out.val1 := regfile.io.rdData1 // Value read from register
  io.out.val2 := regfile.io.rdData2 // Value read from register
  io.out.imm := immGenerator.io.immOut // Immediate value
  io.out.pc := io.in.pc // Program counter value

  //------------testing purposes-----------
  when(io.test.startTest) {
    regfile.io.wren := io.test.wren
    regfile.io.wrAddr := io.test.wrAddr
    regfile.io.wrData := io.test.wrData
  }.otherwise {
    regfile.io.wren := false.B
    regfile.io.wrAddr := 0.U
    regfile.io.wrData := 0.U
  }

}
