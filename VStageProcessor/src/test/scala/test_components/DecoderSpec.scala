package test_components
import chisel3._
import chiseltest._
import components._
import utilities._
import org.scalatest.flatspec.AnyFlatSpec
class DecoderSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if decoder sets correct control values for BEQ instruction" in {
    test(new Decoder(32, 5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.inInst.poke("h10812063".U)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.ctrlSignals.branch.expect(true.B)
      dut.io.ctrlSignals.load.expect(false.B)
      dut.io.ctrlSignals.store.expect(false.B)
      dut.io.ctrlSignals.useALU.expect(false.B)
    }
  }

  it should "decode an ADDI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00A38393".U) // ADDI x7, x7, 10
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(1.U)
      dut.io.rs1.expect(7.U)
      dut.io.rs2.expect(10.U)
      dut.io.rd.expect(7.U)
    }
  }

  it should "decode an LUI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h000012b7".U) // lui x5, 4096
      dut.clock.step(1)
      dut.io.ctrlSignals.load.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an AUIPC instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00001517".U) // auipc x10, 4096
      dut.clock.step(1)
      dut.io.ctrlSignals.load.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rd.expect(10.U)
    }
  }

  it should "decode an JAL instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0280026f".U) // jal x4, 40
      dut.clock.step(1)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.ctrlSignals.jump.expect(true.B)
      dut.io.rd.expect(4.U)
    }
  }

  it should "decode an JALR instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00a28167".U) // jalr x2, x5, 10
      dut.clock.step(1)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.ctrlSignals.jump.expect(true.B)
      dut.io.rd.expect(2.U)
    }
  }

  it should "decode an BR type instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00208263".U) // beq x1, x2, 4
      dut.clock.step(1)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.ctrlSignals.branch.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
    }
  }

  it should "decode an LD type instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00410083".U) //lb x1, 4(x2)
      dut.clock.step(1)
      dut.io.ctrlSignals.load.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rs1.expect(2.U)
      dut.io.rd.expect(1.U)
    }
  }

  it should "decode an ST type instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00a0a023".U) // sw x10, 0(x1)
      dut.clock.step(1)
      dut.io.ctrlSignals.store.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(10.U)
    }
  }

  it should "decode an SLTI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h1f40a113".U) //slti x2, x1, 500
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(9.U)
      dut.io.rs1.expect(1.U)
      dut.io.rd.expect(2.U)
    }
  }

  it should "decode an SLTIU instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0287b293".U) // sltiu x5, x15, 40
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(10.U)
      dut.io.rs1.expect(15.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an XORI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h1f414293".U) // xori x5, x2, 500
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(5.U)
      dut.io.rs1.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an ORI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0320e293".U) // ori x5, x1, 50
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rs1.expect(1.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an ANDI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0324f193".U) // andi x3, x9, 50
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.rs1.expect(9.U)
      dut.io.rd.expect(3.U)
    }
  }


  it should "decode an SLLI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00529793".U) // slli x15, x5, 5
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(8.U)
      dut.io.rs1.expect(5.U)
      dut.io.rd.expect(15.U)
    }
  }

  it should "decode an SRLI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00615293".U) // srli x5, x2, 6
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(7.U)
      dut.io.rs1.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an SRAI instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h40745493".U) // srai x9, x8, 7
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(true.B)
      dut.io.aluOp.expect(6.U)
      dut.io.rs1.expect(8.U)
      dut.io.rd.expect(9.U)
    }
  }

  it should "decode an ADD instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h002082b3".U) // add x5, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(false.B)
      dut.io.aluOp.expect(1.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an SUB instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h402082b3".U) // sub x5, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.ctrlSignals.useImm.expect(false.B)
      dut.io.aluOp.expect(2.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an SLL instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h002092b3".U) // sll x5, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(8.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an SLT instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0020a2b3".U) // slt x5, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(9.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an SLTU instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0020b2b3".U) // sltu x5, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(10.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(5.U)
    }
  }

  it should "decode an XOR instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00b647b3".U) // xor x15, x12, x11
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(5.U)
      dut.io.rs1.expect(12.U)
      dut.io.rs2.expect(11.U)
      dut.io.rd.expect(15.U)
    }
  }

  it should "decode an SRL instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0020da33".U) // srl x20, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(7.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(20.U)

    }
  }

  it should "decode an SRA instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h4020da33".U) // sra x20, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(6.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(20.U)
    }
  }

  it should "decode an OR instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h0020e1b3".U) // or x3, x1, x2
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(4.U)
      dut.io.rs1.expect(1.U)
      dut.io.rs2.expect(2.U)
      dut.io.rd.expect(3.U)
    }
  }

  it should "decode an AND instruction" in {
    test(new Decoder(32, 5)) { dut =>
      dut.io.inInst.poke("h00aa7f33".U) // and x30, x20, x10
      dut.clock.step(1)
      dut.io.ctrlSignals.useALU.expect(true.B)
      dut.io.aluOp.expect(3.U)
      dut.io.rs1.expect(20.U)
      dut.io.rs2.expect(10.U)
      dut.io.rd.expect(30.U)

    }
  }
}
