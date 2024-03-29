package ChiselRISC.stages

import chisel3.{util, _}
import chisel3.util._
import ChiselRISC.components._
import ChiselRISC.components.memory._
import ChiselRISC.utilities._

class WB(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new MEM_WB_IO(dataWidth, addrWidth))
    val out = new WB_ID_IO(dataWidth, addrWidth)
    val wb_fwd = new forwardingIO(dataWidth, addrWidth)
  })

  // THE mux
  val theMux = Mux(io.in.load, io.in.memOut, io.in.aluOut)

  //-------output-------------
  io.out.writeEnable := io.in.writeEnable
  io.out.muxOut := theMux
  io.out.rd := io.in.rd

  //----------Forwarding----------------
  io.wb_fwd.rd := io.out.rd
  io.wb_fwd.stageOutput := io.out.muxOut
  io.wb_fwd.writeEnable := io.out.writeEnable
}