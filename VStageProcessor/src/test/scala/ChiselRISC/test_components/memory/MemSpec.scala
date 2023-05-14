package ChiselRISC.test_components.memory

import chisel3._
import chiseltest._
import ChiselRISC.components.memory.DualReadMem
import org.scalatest.flatspec.AnyFlatSpec

class MemSpec extends AnyFlatSpec with ChiselScalatestTester {
  it should "Write and read from memory address 0x0000 0001" in {
    test(new DualReadMem(32, 32, 100)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke(1234.U)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(1.U)
      dut.clock.step(1)
      dut.io.rden.poke(true.B)
      dut.io.rdData1.expect(1234.U)
    }
  }
  it should "get a value, because reading from mem after rden has been high" in {
    test(new DualReadMem(32, 32, 100)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(1.U)
      dut.io.wrData.poke(1234.U)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(true.B)
      dut.io.rdAddr1.poke(1.U)
      dut.clock.step(1)
      dut.io.rdData1.expect(1234.U)
    }
  }

  it should "get zero, because reading from mem cant read from mem without rden has been high" in {
    test(new DualReadMem(32, 32, 100)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.wren.poke(true.B)
      dut.io.wrAddr.poke(4.U)
      dut.io.wrData.poke(1234.U)
      dut.clock.step(1)
      dut.io.wren.poke(false.B)
      dut.io.rden.poke(false.B)
      dut.io.rdAddr1.poke(4.U)
      dut.clock.step(1)
      dut.io.rdData1.expect(0.U)
    }
  }
}
