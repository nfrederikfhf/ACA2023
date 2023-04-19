package components

import chisel3.{util, _}
import chisel3.util._
import utilities._

class ForwardingUnit(dataWidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val id_rs1 = Input(UInt(addrWidth.W))
    val id_rs2 = Input(UInt(addrWidth.W))
    val id_val1 = Input(UInt(dataWidth.W))
    val id_val2 = Input(UInt(dataWidth.W))
    val mem_fwd = Flipped(new forwardingIO(dataWidth, addrWidth))
    val wb_fwd = Flipped(new forwardingIO(dataWidth, addrWidth))
    // ID output to EX input
    val val1 = Output(UInt(dataWidth.W))
    val val2 = Output(UInt(dataWidth.W))
  })
  //-------------------------Forwarding MEM----------------------------------------------------------
  val forwardingMEMrs1 = (io.mem_fwd.rd === io.id_rs1 && io.id_rs1 =/= 0.U && io.mem_fwd.writeEnable)
  val forwardingMEMrs2 = (io.mem_fwd.rd === io.id_rs2 && io.id_rs2 =/= 0.U && io.mem_fwd.writeEnable)
  //-------------------------Forwarding WB-----------------------------------------------------------
  val forwardingWBrs1 = (io.wb_fwd.rd === io.id_rs1 && io.id_rs1 =/= 0.U && io.wb_fwd.writeEnable)
  val forwardingWBrs2 = (io.wb_fwd.rd === io.id_rs2 && io.id_rs2 =/= 0.U && io.wb_fwd.writeEnable)
  // ------------------------Forwarding EX to MEM----------------------------------------------------
  
  when(forwardingMEMrs1) { // When output from the MEM stage is needed in EX val1, if rd is equal to rs1
    io.val1 := io.mem_fwd.stageOutput
  }.elsewhen(forwardingWBrs1) { // When output from the WB stage is needed in EX val1, if rd is equal to rs1
    io.val1 := io.wb_fwd.stageOutput
  }.otherwise { // Otherwise no forwarding is needed
    io.val1 := io.id_val1
  }

  when(forwardingMEMrs2) { // When output from the MEM stage is needed in EX val2, if rd is equal to rs2
    io.val2 := io.mem_fwd.stageOutput
  }.elsewhen(forwardingWBrs2) { // When output from the WB stage is needed in EX val2, if rd is equal to rs2
    io.val2 := io.wb_fwd.stageOutput
  }.otherwise {
    io.val2 := io.id_val2
  }
}
