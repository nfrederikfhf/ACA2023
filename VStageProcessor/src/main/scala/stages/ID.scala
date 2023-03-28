package stages
import chisel3._
import utilities._
import chisel3.util._
import components.memory.RegisterFile
import components.{ImmGenerator, Decoder}

class ID(datawidth: Int, addrWidth: Int) extends Module {

  val io = IO(new Bundle {
    val inIF = Flipped(new IF_ID_IO(datawidth))
    val out = new ID_EX_IO(datawidth,5)
  })
  val immGenerator = new ImmGenerator(datawidth)
  val decoder = new Decoder(datawidth, addrWidth)
  val regfile = new RegisterFile(addrWidth, datawidth)

  //Init
  io.out.rs1 := RegInit(UInt(datawidth.W))
  io.out.rs2 := RegInit(UInt(datawidth.W))
  io.out.rd := RegInit(UInt(datawidth.W))
  io.out.ctrl := RegInit(UInt(datawidth.W))

  decoder.io.out.ctrl <> io.out.ctrl
  decoder.io.in <> io.inIF
  regfile.io.rdAddr1 := decoder.io.out.rs1
  regfile.io.rdAddr2 := decoder.io.out.rs2
  immGenerator.io.imm := io.inIF.inst
  io.out.imm := immGenerator.io.immediate

  io.out.rs1 := regfile.io.rdData1
  io.out.rs2 := regfile.io.rdData2
  io.out.rd := decoder.io.out.rd
}
