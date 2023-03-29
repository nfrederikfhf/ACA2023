//// See README.md for license details.
//
//package test_components
//
//import chisel3._
//import chiseltest._
//import components.ALU
//import utilities.Funct7
//import utilities.Funct7._
//import org.scalatest.flatspec.AnyFlatSpec
//
//class ALUTest extends AnyFlatSpec with ChiselScalatestTester{
//
//  it should "add 2 integers correctly" in {
//    test(new ALU(32)) { dut =>
//      dut.io.operation.poke(ADD)
//      dut.io.a.poke(3.U)
//      dut.io.b.poke(4.U)
//      dut.clock.step()
//      dut.io.output.expect(7.U)
//    }
//  }
//
//  it should "subtract from integer correctly" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(SUB)
//      dut.io.a.poke(8.U)
//      dut.io.b.poke(5.U)
//      dut.clock.step()
//      dut.io.output.expect(3.U)
//    }
//  }
//
//  it should "perform bitwise AND correctly" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(AND)
//      dut.io.a.poke(6.U) //0110
//      dut.io.b.poke(3.U) //0011
//      dut.clock.step()
//      dut.io.output.expect(2.U) //0010
//    }
//  }
//
//  it should "perform bitwise OR correctly" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(OR)
//      dut.io.a.poke(5.U) //0101
//      dut.io.b.poke(6.U) //0110
//      dut.clock.step()
//      dut.io.output.expect(7.U) //0111
//    }
//  }
//
//  it should "perform bitwise XOR correctly" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(XOR)
//      dut.io.a.poke(9.U) // 1001
//      dut.io.b.poke(7.U) // 0111
//      dut.clock.step()
//      dut.io.output.expect(14.U) //1110
//    }
//  }
//
//  it should "set to 1 when a is less than b" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(SLT)
//      dut.io.a.poke(3.U)
//      dut.io.b.poke(7.U)
//      dut.clock.step()
//      dut.io.output.expect(1.U)
//    }
//  }
//
//  it should "set to 0 when a is NOT less than b" in {
//    test(new ALU) { dut =>
//      dut.io.operation.poke(SLT)
//      dut.io.a.poke(7.U)
//      dut.io.b.poke(3.U)
//      dut.clock.step()
//      dut.io.output.expect(0.U)
//    }
//  }
//}
