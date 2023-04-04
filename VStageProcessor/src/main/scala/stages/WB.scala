package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities._

class WB(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new MEM_WB_IO(dataWidth, addrWidth))
    val out = new WB_ID_IO(dataWidth, addrWidth)
  })
  // Initialise signals
  io.out.muxOut := RegInit(0.U(dataWidth.W))
  io.out.writeEnable := RegInit(false.B)
  io.out.rd := RegInit(0.U(addrWidth.W))

  // The mux
  val theMux = Mux(io.in.writeEnable, io.in.memOut, io.in.aluOut)
  io.out.writeEnable := io.in.writeEnable
  io.out.muxOut := theMux
  io.out.rd := io.in.rd
}