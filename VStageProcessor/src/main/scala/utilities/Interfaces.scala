package utilities
import chisel3._



  // Use flipped to make the interface as input - use as is for output
  class IF_ID_IO(datawidth: Int) extends Bundle {
    val inst = Output(UInt(datawidth.W))
    val pc = Output(UInt(datawidth.W))  //PassThrough
    //val branchPredict = Output(UInt(datawidth.W)) // TODO: Implement branch prediction
  }

  // Use flipped to make the interface as input - use as is for output
  class ID_EX_IO(datawidth: Int, addrWidth: Int) extends Bundle {
    val pc = Output(UInt(datawidth.W))
    val val1 = Output(UInt(datawidth.W))
    val val2 = Output(UInt(datawidth.W))
    val rs1 = Output(UInt(addrWidth.W))
    val rs2 = Output(UInt(addrWidth.W))
    val rd = Output(UInt(addrWidth.W))
    val imm = Output(UInt(datawidth.W))
    val aluOp = Output(UInt(4.W))
    val ctrl = new Bundle { // Control Signals
      val useImm = Output(Bool())
      val useALU = Output(Bool())
      val branch = Output(Bool())
      val jump = Output(Bool())
      val load = Output(Bool())
      val store = Output(Bool())
    }
    //val branchPredict = UInt(32.W) // TODO: Implement branch prediction
  }

  class EX_MEM_IO(datawidth: Int, addrWidth: Int) extends Bundle { // Output from EX to MEM
    val rd = Output(UInt(addrWidth.W)) // Destination Register
    val aluOut = Output(UInt(datawidth.W)) // Result of ALU
    val imm = Output(UInt(datawidth.W)) // Immediate
    val ctrl = new Bundle { // Control Signals
      val store = Output(Bool()) // Save to memory
      val load = Output(Bool()) // Load from memory
     }
    //val branchPredict = UInt(32.W) // TODO: Implement branch prediction
  }

  class MEM_WB_IO(datawidth: Int, addrWidth: Int) extends Bundle {
    val rd = Output(UInt(addrWidth.W)) // Destination Register
    val aluOut = Output(UInt(datawidth.W)) // Result of ALU
    val memOut = Output(UInt(datawidth.W)) // Result of memory
    val writeEnable = Output(Bool()) // Write to register file
  }

  class WB_ID_IO(datawidth: Int, addrWidth: Int) extends Bundle {
    val rd = Output(UInt(addrWidth.W))
    val muxOut = Output(UInt(datawidth.W))
    val writeEnable = Output(Bool())
  }

  class memoryInterface(dataWidth: Int) extends Bundle{ // Interface for memory
    val Request = new Bundle { // Interface for requesting a memory access
      val valid = Output(Bool())
      val addr = Output(UInt(dataWidth.W))
      // Data to be written do memory if store is high
      val writeData = Output(UInt(dataWidth.W))
      val store = Output(Bool())
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


