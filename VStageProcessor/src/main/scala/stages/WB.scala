package stages
import chisel3.{util, _}
import chisel3.util._
import components._
import components.memory._
import utilities._

class WB(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val stallReg = Input(Bool())
    val in = Flipped(new MEM_WB_IO(dataWidth, addrWidth))
    val out = new WB_ID_IO(dataWidth, addrWidth)
    val wb_fwd = new forwardingIO(dataWidth, addrWidth)
  })
  // Initialise signals
  //val outReg = RegEnable(io.out, !io.stallReg)

  // THE mux
  val theMux = Mux(io.in.load, io.in.memOut, io.in.aluOut)

  // Connecting the register
//  outReg.writeEnable := io.in.writeEnable
//  outReg.muxOut := theMux
//  outReg.rd := io.in.rd

  //-------output-------------
  io.out.writeEnable := io.in.writeEnable
  io.out.muxOut := theMux
  io.out.rd := io.in.rd

  //----------Forwarding----------------
  io.wb_fwd.rd := io.out.rd
  io.wb_fwd.stageOutput := io.out.muxOut
  io.wb_fwd.writeEnable := io.out.writeEnable
}