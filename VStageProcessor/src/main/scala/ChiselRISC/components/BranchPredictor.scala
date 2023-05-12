package ChiselRISC.components

import chisel3._
import chisel3.util._

class BranchPredictor(datawidth: Int = 32, pcStep: Int = 4) extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(datawidth.W))
    val instr = Input(UInt(datawidth.W))
    val targetPc = Output(UInt(datawidth.W))
    val changePC = Output(Bool())
    val historicaBranching = Input(Bool()) //coming from Ex if there was a branching (enable)
    val branchTaken = Input(Bool()) //coming from Ex if whether branch with given pc was actually taken
    val historicalPc = Input(UInt(datawidth.W)) //coming from Ex what pc does the correctness relates to
  })

  val entries = 32
  val tagBits = 8
  val indexBits = log2Ceil(entries)
  val stepBits = log2Ceil(pcStep)
  val historyVec = RegInit(VecInit(Seq.fill(entries)(0.U(2.W))))
  val tag = io.pc(indexBits + stepBits - 1, stepBits)
  //   TODO init stuff

  io.targetPc := Cat(Fill(20, io.instr(31)), io.instr(7), io.instr(30, 25), io.instr(11, 8), 0.U)
  io.changePC := Mux(io.instr(6, 0) === "b1100011".U, Mux(historyVec(tag)(1, 1) === 1.U, true.B, false.B ), false.B)

  when(io.historicaBranching) {
    val tagToUpdate = io.historicalPc(indexBits + stepBits - 1, stepBits)
    switch(historyVec(tagToUpdate)) {
      is("b00".U) {
        when(io.branchTaken === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b01".U
        }
      }
      is("b01".U) {
        when(io.branchTaken === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
      is("b11".U) {
        when(io.branchTaken === 0.U) {
          historyVec(tagToUpdate) := "b10".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
      is("b10".U) {
        when(io.branchTaken === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
    }
  }
}