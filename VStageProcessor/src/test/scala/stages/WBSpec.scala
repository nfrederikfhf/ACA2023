package stages
import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec
class WBSpec extends AnyFlatSpec with ChiselScalatestTester {

  it should "forward ALU result when writeEnable is false" in {
    test(new WB(32, 5)) { dut =>
      dut.io.in.load.poke(false.B)
      dut.io.in.aluOut.poke(42.U)
      dut.io.in.memOut.poke(123.U)
//      dut.clock.step()

      dut.io.out.writeEnable.expect(false.B)
      dut.io.out.muxOut.expect(42.U)
      dut.io.out.rd.expect(0.U)
    }
  }

  it should "forward memory result when writeEnable is true" in {
    test(new WB(32, 5)) { dut =>
      dut.io.in.load.poke(true.B)
      dut.io.in.aluOut.poke(42.U)
      dut.io.in.memOut.poke(123.U)
//      dut.clock.step()

      //dut.io.out.writeEnable.expect(true.B)
      dut.io.out.muxOut.expect(123.U)
      dut.io.out.rd.expect(0.U)
    }
  }

  it should "forward the correct destination register" in {
    test(new WB(32, 5)) { dut =>
      dut.io.in.load.poke(true.B)
      dut.io.in.aluOut.poke(42.U)
      dut.io.in.memOut.poke(123.U)
      dut.io.in.rd.poke(7.U)
//      dut.clock.step()

      //dut.io.out.writeEnable.expect(true.B)
      dut.io.out.muxOut.expect(123.U)
      dut.io.out.rd.expect(7.U)
    }
  }
}
