package stages

import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec

class MEMSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "pass through aluOut, rd, and memOut signals" in {
    test(new MEM(32, 5)).withAnnotations(Seq(WriteVcdAnnotation))  { dut =>
      dut.io.in.ctrl.load.poke(true.B)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(1234.U)

      dut.clock.step(1)

      dut.io.out.aluOut.expect(0.U)
      dut.io.out.rd.expect(1.U)
      dut.io.out.memOut.expect(0.U)

      dut.io.in.ctrl.load.poke(false.B)
      dut.io.in.ctrl.store.poke(true.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(5678.U)

      dut.clock.step(1)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.ctrl.load.poke(true.B)
      dut.io.out.aluOut.expect(0.U)
      dut.io.out.rd.expect(1.U)
      dut.io.out.memOut.expect(5678.U)
    }
  }

  it should "write to memory when store signal is high" in {
    test(new MEM(dataWidth = 32, addrWidth = 32)) { dut =>
      dut.io.in.ctrl.load.poke(false.B)
      dut.io.in.ctrl.store.poke(true.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(1234.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(0.U)

      dut.io.in.ctrl.load.poke(true.B)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(5678.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(1234.U)
    }
  }

  it should "not write to memory when store signal is low" in {
    test(new MEM(dataWidth = 32, addrWidth = 32)) { dut =>
      dut.io.in.ctrl.load.poke(true.B)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(1234.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(0.U)

      dut.io.in.ctrl.load.poke(false.B)
      dut.io.in.ctrl.store.poke(true.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(5678.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(0.U)
    }
  }

  it should "not write to memory when load signal is high" in {
    test(new MEM(dataWidth = 32, addrWidth = 32)) { dut =>
      dut.io.in.ctrl.load.poke(true.B)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(1234.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(0.U)

      dut.io.in.ctrl.load.poke(false.B)
      dut.io.in.ctrl.store.poke(false.B)
      dut.io.in.rd.poke(1.U)
      dut.io.in.imm.poke(5678.U)

      dut.clock.step(1)

      dut.io.out.memOut.expect(0.U)
    }
  }
}
