package ChiselRISC.components.memory

import Chisel.Fill
import chisel3._
import chisel3.util.{Cat, log2Ceil}
import chisel3.experimental.{ChiselAnnotation, annotate}
import firrtl.annotations.MemoryArrayInitAnnotation
import ChiselRISC.utilities.Funct3

class SyncBankMemory(dataWidth: Int, depth: Int, banks: Int) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {
    // Read Enable
    val rden = Input(Bool())
    //ReadPort 1
    val rdAddr1 = Input(UInt(bitwidth.W))
    val rdData1 = Output(UInt(dataWidth.W))
    //ReadPort 2
    val rdAddr2 = Input(UInt(bitwidth.W))
    val rdData2 = Output(UInt(dataWidth.W))
    //Write
    val wrAddr = Input(UInt(bitwidth.W))
    val wrData = Input(UInt(dataWidth.W))
    val wren = Input(Bool())
    //Op for memory
    val memOp = Input(UInt(4.W))
  })

  require(banks == 4, "Functionality for other bank types not implemented")
  //Init
  io.rdData1 := WireInit(0.U(dataWidth.W))
  io.rdData2 := WireInit(0.U(dataWidth.W))
  val rdData1 = WireInit(Vec(banks,(UInt((dataWidth/banks).W))), DontCare) // To allow for reading next clock cycle
  val rdData2 = WireInit(Vec(banks,(UInt((dataWidth/banks).W))), DontCare)
  val readAddress1 = WireInit(0.U(bitwidth.W)) // To allow for reading next clock cycle
  val readAddress2 = WireInit(0.U(bitwidth.W))
  val writeAddress = WireInit(0.U(bitwidth.W))
  val memMask = VecInit(Seq.fill(banks)(false.B))
  val wrData = VecInit(io.wrData(7, 0), io.wrData(15, 8), io.wrData(23, 16), io.wrData(31, 24))
  val vecIndexWr = WireInit(0.U(bitwidth.W))
  val vecIndexRd1 = RegInit(0.U(bitwidth.W))
  val vecIndexRd2 = RegInit(0.U(bitwidth.W))

  // Get the correct banks to write and read to/from
  vecIndexWr := io.wrAddr % 4.U
  vecIndexRd1 := io.rdAddr1 % 4.U
  vecIndexRd2 := io.rdAddr2 % 4.U

  when(
    io.memOp === Funct3.SB ||
      io.memOp === Funct3.LB ||
      io.memOp === Funct3.LBU
  ) {
    // Select correct mask
    memMask(vecIndexWr) := true.B
    // To allow for correct masking
    wrData(0) := io.wrData(7,0)
    wrData(1) := io.wrData(7,0)
    wrData(2) := io.wrData(7,0)
    wrData(3) := io.wrData(7,0)
  }
    .elsewhen(
      io.memOp === Funct3.SH ||
        io.memOp === Funct3.LH ||
        io.memOp === Funct3.LHU
    ) {
      // Select correct masks
      memMask(vecIndexWr) := true.B
      memMask(vecIndexWr + 1.U) := true.B
      // To allow for correct masking
      wrData(0) := io.wrData(7, 0)
      wrData(1) := io.wrData(15,8)
      wrData(2) := io.wrData(7, 0)
      wrData(3) := io.wrData(15,8)
    }.otherwise {
    memMask := Seq.fill(banks)(true.B)
    // Get the correct banks to write and read to/from
    vecIndexWr := 0.U
    vecIndexRd1 := 0.U
    vecIndexRd2 := 0.U
  }
  // Instantiate the memory, syncronous read
  val mem = SyncReadMem(actualDepth, Vec(banks, UInt((dataWidth / banks).W)))

  //  annotate(new ChiselAnnotation {
  //    override def toFirrtl = MemoryArrayInitAnnotation(mem.toTarget, Seq(BigInt(0)).padTo(actualDepth, BigInt(0)))
  //  })

  when(io.rden) { // Calculate the address to read from
    // Divide by four to get the correct address due to pc+4 addressing
    readAddress1 := io.rdAddr1 >> 2
    readAddress2 := io.rdAddr2 >> 2
    rdData1 := mem.read(readAddress1)
    rdData2 := mem.read(readAddress2)
  }

  when(RegNext(io.rden)) { // Only update the output if the read is enabled, or if it was enabled last cycle
        when(RegNext(io.memOp) === Funct3.LB) {
          io.rdData1 := Cat(Fill(24,rdData1(vecIndexRd1)(7).asUInt), rdData1(vecIndexRd1)(7,0).asUInt)
          io.rdData2 := Cat(Fill(24,rdData2(vecIndexRd2)(7).asUInt), rdData2(vecIndexRd2)(7,0).asUInt)
        }.elsewhen(RegNext(io.memOp) === Funct3.LH) {
          io.rdData1 := Cat(Fill(16,rdData1(vecIndexRd1 + 1.U)(7).asUInt),rdData1(vecIndexRd1 + 1.U).asUInt, rdData1(vecIndexRd1).asUInt)
          io.rdData2 := Cat(Fill(16,rdData2(vecIndexRd2 + 1.U)(7).asUInt),rdData2(vecIndexRd2 + 1.U).asUInt, rdData2(vecIndexRd2).asUInt)
        }.otherwise {
          io.rdData1 := (rdData1(3) ## rdData1(2) ## rdData1(1) ## rdData1(0)).asUInt
          io.rdData2 := (rdData2(3) ## rdData2(2) ## rdData2(1) ## rdData2(0)).asUInt
        }
  }

  when(io.wren) {
    writeAddress := io.wrAddr >> 2
    mem.write(writeAddress, wrData, memMask)
  }
}
