package components

import chisel3._
import chiseltest._
import org.scalatest._
import org.scalatest.flatspec._
import org.scalatest.matchers._

class RegisterFileSpec extends AnyFlatSpec with ChiselScalatestTester with should.Matchers {
  behavior of "RegisterFile"

  it should "have x0 equal to 0" in {
    test(new RegisterFile) { c =>
      c.io.sourceRegister1.poke(0.U)
      c.io.out1.expect(0.S)
    }
  }
  it should "not write to x0" in {
    test(new RegisterFile) { c =>
      c.io.writeEnable.poke(true)
      c.io.destinationRegister.poke(0.U)
      c.io.writeData.poke(123.S)
      c.clock.step()
      c.io.sourceRegister1.peekInt() should be(0)
    }
  }
  it should "not write if not enabled" in {
    test(new RegisterFile) { c =>
      c.io.sourceRegister1.poke(1)
      c.io.destinationRegister.poke(1)
      c.io.writeData.poke(123.S)
      c.clock.step()
      c.io.out1.expect(0.S)
    }
  }
  it should "write to other registers as expected" in {
    test(new RegisterFile).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      for (i <- 1 until 32) {
        c.io.writeEnable.poke(true)
        c.clock.step()
        c.io.destinationRegister.poke(i)
        c.io.writeData.poke(i.S)
        c.io.sourceRegister2.poke(i)
        c.clock.step()
        c.io.writeEnable.poke(false)
        c.io.out2.expect(i.S)
      }
      c.clock.step(10)
    }
  }
}
