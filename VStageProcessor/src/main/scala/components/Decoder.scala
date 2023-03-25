package components
import chisel3._
import _root_.utilities._



class Decoder(datawidth: Int, addrWidth: Int)  extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new IF_ID_IO(datawidth)) // Input
    val out = new ID_EX_IO(datawidth, addrWidth) // Output
  })

  // Initialize signals
  io.out.imm := WireInit(0.U(datawidth.W))
  io.out.rs1 := WireInit(0.U(addrWidth.W))
  io.out.rs2 := WireInit(0.U(addrWidth.W))
  io.out.rd := WireInit(0.U(addrWidth.W))
  //io.inst.ready := WireInit(false.B)
  io.out.ctrl.useImm := WireInit(false.B)
  io.out.ctrl.useALU := WireInit(false.B)
  io.out.ctrl.jump := WireInit(false.B)
  io.out.ctrl.load := WireInit(false.B)
  io.out.ctrl.store := WireInit(false.B)
  io.out.ctrl.addToPC := WireInit(false.B)

//  switch(io.in.inst(6, 0)) {
//    is("0110011".U) {
//      switch(io.in.inst(30)) {
//
//        is("1".U) {
//          switch(io.in.inst(14, 12)) {
//            is("000".U) {
//
//            }
//          }
//        }
//        is("0".U) {
//          switch(io.in.inst(14, 12)) {
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