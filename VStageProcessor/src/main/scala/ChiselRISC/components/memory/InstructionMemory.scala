package ChiselRISC.components.memory
/*
 Redudant implementation as it uses circular buffer logic, which is not need for instruction memory
 */
import ChiselRISC.utilities._
import chisel3._
import chisel3.experimental.{ChiselAnnotation, annotate}
import chisel3.util._
import firrtl.annotations.MemoryArrayInitAnnotation

class InstructionMemory(depth: Int, datawidth: Int) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {
    val memIO = Flipped(new memoryInterfaceLight(datawidth)) // Memory interface
    val writer = new writeToInstMem(datawidth)
    val memOut = Output(UInt(datawidth.W)) // Data read from memory
  })

  io.memOut := WireInit(0.U(datawidth.W))
  io.memIO.ready := DontCare
  val readAddr = WireInit(0.U(datawidth.W))
  io.memIO.nonEmpty := WireInit(true.B)
  val writePtr = RegInit(0.U(bitwidth.W))
  when(writePtr > 0.U){
    io.memIO.nonEmpty := false.B
  }
  // Instantiate the memory
  val mem = RegInit(VecInit(Seq.fill(actualDepth)(0.U(datawidth.W))))

  when(io.memIO.valid) {
    readAddr := io.memIO.addr >> 2 // Divide by 4 to get the correct read address
    io.memOut := mem(readAddr)
  }

  when(io.writer.ready){
    mem(writePtr) := io.writer.data
    writePtr := writePtr + 1.U
    when(writePtr >= actualDepth.U){
      writePtr := 0.U
    }
  }
}