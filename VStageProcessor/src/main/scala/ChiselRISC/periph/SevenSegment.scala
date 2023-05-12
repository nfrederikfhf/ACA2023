package ChiselRISC.periph

import chisel3._
import chisel3.util._
/*
   This SevenSegment is based on previous work i did in course Digital Elections 2, and some of the code has been reused
    from that project. However it has been adapted to be more modern and to fit the needs of this project. - William
 */
class  SevenSegment(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val rd = Input(UInt(7.W))
    val val1 = Input(UInt(7.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  val sevSeg = WireDefault("b1111111".U(7.W)) //Cathode signal
  val select = WireDefault("b0001".U(4.W)) //Anode selection signal

  val counter = Counter(maxCount) // Counter

  val cntRegSel = RegInit(0.U(2.W)) //The counter used to shift anode signal every tick
  when(counter.inc()) {
    cntRegSel := cntRegSel + 1.U
  }

  switch(cntRegSel){ //Multiplexing the anodes
    is("b00".U){select := "b0001".U}
    is("b01".U){select := "b0010".U}
    is("b10".U){select := "b0100".U}
    is("b11".U){select := "b1000".U}
  }
  val wire1 = WireDefault(0.U(8.W))

  val table = Wire(Vec (100 , UInt (8.W))) //Creating a look-up table function

  for (i <- 0 until 100) { // BCD encoding algorithm
    table(i) := (((i/10) <<4) + i%10).U
  }

  val sevSegIn = WireDefault("b0000".U(4.W))
  switch(cntRegSel){ //Choosing which half of the bit bus to decode (because of the BCD coding)
    is("b00".U){sevSegIn := table(wire1)(3,0)}
    is("b01".U){sevSegIn := table(wire1)(7,4)}
    is("b10".U){sevSegIn := table(wire1)(3,0)}
    is("b11".U){sevSegIn := table(wire1)(7,4)}
  }


  switch(sevSegIn) { //The implementation is simply a look-up table.
    is("b0000".U) {
      sevSeg := "b0111111".U
    }
    is("b0001".U) {
      sevSeg := "b0000110".U
    }
    is("b0010".U) {
      sevSeg := "b1011011".U
    }
    is("b0011".U) {
      sevSeg := "b1001111".U
    }
    is("b0100".U) {
      sevSeg := "b1100110".U
    }
    is("b0101".U) {
      sevSeg := "b1101101".U
    }
    is("b0110".U) {
      sevSeg := "b1111101".U
    }
    is("b0111".U) {
      sevSeg := "b0000111".U
    }
    is("b1000".U) {
      sevSeg := "b1111111".U
    }
    is("b1001".U) {
      sevSeg := "b1101111".U
    }
  }

  switch(cntRegSel){ // Necessary to choose which half of the bit bus to decode
    is("b00".U){wire1 := io.rd}
    is("b01".U){wire1 := io.rd}
    is("b10".U){wire1 := io.val1}
    is("b11".U){wire1 := io.val1}
  }

  io.seg := ~sevSeg
  io.an := ~select
}
