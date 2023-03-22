package components
import chisel3._
import chisel3.util._



class Decoder(datawidth: Int, addrWidth: Int)  extends Module {
  val io = IO(new Bundle {
    val inst = Flipped(DecoupledIO(UInt(datawidth.W))) // Instruction
    val imm = Output(UInt(datawidth.W)) // Immediate
    val rs1 = Output(UInt(addrWidth.W)) // Source Register 1
    val rs2 = Output(UInt(addrWidth.W)) // Source Register 2
    val rd = Output(UInt(addrWidth.W)) // Destination Register
    val ctrl = IO(new Bundle { // Control Signals
      val useImm = Output(Bool())
      val useALU = Output(Bool())
      val branch = Output(Bool())
      val jump = Output(Bool())
      val load = Output(Bool())
      val store = Output(Bool())
      val addToPC = Output(Bool())
    })
  })

  // Initialize signals
  io.imm := WireInit(0.U(datawidth.W))
  io.rs1 := WireInit(0.U(addrWidth.W))
  io.rs2 := WireInit(0.U(addrWidth.W))
  io.rd := WireInit(0.U(addrWidth.W))
  io.inst.ready := WireInit(false.B)
  io.ctrl.useImm := WireInit(false.B)
  io.ctrl.useALU := WireInit(false.B)
  io.ctrl.branch := WireInit(false.B)
  io.ctrl.jump := WireInit(false.B)
  io.ctrl.load := WireInit(false.B)
  io.ctrl.store := WireInit(false.B)
  io.ctrl.addToPC := WireInit(false.B)

//  switch(io.inst.bits(6, 0)) {
//    is("0110011".U) {
//      switch(io.inst.bits(30)) {
//
//        is("1".U) {
//          switch(io.inst.bits(14, 12)) {
//            is("000".U) {
//
//            }
//          }
//        }
//        is("0".U) {
//          switch(io.inst.bits(14, 12)) {
//            is("000".U) {
//
//            }
//
//          }
//
//        }
//      }
//
//
//    }
//  }
}