package memory

import chisel3._
import chisel3.util._
import memory.InstructionMemory

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
  val bitwidth = log2Ceil(depth) // Calculate the number of bits needed to address the memory
  val actualDepth = math.pow(2, bitwidth).toInt // 2^bidwidth

  val io = IO(new Bundle { // Input and Output
    val writeMem = Flipped(new DecoupledIO(UInt(datawidth.W))) // Write to memory
    val rdAdd = Flipped(new DecoupledIO(UInt(datawidth.W))) // Read address
    val inst = new DecoupledIO(UInt(datawidth.W)) // Instruction
  })

  // Initialise the signals
  io.rdAdd.ready := WireInit(false.B)
  io.inst.valid := WireInit(false.B)
  io.inst.bits := WireInit(0.U(datawidth.W))
  io.writeMem.ready := WireInit(false.B)
  val readAddr = WireInit(0.U(bitwidth.W))

  // Pointers to handle empty and full logic
  val readPtr = RegInit(0.U(bitwidth.W)) // Read pointer
  val writePtr = RegInit(0.U(bitwidth.W)) // Write pointer
  val count = RegInit(0.U((bitwidth + 1).W)) // Count of the number of elements in the memory

  // Ready to receive a read address if memory is not empty
  io.rdAdd.ready := count =/= 0.U

  // Instantiate the memory
  val mem = Mem(actualDepth, UInt(datawidth.W))

  // Read from memory
  when(io.rdAdd.valid && io.inst.ready && count =/= 0.U) {
    io.inst.valid := true.B // Valid output
    io.writeMem.ready := true.B // Ready to receive a write - only for testing
    readAddr := io.rdAdd.bits// Divide by 4 to get the correct read address
    io.inst.bits := mem(readAddr) // Read from memory
    readPtr := readPtr + io.inst.bits.asUInt // Increment the read pointer
    count := count - 1.U // Decrement the count

    when(readPtr >= actualDepth.U) {
      readPtr := readPtr - actualDepth.U // Wrap around
    }
  }

  // Write to memory - should only be needed for testing
  when(io.writeMem.valid && !io.rdAdd.valid && count =/= actualDepth.U) {
    mem(writePtr) := io.writeMem.bits // Write to memory
    writePtr := writePtr + 1.U // Increment the write pointer
    count := count + 1.U // Increment the count

    when(writePtr >= actualDepth.U) {
      writePtr := writePtr - actualDepth.U // Wrap around
    }
  }
}