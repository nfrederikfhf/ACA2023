package ChiselRISC.stages
import chisel3._
import chiseltest._
import ChiselRISC.stages._
import org.scalatest.flatspec.AnyFlatSpec
class IFSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "check instruction can be fetched" in {
    test(new IF(32, 100,true)) { dut =>
      dut.io.changePC.poke(false.B)
      dut.io.newPCValue.poke(0.U)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.writeData.poke("h81234523".U(32.W))
      dut.io.startPC.get.poke(true.B)
      dut.clock.step(2)
      dut.io.memIO.ready.poke(false.B)
      dut.io.out.inst.expect("h81234523".U(32.W))
      dut.io.out.pc.expect(0.U)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.writeData.poke("h10812063".U(32.W))

      dut.clock.step(2)
      dut.io.memIO.ready.poke(false.B)

      dut.io.out.inst.expect("h10812063".U(32.W))
      dut.io.out.pc.expect(8.U)
      dut.clock.step(1)
      dut.io.memIO.ready.poke(true.B)
      dut.io.memIO.writeData.poke("h90812063".U(32.W))

      dut.clock.step(2)
      dut.io.memIO.ready.poke(false.B)
      dut.io.out.inst.expect("h90812063".U(32.W))
      dut.io.out.pc.expect(16.U)
    }
  }
}
