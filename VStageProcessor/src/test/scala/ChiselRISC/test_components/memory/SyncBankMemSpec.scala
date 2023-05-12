package ChiselRISC.test_components.memory

import chisel3._
import chiseltest._
import ChiselRISC.components.memory.SyncBankMemory
import ChiselRISC.utilities.Funct3
import org.scalatest.flatspec.AnyFlatSpec

class SyncBankMemSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "check if write/read works as a word" in {
    test(new SyncBankMemory(32, 1024, 4)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke(42.U)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(0.U)
      dut.clock.step(1)
      dut.io.rdData1.expect(42.U)
    }
  }

  it should "check if store/load as a half word works" in {
    test(new SyncBankMemory(32, 1024, 4)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h1234FFFF".U)
      dut.io.memOp.poke(Funct3.SH.litValue)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(0.U)
      dut.clock.step(1)
      dut.io.rdData1.expect("h0000FFFF".U)
    }
  }

  it should "check if store/load as a byte works" in {
    test(new SyncBankMemory(32, 1024, 4)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.wrData.poke("h123456FF".U)
      dut.io.memOp.poke(Funct3.SB.litValue)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(0.U)
      dut.clock.step(1)
      dut.io.rdData1.expect("h000000FF".U)
    }
  }

  it should "check if store/load as a word works with not address % 4 = 0" in {
    test(new SyncBankMemory(32, 1024, 4)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(5.U)
      dut.io.wrData.poke("h123456FF".U)
      dut.io.memOp.poke(Funct3.SW.litValue)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(5.U)
      dut.clock.step(1)
      dut.io.rdData1.expect("h123456FF".U)
    }
  }

  it should "check if storing a word at an address, and loading a byte from the word at another address" in {
    test(new SyncBankMemory(32, 1024, 4)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke("h123456FF".U)
      dut.io.memOp.poke(Funct3.SW.litValue)
      dut.clock.step(1)
      dut.io.memOp.poke(Funct3.LB.litValue)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(7.U)
      dut.clock.step(1)
      dut.io.rdData1.expect("h12".U)
    }
  }
  it should "bruh" in {
    test(new SyncBankMemory(32, 1024, 4)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(0.U)
      dut.io.memOp.poke(Funct3.SB.litValue)
      dut.io.wrData.poke("hDE".U)
      dut.clock.step(1)
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(1.U)
      dut.io.memOp.poke(Funct3.SB.litValue)
      dut.io.wrData.poke("hFF".U)
      dut.clock.step(1)
      dut.io.memOp.poke(Funct3.LB.litValue)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(0.U)
      dut.clock.step(1)
      dut.io.rdData1.expect("hDE".U)
    }
  }
}
