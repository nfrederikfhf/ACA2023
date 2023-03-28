package components.memory

import utilities._
import chisel3._
import chisel3.util._

/**
 * Instruction Memory
 * Is implemented as a circular buffer
 * @param depth     The depth of the memory
 * @param datawidth The width of the data
 *
 */

  /*                 TODO: Handling of full memory might not be optimal,
  *                  write should however only be for testing purposes so
  *                  it shouldn't matter. Also readPtr is possibly redundant
  */
class InstructionMemory(depth: Int, datawidth: Int) extends Module {
  val bitwidth = log2Ceil(depth)                // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle {                      // Input and Output
    val writeMem = Flipped(new DecoupledIO(UInt(datawidth.W))) // Write to memory
    val memIO = Flipped(new memoryInterface(datawidth))   // Memory interface
    // val in = new IF_ID_IO(datawidth)   // input
    val out = new IF_ID_IO(datawidth) // output
  })

  // Initialise the signals
  io.memIO.Response.data := WireInit(0.U(datawidth.W))
  io.memIO.Response.ready := WireInit(false.B)
  io.memIO.Response.nonEmpty := WireInit(false.B)
  io.out.pc := WireInit(0.U(datawidth.W))
  io.out.inst := WireInit(0.U(datawidth.W))
  io.writeMem.ready := WireInit(false.B)
  val readAddr = WireInit(0.U(bitwidth.W))

  // Pointers to handle empty and full logic
  val readPtr = RegInit(0.U(bitwidth.W))
  val writePtr = RegInit(0.U(bitwidth.W))
  val count = RegInit(0.U((bitwidth + 1).W)) // Count of the number of elements in the memory

  // Ready to receive a read address if memory is not empty
  io.memIO.Response.nonEmpty := count =/= 0.U

  // Instantiate the memory
  val mem = Mem(actualDepth, UInt(datawidth.W))

  // Read from memory
  when(io.memIO.Request.valid && count =/= 0.U) {
    io.writeMem.ready := true.B // Ready to receive a write - only for testing
    readAddr := io.memIO.Request.addr// Divide by 4 to get the correct read address
    io.out.inst := mem(readAddr)
    readPtr := readPtr + io.out.inst.asUInt
    count := count - 1.U

    when(readPtr >= actualDepth.U) {
      readPtr := readPtr - actualDepth.U // Wrap around
    }
  }

  // Write to memory - should only be needed for testing
  when(io.writeMem.valid && !io.memIO.Request.valid && count =/= actualDepth.U) {
    mem(writePtr) := io.writeMem.bits
    writePtr := writePtr + 1.U
    count := count + 1.U

    when(writePtr >= actualDepth.U) {
      writePtr := writePtr - actualDepth.U // Wrap around
    }
  }
}