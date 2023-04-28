package ChiselRISC.components

import chisel3.{util, _}
import chisel3.util._
import org.joda.time.format.ISODateTimeFormat
import ChiselRISC.utilities._
class HazardControl(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val EXaluOut = Input(UInt(dataWidth.W))
    val EXctrlBranch = Input(Bool())
    val EXctrlJump = Input(Bool())
    val EXctrlLoad = Input(Bool())
    val EXrd = Input(UInt(addrWidth.W))
    val IDrs1 = Input(UInt(addrWidth.W))
    val IDrs2 = Input(UInt(addrWidth.W))
    val IDFlush = Output(Bool())
    val IFFlush = Output(Bool())
    val IFStall = Output(Bool())

  })

  //Init Outputs
  io.IDFlush := WireInit(false.B)
  io.IFFlush := WireInit(false.B)
  io.IFStall := WireInit(false.B)

  val use_load = io.EXctrlLoad && (io.EXrd === io.IDrs1 || io.EXrd === io.IDrs2) && io.EXrd =/= 0.U
  val branch_jump = (io.EXaluOut === 1.U && io.EXctrlBranch) || io.EXctrlJump

  io.IFFlush := branch_jump
  io.IFStall := use_load
  io.IDFlush := branch_jump || use_load
}