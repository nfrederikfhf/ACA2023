package ChiselRISC.components.memory

import ChiselRISC.utilities._
import chisel3._
import chisel3.util._
import chisel3.experimental.{ChiselAnnotation, ChiselEnum, annotate}
import firrtl.annotations.MemoryArrayInitAnnotation
import chisel3.util.experimental.loadMemoryFromFileInline

class InstructionMemoryFPGA(depth: Int, datawidth: Int, init: Seq[BigInt] = Seq(BigInt(0))) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {
    val memIO = Flipped(new memoryInterfaceLight(datawidth)) // Memory interface
    val memOut = Output(UInt(datawidth.W)) // Data read from memory
  })

  io.memOut := WireInit(0.U(datawidth.W))
  io.memIO.ready := DontCare
  val readAddr = WireInit(0.U(bitwidth.W))
  io.memIO.nonEmpty := WireInit(true.B)
  val writePtr = RegInit(0.U(bitwidth.W))

  // Instantiate the memory
  val mem = Mem(actualDepth, UInt(datawidth.W))


  // Fill memory with program

    annotate(new ChiselAnnotation {
      override def toFirrtl = MemoryArrayInitAnnotation(mem.toTarget, init.padTo(actualDepth, BigInt(0))) // Ready to read as memory is not empty
      io.memIO.nonEmpty := false.B
    })


  // Fill memory with program
//  if (memoryFile.trim().nonEmpty) {
//    io.memIO.nonEmpty := false.B // Ready to read as memory is not empty
//    loadMemoryFromFileInline(mem, memoryFile)
//  }

  // Read from memory
  when(io.memIO.valid) {
    readAddr := io.memIO.addr >> 2 // Divide by 4 to get the correct read address
    io.memOut := mem(readAddr)
  }

  when(io.memIO.write){
    mem(writePtr) := io.memIO.writeData
    writePtr := writePtr + 1.U
    when(writePtr >= actualDepth.U){
      writePtr := 0.U
    }
  }

}