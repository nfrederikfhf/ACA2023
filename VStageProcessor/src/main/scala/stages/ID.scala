package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.{ImmGenerator, Decoder}

class ID(datawidth: Int, addrWidth: Int) extends Module {

  val io = IO(new Bundle {
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
  io.out.val1 := RegInit(0.U(datawidth.W))
  io.out.val2 := RegInit(0.U(datawidth.W))
  io.out.rd := RegInit(0.U(datawidth.W))
  io.out.ctrl.useImm := RegInit(0.U(datawidth.W))
  io.out.ctrl.useALU := RegInit(0.U(datawidth.W))
  io.out.ctrl.branch := RegInit(0.U(datawidth.W))
  io.out.ctrl.jump := RegInit(0.U(datawidth.W))
  io.out.ctrl.load := RegInit(0.U(datawidth.W))
  io.out.ctrl.store := RegInit(0.U(datawidth.W))
  io.out.imm := RegInit(0.U(datawidth.W))
  io.out.pc := RegInit(0.U(datawidth.W))
  regfile.io.wren := WireInit(false.B)
  regfile.io.wrAddr := WireInit(0.U(addrWidth.W))
  regfile.io.wrData := WireInit(0.U(datawidth.W))
  decoder.io.inInst := WireInit(0.U(datawidth.W))

  // Connecting the signals through
  immGenerator.io.immIn := io.in.inst
  decoder.io.inInst := io.in.inst
  regfile.io.rdAddr1 := decoder.io.rs1
  regfile.io.rdAddr2 := decoder.io.rs2
  io.out.ctrl <> decoder.io.ctrl
  io.out.aluOp := decoder.io.aluOp
  io.out.rs1 := decoder.io.rs1
  io.out.rs2 := decoder.io.rs2
  io.out.rd := decoder.io.rd
  io.out.val1 := regfile.io.rdData1
  io.out.val2 := regfile.io.rdData2
  io.out.imm := immGenerator.io.immOut
  io.out.pc := io.in.pc

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
