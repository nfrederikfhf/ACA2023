package ChiselRISC.periph

import chisel3._
import chisel3.util._

class SevenSegment extends Module{
  val io = IO(new Bundle {
    val in = Input(UInt(16.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  io.seg  := WireDefault("b1111111".U(7.W)) //Cathode
  io.an := WireDefault("b1111".U(4.W)) //Anode

  val data = WireInit(0.U(4.W)) //Data to be displayed

  // Generating a tick at 2.3KHz frequency
  val ticker = RegInit(0.U((log2Ceil(100000000 / 200)).W))
  val tick = ticker === (log2Ceil(100000000 / 200) - 1).U
  ticker := Mux(tick, 0.U, ticker + 1.U)

  // The counter used to shift the anode signal
  val cntReg = RegInit(0.U(log2Ceil(3).W))
  when(tick) { // Change every tick
    cntReg := Mux(cntReg === 3.U, 0.U, cntReg + 1.U)
  }

  switch(cntReg){ // Select the anode to be lit
    is(0.U) {
      data := io.in(15, 12)
      io.an := "b0111".U
    }
    is(1.U) {
      data := io.in(11, 8)
      io.an := "b1011".U
    }
    is(2.U) {
      data := io.in(7, 4)
      io.an := "b1101".U
    }
    is(3.U){
       data := io.in(3,0)
       io.an := "b1110".U
    }
  }

  switch(data) { // Lookup table for the 7-segment display
    is(0.U) {
      io.seg := "b1111110".U
    }
    is(1.U) {
      io.seg := "b0110000".U
    }
    is(2.U) {
      io.seg := "b1101101".U
    }
    is(3.U) {
      io.seg := "b1111001".U
    }
    is(4.U) {
      io.seg := "b0110011".U
    }
    is(5.U) {
      io.seg := "b1011011".U
    }
    is(6.U) {
      io.seg := "b1011111".U
    }
    is(7.U) {
      io.seg := "b1110000".U
    }
    is(8.U) {
      io.seg := "b1111111".U
    }
    is(9.U) {
      io.seg := "b1110011".U
    }
    is(10.U) {
      io.seg := "b1110111".U
    }
    is(11.U) {
      io.seg := "b0011111".U
    }
    is(12.U) {
      io.seg := "b1001110".U
    }
    is(13.U) {
      io.seg := "b0111101".U
    }
    is(14.U) {
      io.seg := "b1001111".U
    }
    is(15.U) {
      io.seg := "b1000111".U
    }
  }
}
