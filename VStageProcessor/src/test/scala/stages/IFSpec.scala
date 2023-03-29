package stages
import chisel3._
import chiseltest._
import stages._
import org.scalatest.flatspec.AnyFlatSpec
class IFSpec extends AnyFlatSpec with ChiselScalatestTester{
  it should "check instruction can be fetched" in {
    test(new IF(32, 100)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.addToPC.poke(false.B)
      dut.io.addrOut.poke(0.U)
      dut.instMem.io.writeMem.valid.poke(true.B)
      dut.instMem.io.writeMem.bits.poke("h81234523".U(32.W))
      dut.clock.step(1)
      dut.instMem.io.writeMem.valid.poke(false.B)
      dut.PC.io.memIO.Response.ready.poke(true.B)
      dut.clock.step(1)
      dut.PC.io.memIO.Response.ready.poke(false.B)
      dut.io.out.inst.expect("h81234523".U(32.W))
      dut.clock.step(1)
    }
  }
}
