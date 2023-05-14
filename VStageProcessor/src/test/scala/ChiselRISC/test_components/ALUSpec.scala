// See README.md for license details.

package ChiselRISC.test_components

import chisel3._
import chiseltest._
import ChiselRISC.components.ALU
import ChiselRISC.utilities.ALUOp
import org.scalatest.flatspec.AnyFlatSpec

class ALUSpec extends AnyFlatSpec with ChiselScalatestTester{

  it should "add 2 integers correctly" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.ADD.litValue)
      dut.io.val1.poke(3.U)
      dut.io.val2.poke(4.U)
      dut.clock.step()
      dut.io.aluOut.expect(7.U)
    }
  }

  it should "subtract from integer correctly" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.SUB.litValue)
      dut.io.val1.poke(8.U)
      dut.io.val2.poke(5.U)
      dut.clock.step()
      dut.io.aluOut.expect(3.U)
    }
  }

  it should "perform bitwise AND correctly" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.AND.litValue)
      dut.io.val1.poke(6.U) //0110
      dut.io.val2.poke(3.U) //0011
      dut.clock.step()
      dut.io.aluOut.expect(2.U) //0010
    }
  }

  it should "perform bitwise OR correctly" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.OR.litValue)
      dut.io.val1.poke(5.U) //0101
      dut.io.val2.poke(6.U) //0110
      dut.clock.step()
      dut.io.aluOut.expect(7.U) //0111
    }
  }

  it should "perform bitwise XOR correctly" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.XOR.litValue)
      dut.io.val1.poke(9.U) // 1001
      dut.io.val2.poke(7.U) // 0111
      dut.clock.step()
      dut.io.aluOut.expect(14.U) //1110
    }
  }

  it should "set to 1 when A is less than B" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.SLT.litValue)
      dut.io.val1.poke(3.U)
      dut.io.val2.poke(7.U)
      dut.clock.step()
      dut.io.aluOut.expect(1.U)
    }
  }

  it should "set to 0 when A is NOT less than B" in {
    test(new ALU(32, 5)) { dut =>
      dut.io.aluOp.poke(ALUOp.SLT.litValue)
      dut.io.val1.poke(7.U)
      dut.io.val2.poke(3.U)
      dut.clock.step()
      dut.io.aluOut.expect(0.U)
    }
  }

  //The following still needs testing:
  //SRA
  //SRL
  //SLL
  //SLTU
}
