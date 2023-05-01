circuit ChiselRISC :
  module ProgramCounter :
    input clock : Clock
    input reset : Reset
    output io : { memIO : { flip ready : UInt<1>, write : UInt<1>, writeData : UInt<32>, valid : UInt<1>, flip nonEmpty : UInt<1>, addr : UInt<32>}, flip in : UInt<32>}

    wire _io_memIO_valid_WIRE : UInt<1>
    _io_memIO_valid_WIRE <= UInt<1>("h0")
    io.memIO.valid <= _io_memIO_valid_WIRE @[ProgramCounter.scala 12:18]
    io.memIO.nonEmpty is invalid @[ProgramCounter.scala 13:21]
    io.memIO.writeData is invalid @[ProgramCounter.scala 14:22]
    io.memIO.write is invalid @[ProgramCounter.scala 15:18]
    wire _io_memIO_addr_WIRE : UInt<32>
    _io_memIO_addr_WIRE <= UInt<32>("h0")
    io.memIO.addr <= _io_memIO_addr_WIRE @[ProgramCounter.scala 16:17]
    reg reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProgramCounter.scala 19:20]
    when io.memIO.ready : @[ProgramCounter.scala 21:23]
      io.memIO.valid <= UInt<1>("h1") @[ProgramCounter.scala 22:20]
    else :
      io.memIO.valid <= UInt<1>("h0") @[ProgramCounter.scala 24:20]
    io.memIO.addr <= reg @[ProgramCounter.scala 26:19]
    reg <= io.in @[ProgramCounter.scala 27:9]

  module InstructionMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip memIO : { flip ready : UInt<1>, write : UInt<1>, writeData : UInt<32>, valid : UInt<1>, flip nonEmpty : UInt<1>, addr : UInt<32>}, memOut : UInt<32>}

    wire bufferEmpty : UInt<1>
    bufferEmpty <= UInt<1>("h1")
    wire bufferFull : UInt<1>
    bufferFull <= UInt<1>("h0")
    wire _io_memOut_WIRE : UInt<32>
    _io_memOut_WIRE <= UInt<32>("h0")
    io.memOut <= _io_memOut_WIRE @[InstructionMemory.scala 31:13]
    io.memIO.ready is invalid @[InstructionMemory.scala 32:18]
    wire _io_memIO_nonEmpty_WIRE : UInt<1>
    _io_memIO_nonEmpty_WIRE <= UInt<1>("h0")
    io.memIO.nonEmpty <= _io_memIO_nonEmpty_WIRE @[InstructionMemory.scala 33:21]
    wire readAddr : UInt<7>
    readAddr <= UInt<7>("h0")
    reg readPtr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[InstructionMemory.scala 37:24]
    reg writePtr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[InstructionMemory.scala 38:25]
    wire count : UInt<7>
    count <= UInt<7>("h0")
    node _bufferEmpty_T = eq(count, UInt<1>("h0")) @[InstructionMemory.scala 42:24]
    bufferEmpty <= _bufferEmpty_T @[InstructionMemory.scala 42:15]
    node _bufferFull_T = sub(UInt<8>("h80"), UInt<1>("h1")) @[InstructionMemory.scala 44:40]
    node _bufferFull_T_1 = tail(_bufferFull_T, 1) @[InstructionMemory.scala 44:40]
    node _bufferFull_T_2 = geq(count, _bufferFull_T_1) @[InstructionMemory.scala 44:23]
    bufferFull <= _bufferFull_T_2 @[InstructionMemory.scala 44:14]
    io.memIO.nonEmpty <= bufferEmpty @[InstructionMemory.scala 47:21]
    reg mem : UInt<32>[128], clock with :
      reset => (UInt<1>("h0"), mem) @[InstructionMemory.scala 50:16]
    node _T = eq(bufferEmpty, UInt<1>("h0")) @[InstructionMemory.scala 53:26]
    node _T_1 = and(io.memIO.valid, _T) @[InstructionMemory.scala 53:23]
    when _T_1 : @[InstructionMemory.scala 53:40]
      node _readAddr_T = shr(io.memIO.addr, 2) @[InstructionMemory.scala 54:31]
      readAddr <= _readAddr_T @[InstructionMemory.scala 54:14]
      io.memOut <= mem[readAddr] @[InstructionMemory.scala 55:15]
      node _readPtr_T = add(readPtr, UInt<1>("h1")) @[InstructionMemory.scala 56:24]
      node _readPtr_T_1 = tail(_readPtr_T, 1) @[InstructionMemory.scala 56:24]
      readPtr <= _readPtr_T_1 @[InstructionMemory.scala 56:13]
      node _T_2 = geq(readPtr, UInt<8>("h80")) @[InstructionMemory.scala 57:18]
      when _T_2 : @[InstructionMemory.scala 57:36]
        readPtr <= UInt<1>("h0") @[InstructionMemory.scala 58:15]
    node _T_3 = eq(bufferFull, UInt<1>("h0")) @[InstructionMemory.scala 63:26]
    node _T_4 = and(io.memIO.write, _T_3) @[InstructionMemory.scala 63:23]
    when _T_4 : @[InstructionMemory.scala 63:39]
      mem[writePtr] <= io.memIO.writeData @[InstructionMemory.scala 64:19]
      node _writePtr_T = add(writePtr, UInt<1>("h1")) @[InstructionMemory.scala 65:26]
      node _writePtr_T_1 = tail(_writePtr_T, 1) @[InstructionMemory.scala 65:26]
      writePtr <= _writePtr_T_1 @[InstructionMemory.scala 65:14]
      node _T_5 = geq(writePtr, UInt<8>("h80")) @[InstructionMemory.scala 67:19]
      when _T_5 : @[InstructionMemory.scala 67:37]
        writePtr <= UInt<1>("h0") @[InstructionMemory.scala 68:16]
    node _difference_T = sub(writePtr, readPtr) @[InstructionMemory.scala 72:29]
    node difference = tail(_difference_T, 1) @[InstructionMemory.scala 72:29]
    node _T_6 = leq(difference, UInt<1>("h0")) @[InstructionMemory.scala 73:19]
    when _T_6 : @[InstructionMemory.scala 73:27]
      node _count_T = add(difference, UInt<8>("h80")) @[InstructionMemory.scala 74:25]
      node _count_T_1 = tail(_count_T, 1) @[InstructionMemory.scala 74:25]
      count <= _count_T_1 @[InstructionMemory.scala 74:11]
    else :
      count <= difference @[InstructionMemory.scala 76:11]

  module IF :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip flush : UInt<1>, out : { inst : UInt<32>, pc : UInt<32>}, flip newPCValue : UInt<32>, flip changePC : UInt<1>, memIO : { flip ready : UInt<1>, flip writeData : UInt<32>}}

    inst PC of ProgramCounter @[IF.scala 23:18]
    PC.clock <= clock
    PC.reset <= reset
    inst instMem of InstructionMemory @[IF.scala 24:23]
    instMem.clock <= clock
    instMem.reset <= reset
    node _outReg_T = eq(io.stallReg, UInt<1>("h0")) @[IF.scala 26:34]
    reg outReg : { inst : UInt<32>, pc : UInt<32>}, clock with :
      reset => (UInt<1>("h0"), outReg) @[Reg.scala 19:16]
    when _outReg_T : @[Reg.scala 20:18]
      outReg.pc <= io.out.pc @[Reg.scala 20:22]
      outReg.inst <= io.out.inst @[Reg.scala 20:22]
    PC.io.memIO.nonEmpty is invalid @[IF.scala 38:24]
    wire _PC_io_memIO_ready_WIRE : UInt<1>
    _PC_io_memIO_ready_WIRE <= UInt<1>("h0")
    PC.io.memIO.ready <= _PC_io_memIO_ready_WIRE @[IF.scala 39:21]
    wire _PC_io_in_WIRE : UInt<32>
    _PC_io_in_WIRE <= UInt<32>("h0")
    PC.io.in <= _PC_io_in_WIRE @[IF.scala 40:12]
    wire _instMem_io_memIO_valid_WIRE : UInt<1>
    _instMem_io_memIO_valid_WIRE <= UInt<1>("h0")
    instMem.io.memIO.valid <= _instMem_io_memIO_valid_WIRE @[IF.scala 42:26]
    wire _instMem_io_memIO_write_WIRE : UInt<1>
    _instMem_io_memIO_write_WIRE <= UInt<1>("h0")
    instMem.io.memIO.write <= _instMem_io_memIO_write_WIRE @[IF.scala 43:26]
    instMem.io.memIO.write <= io.memIO.ready @[IF.scala 46:26]
    instMem.io.memIO.writeData <= io.memIO.writeData @[IF.scala 47:30]
    instMem.io.memIO.valid <= PC.io.memIO.valid @[IF.scala 48:26]
    instMem.io.memIO.addr <= PC.io.memIO.addr @[IF.scala 49:25]
    wire pc : UInt
    pc <= PC.io.memIO.addr
    node addMux = mux(io.changePC, io.newPCValue, pc) @[IF.scala 56:19]
    node _T = eq(instMem.io.memIO.nonEmpty, UInt<1>("h0")) @[IF.scala 68:11]
    when _T : @[IF.scala 68:39]
      PC.io.memIO.ready <= UInt<1>("h1") @[IF.scala 69:25]
      node _PC_io_in_T = add(pc, UInt<3>("h4")) @[IF.scala 70:54]
      node _PC_io_in_T_1 = tail(_PC_io_in_T, 1) @[IF.scala 70:54]
      node _PC_io_in_T_2 = mux(io.changePC, io.newPCValue, _PC_io_in_T_1) @[IF.scala 70:22]
      PC.io.in <= _PC_io_in_T_2 @[IF.scala 70:16]
    else :
      PC.io.memIO.ready <= UInt<1>("h0") @[IF.scala 72:25]
      PC.io.in <= addMux @[IF.scala 73:16]
    node muxOutPC = mux(io.stallReg, pc, addMux) @[IF.scala 76:21]
    node muxOutInst = mux(io.flush, UInt<1>("h0"), instMem.io.memOut) @[IF.scala 77:23]
    outReg.inst <= muxOutInst @[IF.scala 79:15]
    outReg.pc <= muxOutPC @[IF.scala 80:13]
    io.out.inst <= outReg.inst @[IF.scala 81:15]
    node _io_out_pc_T = mux(io.stallReg, pc, addMux) @[IF.scala 82:27]
    reg io_out_pc_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_pc_REG) @[IF.scala 82:23]
    io_out_pc_REG <= _io_out_pc_T @[IF.scala 82:23]
    io.out.pc <= io_out_pc_REG @[IF.scala 82:13]

  module ImmGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip immIn : UInt<32>, immOut : UInt<32>}

    node _opcode_T = bits(io.immIn, 6, 0) @[ImmGenerator.scala 16:36]
    wire _opcode_WIRE : UInt<7> @[ImmGenerator.scala 16:27]
    _opcode_WIRE <= _opcode_T @[ImmGenerator.scala 16:27]
    wire opcode : UInt<7> @[ImmGenerator.scala 16:27]
    opcode <= _opcode_WIRE @[ImmGenerator.scala 16:27]
    node _opcode_T_1 = eq(opcode, UInt<2>("h3")) @[ImmGenerator.scala 16:27]
    node _opcode_T_2 = eq(opcode, UInt<5>("h13")) @[ImmGenerator.scala 16:27]
    node _opcode_T_3 = eq(opcode, UInt<5>("h17")) @[ImmGenerator.scala 16:27]
    node _opcode_T_4 = eq(opcode, UInt<6>("h23")) @[ImmGenerator.scala 16:27]
    node _opcode_T_5 = eq(opcode, UInt<6>("h33")) @[ImmGenerator.scala 16:27]
    node _opcode_T_6 = eq(opcode, UInt<6>("h37")) @[ImmGenerator.scala 16:27]
    node _opcode_T_7 = eq(opcode, UInt<7>("h63")) @[ImmGenerator.scala 16:27]
    node _opcode_T_8 = eq(opcode, UInt<7>("h67")) @[ImmGenerator.scala 16:27]
    node _opcode_T_9 = eq(opcode, UInt<7>("h6f")) @[ImmGenerator.scala 16:27]
    node _opcode_T_10 = or(_opcode_T_1, _opcode_T_2) @[ImmGenerator.scala 16:27]
    node _opcode_T_11 = or(_opcode_T_10, _opcode_T_3) @[ImmGenerator.scala 16:27]
    node _opcode_T_12 = or(_opcode_T_11, _opcode_T_4) @[ImmGenerator.scala 16:27]
    node _opcode_T_13 = or(_opcode_T_12, _opcode_T_5) @[ImmGenerator.scala 16:27]
    node _opcode_T_14 = or(_opcode_T_13, _opcode_T_6) @[ImmGenerator.scala 16:27]
    node _opcode_T_15 = or(_opcode_T_14, _opcode_T_7) @[ImmGenerator.scala 16:27]
    node _opcode_T_16 = or(_opcode_T_15, _opcode_T_8) @[ImmGenerator.scala 16:27]
    node _opcode_T_17 = or(_opcode_T_16, _opcode_T_9) @[ImmGenerator.scala 16:27]
    node _immI_T = bits(io.immIn, 31, 31) @[ImmGenerator.scala 17:35]
    node _immI_T_1 = bits(_immI_T, 0, 0) @[Bitwise.scala 77:15]
    node _immI_T_2 = mux(_immI_T_1, UInt<21>("h1fffff"), UInt<21>("h0")) @[Bitwise.scala 77:12]
    node _immI_T_3 = bits(io.immIn, 30, 20) @[ImmGenerator.scala 17:49]
    node immI = cat(_immI_T_2, _immI_T_3) @[Cat.scala 33:92]
    node _immS_T = bits(io.immIn, 31, 31) @[ImmGenerator.scala 18:35]
    node _immS_T_1 = bits(_immS_T, 0, 0) @[Bitwise.scala 77:15]
    node _immS_T_2 = mux(_immS_T_1, UInt<21>("h1fffff"), UInt<21>("h0")) @[Bitwise.scala 77:12]
    node _immS_T_3 = bits(io.immIn, 30, 25) @[ImmGenerator.scala 18:49]
    node _immS_T_4 = bits(io.immIn, 11, 7) @[ImmGenerator.scala 18:65]
    node immS_hi = cat(_immS_T_2, _immS_T_3) @[Cat.scala 33:92]
    node immS = cat(immS_hi, _immS_T_4) @[Cat.scala 33:92]
    node _immB_T = bits(io.immIn, 31, 31) @[ImmGenerator.scala 19:34]
    node _immB_T_1 = bits(_immB_T, 0, 0) @[Bitwise.scala 77:15]
    node _immB_T_2 = mux(_immB_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 77:12]
    node _immB_T_3 = bits(io.immIn, 7, 7) @[ImmGenerator.scala 19:48]
    node _immB_T_4 = bits(io.immIn, 30, 25) @[ImmGenerator.scala 19:60]
    node _immB_T_5 = bits(io.immIn, 11, 8) @[ImmGenerator.scala 19:76]
    node immB_lo = cat(_immB_T_5, UInt<1>("h0")) @[Cat.scala 33:92]
    node immB_hi_hi = cat(_immB_T_2, _immB_T_3) @[Cat.scala 33:92]
    node immB_hi = cat(immB_hi_hi, _immB_T_4) @[Cat.scala 33:92]
    node immB = cat(immB_hi, immB_lo) @[Cat.scala 33:92]
    node _immU_T = bits(io.immIn, 31, 12) @[ImmGenerator.scala 20:26]
    node _immU_T_1 = mux(UInt<1>("h0"), UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 77:12]
    node immU = cat(_immU_T, _immU_T_1) @[Cat.scala 33:92]
    node _immJ_T = bits(io.immIn, 31, 31) @[ImmGenerator.scala 21:34]
    node _immJ_T_1 = bits(_immJ_T, 0, 0) @[Bitwise.scala 77:15]
    node _immJ_T_2 = mux(_immJ_T_1, UInt<11>("h7ff"), UInt<11>("h0")) @[Bitwise.scala 77:12]
    node _immJ_T_3 = bits(io.immIn, 19, 12) @[ImmGenerator.scala 21:48]
    node _immJ_T_4 = bits(io.immIn, 20, 20) @[ImmGenerator.scala 21:64]
    node _immJ_T_5 = bits(io.immIn, 30, 21) @[ImmGenerator.scala 21:77]
    node immJ_lo = cat(_immJ_T_5, UInt<1>("h0")) @[Cat.scala 33:92]
    node immJ_hi_hi = cat(_immJ_T_2, _immJ_T_3) @[Cat.scala 33:92]
    node immJ_hi = cat(immJ_hi_hi, _immJ_T_4) @[Cat.scala 33:92]
    node immJ = cat(immJ_hi, immJ_lo) @[Cat.scala 33:92]
    wire imm : UInt
    imm <= immI
    node _T = asUInt(UInt<6>("h37")) @[ImmGenerator.scala 25:17]
    node _T_1 = asUInt(opcode) @[ImmGenerator.scala 25:17]
    node _T_2 = eq(_T, _T_1) @[ImmGenerator.scala 25:17]
    when _T_2 : @[ImmGenerator.scala 25:17]
      imm <= immU @[ImmGenerator.scala 27:11]
    else :
      node _T_3 = asUInt(UInt<5>("h17")) @[ImmGenerator.scala 25:17]
      node _T_4 = asUInt(opcode) @[ImmGenerator.scala 25:17]
      node _T_5 = eq(_T_3, _T_4) @[ImmGenerator.scala 25:17]
      when _T_5 : @[ImmGenerator.scala 25:17]
        imm <= immU @[ImmGenerator.scala 30:11]
      else :
        node _T_6 = asUInt(UInt<7>("h6f")) @[ImmGenerator.scala 25:17]
        node _T_7 = asUInt(opcode) @[ImmGenerator.scala 25:17]
        node _T_8 = eq(_T_6, _T_7) @[ImmGenerator.scala 25:17]
        when _T_8 : @[ImmGenerator.scala 25:17]
          imm <= immJ @[ImmGenerator.scala 33:11]
        else :
          node _T_9 = asUInt(UInt<6>("h23")) @[ImmGenerator.scala 25:17]
          node _T_10 = asUInt(opcode) @[ImmGenerator.scala 25:17]
          node _T_11 = eq(_T_9, _T_10) @[ImmGenerator.scala 25:17]
          when _T_11 : @[ImmGenerator.scala 25:17]
            imm <= immS @[ImmGenerator.scala 36:10]
          else :
            node _T_12 = asUInt(UInt<7>("h63")) @[ImmGenerator.scala 25:17]
            node _T_13 = asUInt(opcode) @[ImmGenerator.scala 25:17]
            node _T_14 = eq(_T_12, _T_13) @[ImmGenerator.scala 25:17]
            when _T_14 : @[ImmGenerator.scala 25:17]
              imm <= immB @[ImmGenerator.scala 39:11]
    io.immOut <= imm @[ImmGenerator.scala 43:13]

  module Decoder :
    input clock : Clock
    input reset : Reset
    output io : { flip inInst : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>, ctrlSignals : { useImm : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}

    wire _io_rs1_WIRE : UInt<5>
    _io_rs1_WIRE <= UInt<5>("h0")
    io.rs1 <= _io_rs1_WIRE @[Decoder.scala 28:10]
    wire _io_rs2_WIRE : UInt<5>
    _io_rs2_WIRE <= UInt<5>("h0")
    io.rs2 <= _io_rs2_WIRE @[Decoder.scala 29:10]
    wire _io_rd_WIRE : UInt<5>
    _io_rd_WIRE <= UInt<5>("h0")
    io.rd <= _io_rd_WIRE @[Decoder.scala 30:9]
    wire _io_memOp_WIRE : UInt<4>
    _io_memOp_WIRE <= UInt<4>("h0")
    io.memOp <= _io_memOp_WIRE @[Decoder.scala 31:12]
    wire _io_ctrlSignals_useImm_WIRE : UInt<1>
    _io_ctrlSignals_useImm_WIRE <= UInt<1>("h0")
    io.ctrlSignals.useImm <= _io_ctrlSignals_useImm_WIRE @[Decoder.scala 32:25]
    wire _io_ctrlSignals_branch_WIRE : UInt<1>
    _io_ctrlSignals_branch_WIRE <= UInt<1>("h0")
    io.ctrlSignals.branch <= _io_ctrlSignals_branch_WIRE @[Decoder.scala 33:25]
    wire _io_ctrlSignals_useALU_WIRE : UInt<1>
    _io_ctrlSignals_useALU_WIRE <= UInt<1>("h0")
    io.ctrlSignals.useALU <= _io_ctrlSignals_useALU_WIRE @[Decoder.scala 34:25]
    wire _io_ctrlSignals_jump_WIRE : UInt<1>
    _io_ctrlSignals_jump_WIRE <= UInt<1>("h0")
    io.ctrlSignals.jump <= _io_ctrlSignals_jump_WIRE @[Decoder.scala 35:23]
    wire _io_ctrlSignals_load_WIRE : UInt<1>
    _io_ctrlSignals_load_WIRE <= UInt<1>("h0")
    io.ctrlSignals.load <= _io_ctrlSignals_load_WIRE @[Decoder.scala 36:23]
    wire _io_ctrlSignals_store_WIRE : UInt<1>
    _io_ctrlSignals_store_WIRE <= UInt<1>("h0")
    io.ctrlSignals.store <= _io_ctrlSignals_store_WIRE @[Decoder.scala 37:24]
    wire _io_ctrlSignals_changePC_WIRE : UInt<1>
    _io_ctrlSignals_changePC_WIRE <= UInt<1>("h0")
    io.ctrlSignals.changePC <= _io_ctrlSignals_changePC_WIRE @[Decoder.scala 38:27]
    node _io_aluOp_T = asUInt(UInt<1>("h1")) @[Decoder.scala 39:37]
    wire _io_aluOp_WIRE : UInt
    _io_aluOp_WIRE <= _io_aluOp_T
    io.aluOp <= _io_aluOp_WIRE @[Decoder.scala 39:12]
    node _op_T = bits(io.inInst, 6, 0) @[Decoder.scala 42:34]
    wire _op_WIRE : UInt<7> @[Decoder.scala 42:24]
    _op_WIRE <= _op_T @[Decoder.scala 42:24]
    wire op : UInt<7> @[Decoder.scala 42:24]
    op <= _op_WIRE @[Decoder.scala 42:24]
    node _op_T_1 = eq(op, UInt<2>("h3")) @[Decoder.scala 42:24]
    node _op_T_2 = eq(op, UInt<5>("h13")) @[Decoder.scala 42:24]
    node _op_T_3 = eq(op, UInt<5>("h17")) @[Decoder.scala 42:24]
    node _op_T_4 = eq(op, UInt<6>("h23")) @[Decoder.scala 42:24]
    node _op_T_5 = eq(op, UInt<6>("h33")) @[Decoder.scala 42:24]
    node _op_T_6 = eq(op, UInt<6>("h37")) @[Decoder.scala 42:24]
    node _op_T_7 = eq(op, UInt<7>("h63")) @[Decoder.scala 42:24]
    node _op_T_8 = eq(op, UInt<7>("h67")) @[Decoder.scala 42:24]
    node _op_T_9 = eq(op, UInt<7>("h6f")) @[Decoder.scala 42:24]
    node _op_T_10 = or(_op_T_1, _op_T_2) @[Decoder.scala 42:24]
    node _op_T_11 = or(_op_T_10, _op_T_3) @[Decoder.scala 42:24]
    node _op_T_12 = or(_op_T_11, _op_T_4) @[Decoder.scala 42:24]
    node _op_T_13 = or(_op_T_12, _op_T_5) @[Decoder.scala 42:24]
    node _op_T_14 = or(_op_T_13, _op_T_6) @[Decoder.scala 42:24]
    node _op_T_15 = or(_op_T_14, _op_T_7) @[Decoder.scala 42:24]
    node _op_T_16 = or(_op_T_15, _op_T_8) @[Decoder.scala 42:24]
    node _op_T_17 = or(_op_T_16, _op_T_9) @[Decoder.scala 42:24]
    node funct3 = bits(io.inInst, 14, 12) @[Decoder.scala 43:25]
    node funct7 = bits(io.inInst, 31, 25) @[Decoder.scala 44:25]
    node _T = asUInt(UInt<2>("h3")) @[Decoder.scala 47:14]
    node _T_1 = asUInt(op) @[Decoder.scala 47:14]
    node _T_2 = eq(_T, _T_1) @[Decoder.scala 47:14]
    when _T_2 : @[Decoder.scala 47:14]
      io.ctrlSignals.load <= UInt<1>("h1") @[Decoder.scala 49:27]
      io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 50:29]
      io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 51:29]
      node _io_aluOp_T_1 = asUInt(UInt<1>("h1")) @[Decoder.scala 52:29]
      io.aluOp <= _io_aluOp_T_1 @[Decoder.scala 52:16]
      node _T_3 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 53:21]
      when _T_3 : @[Decoder.scala 53:21]
        io.memOp <= UInt<1>("h0") @[Decoder.scala 55:20]
      else :
        node _T_4 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 53:21]
        when _T_4 : @[Decoder.scala 53:21]
          io.memOp <= UInt<1>("h1") @[Decoder.scala 58:20]
        else :
          node _T_5 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 53:21]
          when _T_5 : @[Decoder.scala 53:21]
            io.memOp <= UInt<2>("h2") @[Decoder.scala 61:20]
    else :
      node _T_6 = asUInt(UInt<5>("h13")) @[Decoder.scala 47:14]
      node _T_7 = asUInt(op) @[Decoder.scala 47:14]
      node _T_8 = eq(_T_6, _T_7) @[Decoder.scala 47:14]
      when _T_8 : @[Decoder.scala 47:14]
        io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 67:29]
        io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 68:29]
        node _T_9 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 69:22]
        when _T_9 : @[Decoder.scala 69:22]
          node _io_aluOp_T_2 = asUInt(UInt<1>("h1")) @[Decoder.scala 71:33]
          io.aluOp <= _io_aluOp_T_2 @[Decoder.scala 71:20]
        else :
          node _T_10 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 69:22]
          when _T_10 : @[Decoder.scala 69:22]
            node _io_aluOp_T_3 = asUInt(UInt<4>("h8")) @[Decoder.scala 74:33]
            io.aluOp <= _io_aluOp_T_3 @[Decoder.scala 74:20]
          else :
            node _T_11 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 69:22]
            when _T_11 : @[Decoder.scala 69:22]
              node _io_aluOp_T_4 = asUInt(UInt<4>("h9")) @[Decoder.scala 77:33]
              io.aluOp <= _io_aluOp_T_4 @[Decoder.scala 77:20]
            else :
              node _T_12 = eq(UInt<2>("h3"), funct3) @[Decoder.scala 69:22]
              when _T_12 : @[Decoder.scala 69:22]
                node _io_aluOp_T_5 = asUInt(UInt<4>("ha")) @[Decoder.scala 80:34]
                io.aluOp <= _io_aluOp_T_5 @[Decoder.scala 80:20]
              else :
                node _T_13 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 69:22]
                when _T_13 : @[Decoder.scala 69:22]
                  node _io_aluOp_T_6 = asUInt(UInt<3>("h4")) @[Decoder.scala 83:32]
                  io.aluOp <= _io_aluOp_T_6 @[Decoder.scala 83:20]
                else :
                  node _T_14 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 69:22]
                  when _T_14 : @[Decoder.scala 69:22]
                    node _io_aluOp_T_7 = asUInt(UInt<2>("h3")) @[Decoder.scala 86:33]
                    io.aluOp <= _io_aluOp_T_7 @[Decoder.scala 86:20]
                  else :
                    node _T_15 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 69:22]
                    when _T_15 : @[Decoder.scala 69:22]
                      node _T_16 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 89:26]
                      when _T_16 : @[Decoder.scala 89:26]
                        node _io_aluOp_T_8 = asUInt(UInt<3>("h6")) @[Decoder.scala 91:37]
                        io.aluOp <= _io_aluOp_T_8 @[Decoder.scala 91:24]
                      else :
                        node _T_17 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 89:26]
                        when _T_17 : @[Decoder.scala 89:26]
                          node _io_aluOp_T_9 = asUInt(UInt<3>("h7")) @[Decoder.scala 94:37]
                          io.aluOp <= _io_aluOp_T_9 @[Decoder.scala 94:24]
                    else :
                      node _T_18 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 69:22]
                      when _T_18 : @[Decoder.scala 69:22]
                        node _io_aluOp_T_10 = asUInt(UInt<3>("h5")) @[Decoder.scala 99:33]
                        io.aluOp <= _io_aluOp_T_10 @[Decoder.scala 99:20]
      else :
        node _T_19 = asUInt(UInt<5>("h17")) @[Decoder.scala 47:14]
        node _T_20 = asUInt(op) @[Decoder.scala 47:14]
        node _T_21 = eq(_T_19, _T_20) @[Decoder.scala 47:14]
        when _T_21 : @[Decoder.scala 47:14]
          io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 104:31]
          io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 105:31]
        else :
          node _T_22 = asUInt(UInt<6>("h23")) @[Decoder.scala 47:14]
          node _T_23 = asUInt(op) @[Decoder.scala 47:14]
          node _T_24 = eq(_T_22, _T_23) @[Decoder.scala 47:14]
          when _T_24 : @[Decoder.scala 47:14]
            io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 109:31]
            io.ctrlSignals.store <= UInt<1>("h1") @[Decoder.scala 110:30]
            io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 111:31]
            node _T_25 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 112:24]
            when _T_25 : @[Decoder.scala 112:24]
              io.memOp <= UInt<1>("h0") @[Decoder.scala 114:22]
            else :
              node _T_26 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 112:24]
              when _T_26 : @[Decoder.scala 112:24]
                io.memOp <= UInt<1>("h1") @[Decoder.scala 117:22]
              else :
                node _T_27 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 112:24]
                when _T_27 : @[Decoder.scala 112:24]
                  io.memOp <= UInt<2>("h2") @[Decoder.scala 120:22]
          else :
            node _T_28 = asUInt(UInt<6>("h33")) @[Decoder.scala 47:14]
            node _T_29 = asUInt(op) @[Decoder.scala 47:14]
            node _T_30 = eq(_T_28, _T_29) @[Decoder.scala 47:14]
            when _T_30 : @[Decoder.scala 47:14]
              io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 126:31]
              node _T_31 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 127:24]
              when _T_31 : @[Decoder.scala 127:24]
                node _T_32 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 129:28]
                when _T_32 : @[Decoder.scala 129:28]
                  node _io_aluOp_T_11 = asUInt(UInt<1>("h1")) @[Decoder.scala 131:39]
                  io.aluOp <= _io_aluOp_T_11 @[Decoder.scala 131:26]
                else :
                  node _T_33 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 129:28]
                  when _T_33 : @[Decoder.scala 129:28]
                    node _io_aluOp_T_12 = asUInt(UInt<2>("h2")) @[Decoder.scala 134:39]
                    io.aluOp <= _io_aluOp_T_12 @[Decoder.scala 134:26]
              else :
                node _T_34 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 127:24]
                when _T_34 : @[Decoder.scala 127:24]
                  node _io_aluOp_T_13 = asUInt(UInt<4>("h8")) @[Decoder.scala 139:35]
                  io.aluOp <= _io_aluOp_T_13 @[Decoder.scala 139:22]
                else :
                  node _T_35 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 127:24]
                  when _T_35 : @[Decoder.scala 127:24]
                    node _io_aluOp_T_14 = asUInt(UInt<4>("h9")) @[Decoder.scala 142:35]
                    io.aluOp <= _io_aluOp_T_14 @[Decoder.scala 142:22]
                  else :
                    node _T_36 = eq(UInt<2>("h3"), funct3) @[Decoder.scala 127:24]
                    when _T_36 : @[Decoder.scala 127:24]
                      node _io_aluOp_T_15 = asUInt(UInt<4>("ha")) @[Decoder.scala 145:36]
                      io.aluOp <= _io_aluOp_T_15 @[Decoder.scala 145:22]
                    else :
                      node _T_37 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 127:24]
                      when _T_37 : @[Decoder.scala 127:24]
                        node _io_aluOp_T_16 = asUInt(UInt<3>("h5")) @[Decoder.scala 148:35]
                        io.aluOp <= _io_aluOp_T_16 @[Decoder.scala 148:22]
                      else :
                        node _T_38 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 127:24]
                        when _T_38 : @[Decoder.scala 127:24]
                          node _T_39 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 151:28]
                          when _T_39 : @[Decoder.scala 151:28]
                            node _io_aluOp_T_17 = asUInt(UInt<3>("h6")) @[Decoder.scala 153:39]
                            io.aluOp <= _io_aluOp_T_17 @[Decoder.scala 153:26]
                          else :
                            node _T_40 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 151:28]
                            when _T_40 : @[Decoder.scala 151:28]
                              node _io_aluOp_T_18 = asUInt(UInt<3>("h7")) @[Decoder.scala 156:39]
                              io.aluOp <= _io_aluOp_T_18 @[Decoder.scala 156:26]
                        else :
                          node _T_41 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 127:24]
                          when _T_41 : @[Decoder.scala 127:24]
                            node _io_aluOp_T_19 = asUInt(UInt<3>("h4")) @[Decoder.scala 161:34]
                            io.aluOp <= _io_aluOp_T_19 @[Decoder.scala 161:22]
                          else :
                            node _T_42 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 127:24]
                            when _T_42 : @[Decoder.scala 127:24]
                              node _io_aluOp_T_20 = asUInt(UInt<2>("h3")) @[Decoder.scala 164:35]
                              io.aluOp <= _io_aluOp_T_20 @[Decoder.scala 164:22]
            else :
              node _T_43 = asUInt(UInt<6>("h37")) @[Decoder.scala 47:14]
              node _T_44 = asUInt(op) @[Decoder.scala 47:14]
              node _T_45 = eq(_T_43, _T_44) @[Decoder.scala 47:14]
              when _T_45 : @[Decoder.scala 47:14]
                io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 170:31]
                io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 171:31]
              else :
                node _T_46 = asUInt(UInt<7>("h63")) @[Decoder.scala 47:14]
                node _T_47 = asUInt(op) @[Decoder.scala 47:14]
                node _T_48 = eq(_T_46, _T_47) @[Decoder.scala 47:14]
                when _T_48 : @[Decoder.scala 47:14]
                  io.ctrlSignals.branch <= UInt<1>("h1") @[Decoder.scala 174:31]
                  io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 175:31]
                  node _T_49 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 176:23]
                  when _T_49 : @[Decoder.scala 176:23]
                    node _io_aluOp_T_21 = asUInt(UInt<4>("hb")) @[Decoder.scala 178:35]
                    io.aluOp <= _io_aluOp_T_21 @[Decoder.scala 178:22]
                  else :
                    node _T_50 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 176:23]
                    when _T_50 : @[Decoder.scala 176:23]
                      node _io_aluOp_T_22 = asUInt(UInt<1>("h0")) @[Decoder.scala 181:35]
                      io.aluOp <= _io_aluOp_T_22 @[Decoder.scala 181:22]
                    else :
                      node _T_51 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 176:23]
                      when _T_51 : @[Decoder.scala 176:23]
                        node _io_aluOp_T_23 = asUInt(UInt<4>("hc")) @[Decoder.scala 184:35]
                        io.aluOp <= _io_aluOp_T_23 @[Decoder.scala 184:22]
                      else :
                        node _T_52 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 176:23]
                        when _T_52 : @[Decoder.scala 176:23]
                          node _io_aluOp_T_24 = asUInt(UInt<4>("hd")) @[Decoder.scala 187:35]
                          io.aluOp <= _io_aluOp_T_24 @[Decoder.scala 187:22]
                        else :
                          node _T_53 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 176:23]
                          when _T_53 : @[Decoder.scala 176:23]
                            node _io_aluOp_T_25 = asUInt(UInt<4>("he")) @[Decoder.scala 190:36]
                            io.aluOp <= _io_aluOp_T_25 @[Decoder.scala 190:22]
                          else :
                            node _T_54 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 176:23]
                            when _T_54 : @[Decoder.scala 176:23]
                              node _io_aluOp_T_26 = asUInt(UInt<4>("hf")) @[Decoder.scala 193:36]
                              io.aluOp <= _io_aluOp_T_26 @[Decoder.scala 193:22]
                else :
                  node _T_55 = asUInt(UInt<7>("h67")) @[Decoder.scala 47:14]
                  node _T_56 = asUInt(op) @[Decoder.scala 47:14]
                  node _T_57 = eq(_T_55, _T_56) @[Decoder.scala 47:14]
                  when _T_57 : @[Decoder.scala 47:14]
                    io.ctrlSignals.jump <= UInt<1>("h1") @[Decoder.scala 198:29]
                    io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 199:31]
                    io.ctrlSignals.changePC <= UInt<1>("h1") @[Decoder.scala 200:33]
                  else :
                    node _T_58 = asUInt(UInt<7>("h6f")) @[Decoder.scala 47:14]
                    node _T_59 = asUInt(op) @[Decoder.scala 47:14]
                    node _T_60 = eq(_T_58, _T_59) @[Decoder.scala 47:14]
                    when _T_60 : @[Decoder.scala 47:14]
                      io.ctrlSignals.jump <= UInt<1>("h1") @[Decoder.scala 203:29]
                      io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 204:31]
    node _io_rs1_T = eq(op, UInt<7>("h6f")) @[Decoder.scala 209:22]
    node _io_rs1_T_1 = bits(io.inInst, 19, 15) @[Decoder.scala 209:48]
    node _io_rs1_T_2 = mux(_io_rs1_T, UInt<1>("h0"), _io_rs1_T_1) @[Decoder.scala 209:18]
    io.rs1 <= _io_rs1_T_2 @[Decoder.scala 209:12]
    node _io_rs2_T = eq(op, UInt<7>("h6f")) @[Decoder.scala 210:22]
    node _io_rs2_T_1 = bits(io.inInst, 24, 20) @[Decoder.scala 210:48]
    node _io_rs2_T_2 = mux(_io_rs2_T, UInt<1>("h0"), _io_rs2_T_1) @[Decoder.scala 210:18]
    io.rs2 <= _io_rs2_T_2 @[Decoder.scala 210:12]
    node _io_rd_T = bits(io.inInst, 11, 7) @[Decoder.scala 211:23]
    io.rd <= _io_rd_T @[Decoder.scala 211:11]

  module RegisterFile :
    input clock : Clock
    input reset : Reset
    output io : { flip rdAddr1 : UInt<5>, rdData1 : UInt<32>, flip rdAddr2 : UInt<5>, rdData2 : UInt<32>, flip wrAddr : UInt<5>, flip wrData : UInt<32>, flip wren : UInt<1>}

    wire _io_rdData1_WIRE : UInt<32>
    _io_rdData1_WIRE <= UInt<32>("h0")
    io.rdData1 <= _io_rdData1_WIRE @[RegisterFile.scala 22:14]
    wire _io_rdData2_WIRE : UInt<32>
    _io_rdData2_WIRE <= UInt<32>("h0")
    io.rdData2 <= _io_rdData2_WIRE @[RegisterFile.scala 23:14]
    reg registers : UInt<32>[32], clock with :
      reset => (UInt<1>("h0"), registers) @[RegisterFile.scala 26:22]
    node _T = eq(io.rdAddr1, UInt<1>("h0")) @[RegisterFile.scala 27:19]
    when _T : @[RegisterFile.scala 27:28]
      io.rdData1 <= UInt<1>("h0") @[RegisterFile.scala 28:16]
    else :
      io.rdData1 <= registers[io.rdAddr1] @[RegisterFile.scala 31:18]
    node _T_1 = eq(io.rdAddr2, UInt<1>("h0")) @[RegisterFile.scala 33:19]
    when _T_1 : @[RegisterFile.scala 33:28]
      io.rdData2 <= UInt<1>("h0") @[RegisterFile.scala 34:16]
    else :
      io.rdData2 <= registers[io.rdAddr2] @[RegisterFile.scala 37:18]
    when io.wren : @[RegisterFile.scala 40:17]
      registers[io.wrAddr] <= io.wrData @[RegisterFile.scala 41:26]

  module ID :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip flush : UInt<1>, flip in : { inst : UInt<32>, pc : UInt<32>}, flip wbIn : { rd : UInt<5>, muxOut : UInt<32>, writeEnable : UInt<1>}, out : { pc : UInt<32>, rs1 : UInt<5>, rs2 : UInt<5>, val1 : UInt<32>, val2 : UInt<32>, rd : UInt<5>, imm : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, ctrl : { useImm : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}}

    inst immGenerator of ImmGenerator @[ID.scala 31:28]
    immGenerator.clock <= clock
    immGenerator.reset <= reset
    inst decoder of Decoder @[ID.scala 32:23]
    decoder.clock <= clock
    decoder.reset <= reset
    inst regfile of RegisterFile @[ID.scala 33:23]
    regfile.clock <= clock
    regfile.reset <= reset
    wire _regfile_io_wren_WIRE : UInt<1>
    _regfile_io_wren_WIRE <= UInt<1>("h0")
    regfile.io.wren <= _regfile_io_wren_WIRE @[ID.scala 36:19]
    wire _regfile_io_wrAddr_WIRE : UInt<5>
    _regfile_io_wrAddr_WIRE <= UInt<5>("h0")
    regfile.io.wrAddr <= _regfile_io_wrAddr_WIRE @[ID.scala 37:21]
    wire _regfile_io_wrData_WIRE : UInt<32>
    _regfile_io_wrData_WIRE <= UInt<32>("h0")
    regfile.io.wrData <= _regfile_io_wrData_WIRE @[ID.scala 38:21]
    wire _decoder_io_inInst_WIRE : UInt<32>
    _decoder_io_inInst_WIRE <= UInt<32>("h0")
    decoder.io.inInst <= _decoder_io_inInst_WIRE @[ID.scala 39:21]
    immGenerator.io.immIn <= io.in.inst @[ID.scala 48:25]
    decoder.io.inInst <= io.in.inst @[ID.scala 49:21]
    regfile.io.rdAddr1 <= decoder.io.rs1 @[ID.scala 50:22]
    regfile.io.rdAddr2 <= decoder.io.rs2 @[ID.scala 51:22]
    regfile.io.wren <= io.wbIn.writeEnable @[ID.scala 53:19]
    regfile.io.wrAddr <= io.wbIn.rd @[ID.scala 54:21]
    regfile.io.wrData <= io.wbIn.muxOut @[ID.scala 55:21]
    node _io_out_ctrl_branch_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.branch) @[ID.scala 59:38]
    node _io_out_ctrl_branch_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 59:86]
    reg io_out_ctrl_branch_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_branch_r) @[Reg.scala 19:16]
    when _io_out_ctrl_branch_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_branch_r <= _io_out_ctrl_branch_T @[Reg.scala 20:22]
    io.out.ctrl.branch <= io_out_ctrl_branch_r @[ID.scala 59:22]
    node _io_out_ctrl_load_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.load) @[ID.scala 60:36]
    node _io_out_ctrl_load_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 60:82]
    reg io_out_ctrl_load_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_load_r) @[Reg.scala 19:16]
    when _io_out_ctrl_load_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_load_r <= _io_out_ctrl_load_T @[Reg.scala 20:22]
    io.out.ctrl.load <= io_out_ctrl_load_r @[ID.scala 60:20]
    node _io_out_ctrl_store_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.store) @[ID.scala 61:37]
    node _io_out_ctrl_store_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 61:84]
    reg io_out_ctrl_store_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_store_r) @[Reg.scala 19:16]
    when _io_out_ctrl_store_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_store_r <= _io_out_ctrl_store_T @[Reg.scala 20:22]
    io.out.ctrl.store <= io_out_ctrl_store_r @[ID.scala 61:21]
    node _io_out_ctrl_jump_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.jump) @[ID.scala 62:36]
    node _io_out_ctrl_jump_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 62:82]
    reg io_out_ctrl_jump_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_jump_r) @[Reg.scala 19:16]
    when _io_out_ctrl_jump_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_jump_r <= _io_out_ctrl_jump_T @[Reg.scala 20:22]
    io.out.ctrl.jump <= io_out_ctrl_jump_r @[ID.scala 62:20]
    node _io_out_ctrl_useALU_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.useALU) @[ID.scala 63:38]
    node _io_out_ctrl_useALU_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 63:86]
    reg io_out_ctrl_useALU_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_useALU_r) @[Reg.scala 19:16]
    when _io_out_ctrl_useALU_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_useALU_r <= _io_out_ctrl_useALU_T @[Reg.scala 20:22]
    io.out.ctrl.useALU <= io_out_ctrl_useALU_r @[ID.scala 63:22]
    node _io_out_ctrl_useImm_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.useImm) @[ID.scala 64:38]
    node _io_out_ctrl_useImm_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 64:86]
    reg io_out_ctrl_useImm_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_useImm_r) @[Reg.scala 19:16]
    when _io_out_ctrl_useImm_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_useImm_r <= _io_out_ctrl_useImm_T @[Reg.scala 20:22]
    io.out.ctrl.useImm <= io_out_ctrl_useImm_r @[ID.scala 64:22]
    node _io_out_ctrl_changePC_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.changePC) @[ID.scala 65:40]
    node _io_out_ctrl_changePC_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 65:90]
    reg io_out_ctrl_changePC_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_changePC_r) @[Reg.scala 19:16]
    when _io_out_ctrl_changePC_T_1 : @[Reg.scala 20:18]
      io_out_ctrl_changePC_r <= _io_out_ctrl_changePC_T @[Reg.scala 20:22]
    io.out.ctrl.changePC <= io_out_ctrl_changePC_r @[ID.scala 65:24]
    node _val1_T = eq(io.wbIn.rd, decoder.io.rs1) @[ID.scala 69:52]
    node _val1_T_1 = and(io.wbIn.writeEnable, _val1_T) @[ID.scala 69:38]
    node val1 = mux(_val1_T_1, io.wbIn.muxOut, regfile.io.rdData1) @[ID.scala 69:17]
    node _val2_T = eq(io.wbIn.rd, decoder.io.rs2) @[ID.scala 70:52]
    node _val2_T_1 = and(io.wbIn.writeEnable, _val2_T) @[ID.scala 70:38]
    node val2 = mux(_val2_T_1, io.wbIn.muxOut, regfile.io.rdData2) @[ID.scala 70:17]
    node _io_out_aluOp_T = mux(io.flush, UInt<1>("h0"), decoder.io.aluOp) @[ID.scala 73:32]
    node _io_out_aluOp_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 73:67]
    reg io_out_aluOp_r : UInt<4>, clock with :
      reset => (UInt<1>("h0"), io_out_aluOp_r) @[Reg.scala 19:16]
    when _io_out_aluOp_T_1 : @[Reg.scala 20:18]
      io_out_aluOp_r <= _io_out_aluOp_T @[Reg.scala 20:22]
    io.out.aluOp <= io_out_aluOp_r @[ID.scala 73:16]
    node _io_out_rd_T = mux(io.flush, UInt<1>("h0"), decoder.io.rd) @[ID.scala 74:29]
    node _io_out_rd_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 74:61]
    reg io_out_rd_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rd_r) @[Reg.scala 19:16]
    when _io_out_rd_T_1 : @[Reg.scala 20:18]
      io_out_rd_r <= _io_out_rd_T @[Reg.scala 20:22]
    io.out.rd <= io_out_rd_r @[ID.scala 74:13]
    node _io_out_val1_T = mux(io.flush, UInt<1>("h0"), val1) @[ID.scala 75:31]
    node _io_out_val1_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 75:54]
    reg io_out_val1_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_val1_r) @[Reg.scala 19:16]
    when _io_out_val1_T_1 : @[Reg.scala 20:18]
      io_out_val1_r <= _io_out_val1_T @[Reg.scala 20:22]
    io.out.val1 <= io_out_val1_r @[ID.scala 75:15]
    node _io_out_val2_T = mux(io.flush, UInt<1>("h0"), val2) @[ID.scala 76:31]
    node _io_out_val2_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 76:54]
    reg io_out_val2_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_val2_r) @[Reg.scala 19:16]
    when _io_out_val2_T_1 : @[Reg.scala 20:18]
      io_out_val2_r <= _io_out_val2_T @[Reg.scala 20:22]
    io.out.val2 <= io_out_val2_r @[ID.scala 76:15]
    node _io_out_imm_T = mux(io.flush, UInt<1>("h0"), immGenerator.io.immOut) @[ID.scala 77:30]
    node _io_out_imm_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 77:71]
    reg io_out_imm_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_imm_r) @[Reg.scala 19:16]
    when _io_out_imm_T_1 : @[Reg.scala 20:18]
      io_out_imm_r <= _io_out_imm_T @[Reg.scala 20:22]
    io.out.imm <= io_out_imm_r @[ID.scala 77:14]
    node _io_out_pc_T = mux(io.flush, UInt<1>("h0"), io.in.pc) @[ID.scala 78:29]
    node _io_out_pc_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 78:56]
    reg io_out_pc_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_pc_r) @[Reg.scala 19:16]
    when _io_out_pc_T_1 : @[Reg.scala 20:18]
      io_out_pc_r <= _io_out_pc_T @[Reg.scala 20:22]
    io.out.pc <= io_out_pc_r @[ID.scala 78:13]
    node _io_out_rs1_T = mux(io.flush, UInt<1>("h0"), decoder.io.rs1) @[ID.scala 79:30]
    node _io_out_rs1_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 79:63]
    reg io_out_rs1_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rs1_r) @[Reg.scala 19:16]
    when _io_out_rs1_T_1 : @[Reg.scala 20:18]
      io_out_rs1_r <= _io_out_rs1_T @[Reg.scala 20:22]
    io.out.rs1 <= io_out_rs1_r @[ID.scala 79:14]
    node _io_out_rs2_T = mux(io.flush, UInt<1>("h0"), decoder.io.rs2) @[ID.scala 80:30]
    node _io_out_rs2_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 80:63]
    reg io_out_rs2_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rs2_r) @[Reg.scala 19:16]
    when _io_out_rs2_T_1 : @[Reg.scala 20:18]
      io_out_rs2_r <= _io_out_rs2_T @[Reg.scala 20:22]
    io.out.rs2 <= io_out_rs2_r @[ID.scala 80:14]
    node _io_out_memOp_T = mux(io.flush, UInt<1>("h0"), decoder.io.memOp) @[ID.scala 81:32]
    node _io_out_memOp_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 81:67]
    reg io_out_memOp_r : UInt<4>, clock with :
      reset => (UInt<1>("h0"), io_out_memOp_r) @[Reg.scala 19:16]
    when _io_out_memOp_T_1 : @[Reg.scala 20:18]
      io_out_memOp_r <= _io_out_memOp_T @[Reg.scala 20:22]
    io.out.memOp <= io_out_memOp_r @[ID.scala 81:16]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip aluOp : UInt<4>, flip val1 : UInt<32>, flip val2 : UInt<32>, aluOut : UInt<32>}

    wire _io_aluOut_WIRE : UInt<32>
    _io_aluOut_WIRE <= UInt<32>("h0")
    io.aluOut <= _io_aluOut_WIRE @[ALU.scala 17:13]
    wire _op_WIRE : UInt<4> @[ALU.scala 19:26]
    _op_WIRE <= io.aluOp @[ALU.scala 19:26]
    wire op : UInt<4> @[ALU.scala 19:26]
    op <= _op_WIRE @[ALU.scala 19:26]
    node _T = asUInt(UInt<1>("h1")) @[ALU.scala 21:13]
    node _T_1 = asUInt(op) @[ALU.scala 21:13]
    node _T_2 = eq(_T, _T_1) @[ALU.scala 21:13]
    when _T_2 : @[ALU.scala 21:13]
      node _io_aluOut_T = add(io.val1, io.val2) @[ALU.scala 23:41]
      node _io_aluOut_T_1 = tail(_io_aluOut_T, 1) @[ALU.scala 23:41]
      io.aluOut <= _io_aluOut_T_1 @[ALU.scala 23:30]
    else :
      node _T_3 = asUInt(UInt<2>("h2")) @[ALU.scala 21:13]
      node _T_4 = asUInt(op) @[ALU.scala 21:13]
      node _T_5 = eq(_T_3, _T_4) @[ALU.scala 21:13]
      when _T_5 : @[ALU.scala 21:13]
        node _io_aluOut_T_2 = sub(io.val1, io.val2) @[ALU.scala 24:41]
        node _io_aluOut_T_3 = tail(_io_aluOut_T_2, 1) @[ALU.scala 24:41]
        io.aluOut <= _io_aluOut_T_3 @[ALU.scala 24:30]
      else :
        node _T_6 = asUInt(UInt<2>("h3")) @[ALU.scala 21:13]
        node _T_7 = asUInt(op) @[ALU.scala 21:13]
        node _T_8 = eq(_T_6, _T_7) @[ALU.scala 21:13]
        when _T_8 : @[ALU.scala 21:13]
          node _io_aluOut_T_4 = and(io.val1, io.val2) @[ALU.scala 26:41]
          io.aluOut <= _io_aluOut_T_4 @[ALU.scala 26:30]
        else :
          node _T_9 = asUInt(UInt<3>("h4")) @[ALU.scala 21:13]
          node _T_10 = asUInt(op) @[ALU.scala 21:13]
          node _T_11 = eq(_T_9, _T_10) @[ALU.scala 21:13]
          when _T_11 : @[ALU.scala 21:13]
            node _io_aluOut_T_5 = or(io.val1, io.val2) @[ALU.scala 27:40]
            io.aluOut <= _io_aluOut_T_5 @[ALU.scala 27:29]
          else :
            node _T_12 = asUInt(UInt<3>("h5")) @[ALU.scala 21:13]
            node _T_13 = asUInt(op) @[ALU.scala 21:13]
            node _T_14 = eq(_T_12, _T_13) @[ALU.scala 21:13]
            when _T_14 : @[ALU.scala 21:13]
              node _io_aluOut_T_6 = xor(io.val1, io.val2) @[ALU.scala 28:41]
              io.aluOut <= _io_aluOut_T_6 @[ALU.scala 28:30]
            else :
              node _T_15 = asUInt(UInt<3>("h6")) @[ALU.scala 21:13]
              node _T_16 = asUInt(op) @[ALU.scala 21:13]
              node _T_17 = eq(_T_15, _T_16) @[ALU.scala 21:13]
              when _T_17 : @[ALU.scala 21:13]
                node _io_aluOut_T_7 = asSInt(io.val1) @[ALU.scala 30:42]
                node _io_aluOut_T_8 = bits(io.val2, 4, 0) @[ALU.scala 30:59]
                node _io_aluOut_T_9 = dshr(_io_aluOut_T_7, _io_aluOut_T_8) @[ALU.scala 30:49]
                node _io_aluOut_T_10 = asUInt(_io_aluOut_T_9) @[ALU.scala 30:73]
                io.aluOut <= _io_aluOut_T_10 @[ALU.scala 30:30]
              else :
                node _T_18 = asUInt(UInt<3>("h7")) @[ALU.scala 21:13]
                node _T_19 = asUInt(op) @[ALU.scala 21:13]
                node _T_20 = eq(_T_18, _T_19) @[ALU.scala 21:13]
                when _T_20 : @[ALU.scala 21:13]
                  node _io_aluOut_T_11 = bits(io.val2, 4, 0) @[ALU.scala 31:51]
                  node _io_aluOut_T_12 = dshr(io.val1, _io_aluOut_T_11) @[ALU.scala 31:41]
                  io.aluOut <= _io_aluOut_T_12 @[ALU.scala 31:30]
                else :
                  node _T_21 = asUInt(UInt<4>("h8")) @[ALU.scala 21:13]
                  node _T_22 = asUInt(op) @[ALU.scala 21:13]
                  node _T_23 = eq(_T_21, _T_22) @[ALU.scala 21:13]
                  when _T_23 : @[ALU.scala 21:13]
                    node _io_aluOut_T_13 = bits(io.val2, 4, 0) @[ALU.scala 32:51]
                    node _io_aluOut_T_14 = dshl(io.val1, _io_aluOut_T_13) @[ALU.scala 32:41]
                    io.aluOut <= _io_aluOut_T_14 @[ALU.scala 32:30]
                  else :
                    node _T_24 = asUInt(UInt<4>("h9")) @[ALU.scala 21:13]
                    node _T_25 = asUInt(op) @[ALU.scala 21:13]
                    node _T_26 = eq(_T_24, _T_25) @[ALU.scala 21:13]
                    when _T_26 : @[ALU.scala 21:13]
                      node _io_aluOut_T_15 = asSInt(io.val1) @[ALU.scala 34:45]
                      node _io_aluOut_T_16 = asSInt(io.val2) @[ALU.scala 34:62]
                      node _io_aluOut_T_17 = lt(_io_aluOut_T_15, _io_aluOut_T_16) @[ALU.scala 34:52]
                      node _io_aluOut_T_18 = mux(_io_aluOut_T_17, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 34:36]
                      io.aluOut <= _io_aluOut_T_18 @[ALU.scala 34:30]
                    else :
                      node _T_27 = asUInt(UInt<4>("ha")) @[ALU.scala 21:13]
                      node _T_28 = asUInt(op) @[ALU.scala 21:13]
                      node _T_29 = eq(_T_27, _T_28) @[ALU.scala 21:13]
                      when _T_29 : @[ALU.scala 21:13]
                        node _io_aluOut_T_19 = lt(io.val1, io.val2) @[ALU.scala 35:46]
                        node _io_aluOut_T_20 = mux(_io_aluOut_T_19, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 35:37]
                        io.aluOut <= _io_aluOut_T_20 @[ALU.scala 35:31]
                      else :
                        node _T_30 = asUInt(UInt<4>("hb")) @[ALU.scala 21:13]
                        node _T_31 = asUInt(op) @[ALU.scala 21:13]
                        node _T_32 = eq(_T_30, _T_31) @[ALU.scala 21:13]
                        when _T_32 : @[ALU.scala 21:13]
                          node _io_aluOut_T_21 = eq(io.val1, io.val2) @[ALU.scala 36:45]
                          node _io_aluOut_T_22 = mux(_io_aluOut_T_21, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 36:36]
                          io.aluOut <= _io_aluOut_T_22 @[ALU.scala 36:30]
                        else :
                          node _T_33 = asUInt(UInt<4>("hc")) @[ALU.scala 21:13]
                          node _T_34 = asUInt(op) @[ALU.scala 21:13]
                          node _T_35 = eq(_T_33, _T_34) @[ALU.scala 21:13]
                          when _T_35 : @[ALU.scala 21:13]
                            node _io_aluOut_T_23 = asSInt(io.val1) @[ALU.scala 37:45]
                            node _io_aluOut_T_24 = asSInt(io.val2) @[ALU.scala 37:62]
                            node _io_aluOut_T_25 = lt(_io_aluOut_T_23, _io_aluOut_T_24) @[ALU.scala 37:52]
                            node _io_aluOut_T_26 = mux(_io_aluOut_T_25, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 37:36]
                            io.aluOut <= _io_aluOut_T_26 @[ALU.scala 37:30]
                          else :
                            node _T_36 = asUInt(UInt<4>("hd")) @[ALU.scala 21:13]
                            node _T_37 = asUInt(op) @[ALU.scala 21:13]
                            node _T_38 = eq(_T_36, _T_37) @[ALU.scala 21:13]
                            when _T_38 : @[ALU.scala 21:13]
                              node _io_aluOut_T_27 = asSInt(io.val1) @[ALU.scala 38:45]
                              node _io_aluOut_T_28 = asSInt(io.val2) @[ALU.scala 38:63]
                              node _io_aluOut_T_29 = geq(_io_aluOut_T_27, _io_aluOut_T_28) @[ALU.scala 38:52]
                              node _io_aluOut_T_30 = mux(_io_aluOut_T_29, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 38:36]
                              io.aluOut <= _io_aluOut_T_30 @[ALU.scala 38:30]
                            else :
                              node _T_39 = asUInt(UInt<1>("h0")) @[ALU.scala 21:13]
                              node _T_40 = asUInt(op) @[ALU.scala 21:13]
                              node _T_41 = eq(_T_39, _T_40) @[ALU.scala 21:13]
                              when _T_41 : @[ALU.scala 21:13]
                                node _io_aluOut_T_31 = asSInt(io.val1) @[ALU.scala 39:45]
                                node _io_aluOut_T_32 = asSInt(io.val2) @[ALU.scala 39:64]
                                node _io_aluOut_T_33 = neq(_io_aluOut_T_31, _io_aluOut_T_32) @[ALU.scala 39:52]
                                node _io_aluOut_T_34 = mux(_io_aluOut_T_33, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 39:36]
                                io.aluOut <= _io_aluOut_T_34 @[ALU.scala 39:30]
                              else :
                                node _T_42 = asUInt(UInt<4>("he")) @[ALU.scala 21:13]
                                node _T_43 = asUInt(op) @[ALU.scala 21:13]
                                node _T_44 = eq(_T_42, _T_43) @[ALU.scala 21:13]
                                when _T_44 : @[ALU.scala 21:13]
                                  node _io_aluOut_T_35 = lt(io.val1, io.val2) @[ALU.scala 40:46]
                                  node _io_aluOut_T_36 = mux(_io_aluOut_T_35, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 40:37]
                                  io.aluOut <= _io_aluOut_T_36 @[ALU.scala 40:31]
                                else :
                                  node _T_45 = asUInt(UInt<4>("hf")) @[ALU.scala 21:13]
                                  node _T_46 = asUInt(op) @[ALU.scala 21:13]
                                  node _T_47 = eq(_T_45, _T_46) @[ALU.scala 21:13]
                                  when _T_47 : @[ALU.scala 21:13]
                                    node _io_aluOut_T_37 = geq(io.val1, io.val2) @[ALU.scala 41:46]
                                    node _io_aluOut_T_38 = mux(_io_aluOut_T_37, UInt<1>("h1"), UInt<1>("h0")) @[ALU.scala 41:37]
                                    io.aluOut <= _io_aluOut_T_38 @[ALU.scala 41:31]

  module EX :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip in : { pc : UInt<32>, rs1 : UInt<5>, rs2 : UInt<5>, val1 : UInt<32>, val2 : UInt<32>, rd : UInt<5>, imm : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, ctrl : { useImm : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}, out : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, PCout : UInt<32>, hazardAluOut : UInt<32>, changePC : UInt<1>, newPCValue : UInt<32>}

    inst ALU of ALU @[EX.scala 20:19]
    ALU.clock <= clock
    ALU.reset <= reset
    reg io_PCout_REG : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[EX.scala 23:22]
    io.PCout <= io_PCout_REG @[EX.scala 23:12]
    node _outReg_T = eq(io.stallReg, UInt<1>("h0")) @[EX.scala 24:34]
    reg outReg : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, clock with :
      reset => (UInt<1>("h0"), outReg) @[Reg.scala 19:16]
    when _outReg_T : @[Reg.scala 20:18]
      outReg.ctrl.load <= io.out.ctrl.load @[Reg.scala 20:22]
      outReg.ctrl.store <= io.out.ctrl.store @[Reg.scala 20:22]
      outReg.ctrl.writeEnable <= io.out.ctrl.writeEnable @[Reg.scala 20:22]
      outReg.wrData <= io.out.wrData @[Reg.scala 20:22]
      outReg.aluOut <= io.out.aluOut @[Reg.scala 20:22]
      outReg.rd <= io.out.rd @[Reg.scala 20:22]
    wire _io_hazardAluOut_WIRE : UInt
    _io_hazardAluOut_WIRE <= ALU.io.aluOut
    io.hazardAluOut <= _io_hazardAluOut_WIRE @[EX.scala 25:19]
    ALU.io.aluOp <= io.in.aluOp @[EX.scala 27:16]
    node _outReg_aluOut_T = add(io.in.pc, UInt<3>("h4")) @[EX.scala 28:50]
    node _outReg_aluOut_T_1 = tail(_outReg_aluOut_T, 1) @[EX.scala 28:50]
    node _outReg_aluOut_T_2 = mux(io.in.ctrl.jump, _outReg_aluOut_T_1, ALU.io.aluOut) @[EX.scala 28:23]
    outReg.aluOut <= _outReg_aluOut_T_2 @[EX.scala 28:17]
    outReg.ctrl.load <= io.in.ctrl.load @[EX.scala 29:20]
    outReg.ctrl.store <= io.in.ctrl.store @[EX.scala 30:21]
    outReg.rd <= io.in.rd @[EX.scala 31:13]
    node _outReg_ctrl_writeEnable_T = or(io.in.ctrl.branch, io.in.ctrl.store) @[EX.scala 33:50]
    node _outReg_ctrl_writeEnable_T_1 = eq(_outReg_ctrl_writeEnable_T, UInt<1>("h0")) @[EX.scala 33:30]
    outReg.ctrl.writeEnable <= _outReg_ctrl_writeEnable_T_1 @[EX.scala 33:27]
    node mux2 = mux(io.in.ctrl.useImm, io.in.imm, io.in.val2) @[EX.scala 37:17]
    node _changePC_T = eq(ALU.io.aluOut, UInt<1>("h1")) @[EX.scala 40:73]
    node _changePC_T_1 = and(io.in.ctrl.branch, _changePC_T) @[EX.scala 40:56]
    node changePC = or(io.in.ctrl.jump, _changePC_T_1) @[EX.scala 40:34]
    node _newPCValue_T = mux(io.in.ctrl.changePC, io.in.val1, io.in.pc) @[EX.scala 41:28]
    node _newPCValue_T_1 = add(_newPCValue_T, io.in.imm) @[EX.scala 41:72]
    node _newPCValue_T_2 = tail(_newPCValue_T_1, 1) @[EX.scala 41:72]
    node _newPCValue_T_3 = bits(_newPCValue_T_2, 31, 1) @[EX.scala 41:84]
    node newPCValue = cat(_newPCValue_T_3, UInt<1>("h0")) @[Cat.scala 33:92]
    node _T = eq(io.in.memOp, UInt<2>("h2")) @[EX.scala 45:20]
    when _T : @[EX.scala 45:28]
      outReg.wrData <= io.in.val2 @[EX.scala 46:19]
    node _T_1 = eq(io.in.memOp, UInt<1>("h1")) @[EX.scala 48:20]
    when _T_1 : @[EX.scala 48:28]
      node _outReg_wrData_T = bits(io.in.val2, 15, 15) @[EX.scala 49:45]
      node _outReg_wrData_T_1 = bits(_outReg_wrData_T, 0, 0) @[Bitwise.scala 77:15]
      node _outReg_wrData_T_2 = mux(_outReg_wrData_T_1, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_3 = bits(io.in.val2, 15, 0) @[EX.scala 49:62]
      node _outReg_wrData_T_4 = cat(_outReg_wrData_T_2, _outReg_wrData_T_3) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_4 @[EX.scala 49:19]
    node _T_2 = eq(io.in.memOp, UInt<3>("h5")) @[EX.scala 51:20]
    when _T_2 : @[EX.scala 51:29]
      node _outReg_wrData_T_5 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_6 = bits(io.in.val2, 15, 0) @[EX.scala 52:51]
      node _outReg_wrData_T_7 = cat(_outReg_wrData_T_5, _outReg_wrData_T_6) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_7 @[EX.scala 52:19]
    node _T_3 = eq(io.in.memOp, UInt<1>("h0")) @[EX.scala 54:20]
    when _T_3 : @[EX.scala 54:28]
      node _outReg_wrData_T_8 = bits(io.in.val2, 7, 7) @[EX.scala 55:45]
      node _outReg_wrData_T_9 = bits(_outReg_wrData_T_8, 0, 0) @[Bitwise.scala 77:15]
      node _outReg_wrData_T_10 = mux(_outReg_wrData_T_9, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_11 = bits(io.in.val2, 7, 0) @[EX.scala 55:61]
      node _outReg_wrData_T_12 = cat(_outReg_wrData_T_10, _outReg_wrData_T_11) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_12 @[EX.scala 55:19]
    node _T_4 = eq(io.in.memOp, UInt<3>("h4")) @[EX.scala 57:20]
    when _T_4 : @[EX.scala 57:29]
      node _outReg_wrData_T_13 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_14 = bits(io.in.val2, 7, 0) @[EX.scala 58:51]
      node _outReg_wrData_T_15 = cat(_outReg_wrData_T_13, _outReg_wrData_T_14) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_15 @[EX.scala 58:19]
    node _T_5 = eq(io.in.memOp, UInt<2>("h2")) @[EX.scala 63:20]
    when _T_5 : @[EX.scala 63:27]
      outReg.wrData <= io.in.val2 @[EX.scala 64:19]
    node _T_6 = eq(io.in.memOp, UInt<1>("h1")) @[EX.scala 66:20]
    when _T_6 : @[EX.scala 66:27]
      node _outReg_wrData_T_16 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_17 = bits(io.in.val2, 15, 0) @[EX.scala 67:50]
      node _outReg_wrData_T_18 = cat(_outReg_wrData_T_16, _outReg_wrData_T_17) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_18 @[EX.scala 67:19]
    node _T_7 = eq(io.in.memOp, UInt<1>("h0")) @[EX.scala 69:20]
    when _T_7 : @[EX.scala 69:28]
      node _outReg_wrData_T_19 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_20 = bits(io.in.val2, 7, 0) @[EX.scala 70:50]
      node _outReg_wrData_T_21 = cat(_outReg_wrData_T_19, _outReg_wrData_T_20) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_21 @[EX.scala 70:19]
    when io.in.ctrl.useALU : @[EX.scala 74:27]
      ALU.io.val1 <= io.in.val1 @[EX.scala 75:17]
      ALU.io.val2 <= mux2 @[EX.scala 76:17]
    else :
      ALU.io.val1 <= UInt<1>("h0") @[EX.scala 78:17]
      ALU.io.val2 <= UInt<1>("h0") @[EX.scala 79:17]
    io.out.aluOut <= outReg.aluOut @[EX.scala 83:17]
    io.out.ctrl.load <= outReg.ctrl.load @[EX.scala 84:20]
    io.out.ctrl.store <= outReg.ctrl.store @[EX.scala 85:21]
    io.out.ctrl.writeEnable <= outReg.ctrl.writeEnable @[EX.scala 86:27]
    io.out.rd <= outReg.rd @[EX.scala 87:13]
    io.out.wrData <= outReg.wrData @[EX.scala 88:17]
    node _io_PCout_T = shl(mux2, 1) @[EX.scala 89:40]
    node _io_PCout_T_1 = add(io.in.pc, _io_PCout_T) @[EX.scala 89:32]
    node _io_PCout_T_2 = tail(_io_PCout_T_1, 1) @[EX.scala 89:32]
    reg io_PCout_REG_1 : UInt, clock with :
      reset => (UInt<1>("h0"), io_PCout_REG_1) @[EX.scala 89:22]
    io_PCout_REG_1 <= _io_PCout_T_2 @[EX.scala 89:22]
    io.PCout <= io_PCout_REG_1 @[EX.scala 89:12]
    reg io_changePC_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_changePC_REG) @[EX.scala 90:25]
    io_changePC_REG <= changePC @[EX.scala 90:25]
    io.changePC <= io_changePC_REG @[EX.scala 90:15]
    reg io_newPCValue_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_newPCValue_REG) @[EX.scala 91:27]
    io_newPCValue_REG <= newPCValue @[EX.scala 91:27]
    io.newPCValue <= io_newPCValue_REG @[EX.scala 91:17]

  module DualReadMem :
    input clock : Clock
    input reset : Reset
    output io : { flip rden : UInt<1>, flip rdAddr1 : UInt<5>, rdData1 : UInt<32>, flip rdAddr2 : UInt<5>, rdData2 : UInt<32>, flip wrAddr : UInt<5>, flip wrData : UInt<32>, flip wren : UInt<1>}

    wire _io_rdData1_WIRE : UInt<32>
    _io_rdData1_WIRE <= UInt<32>("h0")
    io.rdData1 <= _io_rdData1_WIRE @[DualReadMem.scala 25:14]
    wire _io_rdData2_WIRE : UInt<32>
    _io_rdData2_WIRE <= UInt<32>("h0")
    io.rdData2 <= _io_rdData2_WIRE @[DualReadMem.scala 26:14]
    wire rdData1 : UInt<32>
    rdData1 is invalid
    wire rdData2 : UInt<32>
    rdData2 is invalid
    wire readAddress1 : UInt<5>
    readAddress1 is invalid
    wire readAddress2 : UInt<5>
    readAddress2 is invalid
    wire writeAddress : UInt<5>
    writeAddress <= UInt<5>("h0")
    smem mem : UInt<32> [128] @[DualReadMem.scala 34:43]
    when io.rden : @[DualReadMem.scala 36:17]
      node _readAddress1_T = shr(io.rdAddr1, 2) @[DualReadMem.scala 38:32]
      readAddress1 <= _readAddress1_T @[DualReadMem.scala 38:18]
      node _readAddress2_T = shr(io.rdAddr2, 2) @[DualReadMem.scala 39:32]
      readAddress2 <= _readAddress2_T @[DualReadMem.scala 39:18]
      wire _rdData1_WIRE : UInt @[DualReadMem.scala 40:24]
      _rdData1_WIRE is invalid @[DualReadMem.scala 40:24]
      when UInt<1>("h1") : @[DualReadMem.scala 40:24]
        _rdData1_WIRE <= readAddress1 @[DualReadMem.scala 40:24]
        node _rdData1_T = or(_rdData1_WIRE, UInt<7>("h0")) @[DualReadMem.scala 40:24]
        node _rdData1_T_1 = bits(_rdData1_T, 6, 0) @[DualReadMem.scala 40:24]
        read mport rdData1_MPORT = mem[_rdData1_T_1], clock @[DualReadMem.scala 40:24]
      rdData1 <= rdData1_MPORT @[DualReadMem.scala 40:13]
      wire _rdData2_WIRE : UInt @[DualReadMem.scala 41:24]
      _rdData2_WIRE is invalid @[DualReadMem.scala 41:24]
      when UInt<1>("h1") : @[DualReadMem.scala 41:24]
        _rdData2_WIRE <= readAddress2 @[DualReadMem.scala 41:24]
        node _rdData2_T = or(_rdData2_WIRE, UInt<7>("h0")) @[DualReadMem.scala 41:24]
        node _rdData2_T_1 = bits(_rdData2_T, 6, 0) @[DualReadMem.scala 41:24]
        read mport rdData2_MPORT = mem[_rdData2_T_1], clock @[DualReadMem.scala 41:24]
      rdData2 <= rdData2_MPORT @[DualReadMem.scala 41:13]
    reg REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), REG) @[DualReadMem.scala 44:15]
    REG <= io.rden @[DualReadMem.scala 44:15]
    when REG : @[DualReadMem.scala 44:26]
      io.rdData1 <= rdData1 @[DualReadMem.scala 45:16]
      io.rdData2 <= rdData2 @[DualReadMem.scala 46:16]
    when io.wren : @[DualReadMem.scala 49:17]
      node _writeAddress_T = shr(io.wrAddr, 2) @[DualReadMem.scala 50:31]
      writeAddress <= _writeAddress_T @[DualReadMem.scala 50:18]
      write mport MPORT = mem[writeAddress], clock
      MPORT <= io.wrData

  module MEM :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip in : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, out : { rd : UInt<5>, aluOut : UInt<32>, memOut : UInt<32>, load : UInt<1>, writeEnable : UInt<1>}, mem_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}}

    node _outReg_T = eq(io.stallReg, UInt<1>("h0")) @[MEM.scala 18:34]
    reg outReg : { rd : UInt<5>, aluOut : UInt<32>, memOut : UInt<32>, load : UInt<1>, writeEnable : UInt<1>}, clock with :
      reset => (UInt<1>("h0"), outReg) @[Reg.scala 19:16]
    when _outReg_T : @[Reg.scala 20:18]
      outReg.writeEnable <= io.out.writeEnable @[Reg.scala 20:22]
      outReg.load <= io.out.load @[Reg.scala 20:22]
      outReg.memOut <= io.out.memOut @[Reg.scala 20:22]
      outReg.aluOut <= io.out.aluOut @[Reg.scala 20:22]
      outReg.rd <= io.out.rd @[Reg.scala 20:22]
    outReg.rd <= io.in.rd @[MEM.scala 21:13]
    outReg.aluOut <= io.in.aluOut @[MEM.scala 22:17]
    outReg.writeEnable <= io.in.ctrl.writeEnable @[MEM.scala 23:22]
    outReg.load <= io.in.ctrl.load @[MEM.scala 24:15]
    outReg.memOut is invalid @[MEM.scala 25:17]
    inst DRMEM of DualReadMem @[MEM.scala 28:21]
    DRMEM.clock <= clock
    DRMEM.reset <= reset
    DRMEM.io.rdAddr2 is invalid @[MEM.scala 31:20]
    DRMEM.io.wren <= io.in.ctrl.store @[MEM.scala 34:17]
    DRMEM.io.rden <= io.in.ctrl.load @[MEM.scala 35:17]
    DRMEM.io.rdAddr1 <= io.in.aluOut @[MEM.scala 36:20]
    DRMEM.io.wrAddr <= io.in.aluOut @[MEM.scala 37:19]
    DRMEM.io.wrData <= io.in.wrData @[MEM.scala 38:19]
    io.out.rd <= outReg.rd @[MEM.scala 53:13]
    io.out.aluOut <= outReg.aluOut @[MEM.scala 54:17]
    io.out.load <= outReg.load @[MEM.scala 55:15]
    io.out.writeEnable <= outReg.writeEnable @[MEM.scala 56:22]
    io.out.memOut <= DRMEM.io.rdData1 @[MEM.scala 57:17]
    io.mem_fwd.rd <= io.in.rd @[MEM.scala 60:17]
    io.mem_fwd.stageOutput <= io.in.aluOut @[MEM.scala 61:26]
    io.mem_fwd.writeEnable <= io.in.ctrl.writeEnable @[MEM.scala 62:26]

  module WB :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip in : { rd : UInt<5>, aluOut : UInt<32>, memOut : UInt<32>, load : UInt<1>, writeEnable : UInt<1>}, out : { rd : UInt<5>, muxOut : UInt<32>, writeEnable : UInt<1>}, wb_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}}

    node theMux = mux(io.in.load, io.in.memOut, io.in.aluOut) @[WB.scala 19:19]
    io.out.writeEnable <= io.in.writeEnable @[WB.scala 27:22]
    io.out.muxOut <= theMux @[WB.scala 28:17]
    io.out.rd <= io.in.rd @[WB.scala 29:13]
    io.wb_fwd.rd <= io.out.rd @[WB.scala 32:16]
    io.wb_fwd.stageOutput <= io.out.muxOut @[WB.scala 33:25]
    io.wb_fwd.writeEnable <= io.out.writeEnable @[WB.scala 34:25]

  module ForwardingUnit :
    input clock : Clock
    input reset : Reset
    output io : { flip id_rs1 : UInt<5>, flip id_rs2 : UInt<5>, flip id_val1 : UInt<32>, flip id_val2 : UInt<32>, flip mem_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}, flip wb_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}, val1 : UInt<32>, val2 : UInt<32>, is_forwarding : UInt<1>}

    node _forwardingMEMrs1_T = eq(io.mem_fwd.rd, io.id_rs1) @[ForwardingUnit.scala 21:41]
    node _forwardingMEMrs1_T_1 = neq(io.id_rs1, UInt<1>("h0")) @[ForwardingUnit.scala 21:68]
    node _forwardingMEMrs1_T_2 = and(_forwardingMEMrs1_T, _forwardingMEMrs1_T_1) @[ForwardingUnit.scala 21:55]
    node forwardingMEMrs1 = and(_forwardingMEMrs1_T_2, io.mem_fwd.writeEnable) @[ForwardingUnit.scala 21:76]
    node _forwardingMEMrs2_T = eq(io.mem_fwd.rd, io.id_rs2) @[ForwardingUnit.scala 22:41]
    node _forwardingMEMrs2_T_1 = neq(io.id_rs2, UInt<1>("h0")) @[ForwardingUnit.scala 22:68]
    node _forwardingMEMrs2_T_2 = and(_forwardingMEMrs2_T, _forwardingMEMrs2_T_1) @[ForwardingUnit.scala 22:55]
    node forwardingMEMrs2 = and(_forwardingMEMrs2_T_2, io.mem_fwd.writeEnable) @[ForwardingUnit.scala 22:76]
    node _forwardingWBrs1_T = eq(io.wb_fwd.rd, io.id_rs1) @[ForwardingUnit.scala 24:39]
    node _forwardingWBrs1_T_1 = neq(io.id_rs1, UInt<1>("h0")) @[ForwardingUnit.scala 24:66]
    node _forwardingWBrs1_T_2 = and(_forwardingWBrs1_T, _forwardingWBrs1_T_1) @[ForwardingUnit.scala 24:53]
    node forwardingWBrs1 = and(_forwardingWBrs1_T_2, io.wb_fwd.writeEnable) @[ForwardingUnit.scala 24:74]
    node _forwardingWBrs2_T = eq(io.wb_fwd.rd, io.id_rs2) @[ForwardingUnit.scala 25:39]
    node _forwardingWBrs2_T_1 = neq(io.id_rs2, UInt<1>("h0")) @[ForwardingUnit.scala 25:66]
    node _forwardingWBrs2_T_2 = and(_forwardingWBrs2_T, _forwardingWBrs2_T_1) @[ForwardingUnit.scala 25:53]
    node forwardingWBrs2 = and(_forwardingWBrs2_T_2, io.wb_fwd.writeEnable) @[ForwardingUnit.scala 25:74]
    node _io_is_forwarding_T = or(forwardingMEMrs1, forwardingMEMrs2) @[ForwardingUnit.scala 27:40]
    node _io_is_forwarding_T_1 = or(_io_is_forwarding_T, forwardingWBrs1) @[ForwardingUnit.scala 27:60]
    node _io_is_forwarding_T_2 = or(_io_is_forwarding_T_1, forwardingWBrs2) @[ForwardingUnit.scala 27:79]
    io.is_forwarding <= _io_is_forwarding_T_2 @[ForwardingUnit.scala 27:20]
    when forwardingMEMrs1 : @[ForwardingUnit.scala 29:26]
      io.val1 <= io.mem_fwd.stageOutput @[ForwardingUnit.scala 30:13]
    else :
      when forwardingWBrs1 : @[ForwardingUnit.scala 31:31]
        io.val1 <= io.wb_fwd.stageOutput @[ForwardingUnit.scala 32:13]
      else :
        io.val1 <= io.id_val1 @[ForwardingUnit.scala 34:13]
    when forwardingMEMrs2 : @[ForwardingUnit.scala 37:26]
      io.val2 <= io.mem_fwd.stageOutput @[ForwardingUnit.scala 38:13]
    else :
      when forwardingWBrs2 : @[ForwardingUnit.scala 39:31]
        io.val2 <= io.wb_fwd.stageOutput @[ForwardingUnit.scala 40:13]
      else :
        io.val2 <= io.id_val2 @[ForwardingUnit.scala 42:13]

  module HazardControl :
    input clock : Clock
    input reset : Reset
    output io : { flip EXaluOut : UInt<32>, flip EXctrlBranch : UInt<1>, flip EXctrlJump : UInt<1>, flip EXctrlLoad : UInt<1>, flip EXrd : UInt<5>, flip IDrs1 : UInt<5>, flip IDrs2 : UInt<5>, IDFlush : UInt<1>, IFFlush : UInt<1>, IFStall : UInt<1>}

    wire _io_IDFlush_WIRE : UInt<1>
    _io_IDFlush_WIRE <= UInt<1>("h0")
    io.IDFlush <= _io_IDFlush_WIRE @[HazardControl.scala 23:14]
    wire _io_IFFlush_WIRE : UInt<1>
    _io_IFFlush_WIRE <= UInt<1>("h0")
    io.IFFlush <= _io_IFFlush_WIRE @[HazardControl.scala 24:14]
    wire _io_IFStall_WIRE : UInt<1>
    _io_IFStall_WIRE <= UInt<1>("h0")
    io.IFStall <= _io_IFStall_WIRE @[HazardControl.scala 25:14]
    node _use_load_T = eq(io.EXrd, io.IDrs1) @[HazardControl.scala 27:44]
    node _use_load_T_1 = eq(io.EXrd, io.IDrs2) @[HazardControl.scala 27:68]
    node _use_load_T_2 = or(_use_load_T, _use_load_T_1) @[HazardControl.scala 27:57]
    node _use_load_T_3 = and(io.EXctrlLoad, _use_load_T_2) @[HazardControl.scala 27:32]
    node _use_load_T_4 = neq(io.EXrd, UInt<1>("h0")) @[HazardControl.scala 27:93]
    node use_load = and(_use_load_T_3, _use_load_T_4) @[HazardControl.scala 27:82]
    node _branch_jump_T = eq(io.EXaluOut, UInt<1>("h1")) @[HazardControl.scala 28:34]
    node _branch_jump_T_1 = and(_branch_jump_T, io.EXctrlBranch) @[HazardControl.scala 28:42]
    node branch_jump = or(_branch_jump_T_1, io.EXctrlJump) @[HazardControl.scala 28:62]
    io.IFFlush <= branch_jump @[HazardControl.scala 30:14]
    io.IFStall <= use_load @[HazardControl.scala 31:14]
    node _io_IDFlush_T = or(branch_jump, use_load) @[HazardControl.scala 32:29]
    io.IDFlush <= _io_IDFlush_T @[HazardControl.scala 32:14]

  module SevenSegment :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<16>, seg : UInt<7>, an : UInt<4>}

    wire _io_seg_WIRE : UInt<7>
    _io_seg_WIRE <= UInt<7>("h7f")
    io.seg <= _io_seg_WIRE @[SevenSegment.scala 13:11]
    wire _io_an_WIRE : UInt<4>
    _io_an_WIRE <= UInt<4>("hf")
    io.an <= _io_an_WIRE @[SevenSegment.scala 14:9]
    wire data : UInt<4>
    data <= UInt<4>("h0")
    reg ticker : UInt<19>, clock with :
      reset => (reset, UInt<19>("h0")) @[SevenSegment.scala 19:23]
    node tick = eq(ticker, UInt<5>("h12")) @[SevenSegment.scala 20:21]
    node _ticker_T = add(ticker, UInt<1>("h1")) @[SevenSegment.scala 21:35]
    node _ticker_T_1 = tail(_ticker_T, 1) @[SevenSegment.scala 21:35]
    node _ticker_T_2 = mux(tick, UInt<1>("h0"), _ticker_T_1) @[SevenSegment.scala 21:16]
    ticker <= _ticker_T_2 @[SevenSegment.scala 21:10]
    reg cntReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[SevenSegment.scala 24:23]
    when tick : @[SevenSegment.scala 25:14]
      node _cntReg_T = eq(cntReg, UInt<2>("h3")) @[SevenSegment.scala 26:26]
      node _cntReg_T_1 = add(cntReg, UInt<1>("h1")) @[SevenSegment.scala 26:47]
      node _cntReg_T_2 = tail(_cntReg_T_1, 1) @[SevenSegment.scala 26:47]
      node _cntReg_T_3 = mux(_cntReg_T, UInt<1>("h0"), _cntReg_T_2) @[SevenSegment.scala 26:18]
      cntReg <= _cntReg_T_3 @[SevenSegment.scala 26:12]
    node _T = eq(UInt<1>("h0"), cntReg) @[SevenSegment.scala 29:17]
    when _T : @[SevenSegment.scala 29:17]
      node _data_T = bits(io.in, 15, 12) @[SevenSegment.scala 31:20]
      data <= _data_T @[SevenSegment.scala 31:12]
      io.an <= UInt<3>("h7") @[SevenSegment.scala 32:13]
    else :
      node _T_1 = eq(UInt<1>("h1"), cntReg) @[SevenSegment.scala 29:17]
      when _T_1 : @[SevenSegment.scala 29:17]
        node _data_T_1 = bits(io.in, 11, 8) @[SevenSegment.scala 35:20]
        data <= _data_T_1 @[SevenSegment.scala 35:12]
        io.an <= UInt<4>("hb") @[SevenSegment.scala 36:13]
      else :
        node _T_2 = eq(UInt<2>("h2"), cntReg) @[SevenSegment.scala 29:17]
        when _T_2 : @[SevenSegment.scala 29:17]
          node _data_T_2 = bits(io.in, 7, 4) @[SevenSegment.scala 39:20]
          data <= _data_T_2 @[SevenSegment.scala 39:12]
          io.an <= UInt<4>("hd") @[SevenSegment.scala 40:13]
        else :
          node _T_3 = eq(UInt<2>("h3"), cntReg) @[SevenSegment.scala 29:17]
          when _T_3 : @[SevenSegment.scala 29:17]
            node _data_T_3 = bits(io.in, 3, 0) @[SevenSegment.scala 43:21]
            data <= _data_T_3 @[SevenSegment.scala 43:13]
            io.an <= UInt<4>("he") @[SevenSegment.scala 44:14]
    node _T_4 = eq(UInt<1>("h0"), data) @[SevenSegment.scala 48:16]
    when _T_4 : @[SevenSegment.scala 48:16]
      io.seg <= UInt<7>("h7e") @[SevenSegment.scala 50:14]
    else :
      node _T_5 = eq(UInt<1>("h1"), data) @[SevenSegment.scala 48:16]
      when _T_5 : @[SevenSegment.scala 48:16]
        io.seg <= UInt<6>("h30") @[SevenSegment.scala 53:14]
      else :
        node _T_6 = eq(UInt<2>("h2"), data) @[SevenSegment.scala 48:16]
        when _T_6 : @[SevenSegment.scala 48:16]
          io.seg <= UInt<7>("h6d") @[SevenSegment.scala 56:14]
        else :
          node _T_7 = eq(UInt<2>("h3"), data) @[SevenSegment.scala 48:16]
          when _T_7 : @[SevenSegment.scala 48:16]
            io.seg <= UInt<7>("h79") @[SevenSegment.scala 59:14]
          else :
            node _T_8 = eq(UInt<3>("h4"), data) @[SevenSegment.scala 48:16]
            when _T_8 : @[SevenSegment.scala 48:16]
              io.seg <= UInt<6>("h33") @[SevenSegment.scala 62:14]
            else :
              node _T_9 = eq(UInt<3>("h5"), data) @[SevenSegment.scala 48:16]
              when _T_9 : @[SevenSegment.scala 48:16]
                io.seg <= UInt<7>("h5b") @[SevenSegment.scala 65:14]
              else :
                node _T_10 = eq(UInt<3>("h6"), data) @[SevenSegment.scala 48:16]
                when _T_10 : @[SevenSegment.scala 48:16]
                  io.seg <= UInt<7>("h5f") @[SevenSegment.scala 68:14]
                else :
                  node _T_11 = eq(UInt<3>("h7"), data) @[SevenSegment.scala 48:16]
                  when _T_11 : @[SevenSegment.scala 48:16]
                    io.seg <= UInt<7>("h70") @[SevenSegment.scala 71:14]
                  else :
                    node _T_12 = eq(UInt<4>("h8"), data) @[SevenSegment.scala 48:16]
                    when _T_12 : @[SevenSegment.scala 48:16]
                      io.seg <= UInt<7>("h7f") @[SevenSegment.scala 74:14]
                    else :
                      node _T_13 = eq(UInt<4>("h9"), data) @[SevenSegment.scala 48:16]
                      when _T_13 : @[SevenSegment.scala 48:16]
                        io.seg <= UInt<7>("h73") @[SevenSegment.scala 77:14]
                      else :
                        node _T_14 = eq(UInt<4>("ha"), data) @[SevenSegment.scala 48:16]
                        when _T_14 : @[SevenSegment.scala 48:16]
                          io.seg <= UInt<7>("h77") @[SevenSegment.scala 80:14]
                        else :
                          node _T_15 = eq(UInt<4>("hb"), data) @[SevenSegment.scala 48:16]
                          when _T_15 : @[SevenSegment.scala 48:16]
                            io.seg <= UInt<5>("h1f") @[SevenSegment.scala 83:14]
                          else :
                            node _T_16 = eq(UInt<4>("hc"), data) @[SevenSegment.scala 48:16]
                            when _T_16 : @[SevenSegment.scala 48:16]
                              io.seg <= UInt<7>("h4e") @[SevenSegment.scala 86:14]
                            else :
                              node _T_17 = eq(UInt<4>("hd"), data) @[SevenSegment.scala 48:16]
                              when _T_17 : @[SevenSegment.scala 48:16]
                                io.seg <= UInt<6>("h3d") @[SevenSegment.scala 89:14]
                              else :
                                node _T_18 = eq(UInt<4>("he"), data) @[SevenSegment.scala 48:16]
                                when _T_18 : @[SevenSegment.scala 48:16]
                                  io.seg <= UInt<7>("h4f") @[SevenSegment.scala 92:14]
                                else :
                                  node _T_19 = eq(UInt<4>("hf"), data) @[SevenSegment.scala 48:16]
                                  when _T_19 : @[SevenSegment.scala 48:16]
                                    io.seg <= UInt<7>("h47") @[SevenSegment.scala 95:14]

  module ChiselRISC :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip startPipeline : UInt<1>, seg : UInt<7>, an : UInt<4>}

    wire _io_seg_WIRE : UInt<7>
    _io_seg_WIRE <= UInt<7>("h0")
    io.seg <= _io_seg_WIRE @[ChiselRISC.scala 22:12]
    wire _io_an_WIRE : UInt<4>
    _io_an_WIRE <= UInt<4>("h0")
    io.an <= _io_an_WIRE @[ChiselRISC.scala 23:11]
    inst IF of IF @[ChiselRISC.scala 27:20]
    IF.clock <= clock
    IF.reset <= reset
    inst ID of ID @[ChiselRISC.scala 28:20]
    ID.clock <= clock
    ID.reset <= reset
    inst EX of EX @[ChiselRISC.scala 29:20]
    EX.clock <= clock
    EX.reset <= reset
    inst MEM of MEM @[ChiselRISC.scala 30:21]
    MEM.clock <= clock
    MEM.reset <= reset
    inst WB of WB @[ChiselRISC.scala 31:20]
    WB.clock <= clock
    WB.reset <= reset
    inst forwardingUnit of ForwardingUnit @[ChiselRISC.scala 33:32]
    forwardingUnit.clock <= clock
    forwardingUnit.reset <= reset
    inst hazardControl of HazardControl @[ChiselRISC.scala 34:31]
    hazardControl.clock <= clock
    hazardControl.reset <= reset
    ID.io.in <= IF.io.out @[ChiselRISC.scala 37:15]
    IF.io.changePC <= EX.io.changePC @[ChiselRISC.scala 38:20]
    IF.io.newPCValue <= EX.io.newPCValue @[ChiselRISC.scala 39:22]
    EX.io.in.pc <= ID.io.out.pc @[ChiselRISC.scala 40:17]
    EX.io.in.rs1 <= ID.io.out.rs1 @[ChiselRISC.scala 41:18]
    EX.io.in.rs2 <= ID.io.out.rs2 @[ChiselRISC.scala 42:18]
    EX.io.in.rd <= ID.io.out.rd @[ChiselRISC.scala 43:17]
    EX.io.in.imm <= ID.io.out.imm @[ChiselRISC.scala 44:18]
    EX.io.in.aluOp <= ID.io.out.aluOp @[ChiselRISC.scala 45:20]
    EX.io.in.ctrl.changePC <= ID.io.out.ctrl.changePC @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.store <= ID.io.out.ctrl.store @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.load <= ID.io.out.ctrl.load @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.jump <= ID.io.out.ctrl.jump @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.branch <= ID.io.out.ctrl.branch @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.useALU <= ID.io.out.ctrl.useALU @[ChiselRISC.scala 46:19]
    EX.io.in.ctrl.useImm <= ID.io.out.ctrl.useImm @[ChiselRISC.scala 46:19]
    EX.io.in.memOp <= ID.io.out.memOp @[ChiselRISC.scala 47:20]
    MEM.io.in <= EX.io.out @[ChiselRISC.scala 48:15]
    WB.io.in <= MEM.io.out @[ChiselRISC.scala 49:16]
    ID.io.wbIn <= WB.io.out @[ChiselRISC.scala 50:15]
    ID.io.stallReg <= IF.io.stallReg @[ChiselRISC.scala 51:20]
    EX.io.stallReg <= ID.io.stallReg @[ChiselRISC.scala 52:20]
    MEM.io.stallReg <= EX.io.stallReg @[ChiselRISC.scala 53:21]
    WB.io.stallReg <= MEM.io.stallReg @[ChiselRISC.scala 54:20]
    forwardingUnit.io.id_rs1 <= ID.io.out.rs1 @[ChiselRISC.scala 57:30]
    forwardingUnit.io.id_rs2 <= ID.io.out.rs2 @[ChiselRISC.scala 58:30]
    forwardingUnit.io.id_val1 <= ID.io.out.val1 @[ChiselRISC.scala 59:31]
    forwardingUnit.io.id_val2 <= ID.io.out.val2 @[ChiselRISC.scala 60:31]
    forwardingUnit.io.mem_fwd <= MEM.io.mem_fwd @[ChiselRISC.scala 61:31]
    forwardingUnit.io.wb_fwd <= WB.io.wb_fwd @[ChiselRISC.scala 62:30]
    EX.io.in.val1 <= forwardingUnit.io.val1 @[ChiselRISC.scala 63:19]
    EX.io.in.val2 <= forwardingUnit.io.val2 @[ChiselRISC.scala 64:19]
    IF.io.flush <= hazardControl.io.IFFlush @[ChiselRISC.scala 67:17]
    ID.io.flush <= hazardControl.io.IDFlush @[ChiselRISC.scala 68:17]
    IF.io.stallReg <= hazardControl.io.IFStall @[ChiselRISC.scala 69:20]
    hazardControl.io.EXaluOut <= EX.io.hazardAluOut @[ChiselRISC.scala 70:31]
    hazardControl.io.EXctrlBranch <= EX.io.in.ctrl.branch @[ChiselRISC.scala 71:35]
    hazardControl.io.EXctrlJump <= EX.io.in.ctrl.jump @[ChiselRISC.scala 72:33]
    hazardControl.io.EXctrlLoad <= EX.io.in.ctrl.load @[ChiselRISC.scala 73:33]
    hazardControl.io.EXrd <= EX.io.in.rd @[ChiselRISC.scala 74:27]
    hazardControl.io.IDrs1 <= ID.io.out.rs1 @[ChiselRISC.scala 75:28]
    hazardControl.io.IDrs2 <= ID.io.out.rs2 @[ChiselRISC.scala 76:28]
    IF.io.memIO.ready is invalid @[ChiselRISC.scala 81:23]
    IF.io.memIO.writeData is invalid @[ChiselRISC.scala 82:27]
    inst sevenSeg of SevenSegment @[ChiselRISC.scala 106:26]
    sevenSeg.clock <= clock
    sevenSeg.reset <= reset
    node _sevenSeg_io_in_T = bits(WB.io.out.muxOut, 15, 0) @[ChiselRISC.scala 107:47]
    reg sevenSeg_io_in_REG : UInt, clock with :
      reset => (UInt<1>("h0"), sevenSeg_io_in_REG) @[ChiselRISC.scala 107:30]
    sevenSeg_io_in_REG <= _sevenSeg_io_in_T @[ChiselRISC.scala 107:30]
    sevenSeg.io.in <= sevenSeg_io_in_REG @[ChiselRISC.scala 107:20]
    io.seg <= sevenSeg.io.seg @[ChiselRISC.scala 108:12]
    io.an <= sevenSeg.io.an @[ChiselRISC.scala 109:11]

