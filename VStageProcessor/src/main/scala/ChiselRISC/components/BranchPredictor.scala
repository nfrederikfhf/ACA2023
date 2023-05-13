package ChiselRISC.components

import chisel3._
import chisel3.util._

class BranchPredictor(datawidth: Int = 32, pcStep: Int = 4) extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(datawidth.W))
    val inst = Input(UInt(datawidth.W))
    val targetPC = Output(UInt(datawidth.W))
    val changePC = Output(Bool())
    val EXbranching = Input(Bool()) //coming from Ex if there was a branching (enable)
    val EXbranchResult = Input(Bool()) //coming from Ex if whether branch with given pc was actually taken
    val EXbranchPC = Input(UInt(datawidth.W)) //coming from Ex what pc does the correctness relates to
  })

  val entries = 32
  val indexBits = log2Ceil(entries)
  val stepBits = log2Ceil(pcStep)
  val historyVec = RegInit(VecInit(Seq.fill(entries)(0.U(2.W))))
  val tag = io.pc(indexBits + stepBits - 1, stepBits)

  io.targetPC := Cat((Cat(Fill(20, io.inst(31)), io.inst(7), io.inst(30, 25), io.inst(11, 8), 0.U) + io.pc.asUInt)(datawidth - 1, 1), 0.U(1.W))
  io.changePC := Mux(io.inst(6, 0) === "b1100011".U, historyVec(tag)(1, 1) === 1.U, false.B)

  when(io.EXbranching) {
    val tagToUpdate = io.EXbranchPC(indexBits + stepBits - 1, stepBits)
    switch(historyVec(tagToUpdate)) {
      is("b00".U) {
        when(io.EXbranchResult === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b01".U
        }
      }
      is("b01".U) {
        when(io.EXbranchResult === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
      is("b11".U) {
        when(io.EXbranchResult === 0.U) {
          historyVec(tagToUpdate) := "b10".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
      is("b10".U) {
        when(io.EXbranchResult === 0.U) {
          historyVec(tagToUpdate) := "b00".U
        }.otherwise {
          historyVec(tagToUpdate) := "b11".U
        }
      }
    }
  }
}