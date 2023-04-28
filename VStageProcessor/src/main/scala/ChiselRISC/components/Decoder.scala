package ChiselRISC.components

import chisel3._
import chisel3.util._
import ChiselRISC.utilities.{OP, Funct3, Funct7, ALUOp}
import ChiselRISC.utilities._

class Decoder(datawidth: Int, addrWidth: Int) extends Module {
  val io = IO(new Bundle {
    val inInst = Input(UInt(datawidth.W)) // Input
    val aluOp = Output(UInt(4.W)) // ALU Operation
    val memOp = Output(UInt(4.W)) // Memory Operation
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
      val changePC = Output(Bool())
    }
  })

  // Initialize signals
  io.rs1 := WireInit(0.U(addrWidth.W))
  io.rs2 := WireInit(0.U(addrWidth.W))
  io.rd := WireInit(0.U(addrWidth.W))
  io.memOp := WireInit(0.U(4.W))
  io.ctrlSignals.useImm := WireInit(false.B)
  io.ctrlSignals.branch := WireInit(false.B)
  io.ctrlSignals.useALU := WireInit(false.B)
  io.ctrlSignals.jump := WireInit(false.B)
  io.ctrlSignals.load := WireInit(false.B)
  io.ctrlSignals.store := WireInit(false.B)
  io.ctrlSignals.changePC := WireInit(false.B)
  io.aluOp := WireDefault(ALUOp.ADD.asUInt)

  // split instruction into fields
  val (op, _) = OP.safe(io.inInst(6, 0))
  val funct3 = io.inInst(14, 12)
  val funct7 = io.inInst(31, 25)

  // Decode instruction
  switch(op) {
    is(OP.LD) { // Load
      io.ctrlSignals.load := true.B
      io.ctrlSignals.useImm := true.B
      io.ctrlSignals.useALU := true.B
      io.aluOp := ALUOp.ADD.asUInt
      switch(funct3){
        is(Funct3.LB) {
          io.memOp := Funct3.LB.asUInt
        }
        is(Funct3.LH) {
          io.memOp := Funct3.LH.asUInt
        }
        is(Funct3.LW) {
          io.memOp := Funct3.LW.asUInt
        }
      }
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
        io.ctrlSignals.useImm := true.B
        io.ctrlSignals.useALU := true.B
      }

      is(OP.ST) { // Store instructions
        io.ctrlSignals.useALU := true.B
        io.ctrlSignals.store := true.B
        io.ctrlSignals.useImm := true.B
        switch(funct3) {
          is(Funct3.SB) {
            io.memOp := Funct3.SB.asUInt
          }
          is(Funct3.SH) {
            io.memOp := Funct3.SH.asUInt
          }
          is(Funct3.SW) {
            io.memOp := Funct3.SW.asUInt
          }
        }
      }

      is(OP.AR) { // Arithmetic instructions
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
        io.ctrlSignals.useALU := true.B
      }
      is(OP.BR) {
        io.ctrlSignals.branch := true.B
        io.ctrlSignals.useALU := true.B
        switch(funct3){
          is(Funct3.BEQ) {
            io.aluOp := ALUOp.BEQ.asUInt
          }
          is(Funct3.BNE) {
            io.aluOp := ALUOp.BNE.asUInt
          }
          is(Funct3.BLT) {
            io.aluOp := ALUOp.BLT.asUInt
          }
          is(Funct3.BGE) {
            io.aluOp := ALUOp.BGE.asUInt
          }
          is(Funct3.BLTU) {
            io.aluOp := ALUOp.BLTU.asUInt
          }
          is(Funct3.BGEU) {
            io.aluOp := ALUOp.BGEU.asUInt
          }
        }
      }
      is(OP.JALR) {
        io.ctrlSignals.jump := true.B
        io.ctrlSignals.useImm := true.B
        io.ctrlSignals.changePC := true.B
      }
      is(OP.JAL) {
        io.ctrlSignals.jump := true.B
        io.ctrlSignals.useImm := true.B
      }
    }

    //---------outputs----------------
    io.rs1 := Mux(op === OP.JAL, 0.U, io.inInst(19, 15)) // Reset rsX to 0 if JAL to avoid false forwarding
    io.rs2 := Mux(op === OP.JAL, 0.U, io.inInst(24, 20))
    io.rd := io.inInst(11, 7)

}