package components
import chisel3._
import chisel3.util._
import utilities.{OP, Funct3, Funct7}
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

  val (op,_) = OP.safe(io.in.inst(6,0))
  val (funct3,_) = Funct3.safe(io.in.inst(14,12))
  val (funct7,_) = Funct7.safe(io.in.inst(31,25))

  switch(op) {
    is(OP.LD) {
      io.out.ctrl.load := true.B
      io.out.ctrl.useImm := true.B
    }

    is(OP.IM){
      io.out.ctrl.useALU := true.B
      io.out.ctrl.useImm := true.B
      switch(funct3){
        is(Funct3.ADDI){}
        is(Funct3.SLLI){}
        is(Funct3.SLTI){}
        is(Funct3.SLTIU){}
        is(Funct3.ORI){}
        is(Funct3.ANDI){}
        is(Funct3.SRI){
          switch(funct7){
            is(Funct7.SRAI){}
            is(Funct7.SRLI){}
          }
        }
        is(Funct3.XORI){}
      }
    }

    is(OP.AUIPC){
      io.out.ctrl.load := true.B
      io.out.ctrl.useImm := true.B
    }

    is(OP.ST){
      io.out.ctrl.store := true.B
      io.out.ctrl.useImm := true.B
    }

    is(OP.AR){
      io.out.ctrl.useALU := true.B
      switch(funct3){
        is(Funct3.ADDSUB){
          switch(funct7){
            is(Funct7.ADD){}
            is(Funct7.SUB){}
          }
        }
        is(Funct3.SLL){}
        is(Funct3.SLT){}
        is(Funct3.SLTU){}
        is(Funct3.XOR){}
        is(Funct3.SR){
          switch(funct7){
            is(Funct7.SRA){}
            is(Funct7.SRL){}
          }
        }
        is(Funct3.OR){}
        is(Funct3.AND){}
      }
    }

    is(OP.LUI){
      io.out.ctrl.useImm := true.B
      io.out.ctrl.load := true.B
    }
    is(OP.BR){
      io.out.ctrl.branch := true.B
      io.out.ctrl.useImm := true.B
    }
    is(OP.JALR){
      io.out.ctrl.jump := true.B
      io.out.ctrl.useImm := true.B
    }
    is(OP.JAL){
      io.out.ctrl.jump := true.B
      io.out.ctrl.useImm := true.B
    }
  }
  io.out.rs1 := io.in.inst(19, 15)
  io.out.rs1 := io.in.inst(24, 20)
  io.out.rd := io.in.inst(11, 7)
}