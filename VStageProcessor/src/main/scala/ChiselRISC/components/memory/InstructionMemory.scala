package ChiselRISC.components.memory

import ChiselRISC.utilities._
import chisel3._
import chisel3.util._

/**
 * Instruction Memory
 * Is implemented as a circular buffer
 *
 * @param depth     The depth of the memory
 * @param datawidth The width of the data
 *
 */
class InstructionMemory(depth: Int, datawidth: Int) extends Module {
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {
    val memIO = Flipped(new memoryInterfaceLight(datawidth)) // Memory interface
    val memOut = Output(UInt(datawidth.W)) // Data read from memory
  })
  // Buffer status signals
  val bufferEmpty = WireInit(true.B)
  val bufferFull = WireInit(false.B)

  // Initialise the signals
//  io.memIO.Response.data := WireInit(0.U(datawidth.W))
//  io.memIO.Response.ready := WireInit(false.B)
//  io.memIO.Response.nonEmpty := WireInit(false.B)
  io.memOut := WireInit(0.U(datawidth.W))
  io.memIO.ready := DontCare
  io.memIO.nonEmpty := WireInit(false.B)
  val readAddr = WireInit(0.U(bitwidth.W))

  // Pointers to handle empty and full logic
  val readPtr = RegInit(0.U(bitwidth.W))
  val writePtr = RegInit(0.U(bitwidth.W))
  val count = WireInit(0.U((bitwidth).W)) // Count of the number of elements in the memory

  // Check instruction memory status
  bufferEmpty := count === 0.U
  //--------
  bufferFull := count >= actualDepth.U - 1.U

  // Ready to receive a read address if memory is not empty
  io.memIO.nonEmpty := bufferEmpty

  // Instantiate the memory
  val mem = Reg(Vec(actualDepth, UInt(datawidth.W)))

  // Read from memory
  when(io.memIO.valid && !bufferEmpty) {
    readAddr := io.memIO.addr >> 2 // Divide by 4 to get the correct read address
    io.memOut := mem(readAddr)
    readPtr := readPtr + 1.U
    when(readPtr >= actualDepth.U) {
      readPtr := 0.U // Wrap around
    }
  }

  // Write to memory - should only be needed for testing
  when(io.memIO.write && !bufferFull) {
    mem(writePtr) := io.memIO.writeData
    writePtr := writePtr + 1.U

    when(writePtr >= actualDepth.U) {
      writePtr := 0.U
    }
  }
  // Calculate the number of elements in the memory
  val difference = writePtr - readPtr
  when(difference <= 0.U) { // Wrap around
    count := difference + actualDepth.U
  }.otherwise {
    count := difference
  }
}