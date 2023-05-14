circuit VStageProcessor :
  module ProgramCounter :
    input clock : Clock
    input reset : Reset
    output io : { memIO : { flip ready : UInt<1>, valid : UInt<1>, flip nonEmpty : UInt<1>, addr : UInt<32>}, flip in : UInt<32>}

    wire _io_memIO_valid_WIRE : UInt<1>
    _io_memIO_valid_WIRE <= UInt<1>("h0")
    io.memIO.valid <= _io_memIO_valid_WIRE @[ProgramCounter.scala 12:18]
    io.memIO.nonEmpty is invalid @[ProgramCounter.scala 13:21]
    wire _io_memIO_addr_WIRE : UInt<32>
    _io_memIO_addr_WIRE <= UInt<32>("h0")
    io.memIO.addr <= _io_memIO_addr_WIRE @[ProgramCounter.scala 14:17]
    reg reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[ProgramCounter.scala 17:20]
    when io.memIO.ready : @[ProgramCounter.scala 19:23]
      io.memIO.valid <= UInt<1>("h1") @[ProgramCounter.scala 20:20]
    else :
      io.memIO.valid <= UInt<1>("h0") @[ProgramCounter.scala 22:20]
    io.memIO.addr <= reg @[ProgramCounter.scala 24:19]
    reg <= io.in @[ProgramCounter.scala 25:9]

  module InstructionMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip memIO : { flip ready : UInt<1>, valid : UInt<1>, flip nonEmpty : UInt<1>, addr : UInt<32>}, writer : { flip ready : UInt<1>, flip data : UInt<32>}, memOut : UInt<32>}

    wire _io_memOut_WIRE : UInt<32>
    _io_memOut_WIRE <= UInt<32>("h0")
    io.memOut <= _io_memOut_WIRE @[InstructionMemory.scala 21:13]
    io.memIO.ready is invalid @[InstructionMemory.scala 22:18]
    wire readAddr : UInt<32>
    readAddr <= UInt<32>("h0")
    wire _io_memIO_nonEmpty_WIRE : UInt<1>
    _io_memIO_nonEmpty_WIRE <= UInt<1>("h1")
    io.memIO.nonEmpty <= _io_memIO_nonEmpty_WIRE @[InstructionMemory.scala 24:21]
    reg writePtr : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[InstructionMemory.scala 25:25]
    node _T = gt(writePtr, UInt<1>("h0")) @[InstructionMemory.scala 26:17]
    when _T : @[InstructionMemory.scala 26:23]
      io.memIO.nonEmpty <= UInt<1>("h0") @[InstructionMemory.scala 27:23]
    wire _mem_WIRE : UInt<32>[128] @[InstructionMemory.scala 30:28]
    _mem_WIRE[0] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[1] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[2] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[3] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[4] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[5] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[6] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[7] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[8] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[9] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[10] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[11] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[12] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[13] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[14] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[15] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[16] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[17] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[18] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[19] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[20] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[21] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[22] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[23] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[24] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[25] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[26] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[27] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[28] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[29] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[30] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[31] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[32] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[33] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[34] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[35] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[36] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[37] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[38] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[39] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[40] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[41] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[42] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[43] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[44] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[45] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[46] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[47] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[48] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[49] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[50] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[51] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[52] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[53] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[54] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[55] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[56] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[57] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[58] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[59] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[60] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[61] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[62] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[63] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[64] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[65] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[66] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[67] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[68] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[69] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[70] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[71] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[72] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[73] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[74] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[75] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[76] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[77] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[78] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[79] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[80] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[81] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[82] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[83] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[84] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[85] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[86] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[87] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[88] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[89] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[90] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[91] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[92] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[93] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[94] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[95] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[96] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[97] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[98] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[99] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[100] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[101] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[102] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[103] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[104] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[105] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[106] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[107] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[108] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[109] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[110] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[111] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[112] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[113] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[114] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[115] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[116] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[117] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[118] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[119] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[120] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[121] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[122] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[123] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[124] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[125] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[126] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    _mem_WIRE[127] <= UInt<32>("h0") @[InstructionMemory.scala 30:28]
    reg mem : UInt<32>[128], clock with :
      reset => (reset, _mem_WIRE) @[InstructionMemory.scala 30:20]
    when io.memIO.valid : @[InstructionMemory.scala 32:24]
      node _readAddr_T = shr(io.memIO.addr, 2) @[InstructionMemory.scala 33:31]
      readAddr <= _readAddr_T @[InstructionMemory.scala 33:14]
      node _io_memOut_T = bits(readAddr, 6, 0)
      io.memOut <= mem[_io_memOut_T] @[InstructionMemory.scala 34:15]
    when io.writer.ready : @[InstructionMemory.scala 37:24]
      mem[writePtr] <= io.writer.data @[InstructionMemory.scala 38:19]
      node _writePtr_T = add(writePtr, UInt<1>("h1")) @[InstructionMemory.scala 39:26]
      node _writePtr_T_1 = tail(_writePtr_T, 1) @[InstructionMemory.scala 39:26]
      writePtr <= _writePtr_T_1 @[InstructionMemory.scala 39:14]
      node _T_1 = geq(writePtr, UInt<8>("h80")) @[InstructionMemory.scala 40:19]
      when _T_1 : @[InstructionMemory.scala 40:36]
        writePtr <= UInt<1>("h0") @[InstructionMemory.scala 41:16]

  module IF :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip flush : UInt<1>, out : { inst : UInt<32>, pc : UInt<32>}, flip newPCValue : UInt<32>, flip changePC : UInt<1>, memIO : { flip ready : UInt<1>, flip writeData : UInt<32>}, flip startPC : UInt<1>}

    inst PC of ProgramCounter @[IF.scala 23:18]
    PC.clock <= clock
    PC.reset <= reset
    inst instMem of InstructionMemory @[IF.scala 26:23]
    instMem.clock <= clock
    instMem.reset <= reset
    wire pc : UInt
    pc <= PC.io.memIO.addr
    reg outReg : { inst : UInt<32>, pc : UInt<32>}, clock with :
      reset => (UInt<1>("h0"), outReg) @[IF.scala 29:23]
    outReg.pc <= io.out.pc @[IF.scala 29:23]
    outReg.inst <= io.out.inst @[IF.scala 29:23]
    PC.io.memIO.nonEmpty is invalid @[IF.scala 31:24]
    wire _PC_io_memIO_ready_WIRE : UInt<1>
    _PC_io_memIO_ready_WIRE <= UInt<1>("h0")
    PC.io.memIO.ready <= _PC_io_memIO_ready_WIRE @[IF.scala 32:21]
    wire _PC_io_in_WIRE : UInt<32>
    _PC_io_in_WIRE <= UInt<32>("h0")
    PC.io.in <= _PC_io_in_WIRE @[IF.scala 33:12]
    wire _instMem_io_writer_ready_WIRE : UInt<1>
    _instMem_io_writer_ready_WIRE <= UInt<1>("h0")
    instMem.io.writer.ready <= _instMem_io_writer_ready_WIRE @[IF.scala 38:27]
    wire _instMem_io_writer_data_WIRE : UInt<32>
    _instMem_io_writer_data_WIRE <= UInt<32>("h0")
    instMem.io.writer.data <= _instMem_io_writer_data_WIRE @[IF.scala 39:26]
    instMem.io.writer.ready <= io.memIO.ready @[IF.scala 42:27]
    instMem.io.writer.data <= io.memIO.writeData @[IF.scala 43:26]
    wire _instMem_io_memIO_valid_WIRE : UInt<1>
    _instMem_io_memIO_valid_WIRE <= UInt<1>("h0")
    instMem.io.memIO.valid <= _instMem_io_memIO_valid_WIRE @[IF.scala 44:26]
    node addr = mux(io.changePC, io.newPCValue, pc) @[IF.scala 47:17]
    node _T = eq(instMem.io.memIO.nonEmpty, UInt<1>("h0")) @[IF.scala 50:8]
    node _T_1 = and(_T, io.startPC) @[IF.scala 50:35]
    when _T_1 : @[IF.scala 50:50]
      PC.io.memIO.ready <= UInt<1>("h1") @[IF.scala 51:23]
      node _PC_io_in_T = add(pc, UInt<3>("h4")) @[IF.scala 52:28]
      node _PC_io_in_T_1 = tail(_PC_io_in_T, 1) @[IF.scala 52:28]
      node _PC_io_in_T_2 = add(io.newPCValue, UInt<3>("h4")) @[IF.scala 53:35]
      node _PC_io_in_T_3 = tail(_PC_io_in_T_2, 1) @[IF.scala 53:35]
      node _PC_io_in_T_4 = mux(io.stallReg, pc, _PC_io_in_T_1) @[Mux.scala 101:16]
      node _PC_io_in_T_5 = mux(io.changePC, _PC_io_in_T_3, _PC_io_in_T_4) @[Mux.scala 101:16]
      PC.io.in <= _PC_io_in_T_5 @[IF.scala 52:14]
    else :
      PC.io.memIO.ready <= UInt<1>("h0") @[IF.scala 57:23]
      PC.io.in <= addr @[IF.scala 58:14]
    instMem.io.memIO.addr <= addr @[IF.scala 61:25]
    instMem.io.memIO.valid <= PC.io.memIO.valid @[IF.scala 62:26]
    node muxOutInst = mux(io.flush, UInt<1>("h0"), instMem.io.memOut) @[IF.scala 64:23]
    node _outReg_inst_T = mux(io.stallReg, outReg.inst, muxOutInst) @[IF.scala 66:21]
    outReg.inst <= _outReg_inst_T @[IF.scala 66:15]
    node _outReg_pc_T = mux(io.stallReg, outReg.pc, addr) @[IF.scala 67:19]
    outReg.pc <= _outReg_pc_T @[IF.scala 67:13]
    io.out.inst <= outReg.inst @[IF.scala 68:15]
    io.out.pc <= outReg.pc @[IF.scala 69:13]

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
    node _immJ_T_2 = mux(_immJ_T_1, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 77:12]
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
    output io : { flip inInst : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, rs1 : UInt<5>, rs2 : UInt<5>, rd : UInt<5>, ctrlSignals : { useImm : UInt<1>, usePC : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}

    wire _io_rs1_WIRE : UInt<5>
    _io_rs1_WIRE <= UInt<5>("h0")
    io.rs1 <= _io_rs1_WIRE @[Decoder.scala 29:10]
    wire _io_rs2_WIRE : UInt<5>
    _io_rs2_WIRE <= UInt<5>("h0")
    io.rs2 <= _io_rs2_WIRE @[Decoder.scala 30:10]
    wire _io_rd_WIRE : UInt<5>
    _io_rd_WIRE <= UInt<5>("h0")
    io.rd <= _io_rd_WIRE @[Decoder.scala 31:9]
    wire _io_memOp_WIRE : UInt<4>
    _io_memOp_WIRE <= UInt<4>("h0")
    io.memOp <= _io_memOp_WIRE @[Decoder.scala 32:12]
    wire _io_ctrlSignals_useImm_WIRE : UInt<1>
    _io_ctrlSignals_useImm_WIRE <= UInt<1>("h0")
    io.ctrlSignals.useImm <= _io_ctrlSignals_useImm_WIRE @[Decoder.scala 33:25]
    wire _io_ctrlSignals_branch_WIRE : UInt<1>
    _io_ctrlSignals_branch_WIRE <= UInt<1>("h0")
    io.ctrlSignals.branch <= _io_ctrlSignals_branch_WIRE @[Decoder.scala 34:25]
    wire _io_ctrlSignals_useALU_WIRE : UInt<1>
    _io_ctrlSignals_useALU_WIRE <= UInt<1>("h0")
    io.ctrlSignals.useALU <= _io_ctrlSignals_useALU_WIRE @[Decoder.scala 35:25]
    wire _io_ctrlSignals_usePC_WIRE : UInt<1>
    _io_ctrlSignals_usePC_WIRE <= UInt<1>("h0")
    io.ctrlSignals.usePC <= _io_ctrlSignals_usePC_WIRE @[Decoder.scala 36:24]
    wire _io_ctrlSignals_jump_WIRE : UInt<1>
    _io_ctrlSignals_jump_WIRE <= UInt<1>("h0")
    io.ctrlSignals.jump <= _io_ctrlSignals_jump_WIRE @[Decoder.scala 37:23]
    wire _io_ctrlSignals_load_WIRE : UInt<1>
    _io_ctrlSignals_load_WIRE <= UInt<1>("h0")
    io.ctrlSignals.load <= _io_ctrlSignals_load_WIRE @[Decoder.scala 38:23]
    wire _io_ctrlSignals_store_WIRE : UInt<1>
    _io_ctrlSignals_store_WIRE <= UInt<1>("h0")
    io.ctrlSignals.store <= _io_ctrlSignals_store_WIRE @[Decoder.scala 39:24]
    wire _io_ctrlSignals_changePC_WIRE : UInt<1>
    _io_ctrlSignals_changePC_WIRE <= UInt<1>("h0")
    io.ctrlSignals.changePC <= _io_ctrlSignals_changePC_WIRE @[Decoder.scala 40:27]
    node _io_aluOp_T = asUInt(UInt<1>("h1")) @[Decoder.scala 41:37]
    wire _io_aluOp_WIRE : UInt
    _io_aluOp_WIRE <= _io_aluOp_T
    io.aluOp <= _io_aluOp_WIRE @[Decoder.scala 41:12]
    node _op_T = bits(io.inInst, 6, 0) @[Decoder.scala 44:34]
    wire _op_WIRE : UInt<7> @[Decoder.scala 44:24]
    _op_WIRE <= _op_T @[Decoder.scala 44:24]
    wire op : UInt<7> @[Decoder.scala 44:24]
    op <= _op_WIRE @[Decoder.scala 44:24]
    node _op_T_1 = eq(op, UInt<2>("h3")) @[Decoder.scala 44:24]
    node _op_T_2 = eq(op, UInt<5>("h13")) @[Decoder.scala 44:24]
    node _op_T_3 = eq(op, UInt<5>("h17")) @[Decoder.scala 44:24]
    node _op_T_4 = eq(op, UInt<6>("h23")) @[Decoder.scala 44:24]
    node _op_T_5 = eq(op, UInt<6>("h33")) @[Decoder.scala 44:24]
    node _op_T_6 = eq(op, UInt<6>("h37")) @[Decoder.scala 44:24]
    node _op_T_7 = eq(op, UInt<7>("h63")) @[Decoder.scala 44:24]
    node _op_T_8 = eq(op, UInt<7>("h67")) @[Decoder.scala 44:24]
    node _op_T_9 = eq(op, UInt<7>("h6f")) @[Decoder.scala 44:24]
    node _op_T_10 = or(_op_T_1, _op_T_2) @[Decoder.scala 44:24]
    node _op_T_11 = or(_op_T_10, _op_T_3) @[Decoder.scala 44:24]
    node _op_T_12 = or(_op_T_11, _op_T_4) @[Decoder.scala 44:24]
    node _op_T_13 = or(_op_T_12, _op_T_5) @[Decoder.scala 44:24]
    node _op_T_14 = or(_op_T_13, _op_T_6) @[Decoder.scala 44:24]
    node _op_T_15 = or(_op_T_14, _op_T_7) @[Decoder.scala 44:24]
    node _op_T_16 = or(_op_T_15, _op_T_8) @[Decoder.scala 44:24]
    node _op_T_17 = or(_op_T_16, _op_T_9) @[Decoder.scala 44:24]
    node funct3 = bits(io.inInst, 14, 12) @[Decoder.scala 45:25]
    node funct7 = bits(io.inInst, 31, 25) @[Decoder.scala 46:25]
    node _T = asUInt(UInt<2>("h3")) @[Decoder.scala 49:14]
    node _T_1 = asUInt(op) @[Decoder.scala 49:14]
    node _T_2 = eq(_T, _T_1) @[Decoder.scala 49:14]
    when _T_2 : @[Decoder.scala 49:14]
      io.ctrlSignals.load <= UInt<1>("h1") @[Decoder.scala 51:27]
      io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 52:29]
      io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 53:29]
      node _io_aluOp_T_1 = asUInt(UInt<1>("h1")) @[Decoder.scala 54:29]
      io.aluOp <= _io_aluOp_T_1 @[Decoder.scala 54:16]
      node _T_3 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 55:21]
      when _T_3 : @[Decoder.scala 55:21]
        io.memOp <= UInt<1>("h0") @[Decoder.scala 57:20]
      else :
        node _T_4 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 55:21]
        when _T_4 : @[Decoder.scala 55:21]
          io.memOp <= UInt<1>("h1") @[Decoder.scala 60:20]
        else :
          node _T_5 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 55:21]
          when _T_5 : @[Decoder.scala 55:21]
            io.memOp <= UInt<2>("h2") @[Decoder.scala 63:20]
    else :
      node _T_6 = asUInt(UInt<5>("h13")) @[Decoder.scala 49:14]
      node _T_7 = asUInt(op) @[Decoder.scala 49:14]
      node _T_8 = eq(_T_6, _T_7) @[Decoder.scala 49:14]
      when _T_8 : @[Decoder.scala 49:14]
        io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 69:29]
        io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 70:29]
        node _T_9 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 71:22]
        when _T_9 : @[Decoder.scala 71:22]
          node _io_aluOp_T_2 = asUInt(UInt<1>("h1")) @[Decoder.scala 73:33]
          io.aluOp <= _io_aluOp_T_2 @[Decoder.scala 73:20]
        else :
          node _T_10 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 71:22]
          when _T_10 : @[Decoder.scala 71:22]
            node _io_aluOp_T_3 = asUInt(UInt<4>("h8")) @[Decoder.scala 76:33]
            io.aluOp <= _io_aluOp_T_3 @[Decoder.scala 76:20]
          else :
            node _T_11 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 71:22]
            when _T_11 : @[Decoder.scala 71:22]
              node _io_aluOp_T_4 = asUInt(UInt<4>("h9")) @[Decoder.scala 79:33]
              io.aluOp <= _io_aluOp_T_4 @[Decoder.scala 79:20]
            else :
              node _T_12 = eq(UInt<2>("h3"), funct3) @[Decoder.scala 71:22]
              when _T_12 : @[Decoder.scala 71:22]
                node _io_aluOp_T_5 = asUInt(UInt<4>("ha")) @[Decoder.scala 82:34]
                io.aluOp <= _io_aluOp_T_5 @[Decoder.scala 82:20]
              else :
                node _T_13 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 71:22]
                when _T_13 : @[Decoder.scala 71:22]
                  node _io_aluOp_T_6 = asUInt(UInt<3>("h4")) @[Decoder.scala 85:32]
                  io.aluOp <= _io_aluOp_T_6 @[Decoder.scala 85:20]
                else :
                  node _T_14 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 71:22]
                  when _T_14 : @[Decoder.scala 71:22]
                    node _io_aluOp_T_7 = asUInt(UInt<2>("h3")) @[Decoder.scala 88:33]
                    io.aluOp <= _io_aluOp_T_7 @[Decoder.scala 88:20]
                  else :
                    node _T_15 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 71:22]
                    when _T_15 : @[Decoder.scala 71:22]
                      node _T_16 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 91:26]
                      when _T_16 : @[Decoder.scala 91:26]
                        node _io_aluOp_T_8 = asUInt(UInt<3>("h6")) @[Decoder.scala 93:37]
                        io.aluOp <= _io_aluOp_T_8 @[Decoder.scala 93:24]
                      else :
                        node _T_17 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 91:26]
                        when _T_17 : @[Decoder.scala 91:26]
                          node _io_aluOp_T_9 = asUInt(UInt<3>("h7")) @[Decoder.scala 96:37]
                          io.aluOp <= _io_aluOp_T_9 @[Decoder.scala 96:24]
                    else :
                      node _T_18 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 71:22]
                      when _T_18 : @[Decoder.scala 71:22]
                        node _io_aluOp_T_10 = asUInt(UInt<3>("h5")) @[Decoder.scala 101:33]
                        io.aluOp <= _io_aluOp_T_10 @[Decoder.scala 101:20]
      else :
        node _T_19 = asUInt(UInt<5>("h17")) @[Decoder.scala 49:14]
        node _T_20 = asUInt(op) @[Decoder.scala 49:14]
        node _T_21 = eq(_T_19, _T_20) @[Decoder.scala 49:14]
        when _T_21 : @[Decoder.scala 49:14]
          io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 106:31]
          io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 107:31]
          io.ctrlSignals.usePC <= UInt<1>("h1") @[Decoder.scala 108:30]
        else :
          node _T_22 = asUInt(UInt<6>("h23")) @[Decoder.scala 49:14]
          node _T_23 = asUInt(op) @[Decoder.scala 49:14]
          node _T_24 = eq(_T_22, _T_23) @[Decoder.scala 49:14]
          when _T_24 : @[Decoder.scala 49:14]
            io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 112:31]
            io.ctrlSignals.store <= UInt<1>("h1") @[Decoder.scala 113:30]
            io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 114:31]
            node _T_25 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 115:24]
            when _T_25 : @[Decoder.scala 115:24]
              io.memOp <= UInt<1>("h0") @[Decoder.scala 117:22]
            else :
              node _T_26 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 115:24]
              when _T_26 : @[Decoder.scala 115:24]
                io.memOp <= UInt<1>("h1") @[Decoder.scala 120:22]
              else :
                node _T_27 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 115:24]
                when _T_27 : @[Decoder.scala 115:24]
                  io.memOp <= UInt<2>("h2") @[Decoder.scala 123:22]
          else :
            node _T_28 = asUInt(UInt<6>("h33")) @[Decoder.scala 49:14]
            node _T_29 = asUInt(op) @[Decoder.scala 49:14]
            node _T_30 = eq(_T_28, _T_29) @[Decoder.scala 49:14]
            when _T_30 : @[Decoder.scala 49:14]
              io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 129:31]
              node _T_31 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 130:24]
              when _T_31 : @[Decoder.scala 130:24]
                node _T_32 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 132:28]
                when _T_32 : @[Decoder.scala 132:28]
                  node _io_aluOp_T_11 = asUInt(UInt<1>("h1")) @[Decoder.scala 134:39]
                  io.aluOp <= _io_aluOp_T_11 @[Decoder.scala 134:26]
                else :
                  node _T_33 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 132:28]
                  when _T_33 : @[Decoder.scala 132:28]
                    node _io_aluOp_T_12 = asUInt(UInt<2>("h2")) @[Decoder.scala 137:39]
                    io.aluOp <= _io_aluOp_T_12 @[Decoder.scala 137:26]
              else :
                node _T_34 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 130:24]
                when _T_34 : @[Decoder.scala 130:24]
                  node _io_aluOp_T_13 = asUInt(UInt<4>("h8")) @[Decoder.scala 142:35]
                  io.aluOp <= _io_aluOp_T_13 @[Decoder.scala 142:22]
                else :
                  node _T_35 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 130:24]
                  when _T_35 : @[Decoder.scala 130:24]
                    node _io_aluOp_T_14 = asUInt(UInt<4>("h9")) @[Decoder.scala 145:35]
                    io.aluOp <= _io_aluOp_T_14 @[Decoder.scala 145:22]
                  else :
                    node _T_36 = eq(UInt<2>("h3"), funct3) @[Decoder.scala 130:24]
                    when _T_36 : @[Decoder.scala 130:24]
                      node _io_aluOp_T_15 = asUInt(UInt<4>("ha")) @[Decoder.scala 148:36]
                      io.aluOp <= _io_aluOp_T_15 @[Decoder.scala 148:22]
                    else :
                      node _T_37 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 130:24]
                      when _T_37 : @[Decoder.scala 130:24]
                        node _io_aluOp_T_16 = asUInt(UInt<3>("h5")) @[Decoder.scala 151:35]
                        io.aluOp <= _io_aluOp_T_16 @[Decoder.scala 151:22]
                      else :
                        node _T_38 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 130:24]
                        when _T_38 : @[Decoder.scala 130:24]
                          node _T_39 = eq(UInt<6>("h20"), funct7) @[Decoder.scala 154:28]
                          when _T_39 : @[Decoder.scala 154:28]
                            node _io_aluOp_T_17 = asUInt(UInt<3>("h6")) @[Decoder.scala 156:39]
                            io.aluOp <= _io_aluOp_T_17 @[Decoder.scala 156:26]
                          else :
                            node _T_40 = eq(UInt<1>("h0"), funct7) @[Decoder.scala 154:28]
                            when _T_40 : @[Decoder.scala 154:28]
                              node _io_aluOp_T_18 = asUInt(UInt<3>("h7")) @[Decoder.scala 159:39]
                              io.aluOp <= _io_aluOp_T_18 @[Decoder.scala 159:26]
                        else :
                          node _T_41 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 130:24]
                          when _T_41 : @[Decoder.scala 130:24]
                            node _io_aluOp_T_19 = asUInt(UInt<3>("h4")) @[Decoder.scala 164:34]
                            io.aluOp <= _io_aluOp_T_19 @[Decoder.scala 164:22]
                          else :
                            node _T_42 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 130:24]
                            when _T_42 : @[Decoder.scala 130:24]
                              node _io_aluOp_T_20 = asUInt(UInt<2>("h3")) @[Decoder.scala 167:35]
                              io.aluOp <= _io_aluOp_T_20 @[Decoder.scala 167:22]
            else :
              node _T_43 = asUInt(UInt<6>("h37")) @[Decoder.scala 49:14]
              node _T_44 = asUInt(op) @[Decoder.scala 49:14]
              node _T_45 = eq(_T_43, _T_44) @[Decoder.scala 49:14]
              when _T_45 : @[Decoder.scala 49:14]
                io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 173:31]
                io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 174:31]
              else :
                node _T_46 = asUInt(UInt<7>("h63")) @[Decoder.scala 49:14]
                node _T_47 = asUInt(op) @[Decoder.scala 49:14]
                node _T_48 = eq(_T_46, _T_47) @[Decoder.scala 49:14]
                when _T_48 : @[Decoder.scala 49:14]
                  io.ctrlSignals.branch <= UInt<1>("h1") @[Decoder.scala 177:31]
                  io.ctrlSignals.useALU <= UInt<1>("h1") @[Decoder.scala 178:31]
                  node _T_49 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 179:23]
                  when _T_49 : @[Decoder.scala 179:23]
                    node _io_aluOp_T_21 = asUInt(UInt<4>("hb")) @[Decoder.scala 181:35]
                    io.aluOp <= _io_aluOp_T_21 @[Decoder.scala 181:22]
                  else :
                    node _T_50 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 179:23]
                    when _T_50 : @[Decoder.scala 179:23]
                      node _io_aluOp_T_22 = asUInt(UInt<1>("h0")) @[Decoder.scala 184:35]
                      io.aluOp <= _io_aluOp_T_22 @[Decoder.scala 184:22]
                    else :
                      node _T_51 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 179:23]
                      when _T_51 : @[Decoder.scala 179:23]
                        node _io_aluOp_T_23 = asUInt(UInt<4>("hc")) @[Decoder.scala 187:35]
                        io.aluOp <= _io_aluOp_T_23 @[Decoder.scala 187:22]
                      else :
                        node _T_52 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 179:23]
                        when _T_52 : @[Decoder.scala 179:23]
                          node _io_aluOp_T_24 = asUInt(UInt<4>("hd")) @[Decoder.scala 190:35]
                          io.aluOp <= _io_aluOp_T_24 @[Decoder.scala 190:22]
                        else :
                          node _T_53 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 179:23]
                          when _T_53 : @[Decoder.scala 179:23]
                            node _io_aluOp_T_25 = asUInt(UInt<4>("he")) @[Decoder.scala 193:36]
                            io.aluOp <= _io_aluOp_T_25 @[Decoder.scala 193:22]
                          else :
                            node _T_54 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 179:23]
                            when _T_54 : @[Decoder.scala 179:23]
                              node _io_aluOp_T_26 = asUInt(UInt<4>("hf")) @[Decoder.scala 196:36]
                              io.aluOp <= _io_aluOp_T_26 @[Decoder.scala 196:22]
                else :
                  node _T_55 = asUInt(UInt<7>("h67")) @[Decoder.scala 49:14]
                  node _T_56 = asUInt(op) @[Decoder.scala 49:14]
                  node _T_57 = eq(_T_55, _T_56) @[Decoder.scala 49:14]
                  when _T_57 : @[Decoder.scala 49:14]
                    io.ctrlSignals.jump <= UInt<1>("h1") @[Decoder.scala 201:29]
                    io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 202:31]
                    io.ctrlSignals.changePC <= UInt<1>("h1") @[Decoder.scala 203:33]
                  else :
                    node _T_58 = asUInt(UInt<7>("h6f")) @[Decoder.scala 49:14]
                    node _T_59 = asUInt(op) @[Decoder.scala 49:14]
                    node _T_60 = eq(_T_58, _T_59) @[Decoder.scala 49:14]
                    when _T_60 : @[Decoder.scala 49:14]
                      io.ctrlSignals.jump <= UInt<1>("h1") @[Decoder.scala 206:29]
                      io.ctrlSignals.useImm <= UInt<1>("h1") @[Decoder.scala 207:31]
    node _io_rs1_T = eq(op, UInt<7>("h6f")) @[Decoder.scala 212:22]
    node _io_rs1_T_1 = eq(op, UInt<6>("h37")) @[Decoder.scala 212:39]
    node _io_rs1_T_2 = or(_io_rs1_T, _io_rs1_T_1) @[Decoder.scala 212:33]
    node _io_rs1_T_3 = eq(op, UInt<5>("h17")) @[Decoder.scala 212:56]
    node _io_rs1_T_4 = or(_io_rs1_T_2, _io_rs1_T_3) @[Decoder.scala 212:50]
    node _io_rs1_T_5 = bits(io.inInst, 19, 15) @[Decoder.scala 212:84]
    node _io_rs1_T_6 = mux(_io_rs1_T_4, UInt<1>("h0"), _io_rs1_T_5) @[Decoder.scala 212:18]
    io.rs1 <= _io_rs1_T_6 @[Decoder.scala 212:12]
    node _io_rs2_T = eq(op, UInt<7>("h6f")) @[Decoder.scala 213:22]
    node _io_rs2_T_1 = eq(op, UInt<6>("h37")) @[Decoder.scala 213:39]
    node _io_rs2_T_2 = or(_io_rs2_T, _io_rs2_T_1) @[Decoder.scala 213:33]
    node _io_rs2_T_3 = eq(op, UInt<5>("h17")) @[Decoder.scala 213:56]
    node _io_rs2_T_4 = or(_io_rs2_T_2, _io_rs2_T_3) @[Decoder.scala 213:50]
    node _io_rs2_T_5 = eq(op, UInt<2>("h3")) @[Decoder.scala 213:75]
    node _io_rs2_T_6 = or(_io_rs2_T_4, _io_rs2_T_5) @[Decoder.scala 213:69]
    node _io_rs2_T_7 = bits(io.inInst, 24, 20) @[Decoder.scala 213:100]
    node _io_rs2_T_8 = mux(_io_rs2_T_6, UInt<1>("h0"), _io_rs2_T_7) @[Decoder.scala 213:18]
    io.rs2 <= _io_rs2_T_8 @[Decoder.scala 213:12]
    node _io_rd_T = bits(io.inInst, 11, 7) @[Decoder.scala 214:23]
    io.rd <= _io_rd_T @[Decoder.scala 214:11]

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
    wire _registers_WIRE : UInt<32>[32] @[RegisterFile.scala 26:34]
    _registers_WIRE[0] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[1] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[2] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[3] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[4] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[5] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[6] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[7] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[8] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[9] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[10] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[11] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[12] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[13] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[14] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[15] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[16] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[17] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[18] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[19] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[20] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[21] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[22] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[23] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[24] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[25] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[26] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[27] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[28] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[29] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[30] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    _registers_WIRE[31] <= UInt<32>("h0") @[RegisterFile.scala 26:34]
    reg registers : UInt<32>[32], clock with :
      reset => (reset, _registers_WIRE) @[RegisterFile.scala 26:26]
    node _T = eq(io.rdAddr1, UInt<1>("h0")) @[RegisterFile.scala 28:19]
    when _T : @[RegisterFile.scala 28:28]
      io.rdData1 <= UInt<1>("h0") @[RegisterFile.scala 29:16]
    else :
      io.rdData1 <= registers[io.rdAddr1] @[RegisterFile.scala 32:18]
    node _T_1 = eq(io.rdAddr2, UInt<1>("h0")) @[RegisterFile.scala 34:19]
    when _T_1 : @[RegisterFile.scala 34:28]
      io.rdData2 <= UInt<1>("h0") @[RegisterFile.scala 35:16]
    else :
      io.rdData2 <= registers[io.rdAddr2] @[RegisterFile.scala 38:18]
    when io.wren : @[RegisterFile.scala 41:17]
      registers[io.wrAddr] <= io.wrData @[RegisterFile.scala 42:26]

  module ID :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip flush : UInt<1>, flip in : { inst : UInt<32>, pc : UInt<32>}, flip wbIn : { rd : UInt<5>, muxOut : UInt<32>, writeEnable : UInt<1>}, out : { pc : UInt<32>, rs1 : UInt<5>, rs2 : UInt<5>, val1 : UInt<32>, val2 : UInt<32>, rd : UInt<5>, imm : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, ctrl : { useImm : UInt<1>, usePC : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}}

    inst immGenerator of ImmGenerator @[ID.scala 19:28]
    immGenerator.clock <= clock
    immGenerator.reset <= reset
    inst decoder of Decoder @[ID.scala 20:23]
    decoder.clock <= clock
    decoder.reset <= reset
    inst regfile of RegisterFile @[ID.scala 21:23]
    regfile.clock <= clock
    regfile.reset <= reset
    wire _regfile_io_wren_WIRE : UInt<1>
    _regfile_io_wren_WIRE <= UInt<1>("h0")
    regfile.io.wren <= _regfile_io_wren_WIRE @[ID.scala 24:19]
    wire _regfile_io_wrAddr_WIRE : UInt<5>
    _regfile_io_wrAddr_WIRE <= UInt<5>("h0")
    regfile.io.wrAddr <= _regfile_io_wrAddr_WIRE @[ID.scala 25:21]
    wire _regfile_io_wrData_WIRE : UInt<32>
    _regfile_io_wrData_WIRE <= UInt<32>("h0")
    regfile.io.wrData <= _regfile_io_wrData_WIRE @[ID.scala 26:21]
    wire _decoder_io_inInst_WIRE : UInt<32>
    _decoder_io_inInst_WIRE <= UInt<32>("h0")
    decoder.io.inInst <= _decoder_io_inInst_WIRE @[ID.scala 27:21]
    immGenerator.io.immIn <= io.in.inst @[ID.scala 38:25]
    decoder.io.inInst <= io.in.inst @[ID.scala 39:21]
    regfile.io.rdAddr1 <= decoder.io.rs1 @[ID.scala 40:22]
    regfile.io.rdAddr2 <= decoder.io.rs2 @[ID.scala 41:22]
    regfile.io.wren <= io.wbIn.writeEnable @[ID.scala 43:19]
    regfile.io.wrAddr <= io.wbIn.rd @[ID.scala 44:21]
    regfile.io.wrData <= io.wbIn.muxOut @[ID.scala 45:21]
    node _io_out_ctrl_branch_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.branch) @[ID.scala 49:36]
    reg io_out_ctrl_branch_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_branch_REG) @[ID.scala 49:32]
    io_out_ctrl_branch_REG <= _io_out_ctrl_branch_T @[ID.scala 49:32]
    io.out.ctrl.branch <= io_out_ctrl_branch_REG @[ID.scala 49:22]
    node _io_out_ctrl_load_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.load) @[ID.scala 50:34]
    reg io_out_ctrl_load_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_load_REG) @[ID.scala 50:30]
    io_out_ctrl_load_REG <= _io_out_ctrl_load_T @[ID.scala 50:30]
    io.out.ctrl.load <= io_out_ctrl_load_REG @[ID.scala 50:20]
    node _io_out_ctrl_store_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.store) @[ID.scala 51:35]
    reg io_out_ctrl_store_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_store_REG) @[ID.scala 51:31]
    io_out_ctrl_store_REG <= _io_out_ctrl_store_T @[ID.scala 51:31]
    io.out.ctrl.store <= io_out_ctrl_store_REG @[ID.scala 51:21]
    node _io_out_ctrl_jump_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.jump) @[ID.scala 52:34]
    reg io_out_ctrl_jump_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_jump_REG) @[ID.scala 52:30]
    io_out_ctrl_jump_REG <= _io_out_ctrl_jump_T @[ID.scala 52:30]
    io.out.ctrl.jump <= io_out_ctrl_jump_REG @[ID.scala 52:20]
    node _io_out_ctrl_useALU_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.useALU) @[ID.scala 53:36]
    reg io_out_ctrl_useALU_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_useALU_REG) @[ID.scala 53:32]
    io_out_ctrl_useALU_REG <= _io_out_ctrl_useALU_T @[ID.scala 53:32]
    io.out.ctrl.useALU <= io_out_ctrl_useALU_REG @[ID.scala 53:22]
    node _io_out_ctrl_usePC_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.usePC) @[ID.scala 54:35]
    reg io_out_ctrl_usePC_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_usePC_REG) @[ID.scala 54:31]
    io_out_ctrl_usePC_REG <= _io_out_ctrl_usePC_T @[ID.scala 54:31]
    io.out.ctrl.usePC <= io_out_ctrl_usePC_REG @[ID.scala 54:21]
    node _io_out_ctrl_useImm_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.useImm) @[ID.scala 55:36]
    reg io_out_ctrl_useImm_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_useImm_REG) @[ID.scala 55:32]
    io_out_ctrl_useImm_REG <= _io_out_ctrl_useImm_T @[ID.scala 55:32]
    io.out.ctrl.useImm <= io_out_ctrl_useImm_REG @[ID.scala 55:22]
    node _io_out_ctrl_changePC_T = mux(io.flush, UInt<1>("h0"), decoder.io.ctrlSignals.changePC) @[ID.scala 56:38]
    reg io_out_ctrl_changePC_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_out_ctrl_changePC_REG) @[ID.scala 56:34]
    io_out_ctrl_changePC_REG <= _io_out_ctrl_changePC_T @[ID.scala 56:34]
    io.out.ctrl.changePC <= io_out_ctrl_changePC_REG @[ID.scala 56:24]
    node _val1_T = eq(io.wbIn.rd, decoder.io.rs1) @[ID.scala 67:52]
    node _val1_T_1 = and(io.wbIn.writeEnable, _val1_T) @[ID.scala 67:38]
    node val1 = mux(_val1_T_1, io.wbIn.muxOut, regfile.io.rdData1) @[ID.scala 67:17]
    node _val2_T = eq(io.wbIn.rd, decoder.io.rs2) @[ID.scala 68:52]
    node _val2_T_1 = and(io.wbIn.writeEnable, _val2_T) @[ID.scala 68:38]
    node val2 = mux(_val2_T_1, io.wbIn.muxOut, regfile.io.rdData2) @[ID.scala 68:17]
    node _io_out_aluOp_T = mux(io.flush, UInt<1>("h0"), decoder.io.aluOp) @[ID.scala 80:32]
    node _io_out_aluOp_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 80:67]
    reg io_out_aluOp_r : UInt<4>, clock with :
      reset => (UInt<1>("h0"), io_out_aluOp_r) @[Reg.scala 19:16]
    when _io_out_aluOp_T_1 : @[Reg.scala 20:18]
      io_out_aluOp_r <= _io_out_aluOp_T @[Reg.scala 20:22]
    io.out.aluOp <= io_out_aluOp_r @[ID.scala 80:16]
    node _io_out_rd_T = mux(io.flush, UInt<1>("h0"), decoder.io.rd) @[ID.scala 81:29]
    node _io_out_rd_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 81:61]
    reg io_out_rd_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rd_r) @[Reg.scala 19:16]
    when _io_out_rd_T_1 : @[Reg.scala 20:18]
      io_out_rd_r <= _io_out_rd_T @[Reg.scala 20:22]
    io.out.rd <= io_out_rd_r @[ID.scala 81:13]
    node _io_out_val1_T = mux(io.flush, UInt<1>("h0"), val1) @[ID.scala 82:31]
    node _io_out_val1_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 82:54]
    reg io_out_val1_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_val1_r) @[Reg.scala 19:16]
    when _io_out_val1_T_1 : @[Reg.scala 20:18]
      io_out_val1_r <= _io_out_val1_T @[Reg.scala 20:22]
    io.out.val1 <= io_out_val1_r @[ID.scala 82:15]
    node _io_out_val2_T = mux(io.flush, UInt<1>("h0"), val2) @[ID.scala 83:31]
    node _io_out_val2_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 83:54]
    reg io_out_val2_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_val2_r) @[Reg.scala 19:16]
    when _io_out_val2_T_1 : @[Reg.scala 20:18]
      io_out_val2_r <= _io_out_val2_T @[Reg.scala 20:22]
    io.out.val2 <= io_out_val2_r @[ID.scala 83:15]
    node _io_out_imm_T = mux(io.flush, UInt<1>("h0"), immGenerator.io.immOut) @[ID.scala 84:30]
    node _io_out_imm_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 84:71]
    reg io_out_imm_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_imm_r) @[Reg.scala 19:16]
    when _io_out_imm_T_1 : @[Reg.scala 20:18]
      io_out_imm_r <= _io_out_imm_T @[Reg.scala 20:22]
    io.out.imm <= io_out_imm_r @[ID.scala 84:14]
    node _io_out_pc_T = mux(io.flush, UInt<1>("h0"), io.in.pc) @[ID.scala 85:29]
    node _io_out_pc_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 85:56]
    reg io_out_pc_r : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_out_pc_r) @[Reg.scala 19:16]
    when _io_out_pc_T_1 : @[Reg.scala 20:18]
      io_out_pc_r <= _io_out_pc_T @[Reg.scala 20:22]
    io.out.pc <= io_out_pc_r @[ID.scala 85:13]
    node _io_out_rs1_T = mux(io.flush, UInt<1>("h0"), decoder.io.rs1) @[ID.scala 86:30]
    node _io_out_rs1_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 86:63]
    reg io_out_rs1_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rs1_r) @[Reg.scala 19:16]
    when _io_out_rs1_T_1 : @[Reg.scala 20:18]
      io_out_rs1_r <= _io_out_rs1_T @[Reg.scala 20:22]
    io.out.rs1 <= io_out_rs1_r @[ID.scala 86:14]
    node _io_out_rs2_T = mux(io.flush, UInt<1>("h0"), decoder.io.rs2) @[ID.scala 87:30]
    node _io_out_rs2_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 87:63]
    reg io_out_rs2_r : UInt<5>, clock with :
      reset => (UInt<1>("h0"), io_out_rs2_r) @[Reg.scala 19:16]
    when _io_out_rs2_T_1 : @[Reg.scala 20:18]
      io_out_rs2_r <= _io_out_rs2_T @[Reg.scala 20:22]
    io.out.rs2 <= io_out_rs2_r @[ID.scala 87:14]
    node _io_out_memOp_T = mux(io.flush, UInt<1>("h0"), decoder.io.memOp) @[ID.scala 88:32]
    node _io_out_memOp_T_1 = eq(io.stallReg, UInt<1>("h0")) @[ID.scala 88:67]
    reg io_out_memOp_r : UInt<4>, clock with :
      reset => (UInt<1>("h0"), io_out_memOp_r) @[Reg.scala 19:16]
    when _io_out_memOp_T_1 : @[Reg.scala 20:18]
      io_out_memOp_r <= _io_out_memOp_T @[Reg.scala 20:22]
    io.out.memOp <= io_out_memOp_r @[ID.scala 88:16]

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
    output io : { flip stallReg : UInt<1>, flip in : { pc : UInt<32>, rs1 : UInt<5>, rs2 : UInt<5>, val1 : UInt<32>, val2 : UInt<32>, rd : UInt<5>, imm : UInt<32>, aluOp : UInt<4>, memOp : UInt<4>, ctrl : { useImm : UInt<1>, usePC : UInt<1>, useALU : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>}}, out : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, memOp : UInt<4>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, hazardAluOut : UInt<32>, changePC : UInt<1>, newPCValue : UInt<32>}

    inst ALU of ALU @[EX.scala 20:19]
    ALU.clock <= clock
    ALU.reset <= reset
    node _outReg_T = eq(io.stallReg, UInt<1>("h0")) @[EX.scala 23:34]
    reg outReg : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, memOp : UInt<4>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, clock with :
      reset => (UInt<1>("h0"), outReg) @[Reg.scala 19:16]
    when _outReg_T : @[Reg.scala 20:18]
      outReg.ctrl.load <= io.out.ctrl.load @[Reg.scala 20:22]
      outReg.ctrl.store <= io.out.ctrl.store @[Reg.scala 20:22]
      outReg.ctrl.writeEnable <= io.out.ctrl.writeEnable @[Reg.scala 20:22]
      outReg.memOp <= io.out.memOp @[Reg.scala 20:22]
      outReg.wrData <= io.out.wrData @[Reg.scala 20:22]
      outReg.aluOut <= io.out.aluOut @[Reg.scala 20:22]
      outReg.rd <= io.out.rd @[Reg.scala 20:22]
    wire _io_hazardAluOut_WIRE : UInt
    _io_hazardAluOut_WIRE <= ALU.io.aluOut
    io.hazardAluOut <= _io_hazardAluOut_WIRE @[EX.scala 24:19]
    wire _ALU_io_val1_WIRE : UInt<32>
    _ALU_io_val1_WIRE <= UInt<32>("h0")
    ALU.io.val1 <= _ALU_io_val1_WIRE @[EX.scala 25:15]
    wire _ALU_io_val2_WIRE : UInt<32>
    _ALU_io_val2_WIRE <= UInt<32>("h0")
    ALU.io.val2 <= _ALU_io_val2_WIRE @[EX.scala 26:15]
    ALU.io.aluOp <= io.in.aluOp @[EX.scala 28:16]
    node _outReg_aluOut_T = add(io.in.pc, UInt<3>("h4")) @[EX.scala 29:50]
    node _outReg_aluOut_T_1 = tail(_outReg_aluOut_T, 1) @[EX.scala 29:50]
    node _outReg_aluOut_T_2 = mux(io.in.ctrl.jump, _outReg_aluOut_T_1, ALU.io.aluOut) @[EX.scala 29:23]
    outReg.aluOut <= _outReg_aluOut_T_2 @[EX.scala 29:17]
    outReg.ctrl.load <= io.in.ctrl.load @[EX.scala 30:20]
    outReg.ctrl.store <= io.in.ctrl.store @[EX.scala 31:21]
    outReg.rd <= io.in.rd @[EX.scala 32:13]
    node _outReg_ctrl_writeEnable_T = or(io.in.ctrl.branch, io.in.ctrl.store) @[EX.scala 33:50]
    node _outReg_ctrl_writeEnable_T_1 = eq(_outReg_ctrl_writeEnable_T, UInt<1>("h0")) @[EX.scala 33:30]
    outReg.ctrl.writeEnable <= _outReg_ctrl_writeEnable_T_1 @[EX.scala 33:27]
    outReg.memOp <= io.in.memOp @[EX.scala 34:16]
    node usePC = mux(io.in.ctrl.usePC, io.in.pc, io.in.val1) @[EX.scala 37:18]
    node useImm = mux(io.in.ctrl.useImm, io.in.imm, io.in.val2) @[EX.scala 38:19]
    node _changePC_T = eq(ALU.io.aluOut, UInt<1>("h1")) @[EX.scala 41:73]
    node _changePC_T_1 = and(io.in.ctrl.branch, _changePC_T) @[EX.scala 41:56]
    node changePC = or(io.in.ctrl.jump, _changePC_T_1) @[EX.scala 41:34]
    node _newPCValue_T = asSInt(io.in.val1) @[EX.scala 42:61]
    node _newPCValue_T_1 = asSInt(io.in.pc) @[EX.scala 42:78]
    node _newPCValue_T_2 = mux(io.in.ctrl.changePC, _newPCValue_T, _newPCValue_T_1) @[EX.scala 42:28]
    node _newPCValue_T_3 = asSInt(io.in.imm) @[EX.scala 42:98]
    node _newPCValue_T_4 = add(_newPCValue_T_2, _newPCValue_T_3) @[EX.scala 42:86]
    node _newPCValue_T_5 = tail(_newPCValue_T_4, 1) @[EX.scala 42:86]
    node _newPCValue_T_6 = asSInt(_newPCValue_T_5) @[EX.scala 42:86]
    node _newPCValue_T_7 = bits(_newPCValue_T_6, 31, 1) @[EX.scala 42:105]
    node newPCValue = cat(_newPCValue_T_7, UInt<1>("h0")) @[Cat.scala 33:92]
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
    node _T_5 = eq(io.in.memOp, UInt<2>("h2")) @[EX.scala 62:20]
    when _T_5 : @[EX.scala 62:27]
      outReg.wrData <= io.in.val2 @[EX.scala 63:19]
    node _T_6 = eq(io.in.memOp, UInt<1>("h1")) @[EX.scala 65:20]
    when _T_6 : @[EX.scala 65:27]
      node _outReg_wrData_T_16 = mux(UInt<1>("h0"), UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_17 = bits(io.in.val2, 15, 0) @[EX.scala 66:50]
      node _outReg_wrData_T_18 = cat(_outReg_wrData_T_16, _outReg_wrData_T_17) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_18 @[EX.scala 66:19]
    node _T_7 = eq(io.in.memOp, UInt<1>("h0")) @[EX.scala 68:20]
    when _T_7 : @[EX.scala 68:28]
      node _outReg_wrData_T_19 = mux(UInt<1>("h0"), UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
      node _outReg_wrData_T_20 = bits(io.in.val2, 7, 0) @[EX.scala 69:50]
      node _outReg_wrData_T_21 = cat(_outReg_wrData_T_19, _outReg_wrData_T_20) @[Cat.scala 33:92]
      outReg.wrData <= _outReg_wrData_T_21 @[EX.scala 69:19]
    when io.in.ctrl.useALU : @[EX.scala 72:27]
      ALU.io.val1 <= usePC @[EX.scala 73:17]
      ALU.io.val2 <= useImm @[EX.scala 74:17]
    io.out.aluOut <= outReg.aluOut @[EX.scala 78:17]
    io.out.ctrl.load <= outReg.ctrl.load @[EX.scala 79:20]
    io.out.ctrl.store <= outReg.ctrl.store @[EX.scala 80:21]
    io.out.ctrl.writeEnable <= outReg.ctrl.writeEnable @[EX.scala 81:27]
    io.out.rd <= outReg.rd @[EX.scala 82:13]
    io.out.wrData <= outReg.wrData @[EX.scala 83:17]
    io.out.memOp <= outReg.memOp @[EX.scala 84:16]
    reg io_changePC_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_changePC_REG) @[EX.scala 85:25]
    io_changePC_REG <= changePC @[EX.scala 85:25]
    io.changePC <= io_changePC_REG @[EX.scala 85:15]
    reg io_newPCValue_REG : UInt, clock with :
      reset => (UInt<1>("h0"), io_newPCValue_REG) @[EX.scala 86:27]
    io_newPCValue_REG <= newPCValue @[EX.scala 86:27]
    io.newPCValue <= io_newPCValue_REG @[EX.scala 86:17]

  module SyncBankMemory :
    input clock : Clock
    input reset : Reset
    output io : { flip rden : UInt<1>, flip rdAddr1 : UInt<10>, rdData1 : UInt<32>, flip rdAddr2 : UInt<10>, rdData2 : UInt<32>, flip wrAddr : UInt<10>, flip wrData : UInt<32>, flip wren : UInt<1>, flip memOp : UInt<4>}

    wire _io_rdData1_WIRE : UInt<32>
    _io_rdData1_WIRE <= UInt<32>("h0")
    io.rdData1 <= _io_rdData1_WIRE @[SyncBankMemory.scala 33:14]
    wire _io_rdData2_WIRE : UInt<32>
    _io_rdData2_WIRE <= UInt<32>("h0")
    io.rdData2 <= _io_rdData2_WIRE @[SyncBankMemory.scala 34:14]
    wire rdData1 : UInt<8>[4]
    rdData1[0] is invalid
    rdData1[1] is invalid
    rdData1[2] is invalid
    rdData1[3] is invalid
    wire rdData2 : UInt<8>[4]
    rdData2[0] is invalid
    rdData2[1] is invalid
    rdData2[2] is invalid
    rdData2[3] is invalid
    wire readAddress1 : UInt<10>
    readAddress1 <= UInt<10>("h0")
    wire readAddress2 : UInt<10>
    readAddress2 <= UInt<10>("h0")
    wire writeAddress : UInt<10>
    writeAddress <= UInt<10>("h0")
    wire memMask : UInt<1>[4] @[SyncBankMemory.scala 40:24]
    memMask[0] <= UInt<1>("h0") @[SyncBankMemory.scala 40:24]
    memMask[1] <= UInt<1>("h0") @[SyncBankMemory.scala 40:24]
    memMask[2] <= UInt<1>("h0") @[SyncBankMemory.scala 40:24]
    memMask[3] <= UInt<1>("h0") @[SyncBankMemory.scala 40:24]
    node _wrData_T = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 41:33]
    node _wrData_T_1 = bits(io.wrData, 15, 8) @[SyncBankMemory.scala 41:50]
    node _wrData_T_2 = bits(io.wrData, 23, 16) @[SyncBankMemory.scala 41:68]
    node _wrData_T_3 = bits(io.wrData, 31, 24) @[SyncBankMemory.scala 41:87]
    wire wrData : UInt<8>[4] @[SyncBankMemory.scala 41:23]
    wrData[0] <= _wrData_T @[SyncBankMemory.scala 41:23]
    wrData[1] <= _wrData_T_1 @[SyncBankMemory.scala 41:23]
    wrData[2] <= _wrData_T_2 @[SyncBankMemory.scala 41:23]
    wrData[3] <= _wrData_T_3 @[SyncBankMemory.scala 41:23]
    wire vecIndexWr : UInt<10>
    vecIndexWr <= UInt<10>("h0")
    reg vecIndexRd1 : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[SyncBankMemory.scala 43:28]
    reg vecIndexRd2 : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[SyncBankMemory.scala 44:28]
    node _vecIndexWr_T = rem(io.wrAddr, UInt<3>("h4")) @[SyncBankMemory.scala 47:27]
    vecIndexWr <= _vecIndexWr_T @[SyncBankMemory.scala 47:14]
    node _vecIndexRd1_T = rem(io.rdAddr1, UInt<3>("h4")) @[SyncBankMemory.scala 48:29]
    vecIndexRd1 <= _vecIndexRd1_T @[SyncBankMemory.scala 48:15]
    node _vecIndexRd2_T = rem(io.rdAddr2, UInt<3>("h4")) @[SyncBankMemory.scala 49:29]
    vecIndexRd2 <= _vecIndexRd2_T @[SyncBankMemory.scala 49:15]
    node _T = eq(io.memOp, UInt<1>("h0")) @[SyncBankMemory.scala 52:14]
    node _T_1 = eq(io.memOp, UInt<1>("h0")) @[SyncBankMemory.scala 53:16]
    node _T_2 = or(_T, _T_1) @[SyncBankMemory.scala 52:28]
    node _T_3 = eq(io.memOp, UInt<3>("h4")) @[SyncBankMemory.scala 54:16]
    node _T_4 = or(_T_2, _T_3) @[SyncBankMemory.scala 53:30]
    when _T_4 : @[SyncBankMemory.scala 55:5]
      node _T_5 = bits(vecIndexWr, 1, 0)
      memMask[_T_5] <= UInt<1>("h1") @[SyncBankMemory.scala 57:25]
      node _wrData_0_T = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 59:27]
      wrData[0] <= _wrData_0_T @[SyncBankMemory.scala 59:15]
      node _wrData_1_T = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 60:27]
      wrData[1] <= _wrData_1_T @[SyncBankMemory.scala 60:15]
      node _wrData_2_T = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 61:27]
      wrData[2] <= _wrData_2_T @[SyncBankMemory.scala 61:15]
      node _wrData_3_T = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 62:27]
      wrData[3] <= _wrData_3_T @[SyncBankMemory.scala 62:15]
    else :
      node _T_6 = eq(io.memOp, UInt<1>("h1")) @[SyncBankMemory.scala 65:16]
      node _T_7 = eq(io.memOp, UInt<1>("h1")) @[SyncBankMemory.scala 66:18]
      node _T_8 = or(_T_6, _T_7) @[SyncBankMemory.scala 65:30]
      node _T_9 = eq(io.memOp, UInt<3>("h5")) @[SyncBankMemory.scala 67:18]
      node _T_10 = or(_T_8, _T_9) @[SyncBankMemory.scala 66:32]
      when _T_10 : @[SyncBankMemory.scala 68:7]
        node _T_11 = bits(vecIndexWr, 1, 0)
        memMask[_T_11] <= UInt<1>("h1") @[SyncBankMemory.scala 70:27]
        node _T_12 = add(vecIndexWr, UInt<1>("h1")) @[SyncBankMemory.scala 71:26]
        node _T_13 = tail(_T_12, 1) @[SyncBankMemory.scala 71:26]
        node _T_14 = bits(_T_13, 1, 0)
        memMask[_T_14] <= UInt<1>("h1") @[SyncBankMemory.scala 71:33]
        node _wrData_0_T_1 = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 73:29]
        wrData[0] <= _wrData_0_T_1 @[SyncBankMemory.scala 73:17]
        node _wrData_1_T_1 = bits(io.wrData, 15, 8) @[SyncBankMemory.scala 74:29]
        wrData[1] <= _wrData_1_T_1 @[SyncBankMemory.scala 74:17]
        node _wrData_2_T_1 = bits(io.wrData, 7, 0) @[SyncBankMemory.scala 75:29]
        wrData[2] <= _wrData_2_T_1 @[SyncBankMemory.scala 75:17]
        node _wrData_3_T_1 = bits(io.wrData, 15, 8) @[SyncBankMemory.scala 76:29]
        wrData[3] <= _wrData_3_T_1 @[SyncBankMemory.scala 76:17]
      else :
        memMask[0] <= UInt<1>("h1") @[SyncBankMemory.scala 78:13]
        memMask[1] <= UInt<1>("h1") @[SyncBankMemory.scala 78:13]
        memMask[2] <= UInt<1>("h1") @[SyncBankMemory.scala 78:13]
        memMask[3] <= UInt<1>("h1") @[SyncBankMemory.scala 78:13]
        vecIndexWr <= UInt<1>("h0") @[SyncBankMemory.scala 80:16]
        vecIndexRd1 <= UInt<1>("h0") @[SyncBankMemory.scala 81:17]
        vecIndexRd2 <= UInt<1>("h0") @[SyncBankMemory.scala 82:17]
    smem mem : UInt<8>[4] [1024] @[SyncBankMemory.scala 85:24]
    when io.rden : @[SyncBankMemory.scala 91:17]
      node _readAddress1_T = shr(io.rdAddr1, 2) @[SyncBankMemory.scala 93:32]
      readAddress1 <= _readAddress1_T @[SyncBankMemory.scala 93:18]
      node _readAddress2_T = shr(io.rdAddr2, 2) @[SyncBankMemory.scala 94:32]
      readAddress2 <= _readAddress2_T @[SyncBankMemory.scala 94:18]
      wire _WIRE : UInt @[SyncBankMemory.scala 95:24]
      _WIRE is invalid @[SyncBankMemory.scala 95:24]
      when UInt<1>("h1") : @[SyncBankMemory.scala 95:24]
        _WIRE <= readAddress1 @[SyncBankMemory.scala 95:24]
        node _T_15 = or(_WIRE, UInt<10>("h0")) @[SyncBankMemory.scala 95:24]
        node _T_16 = bits(_T_15, 9, 0) @[SyncBankMemory.scala 95:24]
        read mport MPORT = mem[_T_16], clock @[SyncBankMemory.scala 95:24]
      rdData1 <= MPORT @[SyncBankMemory.scala 95:13]
      wire _WIRE_1 : UInt @[SyncBankMemory.scala 96:24]
      _WIRE_1 is invalid @[SyncBankMemory.scala 96:24]
      when UInt<1>("h1") : @[SyncBankMemory.scala 96:24]
        _WIRE_1 <= readAddress2 @[SyncBankMemory.scala 96:24]
        node _T_17 = or(_WIRE_1, UInt<10>("h0")) @[SyncBankMemory.scala 96:24]
        node _T_18 = bits(_T_17, 9, 0) @[SyncBankMemory.scala 96:24]
        read mport MPORT_1 = mem[_T_18], clock @[SyncBankMemory.scala 96:24]
      rdData2 <= MPORT_1 @[SyncBankMemory.scala 96:13]
    reg REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), REG) @[SyncBankMemory.scala 99:15]
    REG <= io.rden @[SyncBankMemory.scala 99:15]
    when REG : @[SyncBankMemory.scala 99:26]
      reg REG_1 : UInt, clock with :
        reset => (UInt<1>("h0"), REG_1) @[SyncBankMemory.scala 100:21]
      REG_1 <= io.memOp @[SyncBankMemory.scala 100:21]
      node _T_19 = eq(REG_1, UInt<1>("h0")) @[SyncBankMemory.scala 100:32]
      when _T_19 : @[SyncBankMemory.scala 100:47]
        node _io_rdData1_T = bits(vecIndexRd1, 1, 0)
        node _io_rdData1_T_1 = bits(rdData1[_io_rdData1_T], 7, 7) @[SyncBankMemory.scala 101:57]
        node _io_rdData1_T_2 = bits(_io_rdData1_T_1, 0, 0) @[Bitwise.scala 77:15]
        node _io_rdData1_T_3 = mux(_io_rdData1_T_2, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
        node _io_rdData1_T_4 = bits(vecIndexRd1, 1, 0)
        node _io_rdData1_T_5 = bits(rdData1[_io_rdData1_T_4], 7, 0) @[SyncBankMemory.scala 101:90]
        node _io_rdData1_T_6 = cat(_io_rdData1_T_3, _io_rdData1_T_5) @[Cat.scala 33:92]
        io.rdData1 <= _io_rdData1_T_6 @[SyncBankMemory.scala 101:22]
        node _io_rdData2_T = bits(vecIndexRd2, 1, 0)
        node _io_rdData2_T_1 = bits(rdData2[_io_rdData2_T], 7, 7) @[SyncBankMemory.scala 102:57]
        node _io_rdData2_T_2 = bits(_io_rdData2_T_1, 0, 0) @[Bitwise.scala 77:15]
        node _io_rdData2_T_3 = mux(_io_rdData2_T_2, UInt<24>("hffffff"), UInt<24>("h0")) @[Bitwise.scala 77:12]
        node _io_rdData2_T_4 = bits(vecIndexRd2, 1, 0)
        node _io_rdData2_T_5 = bits(rdData2[_io_rdData2_T_4], 7, 0) @[SyncBankMemory.scala 102:90]
        node _io_rdData2_T_6 = cat(_io_rdData2_T_3, _io_rdData2_T_5) @[Cat.scala 33:92]
        io.rdData2 <= _io_rdData2_T_6 @[SyncBankMemory.scala 102:22]
      else :
        reg REG_2 : UInt, clock with :
          reset => (UInt<1>("h0"), REG_2) @[SyncBankMemory.scala 103:27]
        REG_2 <= io.memOp @[SyncBankMemory.scala 103:27]
        node _T_20 = eq(REG_2, UInt<1>("h1")) @[SyncBankMemory.scala 103:38]
        when _T_20 : @[SyncBankMemory.scala 103:53]
          node _io_rdData1_T_7 = add(vecIndexRd1, UInt<1>("h1")) @[SyncBankMemory.scala 104:57]
          node _io_rdData1_T_8 = tail(_io_rdData1_T_7, 1) @[SyncBankMemory.scala 104:57]
          node _io_rdData1_T_9 = bits(_io_rdData1_T_8, 1, 0)
          node _io_rdData1_T_10 = bits(rdData1[_io_rdData1_T_9], 7, 7) @[SyncBankMemory.scala 104:63]
          node _io_rdData1_T_11 = bits(_io_rdData1_T_10, 0, 0) @[Bitwise.scala 77:15]
          node _io_rdData1_T_12 = mux(_io_rdData1_T_11, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
          node _io_rdData1_T_13 = add(vecIndexRd1, UInt<1>("h1")) @[SyncBankMemory.scala 104:95]
          node _io_rdData1_T_14 = tail(_io_rdData1_T_13, 1) @[SyncBankMemory.scala 104:95]
          node _io_rdData1_T_15 = bits(_io_rdData1_T_14, 1, 0)
          node _io_rdData1_T_16 = bits(vecIndexRd1, 1, 0)
          node io_rdData1_hi = cat(_io_rdData1_T_12, rdData1[_io_rdData1_T_15]) @[Cat.scala 33:92]
          node _io_rdData1_T_17 = cat(io_rdData1_hi, rdData1[_io_rdData1_T_16]) @[Cat.scala 33:92]
          io.rdData1 <= _io_rdData1_T_17 @[SyncBankMemory.scala 104:22]
          node _io_rdData2_T_7 = add(vecIndexRd2, UInt<1>("h1")) @[SyncBankMemory.scala 105:57]
          node _io_rdData2_T_8 = tail(_io_rdData2_T_7, 1) @[SyncBankMemory.scala 105:57]
          node _io_rdData2_T_9 = bits(_io_rdData2_T_8, 1, 0)
          node _io_rdData2_T_10 = bits(rdData2[_io_rdData2_T_9], 7, 7) @[SyncBankMemory.scala 105:63]
          node _io_rdData2_T_11 = bits(_io_rdData2_T_10, 0, 0) @[Bitwise.scala 77:15]
          node _io_rdData2_T_12 = mux(_io_rdData2_T_11, UInt<16>("hffff"), UInt<16>("h0")) @[Bitwise.scala 77:12]
          node _io_rdData2_T_13 = add(vecIndexRd2, UInt<1>("h1")) @[SyncBankMemory.scala 105:95]
          node _io_rdData2_T_14 = tail(_io_rdData2_T_13, 1) @[SyncBankMemory.scala 105:95]
          node _io_rdData2_T_15 = bits(_io_rdData2_T_14, 1, 0)
          node _io_rdData2_T_16 = bits(vecIndexRd2, 1, 0)
          node io_rdData2_hi = cat(_io_rdData2_T_12, rdData2[_io_rdData2_T_15]) @[Cat.scala 33:92]
          node _io_rdData2_T_17 = cat(io_rdData2_hi, rdData2[_io_rdData2_T_16]) @[Cat.scala 33:92]
          io.rdData2 <= _io_rdData2_T_17 @[SyncBankMemory.scala 105:22]
        else :
          node _io_rdData1_T_18 = cat(rdData1[3], rdData1[2]) @[SyncBankMemory.scala 107:37]
          node _io_rdData1_T_19 = cat(_io_rdData1_T_18, rdData1[1]) @[SyncBankMemory.scala 107:51]
          node _io_rdData1_T_20 = cat(_io_rdData1_T_19, rdData1[0]) @[SyncBankMemory.scala 107:65]
          io.rdData1 <= _io_rdData1_T_20 @[SyncBankMemory.scala 107:22]
          node _io_rdData2_T_18 = cat(rdData2[3], rdData2[2]) @[SyncBankMemory.scala 108:37]
          node _io_rdData2_T_19 = cat(_io_rdData2_T_18, rdData2[1]) @[SyncBankMemory.scala 108:51]
          node _io_rdData2_T_20 = cat(_io_rdData2_T_19, rdData2[0]) @[SyncBankMemory.scala 108:65]
          io.rdData2 <= _io_rdData2_T_20 @[SyncBankMemory.scala 108:22]
    when io.wren : @[SyncBankMemory.scala 112:17]
      node _writeAddress_T = shr(io.wrAddr, 2) @[SyncBankMemory.scala 113:31]
      writeAddress <= _writeAddress_T @[SyncBankMemory.scala 113:18]
      write mport MPORT_2 = mem[writeAddress], clock
      when memMask[0] :
        MPORT_2[0] <= wrData[0]
      when memMask[1] :
        MPORT_2[1] <= wrData[1]
      when memMask[2] :
        MPORT_2[2] <= wrData[2]
      when memMask[3] :
        MPORT_2[3] <= wrData[3]

  module MEM :
    input clock : Clock
    input reset : Reset
    output io : { flip stallReg : UInt<1>, flip in : { rd : UInt<5>, aluOut : UInt<32>, wrData : UInt<32>, memOp : UInt<4>, ctrl : { writeEnable : UInt<1>, store : UInt<1>, load : UInt<1>}}, out : { rd : UInt<5>, aluOut : UInt<32>, memOut : UInt<32>, load : UInt<1>, writeEnable : UInt<1>}, mem_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}}

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
    inst MEM of SyncBankMemory @[MEM.scala 29:19]
    MEM.clock <= clock
    MEM.reset <= reset
    MEM.io.rdAddr2 is invalid @[MEM.scala 32:18]
    MEM.io.wren <= io.in.ctrl.store @[MEM.scala 35:15]
    MEM.io.rden <= io.in.ctrl.load @[MEM.scala 36:15]
    MEM.io.rdAddr1 <= io.in.aluOut @[MEM.scala 37:18]
    MEM.io.wrAddr <= io.in.aluOut @[MEM.scala 38:17]
    MEM.io.wrData <= io.in.wrData @[MEM.scala 39:17]
    MEM.io.memOp <= io.in.memOp @[MEM.scala 40:16]
    io.out.rd <= outReg.rd @[MEM.scala 55:13]
    io.out.aluOut <= outReg.aluOut @[MEM.scala 56:17]
    io.out.load <= outReg.load @[MEM.scala 57:15]
    io.out.writeEnable <= outReg.writeEnable @[MEM.scala 58:22]
    io.out.memOut <= MEM.io.rdData1 @[MEM.scala 59:17]
    node _io_mem_fwd_rd_T = mux(io.in.ctrl.load, UInt<1>("h0"), io.in.rd) @[MEM.scala 62:23]
    io.mem_fwd.rd <= _io_mem_fwd_rd_T @[MEM.scala 62:17]
    node _io_mem_fwd_stageOutput_T = mux(io.in.ctrl.load, UInt<1>("h0"), io.in.aluOut) @[MEM.scala 63:32]
    io.mem_fwd.stageOutput <= _io_mem_fwd_stageOutput_T @[MEM.scala 63:26]
    node _io_mem_fwd_writeEnable_T = mux(io.in.ctrl.load, UInt<1>("h0"), io.in.ctrl.writeEnable) @[MEM.scala 64:32]
    io.mem_fwd.writeEnable <= _io_mem_fwd_writeEnable_T @[MEM.scala 64:26]

  module WB :
    input clock : Clock
    input reset : Reset
    output io : { flip in : { rd : UInt<5>, aluOut : UInt<32>, memOut : UInt<32>, load : UInt<1>, writeEnable : UInt<1>}, out : { rd : UInt<5>, muxOut : UInt<32>, writeEnable : UInt<1>}, wb_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}}

    node theMux = mux(io.in.load, io.in.memOut, io.in.aluOut) @[WB.scala 18:19]
    io.out.writeEnable <= io.in.writeEnable @[WB.scala 26:22]
    io.out.muxOut <= theMux @[WB.scala 27:17]
    io.out.rd <= io.in.rd @[WB.scala 28:13]
    io.wb_fwd.rd <= io.out.rd @[WB.scala 31:16]
    io.wb_fwd.stageOutput <= io.out.muxOut @[WB.scala 32:25]
    io.wb_fwd.writeEnable <= io.out.writeEnable @[WB.scala 33:25]

  module ForwardingUnit :
    input clock : Clock
    input reset : Reset
    output io : { flip id_rs1 : UInt<5>, flip id_rs2 : UInt<5>, flip id_val1 : UInt<32>, flip id_val2 : UInt<32>, flip mem_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}, flip wb_fwd : { rd : UInt<5>, stageOutput : UInt<32>, writeEnable : UInt<1>}, val1 : UInt<32>, val2 : UInt<32>}

    node _forwardingMEMrs1_T = eq(io.mem_fwd.rd, io.id_rs1) @[ForwardingUnit.scala 20:41]
    node _forwardingMEMrs1_T_1 = neq(io.id_rs1, UInt<1>("h0")) @[ForwardingUnit.scala 20:68]
    node _forwardingMEMrs1_T_2 = and(_forwardingMEMrs1_T, _forwardingMEMrs1_T_1) @[ForwardingUnit.scala 20:55]
    node forwardingMEMrs1 = and(_forwardingMEMrs1_T_2, io.mem_fwd.writeEnable) @[ForwardingUnit.scala 20:76]
    node _forwardingMEMrs2_T = eq(io.mem_fwd.rd, io.id_rs2) @[ForwardingUnit.scala 21:41]
    node _forwardingMEMrs2_T_1 = neq(io.id_rs2, UInt<1>("h0")) @[ForwardingUnit.scala 21:68]
    node _forwardingMEMrs2_T_2 = and(_forwardingMEMrs2_T, _forwardingMEMrs2_T_1) @[ForwardingUnit.scala 21:55]
    node forwardingMEMrs2 = and(_forwardingMEMrs2_T_2, io.mem_fwd.writeEnable) @[ForwardingUnit.scala 21:76]
    node _forwardingWBrs1_T = eq(io.wb_fwd.rd, io.id_rs1) @[ForwardingUnit.scala 23:39]
    node _forwardingWBrs1_T_1 = neq(io.id_rs1, UInt<1>("h0")) @[ForwardingUnit.scala 23:66]
    node _forwardingWBrs1_T_2 = and(_forwardingWBrs1_T, _forwardingWBrs1_T_1) @[ForwardingUnit.scala 23:53]
    node forwardingWBrs1 = and(_forwardingWBrs1_T_2, io.wb_fwd.writeEnable) @[ForwardingUnit.scala 23:74]
    node _forwardingWBrs2_T = eq(io.wb_fwd.rd, io.id_rs2) @[ForwardingUnit.scala 24:39]
    node _forwardingWBrs2_T_1 = neq(io.id_rs2, UInt<1>("h0")) @[ForwardingUnit.scala 24:66]
    node _forwardingWBrs2_T_2 = and(_forwardingWBrs2_T, _forwardingWBrs2_T_1) @[ForwardingUnit.scala 24:53]
    node forwardingWBrs2 = and(_forwardingWBrs2_T_2, io.wb_fwd.writeEnable) @[ForwardingUnit.scala 24:74]
    when forwardingMEMrs1 : @[ForwardingUnit.scala 28:26]
      io.val1 <= io.mem_fwd.stageOutput @[ForwardingUnit.scala 29:13]
    else :
      when forwardingWBrs1 : @[ForwardingUnit.scala 30:31]
        io.val1 <= io.wb_fwd.stageOutput @[ForwardingUnit.scala 31:13]
      else :
        io.val1 <= io.id_val1 @[ForwardingUnit.scala 33:13]
    when forwardingMEMrs2 : @[ForwardingUnit.scala 36:26]
      io.val2 <= io.mem_fwd.stageOutput @[ForwardingUnit.scala 37:13]
    else :
      when forwardingWBrs2 : @[ForwardingUnit.scala 38:31]
        io.val2 <= io.wb_fwd.stageOutput @[ForwardingUnit.scala 39:13]
      else :
        io.val2 <= io.id_val2 @[ForwardingUnit.scala 41:13]

  module HazardControl :
    input clock : Clock
    input reset : Reset
    output io : { flip EXaluOut : UInt<32>, flip EXctrlBranch : UInt<1>, flip EXctrlJump : UInt<1>, flip EXctrlLoad : UInt<1>, flip EXrd : UInt<5>, flip IDrs1 : UInt<5>, flip IDrs2 : UInt<5>, IDFlush : UInt<1>, IFFlush : UInt<1>, IFStall : UInt<1>}

    wire _io_IDFlush_WIRE : UInt<1>
    _io_IDFlush_WIRE <= UInt<1>("h0")
    io.IDFlush <= _io_IDFlush_WIRE @[HazardControl.scala 22:14]
    wire _io_IFFlush_WIRE : UInt<1>
    _io_IFFlush_WIRE <= UInt<1>("h0")
    io.IFFlush <= _io_IFFlush_WIRE @[HazardControl.scala 23:14]
    wire _io_IFStall_WIRE : UInt<1>
    _io_IFStall_WIRE <= UInt<1>("h0")
    io.IFStall <= _io_IFStall_WIRE @[HazardControl.scala 24:14]
    node _use_load_T = eq(io.EXrd, io.IDrs1) @[HazardControl.scala 26:44]
    node _use_load_T_1 = eq(io.EXrd, io.IDrs2) @[HazardControl.scala 26:68]
    node _use_load_T_2 = or(_use_load_T, _use_load_T_1) @[HazardControl.scala 26:57]
    node _use_load_T_3 = and(io.EXctrlLoad, _use_load_T_2) @[HazardControl.scala 26:32]
    node _use_load_T_4 = neq(io.EXrd, UInt<1>("h0")) @[HazardControl.scala 26:93]
    node use_load = and(_use_load_T_3, _use_load_T_4) @[HazardControl.scala 26:82]
    node _branch_jump_T = eq(io.EXaluOut, UInt<1>("h1")) @[HazardControl.scala 27:34]
    node _branch_jump_T_1 = and(_branch_jump_T, io.EXctrlBranch) @[HazardControl.scala 27:42]
    node branch_jump = or(_branch_jump_T_1, io.EXctrlJump) @[HazardControl.scala 27:62]
    io.IFFlush <= branch_jump @[HazardControl.scala 29:14]
    io.IFStall <= use_load @[HazardControl.scala 30:14]
    node _io_IDFlush_T = or(branch_jump, use_load) @[HazardControl.scala 31:29]
    io.IDFlush <= _io_IDFlush_T @[HazardControl.scala 31:14]

  module SevenSegment :
    input clock : Clock
    input reset : Reset
    output io : { flip rd : UInt<7>, flip val1 : UInt<7>, seg : UInt<7>, an : UInt<4>}

    wire sevSeg : UInt<7>
    sevSeg <= UInt<7>("h7f")
    wire select : UInt<4>
    select <= UInt<4>("h1")
    reg counter_value : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[Counter.scala 61:40]
    reg cntRegSel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[SevenSegment.scala 22:26]
    node wrap = eq(counter_value, UInt<17>("h1869f")) @[Counter.scala 73:24]
    node _value_T = add(counter_value, UInt<1>("h1")) @[Counter.scala 77:24]
    node _value_T_1 = tail(_value_T, 1) @[Counter.scala 77:24]
    counter_value <= _value_T_1 @[Counter.scala 77:15]
    when wrap : @[Counter.scala 87:20]
      counter_value <= UInt<1>("h0") @[Counter.scala 87:28]
    when wrap : @[SevenSegment.scala 23:23]
      node _cntRegSel_T = add(cntRegSel, UInt<1>("h1")) @[SevenSegment.scala 24:28]
      node _cntRegSel_T_1 = tail(_cntRegSel_T, 1) @[SevenSegment.scala 24:28]
      cntRegSel <= _cntRegSel_T_1 @[SevenSegment.scala 24:15]
    node _T = eq(UInt<1>("h0"), cntRegSel) @[SevenSegment.scala 27:20]
    when _T : @[SevenSegment.scala 27:20]
      select <= UInt<1>("h1") @[SevenSegment.scala 28:24]
    else :
      node _T_1 = eq(UInt<1>("h1"), cntRegSel) @[SevenSegment.scala 27:20]
      when _T_1 : @[SevenSegment.scala 27:20]
        select <= UInt<2>("h2") @[SevenSegment.scala 29:24]
      else :
        node _T_2 = eq(UInt<2>("h2"), cntRegSel) @[SevenSegment.scala 27:20]
        when _T_2 : @[SevenSegment.scala 27:20]
          select <= UInt<3>("h4") @[SevenSegment.scala 30:24]
        else :
          node _T_3 = eq(UInt<2>("h3"), cntRegSel) @[SevenSegment.scala 27:20]
          when _T_3 : @[SevenSegment.scala 27:20]
            select <= UInt<4>("h8") @[SevenSegment.scala 31:24]
    wire wire1 : UInt<8>
    wire1 <= UInt<8>("h0")
    wire table : UInt<8>[100] @[SevenSegment.scala 35:19]
    table[0] <= UInt<1>("h0") @[SevenSegment.scala 38:14]
    table[1] <= UInt<1>("h1") @[SevenSegment.scala 38:14]
    table[2] <= UInt<2>("h2") @[SevenSegment.scala 38:14]
    table[3] <= UInt<2>("h3") @[SevenSegment.scala 38:14]
    table[4] <= UInt<3>("h4") @[SevenSegment.scala 38:14]
    table[5] <= UInt<3>("h5") @[SevenSegment.scala 38:14]
    table[6] <= UInt<3>("h6") @[SevenSegment.scala 38:14]
    table[7] <= UInt<3>("h7") @[SevenSegment.scala 38:14]
    table[8] <= UInt<4>("h8") @[SevenSegment.scala 38:14]
    table[9] <= UInt<4>("h9") @[SevenSegment.scala 38:14]
    table[10] <= UInt<5>("h10") @[SevenSegment.scala 38:14]
    table[11] <= UInt<5>("h11") @[SevenSegment.scala 38:14]
    table[12] <= UInt<5>("h12") @[SevenSegment.scala 38:14]
    table[13] <= UInt<5>("h13") @[SevenSegment.scala 38:14]
    table[14] <= UInt<5>("h14") @[SevenSegment.scala 38:14]
    table[15] <= UInt<5>("h15") @[SevenSegment.scala 38:14]
    table[16] <= UInt<5>("h16") @[SevenSegment.scala 38:14]
    table[17] <= UInt<5>("h17") @[SevenSegment.scala 38:14]
    table[18] <= UInt<5>("h18") @[SevenSegment.scala 38:14]
    table[19] <= UInt<5>("h19") @[SevenSegment.scala 38:14]
    table[20] <= UInt<6>("h20") @[SevenSegment.scala 38:14]
    table[21] <= UInt<6>("h21") @[SevenSegment.scala 38:14]
    table[22] <= UInt<6>("h22") @[SevenSegment.scala 38:14]
    table[23] <= UInt<6>("h23") @[SevenSegment.scala 38:14]
    table[24] <= UInt<6>("h24") @[SevenSegment.scala 38:14]
    table[25] <= UInt<6>("h25") @[SevenSegment.scala 38:14]
    table[26] <= UInt<6>("h26") @[SevenSegment.scala 38:14]
    table[27] <= UInt<6>("h27") @[SevenSegment.scala 38:14]
    table[28] <= UInt<6>("h28") @[SevenSegment.scala 38:14]
    table[29] <= UInt<6>("h29") @[SevenSegment.scala 38:14]
    table[30] <= UInt<6>("h30") @[SevenSegment.scala 38:14]
    table[31] <= UInt<6>("h31") @[SevenSegment.scala 38:14]
    table[32] <= UInt<6>("h32") @[SevenSegment.scala 38:14]
    table[33] <= UInt<6>("h33") @[SevenSegment.scala 38:14]
    table[34] <= UInt<6>("h34") @[SevenSegment.scala 38:14]
    table[35] <= UInt<6>("h35") @[SevenSegment.scala 38:14]
    table[36] <= UInt<6>("h36") @[SevenSegment.scala 38:14]
    table[37] <= UInt<6>("h37") @[SevenSegment.scala 38:14]
    table[38] <= UInt<6>("h38") @[SevenSegment.scala 38:14]
    table[39] <= UInt<6>("h39") @[SevenSegment.scala 38:14]
    table[40] <= UInt<7>("h40") @[SevenSegment.scala 38:14]
    table[41] <= UInt<7>("h41") @[SevenSegment.scala 38:14]
    table[42] <= UInt<7>("h42") @[SevenSegment.scala 38:14]
    table[43] <= UInt<7>("h43") @[SevenSegment.scala 38:14]
    table[44] <= UInt<7>("h44") @[SevenSegment.scala 38:14]
    table[45] <= UInt<7>("h45") @[SevenSegment.scala 38:14]
    table[46] <= UInt<7>("h46") @[SevenSegment.scala 38:14]
    table[47] <= UInt<7>("h47") @[SevenSegment.scala 38:14]
    table[48] <= UInt<7>("h48") @[SevenSegment.scala 38:14]
    table[49] <= UInt<7>("h49") @[SevenSegment.scala 38:14]
    table[50] <= UInt<7>("h50") @[SevenSegment.scala 38:14]
    table[51] <= UInt<7>("h51") @[SevenSegment.scala 38:14]
    table[52] <= UInt<7>("h52") @[SevenSegment.scala 38:14]
    table[53] <= UInt<7>("h53") @[SevenSegment.scala 38:14]
    table[54] <= UInt<7>("h54") @[SevenSegment.scala 38:14]
    table[55] <= UInt<7>("h55") @[SevenSegment.scala 38:14]
    table[56] <= UInt<7>("h56") @[SevenSegment.scala 38:14]
    table[57] <= UInt<7>("h57") @[SevenSegment.scala 38:14]
    table[58] <= UInt<7>("h58") @[SevenSegment.scala 38:14]
    table[59] <= UInt<7>("h59") @[SevenSegment.scala 38:14]
    table[60] <= UInt<7>("h60") @[SevenSegment.scala 38:14]
    table[61] <= UInt<7>("h61") @[SevenSegment.scala 38:14]
    table[62] <= UInt<7>("h62") @[SevenSegment.scala 38:14]
    table[63] <= UInt<7>("h63") @[SevenSegment.scala 38:14]
    table[64] <= UInt<7>("h64") @[SevenSegment.scala 38:14]
    table[65] <= UInt<7>("h65") @[SevenSegment.scala 38:14]
    table[66] <= UInt<7>("h66") @[SevenSegment.scala 38:14]
    table[67] <= UInt<7>("h67") @[SevenSegment.scala 38:14]
    table[68] <= UInt<7>("h68") @[SevenSegment.scala 38:14]
    table[69] <= UInt<7>("h69") @[SevenSegment.scala 38:14]
    table[70] <= UInt<7>("h70") @[SevenSegment.scala 38:14]
    table[71] <= UInt<7>("h71") @[SevenSegment.scala 38:14]
    table[72] <= UInt<7>("h72") @[SevenSegment.scala 38:14]
    table[73] <= UInt<7>("h73") @[SevenSegment.scala 38:14]
    table[74] <= UInt<7>("h74") @[SevenSegment.scala 38:14]
    table[75] <= UInt<7>("h75") @[SevenSegment.scala 38:14]
    table[76] <= UInt<7>("h76") @[SevenSegment.scala 38:14]
    table[77] <= UInt<7>("h77") @[SevenSegment.scala 38:14]
    table[78] <= UInt<7>("h78") @[SevenSegment.scala 38:14]
    table[79] <= UInt<7>("h79") @[SevenSegment.scala 38:14]
    table[80] <= UInt<8>("h80") @[SevenSegment.scala 38:14]
    table[81] <= UInt<8>("h81") @[SevenSegment.scala 38:14]
    table[82] <= UInt<8>("h82") @[SevenSegment.scala 38:14]
    table[83] <= UInt<8>("h83") @[SevenSegment.scala 38:14]
    table[84] <= UInt<8>("h84") @[SevenSegment.scala 38:14]
    table[85] <= UInt<8>("h85") @[SevenSegment.scala 38:14]
    table[86] <= UInt<8>("h86") @[SevenSegment.scala 38:14]
    table[87] <= UInt<8>("h87") @[SevenSegment.scala 38:14]
    table[88] <= UInt<8>("h88") @[SevenSegment.scala 38:14]
    table[89] <= UInt<8>("h89") @[SevenSegment.scala 38:14]
    table[90] <= UInt<8>("h90") @[SevenSegment.scala 38:14]
    table[91] <= UInt<8>("h91") @[SevenSegment.scala 38:14]
    table[92] <= UInt<8>("h92") @[SevenSegment.scala 38:14]
    table[93] <= UInt<8>("h93") @[SevenSegment.scala 38:14]
    table[94] <= UInt<8>("h94") @[SevenSegment.scala 38:14]
    table[95] <= UInt<8>("h95") @[SevenSegment.scala 38:14]
    table[96] <= UInt<8>("h96") @[SevenSegment.scala 38:14]
    table[97] <= UInt<8>("h97") @[SevenSegment.scala 38:14]
    table[98] <= UInt<8>("h98") @[SevenSegment.scala 38:14]
    table[99] <= UInt<8>("h99") @[SevenSegment.scala 38:14]
    wire sevSegIn : UInt<4>
    sevSegIn <= UInt<4>("h0")
    node _T_4 = eq(UInt<1>("h0"), cntRegSel) @[SevenSegment.scala 42:20]
    when _T_4 : @[SevenSegment.scala 42:20]
      node _sevSegIn_T = bits(wire1, 6, 0)
      node _sevSegIn_T_1 = bits(table[_sevSegIn_T], 3, 0) @[SevenSegment.scala 43:41]
      sevSegIn <= _sevSegIn_T_1 @[SevenSegment.scala 43:26]
    else :
      node _T_5 = eq(UInt<1>("h1"), cntRegSel) @[SevenSegment.scala 42:20]
      when _T_5 : @[SevenSegment.scala 42:20]
        node _sevSegIn_T_2 = bits(wire1, 6, 0)
        node _sevSegIn_T_3 = bits(table[_sevSegIn_T_2], 7, 4) @[SevenSegment.scala 44:41]
        sevSegIn <= _sevSegIn_T_3 @[SevenSegment.scala 44:26]
      else :
        node _T_6 = eq(UInt<2>("h2"), cntRegSel) @[SevenSegment.scala 42:20]
        when _T_6 : @[SevenSegment.scala 42:20]
          node _sevSegIn_T_4 = bits(wire1, 6, 0)
          node _sevSegIn_T_5 = bits(table[_sevSegIn_T_4], 3, 0) @[SevenSegment.scala 45:41]
          sevSegIn <= _sevSegIn_T_5 @[SevenSegment.scala 45:26]
        else :
          node _T_7 = eq(UInt<2>("h3"), cntRegSel) @[SevenSegment.scala 42:20]
          when _T_7 : @[SevenSegment.scala 42:20]
            node _sevSegIn_T_6 = bits(wire1, 6, 0)
            node _sevSegIn_T_7 = bits(table[_sevSegIn_T_6], 7, 4) @[SevenSegment.scala 46:41]
            sevSegIn <= _sevSegIn_T_7 @[SevenSegment.scala 46:26]
    node _T_8 = eq(UInt<1>("h0"), sevSegIn) @[SevenSegment.scala 50:20]
    when _T_8 : @[SevenSegment.scala 50:20]
      sevSeg <= UInt<6>("h3f") @[SevenSegment.scala 52:14]
    else :
      node _T_9 = eq(UInt<1>("h1"), sevSegIn) @[SevenSegment.scala 50:20]
      when _T_9 : @[SevenSegment.scala 50:20]
        sevSeg <= UInt<3>("h6") @[SevenSegment.scala 55:14]
      else :
        node _T_10 = eq(UInt<2>("h2"), sevSegIn) @[SevenSegment.scala 50:20]
        when _T_10 : @[SevenSegment.scala 50:20]
          sevSeg <= UInt<7>("h5b") @[SevenSegment.scala 58:14]
        else :
          node _T_11 = eq(UInt<2>("h3"), sevSegIn) @[SevenSegment.scala 50:20]
          when _T_11 : @[SevenSegment.scala 50:20]
            sevSeg <= UInt<7>("h4f") @[SevenSegment.scala 61:14]
          else :
            node _T_12 = eq(UInt<3>("h4"), sevSegIn) @[SevenSegment.scala 50:20]
            when _T_12 : @[SevenSegment.scala 50:20]
              sevSeg <= UInt<7>("h66") @[SevenSegment.scala 64:14]
            else :
              node _T_13 = eq(UInt<3>("h5"), sevSegIn) @[SevenSegment.scala 50:20]
              when _T_13 : @[SevenSegment.scala 50:20]
                sevSeg <= UInt<7>("h6d") @[SevenSegment.scala 67:14]
              else :
                node _T_14 = eq(UInt<3>("h6"), sevSegIn) @[SevenSegment.scala 50:20]
                when _T_14 : @[SevenSegment.scala 50:20]
                  sevSeg <= UInt<7>("h7d") @[SevenSegment.scala 70:14]
                else :
                  node _T_15 = eq(UInt<3>("h7"), sevSegIn) @[SevenSegment.scala 50:20]
                  when _T_15 : @[SevenSegment.scala 50:20]
                    sevSeg <= UInt<3>("h7") @[SevenSegment.scala 73:14]
                  else :
                    node _T_16 = eq(UInt<4>("h8"), sevSegIn) @[SevenSegment.scala 50:20]
                    when _T_16 : @[SevenSegment.scala 50:20]
                      sevSeg <= UInt<7>("h7f") @[SevenSegment.scala 76:14]
                    else :
                      node _T_17 = eq(UInt<4>("h9"), sevSegIn) @[SevenSegment.scala 50:20]
                      when _T_17 : @[SevenSegment.scala 50:20]
                        sevSeg <= UInt<7>("h6f") @[SevenSegment.scala 79:14]
    node _T_18 = eq(UInt<1>("h0"), cntRegSel) @[SevenSegment.scala 83:20]
    when _T_18 : @[SevenSegment.scala 83:20]
      wire1 <= io.rd @[SevenSegment.scala 84:23]
    else :
      node _T_19 = eq(UInt<1>("h1"), cntRegSel) @[SevenSegment.scala 83:20]
      when _T_19 : @[SevenSegment.scala 83:20]
        wire1 <= io.rd @[SevenSegment.scala 85:23]
      else :
        node _T_20 = eq(UInt<2>("h2"), cntRegSel) @[SevenSegment.scala 83:20]
        when _T_20 : @[SevenSegment.scala 83:20]
          wire1 <= io.val1 @[SevenSegment.scala 86:23]
        else :
          node _T_21 = eq(UInt<2>("h3"), cntRegSel) @[SevenSegment.scala 83:20]
          when _T_21 : @[SevenSegment.scala 83:20]
            wire1 <= io.val1 @[SevenSegment.scala 87:23]
    node _io_seg_T = not(sevSeg) @[SevenSegment.scala 90:13]
    io.seg <= _io_seg_T @[SevenSegment.scala 90:10]
    node _io_an_T = not(select) @[SevenSegment.scala 91:12]
    io.an <= _io_an_T @[SevenSegment.scala 91:9]

  module VStageProcessor :
    input clock : Clock
    input reset : UInt<1>
    output io : { memIO : { flip ready : UInt<1>, flip data : UInt<32>}, flip startPipeline : UInt<1>, flip add : UInt<1>, flip branchInst : UInt<1>, flip jumpInst : UInt<1>, seg : UInt<7>, an : UInt<4>, useImm : UInt<1>, useAlu : UInt<1>, branch : UInt<1>, jump : UInt<1>, load : UInt<1>, store : UInt<1>, changePC : UInt<1>, writeEnable : UInt<1>}

    inst IF of IF @[VStageProcessor.scala 33:18]
    IF.clock <= clock
    IF.reset <= reset
    inst ID of ID @[VStageProcessor.scala 34:18]
    ID.clock <= clock
    ID.reset <= reset
    inst EX of EX @[VStageProcessor.scala 35:18]
    EX.clock <= clock
    EX.reset <= reset
    inst MEM of MEM @[VStageProcessor.scala 36:19]
    MEM.clock <= clock
    MEM.reset <= reset
    inst WB of WB @[VStageProcessor.scala 37:18]
    WB.clock <= clock
    WB.reset <= reset
    inst forwardingUnit of ForwardingUnit @[VStageProcessor.scala 40:30]
    forwardingUnit.clock <= clock
    forwardingUnit.reset <= reset
    inst hazardControl of HazardControl @[VStageProcessor.scala 41:29]
    hazardControl.clock <= clock
    hazardControl.reset <= reset
    ID.io.in <= IF.io.out @[VStageProcessor.scala 44:13]
    EX.io.in <= ID.io.out @[VStageProcessor.scala 45:13]
    MEM.io.in <= EX.io.out @[VStageProcessor.scala 46:13]
    WB.io.in <= MEM.io.out @[VStageProcessor.scala 47:14]
    ID.io.wbIn <= WB.io.out @[VStageProcessor.scala 48:13]
    forwardingUnit.io.mem_fwd <= MEM.io.mem_fwd @[VStageProcessor.scala 51:29]
    forwardingUnit.io.wb_fwd <= WB.io.wb_fwd @[VStageProcessor.scala 52:28]
    forwardingUnit.io.id_rs1 <= ID.io.out.rs1 @[VStageProcessor.scala 54:28]
    forwardingUnit.io.id_rs2 <= ID.io.out.rs2 @[VStageProcessor.scala 55:28]
    forwardingUnit.io.id_val1 <= ID.io.out.val1 @[VStageProcessor.scala 56:29]
    forwardingUnit.io.id_val2 <= ID.io.out.val2 @[VStageProcessor.scala 57:29]
    EX.io.in.val1 <= forwardingUnit.io.val1 @[VStageProcessor.scala 59:17]
    EX.io.in.val2 <= forwardingUnit.io.val2 @[VStageProcessor.scala 60:17]
    IF.io.changePC <= EX.io.changePC @[VStageProcessor.scala 61:18]
    IF.io.newPCValue <= EX.io.newPCValue @[VStageProcessor.scala 62:20]
    hazardControl.io.EXaluOut <= EX.io.hazardAluOut @[VStageProcessor.scala 65:29]
    hazardControl.io.EXrd <= EX.io.out.rd @[VStageProcessor.scala 66:25]
    hazardControl.io.EXctrlLoad <= ID.io.out.ctrl.load @[VStageProcessor.scala 67:31]
    hazardControl.io.EXctrlBranch <= ID.io.out.ctrl.branch @[VStageProcessor.scala 68:33]
    hazardControl.io.EXctrlJump <= ID.io.out.ctrl.jump @[VStageProcessor.scala 69:31]
    hazardControl.io.IDrs1 <= ID.io.out.rs1 @[VStageProcessor.scala 70:26]
    hazardControl.io.IDrs2 <= ID.io.out.rs2 @[VStageProcessor.scala 71:26]
    IF.io.flush <= hazardControl.io.IFFlush @[VStageProcessor.scala 74:15]
    ID.io.flush <= hazardControl.io.IDFlush @[VStageProcessor.scala 75:15]
    IF.io.stallReg <= hazardControl.io.IFStall @[VStageProcessor.scala 77:18]
    ID.io.stallReg is invalid @[VStageProcessor.scala 78:18]
    EX.io.stallReg is invalid @[VStageProcessor.scala 79:18]
    MEM.io.stallReg is invalid @[VStageProcessor.scala 80:19]
    IF.io.memIO.ready <= io.memIO.ready @[VStageProcessor.scala 83:23]
    IF.io.memIO.writeData <= io.memIO.data @[VStageProcessor.scala 84:27]
    IF.io.startPC <= io.startPipeline @[VStageProcessor.scala 88:17]
    inst sevenSegmentDisplay of SevenSegment @[VStageProcessor.scala 94:35]
    sevenSegmentDisplay.clock <= clock
    sevenSegmentDisplay.reset <= reset
    io.seg <= sevenSegmentDisplay.io.seg @[VStageProcessor.scala 95:10]
    io.an <= sevenSegmentDisplay.io.an @[VStageProcessor.scala 96:9]
    sevenSegmentDisplay.io.val1 <= ID.io.out.val1 @[VStageProcessor.scala 97:31]
    sevenSegmentDisplay.io.rd <= ID.io.out.val2 @[VStageProcessor.scala 98:29]
    when io.add : @[VStageProcessor.scala 102:16]
      IF.io.startPC <= UInt<1>("h1") @[VStageProcessor.scala 103:19]
      IF.io.memIO.ready <= UInt<1>("h1") @[VStageProcessor.scala 104:23]
      IF.io.memIO.writeData <= UInt<21>("h108093") @[VStageProcessor.scala 105:27]
    when io.branchInst : @[VStageProcessor.scala 108:23]
      IF.io.startPC <= UInt<1>("h1") @[VStageProcessor.scala 109:19]
      IF.io.memIO.ready <= UInt<1>("h1") @[VStageProcessor.scala 110:23]
      IF.io.memIO.writeData <= UInt<22>("h310863") @[VStageProcessor.scala 111:27]
    when io.jumpInst : @[VStageProcessor.scala 126:21]
      IF.io.startPC <= UInt<1>("h1") @[VStageProcessor.scala 127:19]
      IF.io.memIO.ready <= UInt<1>("h1") @[VStageProcessor.scala 128:23]
      IF.io.memIO.writeData <= UInt<26>("h280006f") @[VStageProcessor.scala 129:27]
    io.useImm <= ID.io.out.ctrl.useImm @[VStageProcessor.scala 141:13]
    io.useAlu <= ID.io.out.ctrl.useALU @[VStageProcessor.scala 142:13]
    io.branch <= ID.io.out.ctrl.branch @[VStageProcessor.scala 143:13]
    io.jump <= ID.io.out.ctrl.jump @[VStageProcessor.scala 144:11]
    io.load <= ID.io.out.ctrl.load @[VStageProcessor.scala 145:11]
    io.store <= ID.io.out.ctrl.store @[VStageProcessor.scala 146:12]
    io.changePC <= ID.io.out.ctrl.changePC @[VStageProcessor.scala 147:15]
    io.writeEnable <= WB.io.in.writeEnable @[VStageProcessor.scala 148:18]

