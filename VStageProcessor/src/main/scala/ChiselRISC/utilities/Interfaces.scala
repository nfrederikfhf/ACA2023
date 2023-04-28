package ChiselRISC.utilities

import chisel3._


// Use flipped to make the interface as input - use as is for output
class IF_ID_IO(datawidth: Int) extends Bundle {
  val inst = Output(UInt(datawidth.W))
  val pc = Output(UInt(datawidth.W)) //PassThrough
  //val branchPredict = Output(UInt(datawidth.W)) // TODO: Implement branch prediction
}

// Use flipped to make the interface as input - use as is for output
class ID_EX_IO(datawidth: Int, addrWidth: Int) extends Bundle {
  val pc = Output(UInt(datawidth.W))
  val rs1 = Output(UInt(addrWidth.W))
  val rs2 = Output(UInt(addrWidth.W))
  val val1 = Output(UInt(datawidth.W))
  val val2 = Output(UInt(datawidth.W))
  val rd = Output(UInt(addrWidth.W))
  val imm = Output(UInt(datawidth.W))
  val aluOp = Output(UInt(4.W))
  val memOp = Output(UInt(4.W))
  val ctrl = new Bundle { // Control Signals
    val useImm = Output(Bool())
    val useALU = Output(Bool())
    val branch = Output(Bool())
    val jump = Output(Bool())
    val load = Output(Bool())
    val store = Output(Bool())
    val changePC = Output(Bool())
  }
  //val branchPredict = UInt(32.W) // TODO: Implement branch prediction
}

class EX_MEM_IO(datawidth: Int, addrWidth: Int) extends Bundle { // Output from EX to MEM
  val rd = Output(UInt(addrWidth.W)) // Destination Register
  val aluOut = Output(UInt(datawidth.W)) // Result of ALU
  val wrData = Output(UInt(datawidth.W)) // Data to be written to memory
  val ctrl = new Bundle { // Control Signals
    val writeEnable = Output(Bool()) // Write to register file
    val store = Output(Bool()) // Save to memory
    val load = Output(Bool()) // Load from memory
  }
  //val branchPredict = UInt(32.W) // TODO: Implement branch prediction
}

class MEM_WB_IO(datawidth: Int, addrWidth: Int) extends Bundle {
  val rd = Output(UInt(addrWidth.W)) // Destination Register
  val aluOut = Output(UInt(datawidth.W)) // Result of ALU
  val memOut = Output(UInt(datawidth.W)) // Result of memory
  val load = Output(Bool()) // Load from memory
  val writeEnable = Output(Bool()) // Write to register file
}

class WB_ID_IO(datawidth: Int, addrWidth: Int) extends Bundle {
  val rd = Output(UInt(addrWidth.W))
  val muxOut = Output(UInt(datawidth.W))
  val writeEnable = Output(Bool())
}

class memoryInterface(dataWidth: Int) extends Bundle { // Interface for memory
  val Request = new Bundle { // Interface for requesting a memory access
    val valid = Output(Bool())
    val addr = Output(UInt(dataWidth.W))
    // Data to be written do memory if store is high
    val writeData = Output(UInt(dataWidth.W))
  }
  val Response = new Bundle { // Interface for data read from memory
    val ready = Input(Bool())
    val nonEmpty = Input(Bool())
    // Data from memory if a read was done
    val data = Input(UInt(dataWidth.W))

  }
  val write = new Bundle { // Interface for writing to memory
    val ready = Output(Bool())
    val data = Output(UInt(dataWidth.W))
  }
}

class forwardingIO(dataWidth: Int, addrWidth: Int) extends Bundle { // Forwarding interface
  val rd = Output(UInt(addrWidth.W)) // Destination register
  val stageOutput = Output(UInt(dataWidth.W)) // Output from stage
  val writeEnable = Output(Bool()) // Write to register file, which is also the forwarding signal
}


class debugIO(dataWidth: Int, addrWidth: Int) extends Bundle { // Debug interface
  val regFile = Output(Vec(dataWidth, UInt(dataWidth.W))) // Register file
  val memoryIO = new Bundle { // Memory output and input
    val rden = Output(Bool())
    val wren = Output(Bool())
    val rdAddr1 = Output(UInt(addrWidth.W))
    val wrAddr = Output(UInt(addrWidth.W))
    val wrData = Output(UInt(dataWidth.W))
  }
  val pc = Output(UInt(dataWidth.W)) // Program counter
  val inst = Output(UInt(dataWidth.W)) // Instruction
  val out = Output(UInt(dataWidth.W)) // Output from WB stage
}


