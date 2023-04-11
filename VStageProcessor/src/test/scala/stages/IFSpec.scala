package stages
import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec
class IFSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "check instruction can be fetched" in {
    test(new IF(32, 100)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.branch.poke(false.B)
      dut.io.addrOut.poke(0.U)
      dut.clock.step(1)
      dut.io.memIO.write.ready.poke(true.B)
      dut.io.memIO.write.data.poke("h81234523".U(32.W))
      dut.clock.step(1)
      dut.io.memIO.write.data.poke("h10812063".U(32.W))
      dut.clock.step(1)
      dut.io.memIO.write.data.poke("h90812063".U(32.W))
      dut.clock.step(1)
      dut.io.memIO.write.ready.poke(false.B)
      dut.io.startPC.poke(true.B)
      dut.clock.step()

      dut.io.out.inst.expect("h81234523".U(32.W))
      dut.io.out.pc.expect(0.U)
      dut.io.startPC.poke(false.B)
      dut.clock.step()

      dut.io.startPC.poke(true.B)
      dut.clock.step()

      dut.io.out.inst.expect("h10812063".U(32.W))
      dut.io.out.pc.expect(4.U)
      dut.io.startPC.poke(false.B)
      dut.clock.step()

      dut.io.startPC.poke(true.B)

      dut.clock.step(1)
      dut.io.out.inst.expect("h90812063".U(32.W))
      dut.io.out.pc.expect(8.U)
      dut.io.startPC.poke(false.B)

    }
  }
}
