package components

import chisel3._
import chisel3.util._
import utilities.{OP, Funct3, Funct7, ALUOp}
import _root_.utilities._

class Decoder(datawidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val inInst = Input(UInt(datawidth.W)) // Input
    val aluOp = Output(UInt(4.W)) // ALU Operation
    val rs1 = Output(UInt(addrWidth.W))
    val rs2 = Output(UInt(addrWidth.W))
    val rd = Output(UInt(addrWidth.W))
    val ctrlSignals = new Bundle { // Control Signals
      val useImm = Output(Bool())
      val useALU = Output(Bool())
      val branch = Output(Bool())
      val jump = Output(Bool())
      val load = Output(Bool())
      val store = Output(Bool())
    }
  })

  // Initialize signals
  io.rs1 := WireInit(0.U(addrWidth.W))
  io.rs2 := WireInit(0.U(addrWidth.W))
  io.rd := WireInit(0.U(addrWidth.W))
  io.ctrlSignals.useImm := WireInit(false.B)
  io.ctrlSignals.branch := WireInit(false.B)
  io.ctrlSignals.useALU := WireInit(false.B)
  io.ctrlSignals.jump := WireInit(false.B)
  io.ctrlSignals.load := WireInit(false.B)
  io.ctrlSignals.store := WireInit(false.B)
  io.aluOp := WireInit(0.U(4.W))

  // split instruction into fields
  val (op, _) = OP.safe(io.inInst(6, 0))
  val funct3 = io.inInst(14, 12)
  val funct7 = io.inInst(31, 25)

  // Decode instruction
  switch(op) {
    is(OP.LD) {
      io.ctrlSignals.load := true.B
      io.ctrlSignals.useImm := true.B
      io.aluOp := ALUOp.ADD.asUInt
    }

    is(OP.IM) {
      io.ctrlSignals.useALU := true.B
      io.ctrlSignals.useImm := true.B
      switch(funct3) {
        is(Funct3.ADDI) {
          io.aluOp := ALUOp.ADD.asUInt
        }
        is(Funct3.SLLI) {
          io.aluOp := ALUOp.SLL.asUInt
        }
        is(Funct3.SLTI) {
          io.aluOp := ALUOp.SLT.asUInt
        }
        is(Funct3.SLTIU) {
          io.aluOp := ALUOp.SLTU.asUInt
        }
        is(Funct3.ORI) {
          io.aluOp := ALUOp.OR.asUInt
        }
        is(Funct3.ANDI) {
          io.aluOp := ALUOp.AND.asUInt
        }
        is(Funct3.SRI) {
          switch(funct7) {
            is(Funct7.SRAI) {
              io.aluOp := ALUOp.SRA.asUInt
            }
            is(Funct7.SRLI) {
              io.aluOp := ALUOp.SRL.asUInt
            }
          }
        }
        is(Funct3.XORI) {
          io.aluOp := ALUOp.XOR.asUInt
        }
      }
    }
      is(OP.AUIPC) {
        io.ctrlSignals.load := true.B
        io.ctrlSignals.useImm := true.B
      }

      is(OP.ST) {
        io.ctrlSignals.store := true.B
        io.ctrlSignals.useImm := true.B
      }

      is(OP.AR) {
        io.ctrlSignals.useALU := true.B
        switch(funct3) {
          is(Funct3.ADDSUB) {
            switch(funct7) {
              is(Funct7.ADD) {
                io.aluOp := ALUOp.ADD.asUInt
              }
              is(Funct7.SUB) {
                io.aluOp := ALUOp.SUB.asUInt
              }
            }
          }
          is(Funct3.SLL) {
            io.aluOp := ALUOp.SLL.asUInt
          }
          is(Funct3.SLT) {
            io.aluOp := ALUOp.SLT.asUInt
          }
          is(Funct3.SLTU) {
            io.aluOp := ALUOp.SLTU.asUInt
          }
          is(Funct3.XOR) {
            io.aluOp := ALUOp.XOR.asUInt
          }
          is(Funct3.SR) {
            switch(funct7) {
              is(Funct7.SRA) {
                io.aluOp := ALUOp.SRA.asUInt
              }
              is(Funct7.SRL) {
                io.aluOp := ALUOp.SRL.asUInt
              }
            }
          }
          is(Funct3.OR) {
            io.aluOp := ALUOp.OR.asUInt
          }
          is(Funct3.AND) {
            io.aluOp := ALUOp.AND.asUInt
          }
        }
      }

      is(OP.LUI) {
        io.ctrlSignals.useImm := true.B
        io.ctrlSignals.load := true.B
      }
      is(OP.BR) {
        io.ctrlSignals.branch := true.B
        io.ctrlSignals.useImm := true.B
      }
      is(OP.JALR) {
        io.ctrlSignals.jump := true.B
        io.ctrlSignals.useImm := true.B
      }
      is(OP.JAL) {
        io.ctrlSignals.jump := true.B
        io.ctrlSignals.useImm := true.B
      }
    }

    //---------outputs----------------
    io.rs1 := io.inInst(19, 15)
    io.rs2 := io.inInst(24, 20)
    io.rd := io.inInst(11, 7)

}