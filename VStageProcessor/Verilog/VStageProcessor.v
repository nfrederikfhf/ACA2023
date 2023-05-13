module ProgramCounter(
  input         clock,
  input         reset,
  input         io_memIO_ready,
  output        io_memIO_valid,
  output [31:0] io_memIO_addr,
  input  [31:0] io_in
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_; // @[ProgramCounter.scala 17:20]
  assign io_memIO_valid = io_memIO_ready; // @[ProgramCounter.scala 19:23 20:20 22:20]
  assign io_memIO_addr = reg_; // @[ProgramCounter.scala 24:19]
  always @(posedge clock) begin
    if (reset) begin // @[ProgramCounter.scala 17:20]
      reg_ <= 32'h0; // @[ProgramCounter.scala 17:20]
    end else begin
      reg_ <= io_in; // @[ProgramCounter.scala 25:9]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_ = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module InstructionMemory(
  input         clock,
  input         reset,
  input         io_memIO_valid,
  output        io_memIO_nonEmpty,
  input  [31:0] io_memIO_addr,
  input         io_writer_ready,
  input  [31:0] io_writer_data,
  output [31:0] io_memOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
`endif // RANDOMIZE_REG_INIT
  reg [6:0] readPtr; // @[InstructionMemory.scala 34:24]
  reg [6:0] writePtr; // @[InstructionMemory.scala 35:25]
  wire [6:0] difference = writePtr - readPtr; // @[InstructionMemory.scala 69:29]
  wire [7:0] _GEN_391 = {{1'd0}, difference}; // @[InstructionMemory.scala 71:25]
  wire [7:0] _count_T_1 = _GEN_391 + 8'h80; // @[InstructionMemory.scala 71:25]
  wire [7:0] _GEN_390 = difference <= 7'h0 ? _count_T_1 : {{1'd0}, difference}; // @[InstructionMemory.scala 70:27 71:11 73:11]
  wire [6:0] count = _GEN_390[6:0];
  wire  bufferEmpty = count == 7'h0; // @[InstructionMemory.scala 39:24]
  wire [7:0] _bufferFull_T_1 = 8'h80 - 8'h1; // @[InstructionMemory.scala 41:40]
  wire [7:0] _GEN_392 = {{1'd0}, count}; // @[InstructionMemory.scala 41:23]
  wire  bufferFull = _GEN_392 >= _bufferFull_T_1; // @[InstructionMemory.scala 41:23]
  reg [31:0] mem_0; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_1; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_2; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_3; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_4; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_5; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_6; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_7; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_8; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_9; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_10; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_11; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_12; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_13; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_14; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_15; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_16; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_17; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_18; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_19; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_20; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_21; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_22; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_23; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_24; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_25; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_26; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_27; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_28; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_29; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_30; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_31; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_32; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_33; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_34; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_35; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_36; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_37; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_38; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_39; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_40; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_41; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_42; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_43; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_44; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_45; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_46; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_47; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_48; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_49; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_50; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_51; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_52; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_53; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_54; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_55; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_56; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_57; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_58; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_59; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_60; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_61; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_62; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_63; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_64; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_65; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_66; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_67; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_68; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_69; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_70; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_71; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_72; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_73; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_74; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_75; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_76; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_77; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_78; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_79; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_80; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_81; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_82; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_83; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_84; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_85; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_86; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_87; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_88; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_89; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_90; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_91; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_92; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_93; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_94; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_95; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_96; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_97; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_98; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_99; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_100; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_101; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_102; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_103; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_104; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_105; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_106; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_107; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_108; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_109; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_110; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_111; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_112; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_113; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_114; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_115; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_116; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_117; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_118; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_119; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_120; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_121; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_122; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_123; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_124; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_125; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_126; // @[InstructionMemory.scala 47:20]
  reg [31:0] mem_127; // @[InstructionMemory.scala 47:20]
  wire [29:0] _GEN_129 = io_memIO_valid & ~bufferEmpty ? io_memIO_addr[31:2] : 30'h0; // @[InstructionMemory.scala 50:40 51:14]
  wire [6:0] readAddr = _GEN_129[6:0];
  wire [31:0] _GEN_1 = 7'h1 == readAddr ? mem_1 : mem_0; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_2 = 7'h2 == readAddr ? mem_2 : _GEN_1; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_3 = 7'h3 == readAddr ? mem_3 : _GEN_2; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_4 = 7'h4 == readAddr ? mem_4 : _GEN_3; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_5 = 7'h5 == readAddr ? mem_5 : _GEN_4; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_6 = 7'h6 == readAddr ? mem_6 : _GEN_5; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_7 = 7'h7 == readAddr ? mem_7 : _GEN_6; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_8 = 7'h8 == readAddr ? mem_8 : _GEN_7; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_9 = 7'h9 == readAddr ? mem_9 : _GEN_8; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_10 = 7'ha == readAddr ? mem_10 : _GEN_9; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_11 = 7'hb == readAddr ? mem_11 : _GEN_10; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_12 = 7'hc == readAddr ? mem_12 : _GEN_11; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_13 = 7'hd == readAddr ? mem_13 : _GEN_12; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_14 = 7'he == readAddr ? mem_14 : _GEN_13; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_15 = 7'hf == readAddr ? mem_15 : _GEN_14; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_16 = 7'h10 == readAddr ? mem_16 : _GEN_15; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_17 = 7'h11 == readAddr ? mem_17 : _GEN_16; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_18 = 7'h12 == readAddr ? mem_18 : _GEN_17; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_19 = 7'h13 == readAddr ? mem_19 : _GEN_18; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_20 = 7'h14 == readAddr ? mem_20 : _GEN_19; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_21 = 7'h15 == readAddr ? mem_21 : _GEN_20; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_22 = 7'h16 == readAddr ? mem_22 : _GEN_21; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_23 = 7'h17 == readAddr ? mem_23 : _GEN_22; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_24 = 7'h18 == readAddr ? mem_24 : _GEN_23; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_25 = 7'h19 == readAddr ? mem_25 : _GEN_24; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_26 = 7'h1a == readAddr ? mem_26 : _GEN_25; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_27 = 7'h1b == readAddr ? mem_27 : _GEN_26; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_28 = 7'h1c == readAddr ? mem_28 : _GEN_27; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_29 = 7'h1d == readAddr ? mem_29 : _GEN_28; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_30 = 7'h1e == readAddr ? mem_30 : _GEN_29; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_31 = 7'h1f == readAddr ? mem_31 : _GEN_30; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_32 = 7'h20 == readAddr ? mem_32 : _GEN_31; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_33 = 7'h21 == readAddr ? mem_33 : _GEN_32; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_34 = 7'h22 == readAddr ? mem_34 : _GEN_33; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_35 = 7'h23 == readAddr ? mem_35 : _GEN_34; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_36 = 7'h24 == readAddr ? mem_36 : _GEN_35; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_37 = 7'h25 == readAddr ? mem_37 : _GEN_36; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_38 = 7'h26 == readAddr ? mem_38 : _GEN_37; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_39 = 7'h27 == readAddr ? mem_39 : _GEN_38; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_40 = 7'h28 == readAddr ? mem_40 : _GEN_39; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_41 = 7'h29 == readAddr ? mem_41 : _GEN_40; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_42 = 7'h2a == readAddr ? mem_42 : _GEN_41; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_43 = 7'h2b == readAddr ? mem_43 : _GEN_42; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_44 = 7'h2c == readAddr ? mem_44 : _GEN_43; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_45 = 7'h2d == readAddr ? mem_45 : _GEN_44; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_46 = 7'h2e == readAddr ? mem_46 : _GEN_45; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_47 = 7'h2f == readAddr ? mem_47 : _GEN_46; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_48 = 7'h30 == readAddr ? mem_48 : _GEN_47; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_49 = 7'h31 == readAddr ? mem_49 : _GEN_48; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_50 = 7'h32 == readAddr ? mem_50 : _GEN_49; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_51 = 7'h33 == readAddr ? mem_51 : _GEN_50; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_52 = 7'h34 == readAddr ? mem_52 : _GEN_51; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_53 = 7'h35 == readAddr ? mem_53 : _GEN_52; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_54 = 7'h36 == readAddr ? mem_54 : _GEN_53; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_55 = 7'h37 == readAddr ? mem_55 : _GEN_54; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_56 = 7'h38 == readAddr ? mem_56 : _GEN_55; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_57 = 7'h39 == readAddr ? mem_57 : _GEN_56; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_58 = 7'h3a == readAddr ? mem_58 : _GEN_57; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_59 = 7'h3b == readAddr ? mem_59 : _GEN_58; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_60 = 7'h3c == readAddr ? mem_60 : _GEN_59; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_61 = 7'h3d == readAddr ? mem_61 : _GEN_60; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_62 = 7'h3e == readAddr ? mem_62 : _GEN_61; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_63 = 7'h3f == readAddr ? mem_63 : _GEN_62; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_64 = 7'h40 == readAddr ? mem_64 : _GEN_63; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_65 = 7'h41 == readAddr ? mem_65 : _GEN_64; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_66 = 7'h42 == readAddr ? mem_66 : _GEN_65; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_67 = 7'h43 == readAddr ? mem_67 : _GEN_66; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_68 = 7'h44 == readAddr ? mem_68 : _GEN_67; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_69 = 7'h45 == readAddr ? mem_69 : _GEN_68; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_70 = 7'h46 == readAddr ? mem_70 : _GEN_69; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_71 = 7'h47 == readAddr ? mem_71 : _GEN_70; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_72 = 7'h48 == readAddr ? mem_72 : _GEN_71; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_73 = 7'h49 == readAddr ? mem_73 : _GEN_72; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_74 = 7'h4a == readAddr ? mem_74 : _GEN_73; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_75 = 7'h4b == readAddr ? mem_75 : _GEN_74; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_76 = 7'h4c == readAddr ? mem_76 : _GEN_75; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_77 = 7'h4d == readAddr ? mem_77 : _GEN_76; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_78 = 7'h4e == readAddr ? mem_78 : _GEN_77; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_79 = 7'h4f == readAddr ? mem_79 : _GEN_78; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_80 = 7'h50 == readAddr ? mem_80 : _GEN_79; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_81 = 7'h51 == readAddr ? mem_81 : _GEN_80; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_82 = 7'h52 == readAddr ? mem_82 : _GEN_81; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_83 = 7'h53 == readAddr ? mem_83 : _GEN_82; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_84 = 7'h54 == readAddr ? mem_84 : _GEN_83; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_85 = 7'h55 == readAddr ? mem_85 : _GEN_84; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_86 = 7'h56 == readAddr ? mem_86 : _GEN_85; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_87 = 7'h57 == readAddr ? mem_87 : _GEN_86; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_88 = 7'h58 == readAddr ? mem_88 : _GEN_87; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_89 = 7'h59 == readAddr ? mem_89 : _GEN_88; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_90 = 7'h5a == readAddr ? mem_90 : _GEN_89; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_91 = 7'h5b == readAddr ? mem_91 : _GEN_90; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_92 = 7'h5c == readAddr ? mem_92 : _GEN_91; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_93 = 7'h5d == readAddr ? mem_93 : _GEN_92; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_94 = 7'h5e == readAddr ? mem_94 : _GEN_93; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_95 = 7'h5f == readAddr ? mem_95 : _GEN_94; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_96 = 7'h60 == readAddr ? mem_96 : _GEN_95; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_97 = 7'h61 == readAddr ? mem_97 : _GEN_96; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_98 = 7'h62 == readAddr ? mem_98 : _GEN_97; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_99 = 7'h63 == readAddr ? mem_99 : _GEN_98; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_100 = 7'h64 == readAddr ? mem_100 : _GEN_99; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_101 = 7'h65 == readAddr ? mem_101 : _GEN_100; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_102 = 7'h66 == readAddr ? mem_102 : _GEN_101; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_103 = 7'h67 == readAddr ? mem_103 : _GEN_102; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_104 = 7'h68 == readAddr ? mem_104 : _GEN_103; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_105 = 7'h69 == readAddr ? mem_105 : _GEN_104; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_106 = 7'h6a == readAddr ? mem_106 : _GEN_105; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_107 = 7'h6b == readAddr ? mem_107 : _GEN_106; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_108 = 7'h6c == readAddr ? mem_108 : _GEN_107; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_109 = 7'h6d == readAddr ? mem_109 : _GEN_108; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_110 = 7'h6e == readAddr ? mem_110 : _GEN_109; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_111 = 7'h6f == readAddr ? mem_111 : _GEN_110; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_112 = 7'h70 == readAddr ? mem_112 : _GEN_111; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_113 = 7'h71 == readAddr ? mem_113 : _GEN_112; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_114 = 7'h72 == readAddr ? mem_114 : _GEN_113; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_115 = 7'h73 == readAddr ? mem_115 : _GEN_114; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_116 = 7'h74 == readAddr ? mem_116 : _GEN_115; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_117 = 7'h75 == readAddr ? mem_117 : _GEN_116; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_118 = 7'h76 == readAddr ? mem_118 : _GEN_117; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_119 = 7'h77 == readAddr ? mem_119 : _GEN_118; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_120 = 7'h78 == readAddr ? mem_120 : _GEN_119; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_121 = 7'h79 == readAddr ? mem_121 : _GEN_120; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_122 = 7'h7a == readAddr ? mem_122 : _GEN_121; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_123 = 7'h7b == readAddr ? mem_123 : _GEN_122; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_124 = 7'h7c == readAddr ? mem_124 : _GEN_123; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_125 = 7'h7d == readAddr ? mem_125 : _GEN_124; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_126 = 7'h7e == readAddr ? mem_126 : _GEN_125; // @[InstructionMemory.scala 52:{15,15}]
  wire [31:0] _GEN_127 = 7'h7f == readAddr ? mem_127 : _GEN_126; // @[InstructionMemory.scala 52:{15,15}]
  wire [6:0] _readPtr_T_1 = readPtr + 7'h1; // @[InstructionMemory.scala 53:24]
  wire [6:0] _writePtr_T_1 = writePtr + 7'h1; // @[InstructionMemory.scala 62:26]
  assign io_memIO_nonEmpty = count == 7'h0; // @[InstructionMemory.scala 39:24]
  assign io_memOut = io_memIO_valid & ~bufferEmpty ? _GEN_127 : 32'h0; // @[InstructionMemory.scala 29:13 50:40 52:15]
  always @(posedge clock) begin
    if (reset) begin // @[InstructionMemory.scala 34:24]
      readPtr <= 7'h0; // @[InstructionMemory.scala 34:24]
    end else if (io_memIO_valid & ~bufferEmpty) begin // @[InstructionMemory.scala 50:40]
      readPtr <= _readPtr_T_1;
    end
    if (reset) begin // @[InstructionMemory.scala 35:25]
      writePtr <= 7'h0; // @[InstructionMemory.scala 35:25]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      writePtr <= _writePtr_T_1;
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_0 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h0 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_0 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_1 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_1 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_2 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_2 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_3 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_3 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_4 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_4 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_5 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_5 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_6 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_6 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_7 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_7 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_8 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h8 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_8 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_9 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h9 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_9 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_10 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'ha == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_10 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_11 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'hb == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_11 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_12 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'hc == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_12 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_13 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'hd == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_13 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_14 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'he == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_14 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_15 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'hf == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_15 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_16 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h10 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_16 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_17 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h11 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_17 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_18 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h12 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_18 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_19 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h13 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_19 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_20 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h14 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_20 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_21 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h15 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_21 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_22 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h16 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_22 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_23 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h17 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_23 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_24 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h18 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_24 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_25 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h19 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_25 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_26 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_26 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_27 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_27 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_28 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_28 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_29 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_29 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_30 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_30 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_31 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h1f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_31 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_32 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h20 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_32 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_33 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h21 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_33 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_34 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h22 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_34 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_35 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h23 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_35 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_36 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h24 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_36 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_37 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h25 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_37 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_38 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h26 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_38 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_39 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h27 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_39 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_40 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h28 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_40 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_41 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h29 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_41 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_42 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_42 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_43 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_43 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_44 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_44 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_45 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_45 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_46 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_46 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_47 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h2f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_47 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_48 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h30 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_48 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_49 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h31 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_49 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_50 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h32 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_50 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_51 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h33 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_51 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_52 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h34 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_52 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_53 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h35 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_53 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_54 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h36 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_54 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_55 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h37 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_55 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_56 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h38 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_56 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_57 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h39 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_57 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_58 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_58 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_59 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_59 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_60 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_60 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_61 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_61 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_62 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_62 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_63 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h3f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_63 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_64 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h40 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_64 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_65 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h41 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_65 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_66 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h42 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_66 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_67 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h43 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_67 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_68 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h44 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_68 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_69 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h45 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_69 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_70 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h46 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_70 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_71 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h47 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_71 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_72 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h48 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_72 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_73 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h49 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_73 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_74 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_74 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_75 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_75 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_76 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_76 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_77 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_77 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_78 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_78 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_79 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h4f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_79 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_80 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h50 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_80 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_81 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h51 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_81 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_82 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h52 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_82 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_83 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h53 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_83 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_84 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h54 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_84 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_85 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h55 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_85 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_86 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h56 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_86 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_87 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h57 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_87 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_88 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h58 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_88 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_89 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h59 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_89 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_90 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_90 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_91 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_91 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_92 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_92 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_93 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_93 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_94 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_94 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_95 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h5f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_95 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_96 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h60 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_96 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_97 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h61 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_97 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_98 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h62 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_98 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_99 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h63 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_99 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_100 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h64 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_100 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_101 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h65 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_101 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_102 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h66 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_102 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_103 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h67 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_103 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_104 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h68 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_104 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_105 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h69 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_105 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_106 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_106 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_107 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_107 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_108 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_108 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_109 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_109 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_110 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_110 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_111 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h6f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_111 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_112 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h70 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_112 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_113 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h71 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_113 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_114 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h72 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_114 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_115 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h73 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_115 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_116 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h74 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_116 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_117 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h75 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_117 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_118 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h76 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_118 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_119 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h77 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_119 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_120 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h78 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_120 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_121 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h79 == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_121 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_122 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7a == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_122 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_123 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7b == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_123 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_124 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7c == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_124 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_125 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7d == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_125 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_126 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7e == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_126 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
    if (reset) begin // @[InstructionMemory.scala 47:20]
      mem_127 <= 32'h0; // @[InstructionMemory.scala 47:20]
    end else if (io_writer_ready & ~bufferFull) begin // @[InstructionMemory.scala 60:40]
      if (7'h7f == writePtr) begin // @[InstructionMemory.scala 61:19]
        mem_127 <= io_writer_data; // @[InstructionMemory.scala 61:19]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  readPtr = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  writePtr = _RAND_1[6:0];
  _RAND_2 = {1{`RANDOM}};
  mem_0 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mem_1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  mem_2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  mem_3 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  mem_4 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  mem_5 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  mem_6 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  mem_7 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  mem_8 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  mem_9 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  mem_10 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  mem_11 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  mem_12 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  mem_13 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mem_14 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mem_15 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mem_16 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mem_17 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mem_18 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  mem_19 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  mem_20 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  mem_21 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  mem_22 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  mem_23 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  mem_24 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  mem_25 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  mem_26 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  mem_27 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  mem_28 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  mem_29 = _RAND_31[31:0];
  _RAND_32 = {1{`RANDOM}};
  mem_30 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  mem_31 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  mem_32 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  mem_33 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  mem_34 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  mem_35 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  mem_36 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  mem_37 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  mem_38 = _RAND_40[31:0];
  _RAND_41 = {1{`RANDOM}};
  mem_39 = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  mem_40 = _RAND_42[31:0];
  _RAND_43 = {1{`RANDOM}};
  mem_41 = _RAND_43[31:0];
  _RAND_44 = {1{`RANDOM}};
  mem_42 = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  mem_43 = _RAND_45[31:0];
  _RAND_46 = {1{`RANDOM}};
  mem_44 = _RAND_46[31:0];
  _RAND_47 = {1{`RANDOM}};
  mem_45 = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  mem_46 = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  mem_47 = _RAND_49[31:0];
  _RAND_50 = {1{`RANDOM}};
  mem_48 = _RAND_50[31:0];
  _RAND_51 = {1{`RANDOM}};
  mem_49 = _RAND_51[31:0];
  _RAND_52 = {1{`RANDOM}};
  mem_50 = _RAND_52[31:0];
  _RAND_53 = {1{`RANDOM}};
  mem_51 = _RAND_53[31:0];
  _RAND_54 = {1{`RANDOM}};
  mem_52 = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  mem_53 = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  mem_54 = _RAND_56[31:0];
  _RAND_57 = {1{`RANDOM}};
  mem_55 = _RAND_57[31:0];
  _RAND_58 = {1{`RANDOM}};
  mem_56 = _RAND_58[31:0];
  _RAND_59 = {1{`RANDOM}};
  mem_57 = _RAND_59[31:0];
  _RAND_60 = {1{`RANDOM}};
  mem_58 = _RAND_60[31:0];
  _RAND_61 = {1{`RANDOM}};
  mem_59 = _RAND_61[31:0];
  _RAND_62 = {1{`RANDOM}};
  mem_60 = _RAND_62[31:0];
  _RAND_63 = {1{`RANDOM}};
  mem_61 = _RAND_63[31:0];
  _RAND_64 = {1{`RANDOM}};
  mem_62 = _RAND_64[31:0];
  _RAND_65 = {1{`RANDOM}};
  mem_63 = _RAND_65[31:0];
  _RAND_66 = {1{`RANDOM}};
  mem_64 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  mem_65 = _RAND_67[31:0];
  _RAND_68 = {1{`RANDOM}};
  mem_66 = _RAND_68[31:0];
  _RAND_69 = {1{`RANDOM}};
  mem_67 = _RAND_69[31:0];
  _RAND_70 = {1{`RANDOM}};
  mem_68 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  mem_69 = _RAND_71[31:0];
  _RAND_72 = {1{`RANDOM}};
  mem_70 = _RAND_72[31:0];
  _RAND_73 = {1{`RANDOM}};
  mem_71 = _RAND_73[31:0];
  _RAND_74 = {1{`RANDOM}};
  mem_72 = _RAND_74[31:0];
  _RAND_75 = {1{`RANDOM}};
  mem_73 = _RAND_75[31:0];
  _RAND_76 = {1{`RANDOM}};
  mem_74 = _RAND_76[31:0];
  _RAND_77 = {1{`RANDOM}};
  mem_75 = _RAND_77[31:0];
  _RAND_78 = {1{`RANDOM}};
  mem_76 = _RAND_78[31:0];
  _RAND_79 = {1{`RANDOM}};
  mem_77 = _RAND_79[31:0];
  _RAND_80 = {1{`RANDOM}};
  mem_78 = _RAND_80[31:0];
  _RAND_81 = {1{`RANDOM}};
  mem_79 = _RAND_81[31:0];
  _RAND_82 = {1{`RANDOM}};
  mem_80 = _RAND_82[31:0];
  _RAND_83 = {1{`RANDOM}};
  mem_81 = _RAND_83[31:0];
  _RAND_84 = {1{`RANDOM}};
  mem_82 = _RAND_84[31:0];
  _RAND_85 = {1{`RANDOM}};
  mem_83 = _RAND_85[31:0];
  _RAND_86 = {1{`RANDOM}};
  mem_84 = _RAND_86[31:0];
  _RAND_87 = {1{`RANDOM}};
  mem_85 = _RAND_87[31:0];
  _RAND_88 = {1{`RANDOM}};
  mem_86 = _RAND_88[31:0];
  _RAND_89 = {1{`RANDOM}};
  mem_87 = _RAND_89[31:0];
  _RAND_90 = {1{`RANDOM}};
  mem_88 = _RAND_90[31:0];
  _RAND_91 = {1{`RANDOM}};
  mem_89 = _RAND_91[31:0];
  _RAND_92 = {1{`RANDOM}};
  mem_90 = _RAND_92[31:0];
  _RAND_93 = {1{`RANDOM}};
  mem_91 = _RAND_93[31:0];
  _RAND_94 = {1{`RANDOM}};
  mem_92 = _RAND_94[31:0];
  _RAND_95 = {1{`RANDOM}};
  mem_93 = _RAND_95[31:0];
  _RAND_96 = {1{`RANDOM}};
  mem_94 = _RAND_96[31:0];
  _RAND_97 = {1{`RANDOM}};
  mem_95 = _RAND_97[31:0];
  _RAND_98 = {1{`RANDOM}};
  mem_96 = _RAND_98[31:0];
  _RAND_99 = {1{`RANDOM}};
  mem_97 = _RAND_99[31:0];
  _RAND_100 = {1{`RANDOM}};
  mem_98 = _RAND_100[31:0];
  _RAND_101 = {1{`RANDOM}};
  mem_99 = _RAND_101[31:0];
  _RAND_102 = {1{`RANDOM}};
  mem_100 = _RAND_102[31:0];
  _RAND_103 = {1{`RANDOM}};
  mem_101 = _RAND_103[31:0];
  _RAND_104 = {1{`RANDOM}};
  mem_102 = _RAND_104[31:0];
  _RAND_105 = {1{`RANDOM}};
  mem_103 = _RAND_105[31:0];
  _RAND_106 = {1{`RANDOM}};
  mem_104 = _RAND_106[31:0];
  _RAND_107 = {1{`RANDOM}};
  mem_105 = _RAND_107[31:0];
  _RAND_108 = {1{`RANDOM}};
  mem_106 = _RAND_108[31:0];
  _RAND_109 = {1{`RANDOM}};
  mem_107 = _RAND_109[31:0];
  _RAND_110 = {1{`RANDOM}};
  mem_108 = _RAND_110[31:0];
  _RAND_111 = {1{`RANDOM}};
  mem_109 = _RAND_111[31:0];
  _RAND_112 = {1{`RANDOM}};
  mem_110 = _RAND_112[31:0];
  _RAND_113 = {1{`RANDOM}};
  mem_111 = _RAND_113[31:0];
  _RAND_114 = {1{`RANDOM}};
  mem_112 = _RAND_114[31:0];
  _RAND_115 = {1{`RANDOM}};
  mem_113 = _RAND_115[31:0];
  _RAND_116 = {1{`RANDOM}};
  mem_114 = _RAND_116[31:0];
  _RAND_117 = {1{`RANDOM}};
  mem_115 = _RAND_117[31:0];
  _RAND_118 = {1{`RANDOM}};
  mem_116 = _RAND_118[31:0];
  _RAND_119 = {1{`RANDOM}};
  mem_117 = _RAND_119[31:0];
  _RAND_120 = {1{`RANDOM}};
  mem_118 = _RAND_120[31:0];
  _RAND_121 = {1{`RANDOM}};
  mem_119 = _RAND_121[31:0];
  _RAND_122 = {1{`RANDOM}};
  mem_120 = _RAND_122[31:0];
  _RAND_123 = {1{`RANDOM}};
  mem_121 = _RAND_123[31:0];
  _RAND_124 = {1{`RANDOM}};
  mem_122 = _RAND_124[31:0];
  _RAND_125 = {1{`RANDOM}};
  mem_123 = _RAND_125[31:0];
  _RAND_126 = {1{`RANDOM}};
  mem_124 = _RAND_126[31:0];
  _RAND_127 = {1{`RANDOM}};
  mem_125 = _RAND_127[31:0];
  _RAND_128 = {1{`RANDOM}};
  mem_126 = _RAND_128[31:0];
  _RAND_129 = {1{`RANDOM}};
  mem_127 = _RAND_129[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module IF(
  input         clock,
  input         reset,
  input         io_stallReg,
  input         io_flush,
  output [31:0] io_out_inst,
  output [31:0] io_out_pc,
  input  [31:0] io_newPCValue,
  input         io_changePC,
  input         io_memIO_ready,
  input  [31:0] io_memIO_writeData,
  input         io_startPC
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  PC_clock; // @[IF.scala 23:18]
  wire  PC_reset; // @[IF.scala 23:18]
  wire  PC_io_memIO_ready; // @[IF.scala 23:18]
  wire  PC_io_memIO_valid; // @[IF.scala 23:18]
  wire [31:0] PC_io_memIO_addr; // @[IF.scala 23:18]
  wire [31:0] PC_io_in; // @[IF.scala 23:18]
  wire  instMem_clock; // @[IF.scala 25:23]
  wire  instMem_reset; // @[IF.scala 25:23]
  wire  instMem_io_memIO_valid; // @[IF.scala 25:23]
  wire  instMem_io_memIO_nonEmpty; // @[IF.scala 25:23]
  wire [31:0] instMem_io_memIO_addr; // @[IF.scala 25:23]
  wire  instMem_io_writer_ready; // @[IF.scala 25:23]
  wire [31:0] instMem_io_writer_data; // @[IF.scala 25:23]
  wire [31:0] instMem_io_memOut; // @[IF.scala 25:23]
  reg [31:0] outReg_inst; // @[Reg.scala 19:16]
  reg [31:0] outReg_pc; // @[Reg.scala 19:16]
  wire [31:0] pc = PC_io_memIO_addr;
  wire [31:0] addr = io_changePC ? io_newPCValue : pc; // @[IF.scala 45:17]
  wire [31:0] _PC_io_in_T_1 = pc + 32'h4; // @[IF.scala 50:28]
  wire [31:0] _PC_io_in_T_2 = io_stallReg ? pc : _PC_io_in_T_1; // @[Mux.scala 101:16]
  wire [31:0] _PC_io_in_T_3 = io_changePC ? io_newPCValue : _PC_io_in_T_2; // @[Mux.scala 101:16]
  ProgramCounter PC ( // @[IF.scala 23:18]
    .clock(PC_clock),
    .reset(PC_reset),
    .io_memIO_ready(PC_io_memIO_ready),
    .io_memIO_valid(PC_io_memIO_valid),
    .io_memIO_addr(PC_io_memIO_addr),
    .io_in(PC_io_in)
  );
  InstructionMemory instMem ( // @[IF.scala 25:23]
    .clock(instMem_clock),
    .reset(instMem_reset),
    .io_memIO_valid(instMem_io_memIO_valid),
    .io_memIO_nonEmpty(instMem_io_memIO_nonEmpty),
    .io_memIO_addr(instMem_io_memIO_addr),
    .io_writer_ready(instMem_io_writer_ready),
    .io_writer_data(instMem_io_writer_data),
    .io_memOut(instMem_io_memOut)
  );
  assign io_out_inst = outReg_inst; // @[IF.scala 66:15]
  assign io_out_pc = outReg_pc; // @[IF.scala 67:13]
  assign PC_clock = clock;
  assign PC_reset = reset;
  assign PC_io_memIO_ready = ~instMem_io_memIO_nonEmpty & io_startPC; // @[IF.scala 48:35]
  assign PC_io_in = ~instMem_io_memIO_nonEmpty & io_startPC ? _PC_io_in_T_3 : addr; // @[IF.scala 48:50 50:14 56:14]
  assign instMem_clock = clock;
  assign instMem_reset = reset;
  assign instMem_io_memIO_valid = PC_io_memIO_valid; // @[IF.scala 60:26]
  assign instMem_io_memIO_addr = io_changePC ? io_newPCValue : pc; // @[IF.scala 45:17]
  assign instMem_io_writer_ready = io_memIO_ready; // @[IF.scala 40:27]
  assign instMem_io_writer_data = io_memIO_writeData; // @[IF.scala 41:26]
  always @(posedge clock) begin
    if (io_flush) begin // @[IF.scala 62:23]
      outReg_inst <= 32'h0;
    end else begin
      outReg_inst <= instMem_io_memOut;
    end
    if (io_changePC) begin // @[IF.scala 45:17]
      outReg_pc <= io_newPCValue;
    end else begin
      outReg_pc <= pc;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  outReg_inst = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  outReg_pc = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ImmGenerator(
  input  [31:0] io_immIn,
  output [31:0] io_immOut
);
  wire [6:0] opcode = io_immIn[6:0]; // @[ImmGenerator.scala 16:36]
  wire [20:0] _immI_T_2 = io_immIn[31] ? 21'h1fffff : 21'h0; // @[Bitwise.scala 77:12]
  wire [31:0] immI = {_immI_T_2,io_immIn[30:20]}; // @[Cat.scala 33:92]
  wire [31:0] immS = {_immI_T_2,io_immIn[30:25],io_immIn[11:7]}; // @[Cat.scala 33:92]
  wire [19:0] _immB_T_2 = io_immIn[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] immB = {_immB_T_2,io_immIn[7],io_immIn[30:25],io_immIn[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] immU = {io_immIn[31:12],12'h0}; // @[Cat.scala 33:92]
  wire [10:0] _immJ_T_2 = io_immIn[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [30:0] immJ = {_immJ_T_2,io_immIn[19:12],io_immIn[20],io_immIn[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_0 = 7'h63 == opcode ? immB : immI; // @[ImmGenerator.scala 25:17 39:11]
  wire [31:0] _GEN_1 = 7'h23 == opcode ? immS : _GEN_0; // @[ImmGenerator.scala 25:17 36:10]
  wire [31:0] _GEN_2 = 7'h6f == opcode ? {{1'd0}, immJ} : _GEN_1; // @[ImmGenerator.scala 25:17 33:11]
  wire [31:0] _GEN_3 = 7'h17 == opcode ? immU : _GEN_2; // @[ImmGenerator.scala 25:17 30:11]
  assign io_immOut = 7'h37 == opcode ? immU : _GEN_3; // @[ImmGenerator.scala 25:17 27:11]
endmodule
module Decoder(
  input  [31:0] io_inInst,
  output [3:0]  io_aluOp,
  output [3:0]  io_memOp,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [4:0]  io_rd,
  output        io_ctrlSignals_useImm,
  output        io_ctrlSignals_useALU,
  output        io_ctrlSignals_branch,
  output        io_ctrlSignals_jump,
  output        io_ctrlSignals_load,
  output        io_ctrlSignals_store,
  output        io_ctrlSignals_changePC
);
  wire [6:0] op = io_inInst[6:0]; // @[Decoder.scala 42:34]
  wire  _op_T_9 = op == 7'h6f; // @[Decoder.scala 42:24]
  wire [2:0] funct3 = io_inInst[14:12]; // @[Decoder.scala 43:25]
  wire [6:0] funct7 = io_inInst[31:25]; // @[Decoder.scala 44:25]
  wire  _T_3 = 3'h0 == funct3; // @[Decoder.scala 53:21]
  wire  _T_4 = 3'h1 == funct3; // @[Decoder.scala 53:21]
  wire  _T_5 = 3'h2 == funct3; // @[Decoder.scala 53:21]
  wire [3:0] _GEN_0 = 3'h2 == funct3 ? 4'h2 : 4'h0; // @[Decoder.scala 31:12 53:21 61:20]
  wire [3:0] _GEN_1 = 3'h1 == funct3 ? 4'h1 : _GEN_0; // @[Decoder.scala 53:21 58:20]
  wire [3:0] _GEN_2 = 3'h0 == funct3 ? 4'h0 : _GEN_1; // @[Decoder.scala 53:21 55:20]
  wire  _T_12 = 3'h3 == funct3; // @[Decoder.scala 69:22]
  wire  _T_13 = 3'h6 == funct3; // @[Decoder.scala 69:22]
  wire  _T_14 = 3'h7 == funct3; // @[Decoder.scala 69:22]
  wire  _T_15 = 3'h5 == funct3; // @[Decoder.scala 69:22]
  wire  _T_16 = 7'h20 == funct7; // @[Decoder.scala 89:26]
  wire  _T_17 = 7'h0 == funct7; // @[Decoder.scala 89:26]
  wire [2:0] _GEN_3 = 7'h0 == funct7 ? 3'h7 : 3'h1; // @[Decoder.scala 39:12 89:26 94:24]
  wire [2:0] _GEN_4 = 7'h20 == funct7 ? 3'h6 : _GEN_3; // @[Decoder.scala 89:26 91:24]
  wire  _T_18 = 3'h4 == funct3; // @[Decoder.scala 69:22]
  wire [2:0] _GEN_5 = 3'h4 == funct3 ? 3'h5 : 3'h1; // @[Decoder.scala 39:12 69:22 99:20]
  wire [2:0] _GEN_6 = 3'h5 == funct3 ? _GEN_4 : _GEN_5; // @[Decoder.scala 69:22]
  wire [2:0] _GEN_7 = 3'h7 == funct3 ? 3'h3 : _GEN_6; // @[Decoder.scala 69:22 86:20]
  wire [2:0] _GEN_8 = 3'h6 == funct3 ? 3'h4 : _GEN_7; // @[Decoder.scala 69:22 83:20]
  wire [3:0] _GEN_9 = 3'h3 == funct3 ? 4'ha : {{1'd0}, _GEN_8}; // @[Decoder.scala 69:22 80:20]
  wire [3:0] _GEN_10 = _T_5 ? 4'h9 : _GEN_9; // @[Decoder.scala 69:22 77:20]
  wire [3:0] _GEN_11 = _T_4 ? 4'h8 : _GEN_10; // @[Decoder.scala 69:22 74:20]
  wire [3:0] _GEN_12 = _T_3 ? 4'h1 : _GEN_11; // @[Decoder.scala 69:22 71:20]
  wire [1:0] _GEN_16 = _T_16 ? 2'h2 : 2'h1; // @[Decoder.scala 129:28 134:26 39:12]
  wire [1:0] _GEN_17 = _T_17 ? 2'h1 : _GEN_16; // @[Decoder.scala 129:28 131:26]
  wire [1:0] _GEN_20 = _T_14 ? 2'h3 : 2'h1; // @[Decoder.scala 127:24 164:22 39:12]
  wire [2:0] _GEN_21 = _T_13 ? 3'h4 : {{1'd0}, _GEN_20}; // @[Decoder.scala 127:24 161:22]
  wire [2:0] _GEN_22 = _T_15 ? _GEN_4 : _GEN_21; // @[Decoder.scala 127:24]
  wire [2:0] _GEN_23 = _T_18 ? 3'h5 : _GEN_22; // @[Decoder.scala 127:24 148:22]
  wire [3:0] _GEN_24 = _T_12 ? 4'ha : {{1'd0}, _GEN_23}; // @[Decoder.scala 127:24 145:22]
  wire [3:0] _GEN_25 = _T_5 ? 4'h9 : _GEN_24; // @[Decoder.scala 127:24 142:22]
  wire [3:0] _GEN_26 = _T_4 ? 4'h8 : _GEN_25; // @[Decoder.scala 127:24 139:22]
  wire [3:0] _GEN_27 = _T_3 ? {{2'd0}, _GEN_17} : _GEN_26; // @[Decoder.scala 127:24]
  wire [3:0] _GEN_28 = _T_14 ? 4'hf : 4'h1; // @[Decoder.scala 176:23 193:22 39:12]
  wire [3:0] _GEN_29 = _T_13 ? 4'he : _GEN_28; // @[Decoder.scala 176:23 190:22]
  wire [3:0] _GEN_30 = _T_15 ? 4'hd : _GEN_29; // @[Decoder.scala 176:23 187:22]
  wire [3:0] _GEN_31 = _T_18 ? 4'hc : _GEN_30; // @[Decoder.scala 176:23 184:22]
  wire [3:0] _GEN_32 = _T_4 ? 4'h0 : _GEN_31; // @[Decoder.scala 176:23 181:22]
  wire [3:0] _GEN_33 = _T_3 ? 4'hb : _GEN_32; // @[Decoder.scala 176:23 178:22]
  wire  _GEN_36 = 7'h67 == op | 7'h6f == op; // @[Decoder.scala 47:14 198:29]
  wire [3:0] _GEN_41 = 7'h63 == op ? _GEN_33 : 4'h1; // @[Decoder.scala 39:12 47:14]
  wire  _GEN_42 = 7'h63 == op ? 1'h0 : _GEN_36; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_44 = 7'h63 == op ? 1'h0 : 7'h67 == op; // @[Decoder.scala 47:14 38:27]
  wire  _GEN_45 = 7'h37 == op | _GEN_42; // @[Decoder.scala 47:14 170:31]
  wire  _GEN_46 = 7'h37 == op | 7'h63 == op; // @[Decoder.scala 47:14 171:31]
  wire  _GEN_47 = 7'h37 == op ? 1'h0 : 7'h63 == op; // @[Decoder.scala 47:14 33:25]
  wire [3:0] _GEN_48 = 7'h37 == op ? 4'h1 : _GEN_41; // @[Decoder.scala 39:12 47:14]
  wire  _GEN_49 = 7'h37 == op ? 1'h0 : _GEN_42; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_50 = 7'h37 == op ? 1'h0 : _GEN_44; // @[Decoder.scala 47:14 38:27]
  wire  _GEN_51 = 7'h33 == op | _GEN_46; // @[Decoder.scala 47:14 126:31]
  wire [3:0] _GEN_52 = 7'h33 == op ? _GEN_27 : _GEN_48; // @[Decoder.scala 47:14]
  wire  _GEN_53 = 7'h33 == op ? 1'h0 : _GEN_45; // @[Decoder.scala 47:14 32:25]
  wire  _GEN_54 = 7'h33 == op ? 1'h0 : _GEN_47; // @[Decoder.scala 47:14 33:25]
  wire  _GEN_55 = 7'h33 == op ? 1'h0 : _GEN_49; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_56 = 7'h33 == op ? 1'h0 : _GEN_50; // @[Decoder.scala 47:14 38:27]
  wire  _GEN_57 = 7'h23 == op | _GEN_51; // @[Decoder.scala 47:14 109:31]
  wire  _GEN_59 = 7'h23 == op | _GEN_53; // @[Decoder.scala 47:14 111:31]
  wire [3:0] _GEN_60 = 7'h23 == op ? _GEN_2 : 4'h0; // @[Decoder.scala 31:12 47:14]
  wire [3:0] _GEN_61 = 7'h23 == op ? 4'h1 : _GEN_52; // @[Decoder.scala 39:12 47:14]
  wire  _GEN_62 = 7'h23 == op ? 1'h0 : _GEN_54; // @[Decoder.scala 47:14 33:25]
  wire  _GEN_63 = 7'h23 == op ? 1'h0 : _GEN_55; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_64 = 7'h23 == op ? 1'h0 : _GEN_56; // @[Decoder.scala 47:14 38:27]
  wire  _GEN_65 = 7'h17 == op | _GEN_59; // @[Decoder.scala 47:14 104:31]
  wire  _GEN_66 = 7'h17 == op | _GEN_57; // @[Decoder.scala 47:14 105:31]
  wire  _GEN_67 = 7'h17 == op ? 1'h0 : 7'h23 == op; // @[Decoder.scala 47:14 37:24]
  wire [3:0] _GEN_68 = 7'h17 == op ? 4'h0 : _GEN_60; // @[Decoder.scala 31:12 47:14]
  wire [3:0] _GEN_69 = 7'h17 == op ? 4'h1 : _GEN_61; // @[Decoder.scala 39:12 47:14]
  wire  _GEN_70 = 7'h17 == op ? 1'h0 : _GEN_62; // @[Decoder.scala 47:14 33:25]
  wire  _GEN_71 = 7'h17 == op ? 1'h0 : _GEN_63; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_72 = 7'h17 == op ? 1'h0 : _GEN_64; // @[Decoder.scala 47:14 38:27]
  wire  _GEN_73 = 7'h13 == op | _GEN_66; // @[Decoder.scala 47:14 67:29]
  wire  _GEN_74 = 7'h13 == op | _GEN_65; // @[Decoder.scala 47:14 68:29]
  wire [3:0] _GEN_75 = 7'h13 == op ? _GEN_12 : _GEN_69; // @[Decoder.scala 47:14]
  wire  _GEN_76 = 7'h13 == op ? 1'h0 : _GEN_67; // @[Decoder.scala 47:14 37:24]
  wire [3:0] _GEN_77 = 7'h13 == op ? 4'h0 : _GEN_68; // @[Decoder.scala 31:12 47:14]
  wire  _GEN_78 = 7'h13 == op ? 1'h0 : _GEN_70; // @[Decoder.scala 47:14 33:25]
  wire  _GEN_79 = 7'h13 == op ? 1'h0 : _GEN_71; // @[Decoder.scala 47:14 35:23]
  wire  _GEN_80 = 7'h13 == op ? 1'h0 : _GEN_72; // @[Decoder.scala 47:14 38:27]
  assign io_aluOp = 7'h3 == op ? 4'h1 : _GEN_75; // @[Decoder.scala 47:14 52:16]
  assign io_memOp = 7'h3 == op ? _GEN_2 : _GEN_77; // @[Decoder.scala 47:14]
  assign io_rs1 = _op_T_9 ? 5'h0 : io_inInst[19:15]; // @[Decoder.scala 209:18]
  assign io_rs2 = _op_T_9 ? 5'h0 : io_inInst[24:20]; // @[Decoder.scala 210:18]
  assign io_rd = io_inInst[11:7]; // @[Decoder.scala 211:23]
  assign io_ctrlSignals_useImm = 7'h3 == op | _GEN_74; // @[Decoder.scala 47:14 50:29]
  assign io_ctrlSignals_useALU = 7'h3 == op | _GEN_73; // @[Decoder.scala 47:14 51:29]
  assign io_ctrlSignals_branch = 7'h3 == op ? 1'h0 : _GEN_78; // @[Decoder.scala 47:14 33:25]
  assign io_ctrlSignals_jump = 7'h3 == op ? 1'h0 : _GEN_79; // @[Decoder.scala 47:14 35:23]
  assign io_ctrlSignals_load = 7'h3 == op; // @[Decoder.scala 47:14]
  assign io_ctrlSignals_store = 7'h3 == op ? 1'h0 : _GEN_76; // @[Decoder.scala 47:14 37:24]
  assign io_ctrlSignals_changePC = 7'h3 == op ? 1'h0 : _GEN_80; // @[Decoder.scala 47:14 38:27]
endmodule
module RegisterFile(
  input         clock,
  input         reset,
  input  [4:0]  io_rdAddr1,
  output [31:0] io_rdData1,
  input  [4:0]  io_rdAddr2,
  output [31:0] io_rdData2,
  input  [4:0]  io_wrAddr,
  input  [31:0] io_wrData,
  input         io_wren
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] registers_0; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_1; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_2; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_3; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_4; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_5; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_6; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_7; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_8; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_9; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_10; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_11; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_12; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_13; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_14; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_15; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_16; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_17; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_18; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_19; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_20; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_21; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_22; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_23; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_24; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_25; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_26; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_27; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_28; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_29; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_30; // @[RegisterFile.scala 26:26]
  reg [31:0] registers_31; // @[RegisterFile.scala 26:26]
  wire [31:0] _GEN_1 = 5'h1 == io_rdAddr1 ? registers_1 : registers_0; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_2 = 5'h2 == io_rdAddr1 ? registers_2 : _GEN_1; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_3 = 5'h3 == io_rdAddr1 ? registers_3 : _GEN_2; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_4 = 5'h4 == io_rdAddr1 ? registers_4 : _GEN_3; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_5 = 5'h5 == io_rdAddr1 ? registers_5 : _GEN_4; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_6 = 5'h6 == io_rdAddr1 ? registers_6 : _GEN_5; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_7 = 5'h7 == io_rdAddr1 ? registers_7 : _GEN_6; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_8 = 5'h8 == io_rdAddr1 ? registers_8 : _GEN_7; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_9 = 5'h9 == io_rdAddr1 ? registers_9 : _GEN_8; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_10 = 5'ha == io_rdAddr1 ? registers_10 : _GEN_9; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_11 = 5'hb == io_rdAddr1 ? registers_11 : _GEN_10; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_12 = 5'hc == io_rdAddr1 ? registers_12 : _GEN_11; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_13 = 5'hd == io_rdAddr1 ? registers_13 : _GEN_12; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_14 = 5'he == io_rdAddr1 ? registers_14 : _GEN_13; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_15 = 5'hf == io_rdAddr1 ? registers_15 : _GEN_14; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_16 = 5'h10 == io_rdAddr1 ? registers_16 : _GEN_15; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_17 = 5'h11 == io_rdAddr1 ? registers_17 : _GEN_16; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_18 = 5'h12 == io_rdAddr1 ? registers_18 : _GEN_17; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_19 = 5'h13 == io_rdAddr1 ? registers_19 : _GEN_18; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_20 = 5'h14 == io_rdAddr1 ? registers_20 : _GEN_19; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_21 = 5'h15 == io_rdAddr1 ? registers_21 : _GEN_20; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_22 = 5'h16 == io_rdAddr1 ? registers_22 : _GEN_21; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_23 = 5'h17 == io_rdAddr1 ? registers_23 : _GEN_22; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_24 = 5'h18 == io_rdAddr1 ? registers_24 : _GEN_23; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_25 = 5'h19 == io_rdAddr1 ? registers_25 : _GEN_24; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_26 = 5'h1a == io_rdAddr1 ? registers_26 : _GEN_25; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_27 = 5'h1b == io_rdAddr1 ? registers_27 : _GEN_26; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_28 = 5'h1c == io_rdAddr1 ? registers_28 : _GEN_27; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_29 = 5'h1d == io_rdAddr1 ? registers_29 : _GEN_28; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_30 = 5'h1e == io_rdAddr1 ? registers_30 : _GEN_29; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_31 = 5'h1f == io_rdAddr1 ? registers_31 : _GEN_30; // @[RegisterFile.scala 32:{18,18}]
  wire [31:0] _GEN_34 = 5'h1 == io_rdAddr2 ? registers_1 : registers_0; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_35 = 5'h2 == io_rdAddr2 ? registers_2 : _GEN_34; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_36 = 5'h3 == io_rdAddr2 ? registers_3 : _GEN_35; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_37 = 5'h4 == io_rdAddr2 ? registers_4 : _GEN_36; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_38 = 5'h5 == io_rdAddr2 ? registers_5 : _GEN_37; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_39 = 5'h6 == io_rdAddr2 ? registers_6 : _GEN_38; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_40 = 5'h7 == io_rdAddr2 ? registers_7 : _GEN_39; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_41 = 5'h8 == io_rdAddr2 ? registers_8 : _GEN_40; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_42 = 5'h9 == io_rdAddr2 ? registers_9 : _GEN_41; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_43 = 5'ha == io_rdAddr2 ? registers_10 : _GEN_42; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_44 = 5'hb == io_rdAddr2 ? registers_11 : _GEN_43; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_45 = 5'hc == io_rdAddr2 ? registers_12 : _GEN_44; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_46 = 5'hd == io_rdAddr2 ? registers_13 : _GEN_45; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_47 = 5'he == io_rdAddr2 ? registers_14 : _GEN_46; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_48 = 5'hf == io_rdAddr2 ? registers_15 : _GEN_47; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_49 = 5'h10 == io_rdAddr2 ? registers_16 : _GEN_48; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_50 = 5'h11 == io_rdAddr2 ? registers_17 : _GEN_49; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_51 = 5'h12 == io_rdAddr2 ? registers_18 : _GEN_50; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_52 = 5'h13 == io_rdAddr2 ? registers_19 : _GEN_51; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_53 = 5'h14 == io_rdAddr2 ? registers_20 : _GEN_52; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_54 = 5'h15 == io_rdAddr2 ? registers_21 : _GEN_53; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_55 = 5'h16 == io_rdAddr2 ? registers_22 : _GEN_54; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_56 = 5'h17 == io_rdAddr2 ? registers_23 : _GEN_55; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_57 = 5'h18 == io_rdAddr2 ? registers_24 : _GEN_56; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_58 = 5'h19 == io_rdAddr2 ? registers_25 : _GEN_57; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_59 = 5'h1a == io_rdAddr2 ? registers_26 : _GEN_58; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_60 = 5'h1b == io_rdAddr2 ? registers_27 : _GEN_59; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_61 = 5'h1c == io_rdAddr2 ? registers_28 : _GEN_60; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_62 = 5'h1d == io_rdAddr2 ? registers_29 : _GEN_61; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_63 = 5'h1e == io_rdAddr2 ? registers_30 : _GEN_62; // @[RegisterFile.scala 38:{18,18}]
  wire [31:0] _GEN_64 = 5'h1f == io_rdAddr2 ? registers_31 : _GEN_63; // @[RegisterFile.scala 38:{18,18}]
  assign io_rdData1 = io_rdAddr1 == 5'h0 ? 32'h0 : _GEN_31; // @[RegisterFile.scala 28:28 29:16 32:18]
  assign io_rdData2 = io_rdAddr2 == 5'h0 ? 32'h0 : _GEN_64; // @[RegisterFile.scala 34:28 35:16 38:18]
  always @(posedge clock) begin
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_0 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h0 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_0 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_1 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_1 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_2 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h2 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_2 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_3 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h3 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_3 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_4 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h4 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_4 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_5 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h5 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_5 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_6 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h6 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_6 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_7 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h7 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_7 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_8 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h8 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_8 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_9 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h9 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_9 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_10 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'ha == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_10 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_11 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'hb == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_11 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_12 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'hc == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_12 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_13 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'hd == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_13 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_14 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'he == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_14 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_15 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'hf == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_15 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_16 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h10 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_16 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_17 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h11 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_17 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_18 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h12 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_18 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_19 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h13 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_19 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_20 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h14 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_20 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_21 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h15 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_21 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_22 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h16 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_22 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_23 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h17 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_23 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_24 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h18 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_24 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_25 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h19 == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_25 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_26 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1a == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_26 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_27 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1b == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_27 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_28 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1c == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_28 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_29 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1d == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_29 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_30 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1e == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_30 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
    if (reset) begin // @[RegisterFile.scala 26:26]
      registers_31 <= 32'h0; // @[RegisterFile.scala 26:26]
    end else if (io_wren) begin // @[RegisterFile.scala 41:17]
      if (5'h1f == io_wrAddr) begin // @[RegisterFile.scala 42:26]
        registers_31 <= io_wrData; // @[RegisterFile.scala 42:26]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  registers_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  registers_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  registers_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  registers_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  registers_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  registers_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  registers_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  registers_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  registers_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  registers_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  registers_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  registers_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  registers_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  registers_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  registers_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  registers_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  registers_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  registers_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  registers_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  registers_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  registers_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  registers_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  registers_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  registers_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  registers_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  registers_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  registers_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  registers_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  registers_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  registers_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  registers_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  registers_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ID(
  input         clock,
  input         reset,
  input         io_stallReg,
  input         io_flush,
  input  [31:0] io_in_inst,
  input  [31:0] io_in_pc,
  input  [4:0]  io_wbIn_rd,
  input  [31:0] io_wbIn_muxOut,
  input         io_wbIn_writeEnable,
  output [31:0] io_out_pc,
  output [4:0]  io_out_rs1,
  output [4:0]  io_out_rs2,
  output [31:0] io_out_val1,
  output [31:0] io_out_val2,
  output [4:0]  io_out_rd,
  output [31:0] io_out_imm,
  output [3:0]  io_out_aluOp,
  output [3:0]  io_out_memOp,
  output        io_out_ctrl_useImm,
  output        io_out_ctrl_useALU,
  output        io_out_ctrl_branch,
  output        io_out_ctrl_jump,
  output        io_out_ctrl_load,
  output        io_out_ctrl_store,
  output        io_out_ctrl_changePC
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] immGenerator_io_immIn; // @[ID.scala 19:28]
  wire [31:0] immGenerator_io_immOut; // @[ID.scala 19:28]
  wire [31:0] decoder_io_inInst; // @[ID.scala 20:23]
  wire [3:0] decoder_io_aluOp; // @[ID.scala 20:23]
  wire [3:0] decoder_io_memOp; // @[ID.scala 20:23]
  wire [4:0] decoder_io_rs1; // @[ID.scala 20:23]
  wire [4:0] decoder_io_rs2; // @[ID.scala 20:23]
  wire [4:0] decoder_io_rd; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_useImm; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_useALU; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_branch; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_jump; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_load; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_store; // @[ID.scala 20:23]
  wire  decoder_io_ctrlSignals_changePC; // @[ID.scala 20:23]
  wire  regfile_clock; // @[ID.scala 21:23]
  wire  regfile_reset; // @[ID.scala 21:23]
  wire [4:0] regfile_io_rdAddr1; // @[ID.scala 21:23]
  wire [31:0] regfile_io_rdData1; // @[ID.scala 21:23]
  wire [4:0] regfile_io_rdAddr2; // @[ID.scala 21:23]
  wire [31:0] regfile_io_rdData2; // @[ID.scala 21:23]
  wire [4:0] regfile_io_wrAddr; // @[ID.scala 21:23]
  wire [31:0] regfile_io_wrData; // @[ID.scala 21:23]
  wire  regfile_io_wren; // @[ID.scala 21:23]
  wire  _io_out_ctrl_branch_T_1 = ~io_stallReg; // @[ID.scala 49:86]
  reg  io_out_ctrl_branch_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_load_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_store_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_jump_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_useALU_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_useImm_r; // @[Reg.scala 19:16]
  reg  io_out_ctrl_changePC_r; // @[Reg.scala 19:16]
  reg [3:0] io_out_aluOp_r; // @[Reg.scala 19:16]
  reg [4:0] io_out_rd_r; // @[Reg.scala 19:16]
  reg [31:0] io_out_val1_r; // @[Reg.scala 19:16]
  reg [31:0] io_out_val2_r; // @[Reg.scala 19:16]
  reg [31:0] io_out_imm_r; // @[Reg.scala 19:16]
  reg [31:0] io_out_pc_r; // @[Reg.scala 19:16]
  reg [4:0] io_out_rs1_r; // @[Reg.scala 19:16]
  reg [4:0] io_out_rs2_r; // @[Reg.scala 19:16]
  reg [3:0] io_out_memOp_r; // @[Reg.scala 19:16]
  ImmGenerator immGenerator ( // @[ID.scala 19:28]
    .io_immIn(immGenerator_io_immIn),
    .io_immOut(immGenerator_io_immOut)
  );
  Decoder decoder ( // @[ID.scala 20:23]
    .io_inInst(decoder_io_inInst),
    .io_aluOp(decoder_io_aluOp),
    .io_memOp(decoder_io_memOp),
    .io_rs1(decoder_io_rs1),
    .io_rs2(decoder_io_rs2),
    .io_rd(decoder_io_rd),
    .io_ctrlSignals_useImm(decoder_io_ctrlSignals_useImm),
    .io_ctrlSignals_useALU(decoder_io_ctrlSignals_useALU),
    .io_ctrlSignals_branch(decoder_io_ctrlSignals_branch),
    .io_ctrlSignals_jump(decoder_io_ctrlSignals_jump),
    .io_ctrlSignals_load(decoder_io_ctrlSignals_load),
    .io_ctrlSignals_store(decoder_io_ctrlSignals_store),
    .io_ctrlSignals_changePC(decoder_io_ctrlSignals_changePC)
  );
  RegisterFile regfile ( // @[ID.scala 21:23]
    .clock(regfile_clock),
    .reset(regfile_reset),
    .io_rdAddr1(regfile_io_rdAddr1),
    .io_rdData1(regfile_io_rdData1),
    .io_rdAddr2(regfile_io_rdAddr2),
    .io_rdData2(regfile_io_rdData2),
    .io_wrAddr(regfile_io_wrAddr),
    .io_wrData(regfile_io_wrData),
    .io_wren(regfile_io_wren)
  );
  assign io_out_pc = io_out_pc_r; // @[ID.scala 67:13]
  assign io_out_rs1 = io_out_rs1_r; // @[ID.scala 68:14]
  assign io_out_rs2 = io_out_rs2_r; // @[ID.scala 69:14]
  assign io_out_val1 = io_out_val1_r; // @[ID.scala 64:15]
  assign io_out_val2 = io_out_val2_r; // @[ID.scala 65:15]
  assign io_out_rd = io_out_rd_r; // @[ID.scala 63:13]
  assign io_out_imm = io_out_imm_r; // @[ID.scala 66:14]
  assign io_out_aluOp = io_out_aluOp_r; // @[ID.scala 62:16]
  assign io_out_memOp = io_out_memOp_r; // @[ID.scala 70:16]
  assign io_out_ctrl_useImm = io_out_ctrl_useImm_r; // @[ID.scala 54:22]
  assign io_out_ctrl_useALU = io_out_ctrl_useALU_r; // @[ID.scala 53:22]
  assign io_out_ctrl_branch = io_out_ctrl_branch_r; // @[ID.scala 49:22]
  assign io_out_ctrl_jump = io_out_ctrl_jump_r; // @[ID.scala 52:20]
  assign io_out_ctrl_load = io_out_ctrl_load_r; // @[ID.scala 50:20]
  assign io_out_ctrl_store = io_out_ctrl_store_r; // @[ID.scala 51:21]
  assign io_out_ctrl_changePC = io_out_ctrl_changePC_r; // @[ID.scala 55:24]
  assign immGenerator_io_immIn = io_in_inst; // @[ID.scala 38:25]
  assign decoder_io_inInst = io_in_inst; // @[ID.scala 39:21]
  assign regfile_clock = clock;
  assign regfile_reset = reset;
  assign regfile_io_rdAddr1 = decoder_io_rs1; // @[ID.scala 40:22]
  assign regfile_io_rdAddr2 = decoder_io_rs2; // @[ID.scala 41:22]
  assign regfile_io_wrAddr = io_wbIn_rd; // @[ID.scala 44:21]
  assign regfile_io_wrData = io_wbIn_muxOut; // @[ID.scala 45:21]
  assign regfile_io_wren = io_wbIn_writeEnable; // @[ID.scala 43:19]
  always @(posedge clock) begin
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 49:38]
        io_out_ctrl_branch_r <= 1'h0;
      end else begin
        io_out_ctrl_branch_r <= decoder_io_ctrlSignals_branch;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 50:36]
        io_out_ctrl_load_r <= 1'h0;
      end else begin
        io_out_ctrl_load_r <= decoder_io_ctrlSignals_load;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 51:37]
        io_out_ctrl_store_r <= 1'h0;
      end else begin
        io_out_ctrl_store_r <= decoder_io_ctrlSignals_store;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 52:36]
        io_out_ctrl_jump_r <= 1'h0;
      end else begin
        io_out_ctrl_jump_r <= decoder_io_ctrlSignals_jump;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 53:38]
        io_out_ctrl_useALU_r <= 1'h0;
      end else begin
        io_out_ctrl_useALU_r <= decoder_io_ctrlSignals_useALU;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 54:38]
        io_out_ctrl_useImm_r <= 1'h0;
      end else begin
        io_out_ctrl_useImm_r <= decoder_io_ctrlSignals_useImm;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 55:40]
        io_out_ctrl_changePC_r <= 1'h0;
      end else begin
        io_out_ctrl_changePC_r <= decoder_io_ctrlSignals_changePC;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 62:32]
        io_out_aluOp_r <= 4'h0;
      end else begin
        io_out_aluOp_r <= decoder_io_aluOp;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 63:29]
        io_out_rd_r <= 5'h0;
      end else begin
        io_out_rd_r <= decoder_io_rd;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 64:31]
        io_out_val1_r <= 32'h0;
      end else if (io_wbIn_writeEnable & io_wbIn_rd == decoder_io_rs1) begin // @[ID.scala 58:17]
        io_out_val1_r <= io_wbIn_muxOut;
      end else begin
        io_out_val1_r <= regfile_io_rdData1;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 65:31]
        io_out_val2_r <= 32'h0;
      end else if (io_wbIn_writeEnable & io_wbIn_rd == decoder_io_rs2) begin // @[ID.scala 59:17]
        io_out_val2_r <= io_wbIn_muxOut;
      end else begin
        io_out_val2_r <= regfile_io_rdData2;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 66:30]
        io_out_imm_r <= 32'h0;
      end else begin
        io_out_imm_r <= immGenerator_io_immOut;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 67:29]
        io_out_pc_r <= 32'h0;
      end else begin
        io_out_pc_r <= io_in_pc;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 68:30]
        io_out_rs1_r <= 5'h0;
      end else begin
        io_out_rs1_r <= decoder_io_rs1;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 69:30]
        io_out_rs2_r <= 5'h0;
      end else begin
        io_out_rs2_r <= decoder_io_rs2;
      end
    end
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 70:32]
        io_out_memOp_r <= 4'h0;
      end else begin
        io_out_memOp_r <= decoder_io_memOp;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_out_ctrl_branch_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_out_ctrl_load_r = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  io_out_ctrl_store_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  io_out_ctrl_jump_r = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  io_out_ctrl_useALU_r = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  io_out_ctrl_useImm_r = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_out_ctrl_changePC_r = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  io_out_aluOp_r = _RAND_7[3:0];
  _RAND_8 = {1{`RANDOM}};
  io_out_rd_r = _RAND_8[4:0];
  _RAND_9 = {1{`RANDOM}};
  io_out_val1_r = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  io_out_val2_r = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  io_out_imm_r = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  io_out_pc_r = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  io_out_rs1_r = _RAND_13[4:0];
  _RAND_14 = {1{`RANDOM}};
  io_out_rs2_r = _RAND_14[4:0];
  _RAND_15 = {1{`RANDOM}};
  io_out_memOp_r = _RAND_15[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input  [3:0]  io_aluOp,
  input  [31:0] io_val1,
  input  [31:0] io_val2,
  output [31:0] io_aluOut
);
  wire [31:0] _io_aluOut_T_1 = io_val1 + io_val2; // @[ALU.scala 23:41]
  wire [31:0] _io_aluOut_T_3 = io_val1 - io_val2; // @[ALU.scala 24:41]
  wire [31:0] _io_aluOut_T_4 = io_val1 & io_val2; // @[ALU.scala 26:41]
  wire [31:0] _io_aluOut_T_5 = io_val1 | io_val2; // @[ALU.scala 27:40]
  wire [31:0] _io_aluOut_T_6 = io_val1 ^ io_val2; // @[ALU.scala 28:41]
  wire [31:0] _io_aluOut_T_7 = io_val1; // @[ALU.scala 30:42]
  wire [31:0] _io_aluOut_T_10 = $signed(io_val1) >>> io_val2[4:0]; // @[ALU.scala 30:73]
  wire [31:0] _io_aluOut_T_12 = io_val1 >> io_val2[4:0]; // @[ALU.scala 31:41]
  wire [62:0] _GEN_16 = {{31'd0}, io_val1}; // @[ALU.scala 32:41]
  wire [62:0] _io_aluOut_T_14 = _GEN_16 << io_val2[4:0]; // @[ALU.scala 32:41]
  wire [31:0] _io_aluOut_T_16 = io_val2; // @[ALU.scala 34:62]
  wire  _io_aluOut_T_17 = $signed(io_val1) < $signed(io_val2); // @[ALU.scala 34:52]
  wire  _io_aluOut_T_19 = io_val1 < io_val2; // @[ALU.scala 35:46]
  wire [31:0] _GEN_0 = 4'hf == io_aluOp ? {{31'd0}, io_val1 >= io_val2} : 32'h0; // @[ALU.scala 17:13 21:13 41:31]
  wire [31:0] _GEN_1 = 4'he == io_aluOp ? {{31'd0}, _io_aluOut_T_19} : _GEN_0; // @[ALU.scala 21:13 40:31]
  wire [31:0] _GEN_2 = 4'h0 == io_aluOp ? {{31'd0}, $signed(_io_aluOut_T_7) != $signed(_io_aluOut_T_16)} : _GEN_1; // @[ALU.scala 21:13 39:30]
  wire [31:0] _GEN_3 = 4'hd == io_aluOp ? {{31'd0}, $signed(_io_aluOut_T_7) >= $signed(_io_aluOut_T_16)} : _GEN_2; // @[ALU.scala 21:13 38:30]
  wire [31:0] _GEN_4 = 4'hc == io_aluOp ? {{31'd0}, _io_aluOut_T_17} : _GEN_3; // @[ALU.scala 21:13 37:30]
  wire [31:0] _GEN_5 = 4'hb == io_aluOp ? {{31'd0}, io_val1 == io_val2} : _GEN_4; // @[ALU.scala 21:13 36:30]
  wire [31:0] _GEN_6 = 4'ha == io_aluOp ? {{31'd0}, io_val1 < io_val2} : _GEN_5; // @[ALU.scala 21:13 35:31]
  wire [31:0] _GEN_7 = 4'h9 == io_aluOp ? {{31'd0}, $signed(_io_aluOut_T_7) < $signed(_io_aluOut_T_16)} : _GEN_6; // @[ALU.scala 21:13 34:30]
  wire [62:0] _GEN_8 = 4'h8 == io_aluOp ? _io_aluOut_T_14 : {{31'd0}, _GEN_7}; // @[ALU.scala 21:13 32:30]
  wire [62:0] _GEN_9 = 4'h7 == io_aluOp ? {{31'd0}, _io_aluOut_T_12} : _GEN_8; // @[ALU.scala 21:13 31:30]
  wire [62:0] _GEN_10 = 4'h6 == io_aluOp ? {{31'd0}, _io_aluOut_T_10} : _GEN_9; // @[ALU.scala 21:13 30:30]
  wire [62:0] _GEN_11 = 4'h5 == io_aluOp ? {{31'd0}, _io_aluOut_T_6} : _GEN_10; // @[ALU.scala 21:13 28:30]
  wire [62:0] _GEN_12 = 4'h4 == io_aluOp ? {{31'd0}, _io_aluOut_T_5} : _GEN_11; // @[ALU.scala 21:13 27:29]
  wire [62:0] _GEN_13 = 4'h3 == io_aluOp ? {{31'd0}, _io_aluOut_T_4} : _GEN_12; // @[ALU.scala 21:13 26:30]
  wire [62:0] _GEN_14 = 4'h2 == io_aluOp ? {{31'd0}, _io_aluOut_T_3} : _GEN_13; // @[ALU.scala 21:13 24:30]
  wire [62:0] _GEN_15 = 4'h1 == io_aluOp ? {{31'd0}, _io_aluOut_T_1} : _GEN_14; // @[ALU.scala 21:13 23:30]
  assign io_aluOut = _GEN_15[31:0];
endmodule
module EX(
  input         clock,
  input         io_stallReg,
  input  [31:0] io_in_pc,
  input  [31:0] io_in_val1,
  input  [31:0] io_in_val2,
  input  [4:0]  io_in_rd,
  input  [31:0] io_in_imm,
  input  [3:0]  io_in_aluOp,
  input  [3:0]  io_in_memOp,
  input         io_in_ctrl_useImm,
  input         io_in_ctrl_useALU,
  input         io_in_ctrl_branch,
  input         io_in_ctrl_jump,
  input         io_in_ctrl_load,
  input         io_in_ctrl_store,
  input         io_in_ctrl_changePC,
  output [4:0]  io_out_rd,
  output [31:0] io_out_aluOut,
  output [31:0] io_out_wrData,
  output        io_out_ctrl_writeEnable,
  output        io_out_ctrl_store,
  output        io_out_ctrl_load,
  output [31:0] io_hazardAluOut,
  output        io_changePC,
  output [31:0] io_newPCValue
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] ALU_io_aluOp; // @[EX.scala 21:19]
  wire [31:0] ALU_io_val1; // @[EX.scala 21:19]
  wire [31:0] ALU_io_val2; // @[EX.scala 21:19]
  wire [31:0] ALU_io_aluOut; // @[EX.scala 21:19]
  wire  _outReg_T = ~io_stallReg; // @[EX.scala 25:34]
  reg [4:0] outReg_rd; // @[Reg.scala 19:16]
  reg [31:0] outReg_aluOut; // @[Reg.scala 19:16]
  reg [31:0] outReg_wrData; // @[Reg.scala 19:16]
  reg  outReg_ctrl_writeEnable; // @[Reg.scala 19:16]
  reg  outReg_ctrl_store; // @[Reg.scala 19:16]
  reg  outReg_ctrl_load; // @[Reg.scala 19:16]
  wire [31:0] _GEN_3 = _outReg_T ? io_out_wrData : outReg_wrData; // @[Reg.scala 19:16 20:{18,22}]
  wire [31:0] _outReg_aluOut_T_1 = io_in_pc + 32'h4; // @[EX.scala 31:50]
  wire [31:0] useImm = io_in_ctrl_useImm ? io_in_imm : io_in_val2; // @[EX.scala 38:19]
  wire [31:0] _newPCValue_T = io_in_ctrl_changePC ? io_in_val1 : io_in_pc; // @[EX.scala 42:28]
  wire [31:0] _newPCValue_T_2 = _newPCValue_T + io_in_imm; // @[EX.scala 42:72]
  wire  _T = io_in_memOp == 4'h2; // @[EX.scala 45:20]
  wire [31:0] _GEN_6 = io_in_memOp == 4'h2 ? io_in_val2 : _GEN_3; // @[EX.scala 45:28 46:19]
  wire  _T_1 = io_in_memOp == 4'h1; // @[EX.scala 48:20]
  wire [15:0] _outReg_wrData_T_2 = io_in_val2[15] ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _outReg_wrData_T_4 = {_outReg_wrData_T_2,io_in_val2[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_7 = io_in_memOp == 4'h1 ? _outReg_wrData_T_4 : _GEN_6; // @[EX.scala 48:28 49:19]
  wire [31:0] _outReg_wrData_T_7 = {16'h0,io_in_val2[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_8 = io_in_memOp == 4'h5 ? _outReg_wrData_T_7 : _GEN_7; // @[EX.scala 51:29 52:19]
  wire  _T_3 = io_in_memOp == 4'h0; // @[EX.scala 54:20]
  wire [23:0] _outReg_wrData_T_10 = io_in_val2[7] ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _outReg_wrData_T_12 = {_outReg_wrData_T_10,io_in_val2[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_9 = io_in_memOp == 4'h0 ? _outReg_wrData_T_12 : _GEN_8; // @[EX.scala 54:28 55:19]
  wire [31:0] _outReg_wrData_T_15 = {24'h0,io_in_val2[7:0]}; // @[Cat.scala 33:92]
  reg  io_changePC_REG; // @[EX.scala 85:25]
  reg [31:0] io_newPCValue_REG; // @[EX.scala 86:27]
  ALU ALU ( // @[EX.scala 21:19]
    .io_aluOp(ALU_io_aluOp),
    .io_val1(ALU_io_val1),
    .io_val2(ALU_io_val2),
    .io_aluOut(ALU_io_aluOut)
  );
  assign io_out_rd = outReg_rd; // @[EX.scala 82:13]
  assign io_out_aluOut = outReg_aluOut; // @[EX.scala 78:17]
  assign io_out_wrData = outReg_wrData; // @[EX.scala 83:17]
  assign io_out_ctrl_writeEnable = outReg_ctrl_writeEnable; // @[EX.scala 81:27]
  assign io_out_ctrl_store = outReg_ctrl_store; // @[EX.scala 80:21]
  assign io_out_ctrl_load = outReg_ctrl_load; // @[EX.scala 79:20]
  assign io_hazardAluOut = ALU_io_aluOut; // @[EX.scala 26:19]
  assign io_changePC = io_changePC_REG; // @[EX.scala 85:15]
  assign io_newPCValue = io_newPCValue_REG; // @[EX.scala 86:17]
  assign ALU_io_aluOp = io_in_aluOp; // @[EX.scala 30:16]
  assign ALU_io_val1 = io_in_ctrl_useALU ? io_in_val1 : 32'h0; // @[EX.scala 27:15 72:27 73:17]
  assign ALU_io_val2 = io_in_ctrl_useALU ? useImm : 32'h0; // @[EX.scala 28:15 72:27 74:17]
  always @(posedge clock) begin
    outReg_rd <= io_in_rd; // @[EX.scala 34:13]
    if (io_in_ctrl_jump) begin // @[EX.scala 31:23]
      outReg_aluOut <= _outReg_aluOut_T_1;
    end else begin
      outReg_aluOut <= ALU_io_aluOut;
    end
    if (_T_3) begin // @[EX.scala 68:28]
      outReg_wrData <= _outReg_wrData_T_15; // @[EX.scala 69:19]
    end else if (_T_1) begin // @[EX.scala 65:27]
      outReg_wrData <= _outReg_wrData_T_7; // @[EX.scala 66:19]
    end else if (_T) begin // @[EX.scala 62:27]
      outReg_wrData <= io_in_val2; // @[EX.scala 63:19]
    end else if (io_in_memOp == 4'h4) begin // @[EX.scala 57:29]
      outReg_wrData <= _outReg_wrData_T_15; // @[EX.scala 58:19]
    end else begin
      outReg_wrData <= _GEN_9;
    end
    outReg_ctrl_writeEnable <= ~(io_in_ctrl_branch | io_in_ctrl_store); // @[EX.scala 35:30]
    outReg_ctrl_store <= io_in_ctrl_store; // @[EX.scala 33:21]
    outReg_ctrl_load <= io_in_ctrl_load; // @[EX.scala 32:20]
    io_changePC_REG <= io_in_ctrl_jump | io_in_ctrl_branch & ALU_io_aluOut == 32'h1; // @[EX.scala 41:34]
    io_newPCValue_REG <= {_newPCValue_T_2[31:1],1'h0}; // @[Cat.scala 33:92]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  outReg_rd = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  outReg_aluOut = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  outReg_wrData = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  outReg_ctrl_writeEnable = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  outReg_ctrl_store = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  outReg_ctrl_load = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  io_changePC_REG = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  io_newPCValue_REG = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DualReadMem(
  input         clock,
  input         io_rden,
  input  [4:0]  io_rdAddr1,
  output [31:0] io_rdData1,
  input  [4:0]  io_wrAddr,
  input  [31:0] io_wrData,
  input         io_wren
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[DualReadMem.scala 35:43]
  wire  mem_rdData1_MPORT_en; // @[DualReadMem.scala 35:43]
  wire [9:0] mem_rdData1_MPORT_addr; // @[DualReadMem.scala 35:43]
  wire [31:0] mem_rdData1_MPORT_data; // @[DualReadMem.scala 35:43]
  wire  mem_rdData2_MPORT_en; // @[DualReadMem.scala 35:43]
  wire [9:0] mem_rdData2_MPORT_addr; // @[DualReadMem.scala 35:43]
  wire [31:0] mem_rdData2_MPORT_data; // @[DualReadMem.scala 35:43]
  wire [31:0] mem_MPORT_data; // @[DualReadMem.scala 35:43]
  wire [9:0] mem_MPORT_addr; // @[DualReadMem.scala 35:43]
  wire  mem_MPORT_mask; // @[DualReadMem.scala 35:43]
  wire  mem_MPORT_en; // @[DualReadMem.scala 35:43]
  reg  mem_rdData1_MPORT_en_pipe_0;
  reg [9:0] mem_rdData1_MPORT_addr_pipe_0;
  reg  mem_rdData2_MPORT_en_pipe_0;
  reg [9:0] mem_rdData2_MPORT_addr_pipe_0;
  wire [4:0] readAddress1 = {{2'd0}, io_rdAddr1[4:2]};
  wire [31:0] rdData1 = mem_rdData1_MPORT_data; // @[DualReadMem.scala 41:17 45:13]
  reg  REG; // @[DualReadMem.scala 49:15]
  wire [4:0] writeAddress = io_wren ? {{2'd0}, io_wrAddr[4:2]} : 5'h0; // @[DualReadMem.scala 54:17 55:18]
  assign mem_rdData1_MPORT_en = mem_rdData1_MPORT_en_pipe_0;
  assign mem_rdData1_MPORT_addr = mem_rdData1_MPORT_addr_pipe_0;
  assign mem_rdData1_MPORT_data = mem[mem_rdData1_MPORT_addr]; // @[DualReadMem.scala 35:43]
  assign mem_rdData2_MPORT_en = mem_rdData2_MPORT_en_pipe_0;
  assign mem_rdData2_MPORT_addr = mem_rdData2_MPORT_addr_pipe_0;
  assign mem_rdData2_MPORT_data = mem[mem_rdData2_MPORT_addr]; // @[DualReadMem.scala 35:43]
  assign mem_MPORT_data = io_wrData;
  assign mem_MPORT_addr = {{5'd0}, writeAddress};
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_wren;
  assign io_rdData1 = REG ? rdData1 : 32'h0; // @[DualReadMem.scala 26:14 49:26 50:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[DualReadMem.scala 35:43]
    end
    mem_rdData1_MPORT_en_pipe_0 <= io_rden;
    if (io_rden) begin
      mem_rdData1_MPORT_addr_pipe_0 <= {{5'd0}, readAddress1};
    end
    mem_rdData2_MPORT_en_pipe_0 <= io_rden;
    if (io_rden) begin
      mem_rdData2_MPORT_addr_pipe_0 <= 10'h0;
    end
    REG <= io_rden; // @[DualReadMem.scala 49:15]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
  integer initvar;
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  mem_rdData1_MPORT_en_pipe_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mem_rdData1_MPORT_addr_pipe_0 = _RAND_1[9:0];
  _RAND_2 = {1{`RANDOM}};
  mem_rdData2_MPORT_en_pipe_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mem_rdData2_MPORT_addr_pipe_0 = _RAND_3[9:0];
  _RAND_4 = {1{`RANDOM}};
  REG = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
  mem[0] = 0;
  mem[1] = 0;
  mem[2] = 0;
  mem[3] = 0;
  mem[4] = 0;
  mem[5] = 0;
  mem[6] = 0;
  mem[7] = 0;
  mem[8] = 0;
  mem[9] = 0;
  mem[10] = 0;
  mem[11] = 0;
  mem[12] = 0;
  mem[13] = 0;
  mem[14] = 0;
  mem[15] = 0;
  mem[16] = 0;
  mem[17] = 0;
  mem[18] = 0;
  mem[19] = 0;
  mem[20] = 0;
  mem[21] = 0;
  mem[22] = 0;
  mem[23] = 0;
  mem[24] = 0;
  mem[25] = 0;
  mem[26] = 0;
  mem[27] = 0;
  mem[28] = 0;
  mem[29] = 0;
  mem[30] = 0;
  mem[31] = 0;
  mem[32] = 0;
  mem[33] = 0;
  mem[34] = 0;
  mem[35] = 0;
  mem[36] = 0;
  mem[37] = 0;
  mem[38] = 0;
  mem[39] = 0;
  mem[40] = 0;
  mem[41] = 0;
  mem[42] = 0;
  mem[43] = 0;
  mem[44] = 0;
  mem[45] = 0;
  mem[46] = 0;
  mem[47] = 0;
  mem[48] = 0;
  mem[49] = 0;
  mem[50] = 0;
  mem[51] = 0;
  mem[52] = 0;
  mem[53] = 0;
  mem[54] = 0;
  mem[55] = 0;
  mem[56] = 0;
  mem[57] = 0;
  mem[58] = 0;
  mem[59] = 0;
  mem[60] = 0;
  mem[61] = 0;
  mem[62] = 0;
  mem[63] = 0;
  mem[64] = 0;
  mem[65] = 0;
  mem[66] = 0;
  mem[67] = 0;
  mem[68] = 0;
  mem[69] = 0;
  mem[70] = 0;
  mem[71] = 0;
  mem[72] = 0;
  mem[73] = 0;
  mem[74] = 0;
  mem[75] = 0;
  mem[76] = 0;
  mem[77] = 0;
  mem[78] = 0;
  mem[79] = 0;
  mem[80] = 0;
  mem[81] = 0;
  mem[82] = 0;
  mem[83] = 0;
  mem[84] = 0;
  mem[85] = 0;
  mem[86] = 0;
  mem[87] = 0;
  mem[88] = 0;
  mem[89] = 0;
  mem[90] = 0;
  mem[91] = 0;
  mem[92] = 0;
  mem[93] = 0;
  mem[94] = 0;
  mem[95] = 0;
  mem[96] = 0;
  mem[97] = 0;
  mem[98] = 0;
  mem[99] = 0;
  mem[100] = 0;
  mem[101] = 0;
  mem[102] = 0;
  mem[103] = 0;
  mem[104] = 0;
  mem[105] = 0;
  mem[106] = 0;
  mem[107] = 0;
  mem[108] = 0;
  mem[109] = 0;
  mem[110] = 0;
  mem[111] = 0;
  mem[112] = 0;
  mem[113] = 0;
  mem[114] = 0;
  mem[115] = 0;
  mem[116] = 0;
  mem[117] = 0;
  mem[118] = 0;
  mem[119] = 0;
  mem[120] = 0;
  mem[121] = 0;
  mem[122] = 0;
  mem[123] = 0;
  mem[124] = 0;
  mem[125] = 0;
  mem[126] = 0;
  mem[127] = 0;
  mem[128] = 0;
  mem[129] = 0;
  mem[130] = 0;
  mem[131] = 0;
  mem[132] = 0;
  mem[133] = 0;
  mem[134] = 0;
  mem[135] = 0;
  mem[136] = 0;
  mem[137] = 0;
  mem[138] = 0;
  mem[139] = 0;
  mem[140] = 0;
  mem[141] = 0;
  mem[142] = 0;
  mem[143] = 0;
  mem[144] = 0;
  mem[145] = 0;
  mem[146] = 0;
  mem[147] = 0;
  mem[148] = 0;
  mem[149] = 0;
  mem[150] = 0;
  mem[151] = 0;
  mem[152] = 0;
  mem[153] = 0;
  mem[154] = 0;
  mem[155] = 0;
  mem[156] = 0;
  mem[157] = 0;
  mem[158] = 0;
  mem[159] = 0;
  mem[160] = 0;
  mem[161] = 0;
  mem[162] = 0;
  mem[163] = 0;
  mem[164] = 0;
  mem[165] = 0;
  mem[166] = 0;
  mem[167] = 0;
  mem[168] = 0;
  mem[169] = 0;
  mem[170] = 0;
  mem[171] = 0;
  mem[172] = 0;
  mem[173] = 0;
  mem[174] = 0;
  mem[175] = 0;
  mem[176] = 0;
  mem[177] = 0;
  mem[178] = 0;
  mem[179] = 0;
  mem[180] = 0;
  mem[181] = 0;
  mem[182] = 0;
  mem[183] = 0;
  mem[184] = 0;
  mem[185] = 0;
  mem[186] = 0;
  mem[187] = 0;
  mem[188] = 0;
  mem[189] = 0;
  mem[190] = 0;
  mem[191] = 0;
  mem[192] = 0;
  mem[193] = 0;
  mem[194] = 0;
  mem[195] = 0;
  mem[196] = 0;
  mem[197] = 0;
  mem[198] = 0;
  mem[199] = 0;
  mem[200] = 0;
  mem[201] = 0;
  mem[202] = 0;
  mem[203] = 0;
  mem[204] = 0;
  mem[205] = 0;
  mem[206] = 0;
  mem[207] = 0;
  mem[208] = 0;
  mem[209] = 0;
  mem[210] = 0;
  mem[211] = 0;
  mem[212] = 0;
  mem[213] = 0;
  mem[214] = 0;
  mem[215] = 0;
  mem[216] = 0;
  mem[217] = 0;
  mem[218] = 0;
  mem[219] = 0;
  mem[220] = 0;
  mem[221] = 0;
  mem[222] = 0;
  mem[223] = 0;
  mem[224] = 0;
  mem[225] = 0;
  mem[226] = 0;
  mem[227] = 0;
  mem[228] = 0;
  mem[229] = 0;
  mem[230] = 0;
  mem[231] = 0;
  mem[232] = 0;
  mem[233] = 0;
  mem[234] = 0;
  mem[235] = 0;
  mem[236] = 0;
  mem[237] = 0;
  mem[238] = 0;
  mem[239] = 0;
  mem[240] = 0;
  mem[241] = 0;
  mem[242] = 0;
  mem[243] = 0;
  mem[244] = 0;
  mem[245] = 0;
  mem[246] = 0;
  mem[247] = 0;
  mem[248] = 0;
  mem[249] = 0;
  mem[250] = 0;
  mem[251] = 0;
  mem[252] = 0;
  mem[253] = 0;
  mem[254] = 0;
  mem[255] = 0;
  mem[256] = 0;
  mem[257] = 0;
  mem[258] = 0;
  mem[259] = 0;
  mem[260] = 0;
  mem[261] = 0;
  mem[262] = 0;
  mem[263] = 0;
  mem[264] = 0;
  mem[265] = 0;
  mem[266] = 0;
  mem[267] = 0;
  mem[268] = 0;
  mem[269] = 0;
  mem[270] = 0;
  mem[271] = 0;
  mem[272] = 0;
  mem[273] = 0;
  mem[274] = 0;
  mem[275] = 0;
  mem[276] = 0;
  mem[277] = 0;
  mem[278] = 0;
  mem[279] = 0;
  mem[280] = 0;
  mem[281] = 0;
  mem[282] = 0;
  mem[283] = 0;
  mem[284] = 0;
  mem[285] = 0;
  mem[286] = 0;
  mem[287] = 0;
  mem[288] = 0;
  mem[289] = 0;
  mem[290] = 0;
  mem[291] = 0;
  mem[292] = 0;
  mem[293] = 0;
  mem[294] = 0;
  mem[295] = 0;
  mem[296] = 0;
  mem[297] = 0;
  mem[298] = 0;
  mem[299] = 0;
  mem[300] = 0;
  mem[301] = 0;
  mem[302] = 0;
  mem[303] = 0;
  mem[304] = 0;
  mem[305] = 0;
  mem[306] = 0;
  mem[307] = 0;
  mem[308] = 0;
  mem[309] = 0;
  mem[310] = 0;
  mem[311] = 0;
  mem[312] = 0;
  mem[313] = 0;
  mem[314] = 0;
  mem[315] = 0;
  mem[316] = 0;
  mem[317] = 0;
  mem[318] = 0;
  mem[319] = 0;
  mem[320] = 0;
  mem[321] = 0;
  mem[322] = 0;
  mem[323] = 0;
  mem[324] = 0;
  mem[325] = 0;
  mem[326] = 0;
  mem[327] = 0;
  mem[328] = 0;
  mem[329] = 0;
  mem[330] = 0;
  mem[331] = 0;
  mem[332] = 0;
  mem[333] = 0;
  mem[334] = 0;
  mem[335] = 0;
  mem[336] = 0;
  mem[337] = 0;
  mem[338] = 0;
  mem[339] = 0;
  mem[340] = 0;
  mem[341] = 0;
  mem[342] = 0;
  mem[343] = 0;
  mem[344] = 0;
  mem[345] = 0;
  mem[346] = 0;
  mem[347] = 0;
  mem[348] = 0;
  mem[349] = 0;
  mem[350] = 0;
  mem[351] = 0;
  mem[352] = 0;
  mem[353] = 0;
  mem[354] = 0;
  mem[355] = 0;
  mem[356] = 0;
  mem[357] = 0;
  mem[358] = 0;
  mem[359] = 0;
  mem[360] = 0;
  mem[361] = 0;
  mem[362] = 0;
  mem[363] = 0;
  mem[364] = 0;
  mem[365] = 0;
  mem[366] = 0;
  mem[367] = 0;
  mem[368] = 0;
  mem[369] = 0;
  mem[370] = 0;
  mem[371] = 0;
  mem[372] = 0;
  mem[373] = 0;
  mem[374] = 0;
  mem[375] = 0;
  mem[376] = 0;
  mem[377] = 0;
  mem[378] = 0;
  mem[379] = 0;
  mem[380] = 0;
  mem[381] = 0;
  mem[382] = 0;
  mem[383] = 0;
  mem[384] = 0;
  mem[385] = 0;
  mem[386] = 0;
  mem[387] = 0;
  mem[388] = 0;
  mem[389] = 0;
  mem[390] = 0;
  mem[391] = 0;
  mem[392] = 0;
  mem[393] = 0;
  mem[394] = 0;
  mem[395] = 0;
  mem[396] = 0;
  mem[397] = 0;
  mem[398] = 0;
  mem[399] = 0;
  mem[400] = 0;
  mem[401] = 0;
  mem[402] = 0;
  mem[403] = 0;
  mem[404] = 0;
  mem[405] = 0;
  mem[406] = 0;
  mem[407] = 0;
  mem[408] = 0;
  mem[409] = 0;
  mem[410] = 0;
  mem[411] = 0;
  mem[412] = 0;
  mem[413] = 0;
  mem[414] = 0;
  mem[415] = 0;
  mem[416] = 0;
  mem[417] = 0;
  mem[418] = 0;
  mem[419] = 0;
  mem[420] = 0;
  mem[421] = 0;
  mem[422] = 0;
  mem[423] = 0;
  mem[424] = 0;
  mem[425] = 0;
  mem[426] = 0;
  mem[427] = 0;
  mem[428] = 0;
  mem[429] = 0;
  mem[430] = 0;
  mem[431] = 0;
  mem[432] = 0;
  mem[433] = 0;
  mem[434] = 0;
  mem[435] = 0;
  mem[436] = 0;
  mem[437] = 0;
  mem[438] = 0;
  mem[439] = 0;
  mem[440] = 0;
  mem[441] = 0;
  mem[442] = 0;
  mem[443] = 0;
  mem[444] = 0;
  mem[445] = 0;
  mem[446] = 0;
  mem[447] = 0;
  mem[448] = 0;
  mem[449] = 0;
  mem[450] = 0;
  mem[451] = 0;
  mem[452] = 0;
  mem[453] = 0;
  mem[454] = 0;
  mem[455] = 0;
  mem[456] = 0;
  mem[457] = 0;
  mem[458] = 0;
  mem[459] = 0;
  mem[460] = 0;
  mem[461] = 0;
  mem[462] = 0;
  mem[463] = 0;
  mem[464] = 0;
  mem[465] = 0;
  mem[466] = 0;
  mem[467] = 0;
  mem[468] = 0;
  mem[469] = 0;
  mem[470] = 0;
  mem[471] = 0;
  mem[472] = 0;
  mem[473] = 0;
  mem[474] = 0;
  mem[475] = 0;
  mem[476] = 0;
  mem[477] = 0;
  mem[478] = 0;
  mem[479] = 0;
  mem[480] = 0;
  mem[481] = 0;
  mem[482] = 0;
  mem[483] = 0;
  mem[484] = 0;
  mem[485] = 0;
  mem[486] = 0;
  mem[487] = 0;
  mem[488] = 0;
  mem[489] = 0;
  mem[490] = 0;
  mem[491] = 0;
  mem[492] = 0;
  mem[493] = 0;
  mem[494] = 0;
  mem[495] = 0;
  mem[496] = 0;
  mem[497] = 0;
  mem[498] = 0;
  mem[499] = 0;
  mem[500] = 0;
  mem[501] = 0;
  mem[502] = 0;
  mem[503] = 0;
  mem[504] = 0;
  mem[505] = 0;
  mem[506] = 0;
  mem[507] = 0;
  mem[508] = 0;
  mem[509] = 0;
  mem[510] = 0;
  mem[511] = 0;
  mem[512] = 0;
  mem[513] = 0;
  mem[514] = 0;
  mem[515] = 0;
  mem[516] = 0;
  mem[517] = 0;
  mem[518] = 0;
  mem[519] = 0;
  mem[520] = 0;
  mem[521] = 0;
  mem[522] = 0;
  mem[523] = 0;
  mem[524] = 0;
  mem[525] = 0;
  mem[526] = 0;
  mem[527] = 0;
  mem[528] = 0;
  mem[529] = 0;
  mem[530] = 0;
  mem[531] = 0;
  mem[532] = 0;
  mem[533] = 0;
  mem[534] = 0;
  mem[535] = 0;
  mem[536] = 0;
  mem[537] = 0;
  mem[538] = 0;
  mem[539] = 0;
  mem[540] = 0;
  mem[541] = 0;
  mem[542] = 0;
  mem[543] = 0;
  mem[544] = 0;
  mem[545] = 0;
  mem[546] = 0;
  mem[547] = 0;
  mem[548] = 0;
  mem[549] = 0;
  mem[550] = 0;
  mem[551] = 0;
  mem[552] = 0;
  mem[553] = 0;
  mem[554] = 0;
  mem[555] = 0;
  mem[556] = 0;
  mem[557] = 0;
  mem[558] = 0;
  mem[559] = 0;
  mem[560] = 0;
  mem[561] = 0;
  mem[562] = 0;
  mem[563] = 0;
  mem[564] = 0;
  mem[565] = 0;
  mem[566] = 0;
  mem[567] = 0;
  mem[568] = 0;
  mem[569] = 0;
  mem[570] = 0;
  mem[571] = 0;
  mem[572] = 0;
  mem[573] = 0;
  mem[574] = 0;
  mem[575] = 0;
  mem[576] = 0;
  mem[577] = 0;
  mem[578] = 0;
  mem[579] = 0;
  mem[580] = 0;
  mem[581] = 0;
  mem[582] = 0;
  mem[583] = 0;
  mem[584] = 0;
  mem[585] = 0;
  mem[586] = 0;
  mem[587] = 0;
  mem[588] = 0;
  mem[589] = 0;
  mem[590] = 0;
  mem[591] = 0;
  mem[592] = 0;
  mem[593] = 0;
  mem[594] = 0;
  mem[595] = 0;
  mem[596] = 0;
  mem[597] = 0;
  mem[598] = 0;
  mem[599] = 0;
  mem[600] = 0;
  mem[601] = 0;
  mem[602] = 0;
  mem[603] = 0;
  mem[604] = 0;
  mem[605] = 0;
  mem[606] = 0;
  mem[607] = 0;
  mem[608] = 0;
  mem[609] = 0;
  mem[610] = 0;
  mem[611] = 0;
  mem[612] = 0;
  mem[613] = 0;
  mem[614] = 0;
  mem[615] = 0;
  mem[616] = 0;
  mem[617] = 0;
  mem[618] = 0;
  mem[619] = 0;
  mem[620] = 0;
  mem[621] = 0;
  mem[622] = 0;
  mem[623] = 0;
  mem[624] = 0;
  mem[625] = 0;
  mem[626] = 0;
  mem[627] = 0;
  mem[628] = 0;
  mem[629] = 0;
  mem[630] = 0;
  mem[631] = 0;
  mem[632] = 0;
  mem[633] = 0;
  mem[634] = 0;
  mem[635] = 0;
  mem[636] = 0;
  mem[637] = 0;
  mem[638] = 0;
  mem[639] = 0;
  mem[640] = 0;
  mem[641] = 0;
  mem[642] = 0;
  mem[643] = 0;
  mem[644] = 0;
  mem[645] = 0;
  mem[646] = 0;
  mem[647] = 0;
  mem[648] = 0;
  mem[649] = 0;
  mem[650] = 0;
  mem[651] = 0;
  mem[652] = 0;
  mem[653] = 0;
  mem[654] = 0;
  mem[655] = 0;
  mem[656] = 0;
  mem[657] = 0;
  mem[658] = 0;
  mem[659] = 0;
  mem[660] = 0;
  mem[661] = 0;
  mem[662] = 0;
  mem[663] = 0;
  mem[664] = 0;
  mem[665] = 0;
  mem[666] = 0;
  mem[667] = 0;
  mem[668] = 0;
  mem[669] = 0;
  mem[670] = 0;
  mem[671] = 0;
  mem[672] = 0;
  mem[673] = 0;
  mem[674] = 0;
  mem[675] = 0;
  mem[676] = 0;
  mem[677] = 0;
  mem[678] = 0;
  mem[679] = 0;
  mem[680] = 0;
  mem[681] = 0;
  mem[682] = 0;
  mem[683] = 0;
  mem[684] = 0;
  mem[685] = 0;
  mem[686] = 0;
  mem[687] = 0;
  mem[688] = 0;
  mem[689] = 0;
  mem[690] = 0;
  mem[691] = 0;
  mem[692] = 0;
  mem[693] = 0;
  mem[694] = 0;
  mem[695] = 0;
  mem[696] = 0;
  mem[697] = 0;
  mem[698] = 0;
  mem[699] = 0;
  mem[700] = 0;
  mem[701] = 0;
  mem[702] = 0;
  mem[703] = 0;
  mem[704] = 0;
  mem[705] = 0;
  mem[706] = 0;
  mem[707] = 0;
  mem[708] = 0;
  mem[709] = 0;
  mem[710] = 0;
  mem[711] = 0;
  mem[712] = 0;
  mem[713] = 0;
  mem[714] = 0;
  mem[715] = 0;
  mem[716] = 0;
  mem[717] = 0;
  mem[718] = 0;
  mem[719] = 0;
  mem[720] = 0;
  mem[721] = 0;
  mem[722] = 0;
  mem[723] = 0;
  mem[724] = 0;
  mem[725] = 0;
  mem[726] = 0;
  mem[727] = 0;
  mem[728] = 0;
  mem[729] = 0;
  mem[730] = 0;
  mem[731] = 0;
  mem[732] = 0;
  mem[733] = 0;
  mem[734] = 0;
  mem[735] = 0;
  mem[736] = 0;
  mem[737] = 0;
  mem[738] = 0;
  mem[739] = 0;
  mem[740] = 0;
  mem[741] = 0;
  mem[742] = 0;
  mem[743] = 0;
  mem[744] = 0;
  mem[745] = 0;
  mem[746] = 0;
  mem[747] = 0;
  mem[748] = 0;
  mem[749] = 0;
  mem[750] = 0;
  mem[751] = 0;
  mem[752] = 0;
  mem[753] = 0;
  mem[754] = 0;
  mem[755] = 0;
  mem[756] = 0;
  mem[757] = 0;
  mem[758] = 0;
  mem[759] = 0;
  mem[760] = 0;
  mem[761] = 0;
  mem[762] = 0;
  mem[763] = 0;
  mem[764] = 0;
  mem[765] = 0;
  mem[766] = 0;
  mem[767] = 0;
  mem[768] = 0;
  mem[769] = 0;
  mem[770] = 0;
  mem[771] = 0;
  mem[772] = 0;
  mem[773] = 0;
  mem[774] = 0;
  mem[775] = 0;
  mem[776] = 0;
  mem[777] = 0;
  mem[778] = 0;
  mem[779] = 0;
  mem[780] = 0;
  mem[781] = 0;
  mem[782] = 0;
  mem[783] = 0;
  mem[784] = 0;
  mem[785] = 0;
  mem[786] = 0;
  mem[787] = 0;
  mem[788] = 0;
  mem[789] = 0;
  mem[790] = 0;
  mem[791] = 0;
  mem[792] = 0;
  mem[793] = 0;
  mem[794] = 0;
  mem[795] = 0;
  mem[796] = 0;
  mem[797] = 0;
  mem[798] = 0;
  mem[799] = 0;
  mem[800] = 0;
  mem[801] = 0;
  mem[802] = 0;
  mem[803] = 0;
  mem[804] = 0;
  mem[805] = 0;
  mem[806] = 0;
  mem[807] = 0;
  mem[808] = 0;
  mem[809] = 0;
  mem[810] = 0;
  mem[811] = 0;
  mem[812] = 0;
  mem[813] = 0;
  mem[814] = 0;
  mem[815] = 0;
  mem[816] = 0;
  mem[817] = 0;
  mem[818] = 0;
  mem[819] = 0;
  mem[820] = 0;
  mem[821] = 0;
  mem[822] = 0;
  mem[823] = 0;
  mem[824] = 0;
  mem[825] = 0;
  mem[826] = 0;
  mem[827] = 0;
  mem[828] = 0;
  mem[829] = 0;
  mem[830] = 0;
  mem[831] = 0;
  mem[832] = 0;
  mem[833] = 0;
  mem[834] = 0;
  mem[835] = 0;
  mem[836] = 0;
  mem[837] = 0;
  mem[838] = 0;
  mem[839] = 0;
  mem[840] = 0;
  mem[841] = 0;
  mem[842] = 0;
  mem[843] = 0;
  mem[844] = 0;
  mem[845] = 0;
  mem[846] = 0;
  mem[847] = 0;
  mem[848] = 0;
  mem[849] = 0;
  mem[850] = 0;
  mem[851] = 0;
  mem[852] = 0;
  mem[853] = 0;
  mem[854] = 0;
  mem[855] = 0;
  mem[856] = 0;
  mem[857] = 0;
  mem[858] = 0;
  mem[859] = 0;
  mem[860] = 0;
  mem[861] = 0;
  mem[862] = 0;
  mem[863] = 0;
  mem[864] = 0;
  mem[865] = 0;
  mem[866] = 0;
  mem[867] = 0;
  mem[868] = 0;
  mem[869] = 0;
  mem[870] = 0;
  mem[871] = 0;
  mem[872] = 0;
  mem[873] = 0;
  mem[874] = 0;
  mem[875] = 0;
  mem[876] = 0;
  mem[877] = 0;
  mem[878] = 0;
  mem[879] = 0;
  mem[880] = 0;
  mem[881] = 0;
  mem[882] = 0;
  mem[883] = 0;
  mem[884] = 0;
  mem[885] = 0;
  mem[886] = 0;
  mem[887] = 0;
  mem[888] = 0;
  mem[889] = 0;
  mem[890] = 0;
  mem[891] = 0;
  mem[892] = 0;
  mem[893] = 0;
  mem[894] = 0;
  mem[895] = 0;
  mem[896] = 0;
  mem[897] = 0;
  mem[898] = 0;
  mem[899] = 0;
  mem[900] = 0;
  mem[901] = 0;
  mem[902] = 0;
  mem[903] = 0;
  mem[904] = 0;
  mem[905] = 0;
  mem[906] = 0;
  mem[907] = 0;
  mem[908] = 0;
  mem[909] = 0;
  mem[910] = 0;
  mem[911] = 0;
  mem[912] = 0;
  mem[913] = 0;
  mem[914] = 0;
  mem[915] = 0;
  mem[916] = 0;
  mem[917] = 0;
  mem[918] = 0;
  mem[919] = 0;
  mem[920] = 0;
  mem[921] = 0;
  mem[922] = 0;
  mem[923] = 0;
  mem[924] = 0;
  mem[925] = 0;
  mem[926] = 0;
  mem[927] = 0;
  mem[928] = 0;
  mem[929] = 0;
  mem[930] = 0;
  mem[931] = 0;
  mem[932] = 0;
  mem[933] = 0;
  mem[934] = 0;
  mem[935] = 0;
  mem[936] = 0;
  mem[937] = 0;
  mem[938] = 0;
  mem[939] = 0;
  mem[940] = 0;
  mem[941] = 0;
  mem[942] = 0;
  mem[943] = 0;
  mem[944] = 0;
  mem[945] = 0;
  mem[946] = 0;
  mem[947] = 0;
  mem[948] = 0;
  mem[949] = 0;
  mem[950] = 0;
  mem[951] = 0;
  mem[952] = 0;
  mem[953] = 0;
  mem[954] = 0;
  mem[955] = 0;
  mem[956] = 0;
  mem[957] = 0;
  mem[958] = 0;
  mem[959] = 0;
  mem[960] = 0;
  mem[961] = 0;
  mem[962] = 0;
  mem[963] = 0;
  mem[964] = 0;
  mem[965] = 0;
  mem[966] = 0;
  mem[967] = 0;
  mem[968] = 0;
  mem[969] = 0;
  mem[970] = 0;
  mem[971] = 0;
  mem[972] = 0;
  mem[973] = 0;
  mem[974] = 0;
  mem[975] = 0;
  mem[976] = 0;
  mem[977] = 0;
  mem[978] = 0;
  mem[979] = 0;
  mem[980] = 0;
  mem[981] = 0;
  mem[982] = 0;
  mem[983] = 0;
  mem[984] = 0;
  mem[985] = 0;
  mem[986] = 0;
  mem[987] = 0;
  mem[988] = 0;
  mem[989] = 0;
  mem[990] = 0;
  mem[991] = 0;
  mem[992] = 0;
  mem[993] = 0;
  mem[994] = 0;
  mem[995] = 0;
  mem[996] = 0;
  mem[997] = 0;
  mem[998] = 0;
  mem[999] = 0;
  mem[1000] = 0;
  mem[1001] = 0;
  mem[1002] = 0;
  mem[1003] = 0;
  mem[1004] = 0;
  mem[1005] = 0;
  mem[1006] = 0;
  mem[1007] = 0;
  mem[1008] = 0;
  mem[1009] = 0;
  mem[1010] = 0;
  mem[1011] = 0;
  mem[1012] = 0;
  mem[1013] = 0;
  mem[1014] = 0;
  mem[1015] = 0;
  mem[1016] = 0;
  mem[1017] = 0;
  mem[1018] = 0;
  mem[1019] = 0;
  mem[1020] = 0;
  mem[1021] = 0;
  mem[1022] = 0;
  mem[1023] = 0;
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM(
  input         clock,
  input  [4:0]  io_in_rd,
  input  [31:0] io_in_aluOut,
  input  [31:0] io_in_wrData,
  input         io_in_ctrl_writeEnable,
  input         io_in_ctrl_store,
  input         io_in_ctrl_load,
  output [4:0]  io_out_rd,
  output [31:0] io_out_aluOut,
  output [31:0] io_out_memOut,
  output        io_out_load,
  output        io_out_writeEnable,
  output [4:0]  io_mem_fwd_rd,
  output [31:0] io_mem_fwd_stageOutput,
  output        io_mem_fwd_writeEnable
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  DRMEM_clock; // @[MEM.scala 28:21]
  wire  DRMEM_io_rden; // @[MEM.scala 28:21]
  wire [4:0] DRMEM_io_rdAddr1; // @[MEM.scala 28:21]
  wire [31:0] DRMEM_io_rdData1; // @[MEM.scala 28:21]
  wire [4:0] DRMEM_io_wrAddr; // @[MEM.scala 28:21]
  wire [31:0] DRMEM_io_wrData; // @[MEM.scala 28:21]
  wire  DRMEM_io_wren; // @[MEM.scala 28:21]
  reg [4:0] outReg_rd; // @[Reg.scala 19:16]
  reg [31:0] outReg_aluOut; // @[Reg.scala 19:16]
  reg  outReg_load; // @[Reg.scala 19:16]
  reg  outReg_writeEnable; // @[Reg.scala 19:16]
  DualReadMem DRMEM ( // @[MEM.scala 28:21]
    .clock(DRMEM_clock),
    .io_rden(DRMEM_io_rden),
    .io_rdAddr1(DRMEM_io_rdAddr1),
    .io_rdData1(DRMEM_io_rdData1),
    .io_wrAddr(DRMEM_io_wrAddr),
    .io_wrData(DRMEM_io_wrData),
    .io_wren(DRMEM_io_wren)
  );
  assign io_out_rd = outReg_rd; // @[MEM.scala 53:13]
  assign io_out_aluOut = outReg_aluOut; // @[MEM.scala 54:17]
  assign io_out_memOut = DRMEM_io_rdData1; // @[MEM.scala 57:17]
  assign io_out_load = outReg_load; // @[MEM.scala 55:15]
  assign io_out_writeEnable = outReg_writeEnable; // @[MEM.scala 56:22]
  assign io_mem_fwd_rd = io_in_rd; // @[MEM.scala 60:17]
  assign io_mem_fwd_stageOutput = io_in_aluOut; // @[MEM.scala 61:26]
  assign io_mem_fwd_writeEnable = io_in_ctrl_writeEnable; // @[MEM.scala 62:26]
  assign DRMEM_clock = clock;
  assign DRMEM_io_rden = io_in_ctrl_load; // @[MEM.scala 35:17]
  assign DRMEM_io_rdAddr1 = io_in_aluOut[4:0]; // @[MEM.scala 36:20]
  assign DRMEM_io_wrAddr = io_in_aluOut[4:0]; // @[MEM.scala 37:19]
  assign DRMEM_io_wrData = io_in_wrData; // @[MEM.scala 38:19]
  assign DRMEM_io_wren = io_in_ctrl_store; // @[MEM.scala 34:17]
  always @(posedge clock) begin
    outReg_rd <= io_in_rd; // @[MEM.scala 21:13]
    outReg_aluOut <= io_in_aluOut; // @[MEM.scala 22:17]
    outReg_load <= io_in_ctrl_load; // @[MEM.scala 24:15]
    outReg_writeEnable <= io_in_ctrl_writeEnable; // @[MEM.scala 23:22]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  outReg_rd = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  outReg_aluOut = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  outReg_load = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  outReg_writeEnable = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WB(
  input  [4:0]  io_in_rd,
  input  [31:0] io_in_aluOut,
  input  [31:0] io_in_memOut,
  input         io_in_load,
  input         io_in_writeEnable,
  output [4:0]  io_out_rd,
  output [31:0] io_out_muxOut,
  output        io_out_writeEnable,
  output [4:0]  io_wb_fwd_rd,
  output [31:0] io_wb_fwd_stageOutput,
  output        io_wb_fwd_writeEnable
);
  assign io_out_rd = io_in_rd; // @[WB.scala 28:13]
  assign io_out_muxOut = io_in_load ? io_in_memOut : io_in_aluOut; // @[WB.scala 18:19]
  assign io_out_writeEnable = io_in_writeEnable; // @[WB.scala 26:22]
  assign io_wb_fwd_rd = io_out_rd; // @[WB.scala 31:16]
  assign io_wb_fwd_stageOutput = io_out_muxOut; // @[WB.scala 32:25]
  assign io_wb_fwd_writeEnable = io_out_writeEnable; // @[WB.scala 33:25]
endmodule
module ForwardingUnit(
  input  [4:0]  io_id_rs1,
  input  [4:0]  io_id_rs2,
  input  [31:0] io_id_val1,
  input  [31:0] io_id_val2,
  input  [4:0]  io_mem_fwd_rd,
  input  [31:0] io_mem_fwd_stageOutput,
  input         io_mem_fwd_writeEnable,
  input  [4:0]  io_wb_fwd_rd,
  input  [31:0] io_wb_fwd_stageOutput,
  input         io_wb_fwd_writeEnable,
  output [31:0] io_val1,
  output [31:0] io_val2
);
  wire  _forwardingMEMrs1_T_1 = io_id_rs1 != 5'h0; // @[ForwardingUnit.scala 21:68]
  wire  forwardingMEMrs1 = io_mem_fwd_rd == io_id_rs1 & io_id_rs1 != 5'h0 & io_mem_fwd_writeEnable; // @[ForwardingUnit.scala 21:76]
  wire  _forwardingMEMrs2_T_1 = io_id_rs2 != 5'h0; // @[ForwardingUnit.scala 22:68]
  wire  forwardingMEMrs2 = io_mem_fwd_rd == io_id_rs2 & io_id_rs2 != 5'h0 & io_mem_fwd_writeEnable; // @[ForwardingUnit.scala 22:76]
  wire  forwardingWBrs1 = io_wb_fwd_rd == io_id_rs1 & _forwardingMEMrs1_T_1 & io_wb_fwd_writeEnable; // @[ForwardingUnit.scala 24:74]
  wire  forwardingWBrs2 = io_wb_fwd_rd == io_id_rs2 & _forwardingMEMrs2_T_1 & io_wb_fwd_writeEnable; // @[ForwardingUnit.scala 25:74]
  wire [31:0] _GEN_0 = forwardingWBrs1 ? io_wb_fwd_stageOutput : io_id_val1; // @[ForwardingUnit.scala 31:31 32:13 34:13]
  wire [31:0] _GEN_2 = forwardingWBrs2 ? io_wb_fwd_stageOutput : io_id_val2; // @[ForwardingUnit.scala 39:31 40:13 42:13]
  assign io_val1 = forwardingMEMrs1 ? io_mem_fwd_stageOutput : _GEN_0; // @[ForwardingUnit.scala 29:26 30:13]
  assign io_val2 = forwardingMEMrs2 ? io_mem_fwd_stageOutput : _GEN_2; // @[ForwardingUnit.scala 37:26 38:13]
endmodule
module HazardControl(
  input  [31:0] io_EXaluOut,
  input         io_EXctrlBranch,
  input         io_EXctrlJump,
  input         io_EXctrlLoad,
  input  [4:0]  io_EXrd,
  input  [4:0]  io_IDrs1,
  input  [4:0]  io_IDrs2,
  output        io_IDFlush,
  output        io_IFFlush,
  output        io_IFStall
);
  wire  use_load = io_EXctrlLoad & (io_EXrd == io_IDrs1 | io_EXrd == io_IDrs2) & io_EXrd != 5'h0; // @[HazardControl.scala 27:82]
  wire  branch_jump = io_EXaluOut == 32'h1 & io_EXctrlBranch | io_EXctrlJump; // @[HazardControl.scala 28:62]
  assign io_IDFlush = branch_jump | use_load; // @[HazardControl.scala 32:29]
  assign io_IFFlush = io_EXaluOut == 32'h1 & io_EXctrlBranch | io_EXctrlJump; // @[HazardControl.scala 28:62]
  assign io_IFStall = io_EXctrlLoad & (io_EXrd == io_IDrs1 | io_EXrd == io_IDrs2) & io_EXrd != 5'h0; // @[HazardControl.scala 27:82]
endmodule
module SevenSegment(
  input        clock,
  input        reset,
  input  [6:0] io_rd,
  input  [6:0] io_val1,
  output [6:0] io_seg,
  output [3:0] io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [16:0] counter_value; // @[Counter.scala 61:40]
  reg [1:0] cntRegSel; // @[SevenSegment.scala 22:26]
  wire  wrap = counter_value == 17'h1869f; // @[Counter.scala 73:24]
  wire [16:0] _value_T_1 = counter_value + 17'h1; // @[Counter.scala 77:24]
  wire [1:0] _cntRegSel_T_1 = cntRegSel + 2'h1; // @[SevenSegment.scala 24:28]
  wire  _T = 2'h0 == cntRegSel; // @[SevenSegment.scala 27:20]
  wire  _T_1 = 2'h1 == cntRegSel; // @[SevenSegment.scala 27:20]
  wire  _T_2 = 2'h2 == cntRegSel; // @[SevenSegment.scala 27:20]
  wire  _T_3 = 2'h3 == cntRegSel; // @[SevenSegment.scala 27:20]
  wire [3:0] _GEN_2 = 2'h3 == cntRegSel ? 4'h8 : 4'h1; // @[SevenSegment.scala 27:20 31:24]
  wire [3:0] _GEN_3 = 2'h2 == cntRegSel ? 4'h4 : _GEN_2; // @[SevenSegment.scala 27:20 30:24]
  wire [3:0] _GEN_4 = 2'h1 == cntRegSel ? 4'h2 : _GEN_3; // @[SevenSegment.scala 27:20 29:24]
  wire [3:0] select = 2'h0 == cntRegSel ? 4'h1 : _GEN_4; // @[SevenSegment.scala 27:20 28:24]
  wire [7:0] _GEN_420 = _T_3 ? {{1'd0}, io_val1} : 8'h0; // @[SevenSegment.scala 83:20 87:23]
  wire [7:0] _GEN_421 = _T_2 ? {{1'd0}, io_val1} : _GEN_420; // @[SevenSegment.scala 83:20 86:23]
  wire [7:0] _GEN_422 = _T_1 ? {{1'd0}, io_rd} : _GEN_421; // @[SevenSegment.scala 83:20 85:23]
  wire [7:0] wire1 = _T ? {{1'd0}, io_rd} : _GEN_422; // @[SevenSegment.scala 83:20 84:23]
  wire [7:0] _GEN_7 = 7'h1 == wire1[6:0] ? 8'h1 : 8'h0; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_8 = 7'h2 == wire1[6:0] ? 8'h2 : _GEN_7; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_9 = 7'h3 == wire1[6:0] ? 8'h3 : _GEN_8; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_10 = 7'h4 == wire1[6:0] ? 8'h4 : _GEN_9; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_11 = 7'h5 == wire1[6:0] ? 8'h5 : _GEN_10; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_12 = 7'h6 == wire1[6:0] ? 8'h6 : _GEN_11; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_13 = 7'h7 == wire1[6:0] ? 8'h7 : _GEN_12; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_14 = 7'h8 == wire1[6:0] ? 8'h8 : _GEN_13; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_15 = 7'h9 == wire1[6:0] ? 8'h9 : _GEN_14; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_16 = 7'ha == wire1[6:0] ? 8'h10 : _GEN_15; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_17 = 7'hb == wire1[6:0] ? 8'h11 : _GEN_16; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_18 = 7'hc == wire1[6:0] ? 8'h12 : _GEN_17; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_19 = 7'hd == wire1[6:0] ? 8'h13 : _GEN_18; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_20 = 7'he == wire1[6:0] ? 8'h14 : _GEN_19; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_21 = 7'hf == wire1[6:0] ? 8'h15 : _GEN_20; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_22 = 7'h10 == wire1[6:0] ? 8'h16 : _GEN_21; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_23 = 7'h11 == wire1[6:0] ? 8'h17 : _GEN_22; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_24 = 7'h12 == wire1[6:0] ? 8'h18 : _GEN_23; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_25 = 7'h13 == wire1[6:0] ? 8'h19 : _GEN_24; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_26 = 7'h14 == wire1[6:0] ? 8'h20 : _GEN_25; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_27 = 7'h15 == wire1[6:0] ? 8'h21 : _GEN_26; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_28 = 7'h16 == wire1[6:0] ? 8'h22 : _GEN_27; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_29 = 7'h17 == wire1[6:0] ? 8'h23 : _GEN_28; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_30 = 7'h18 == wire1[6:0] ? 8'h24 : _GEN_29; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_31 = 7'h19 == wire1[6:0] ? 8'h25 : _GEN_30; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_32 = 7'h1a == wire1[6:0] ? 8'h26 : _GEN_31; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_33 = 7'h1b == wire1[6:0] ? 8'h27 : _GEN_32; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_34 = 7'h1c == wire1[6:0] ? 8'h28 : _GEN_33; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_35 = 7'h1d == wire1[6:0] ? 8'h29 : _GEN_34; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_36 = 7'h1e == wire1[6:0] ? 8'h30 : _GEN_35; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_37 = 7'h1f == wire1[6:0] ? 8'h31 : _GEN_36; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_38 = 7'h20 == wire1[6:0] ? 8'h32 : _GEN_37; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_39 = 7'h21 == wire1[6:0] ? 8'h33 : _GEN_38; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_40 = 7'h22 == wire1[6:0] ? 8'h34 : _GEN_39; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_41 = 7'h23 == wire1[6:0] ? 8'h35 : _GEN_40; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_42 = 7'h24 == wire1[6:0] ? 8'h36 : _GEN_41; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_43 = 7'h25 == wire1[6:0] ? 8'h37 : _GEN_42; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_44 = 7'h26 == wire1[6:0] ? 8'h38 : _GEN_43; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_45 = 7'h27 == wire1[6:0] ? 8'h39 : _GEN_44; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_46 = 7'h28 == wire1[6:0] ? 8'h40 : _GEN_45; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_47 = 7'h29 == wire1[6:0] ? 8'h41 : _GEN_46; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_48 = 7'h2a == wire1[6:0] ? 8'h42 : _GEN_47; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_49 = 7'h2b == wire1[6:0] ? 8'h43 : _GEN_48; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_50 = 7'h2c == wire1[6:0] ? 8'h44 : _GEN_49; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_51 = 7'h2d == wire1[6:0] ? 8'h45 : _GEN_50; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_52 = 7'h2e == wire1[6:0] ? 8'h46 : _GEN_51; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_53 = 7'h2f == wire1[6:0] ? 8'h47 : _GEN_52; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_54 = 7'h30 == wire1[6:0] ? 8'h48 : _GEN_53; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_55 = 7'h31 == wire1[6:0] ? 8'h49 : _GEN_54; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_56 = 7'h32 == wire1[6:0] ? 8'h50 : _GEN_55; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_57 = 7'h33 == wire1[6:0] ? 8'h51 : _GEN_56; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_58 = 7'h34 == wire1[6:0] ? 8'h52 : _GEN_57; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_59 = 7'h35 == wire1[6:0] ? 8'h53 : _GEN_58; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_60 = 7'h36 == wire1[6:0] ? 8'h54 : _GEN_59; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_61 = 7'h37 == wire1[6:0] ? 8'h55 : _GEN_60; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_62 = 7'h38 == wire1[6:0] ? 8'h56 : _GEN_61; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_63 = 7'h39 == wire1[6:0] ? 8'h57 : _GEN_62; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_64 = 7'h3a == wire1[6:0] ? 8'h58 : _GEN_63; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_65 = 7'h3b == wire1[6:0] ? 8'h59 : _GEN_64; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_66 = 7'h3c == wire1[6:0] ? 8'h60 : _GEN_65; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_67 = 7'h3d == wire1[6:0] ? 8'h61 : _GEN_66; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_68 = 7'h3e == wire1[6:0] ? 8'h62 : _GEN_67; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_69 = 7'h3f == wire1[6:0] ? 8'h63 : _GEN_68; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_70 = 7'h40 == wire1[6:0] ? 8'h64 : _GEN_69; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_71 = 7'h41 == wire1[6:0] ? 8'h65 : _GEN_70; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_72 = 7'h42 == wire1[6:0] ? 8'h66 : _GEN_71; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_73 = 7'h43 == wire1[6:0] ? 8'h67 : _GEN_72; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_74 = 7'h44 == wire1[6:0] ? 8'h68 : _GEN_73; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_75 = 7'h45 == wire1[6:0] ? 8'h69 : _GEN_74; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_76 = 7'h46 == wire1[6:0] ? 8'h70 : _GEN_75; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_77 = 7'h47 == wire1[6:0] ? 8'h71 : _GEN_76; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_78 = 7'h48 == wire1[6:0] ? 8'h72 : _GEN_77; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_79 = 7'h49 == wire1[6:0] ? 8'h73 : _GEN_78; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_80 = 7'h4a == wire1[6:0] ? 8'h74 : _GEN_79; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_81 = 7'h4b == wire1[6:0] ? 8'h75 : _GEN_80; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_82 = 7'h4c == wire1[6:0] ? 8'h76 : _GEN_81; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_83 = 7'h4d == wire1[6:0] ? 8'h77 : _GEN_82; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_84 = 7'h4e == wire1[6:0] ? 8'h78 : _GEN_83; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_85 = 7'h4f == wire1[6:0] ? 8'h79 : _GEN_84; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_86 = 7'h50 == wire1[6:0] ? 8'h80 : _GEN_85; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_87 = 7'h51 == wire1[6:0] ? 8'h81 : _GEN_86; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_88 = 7'h52 == wire1[6:0] ? 8'h82 : _GEN_87; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_89 = 7'h53 == wire1[6:0] ? 8'h83 : _GEN_88; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_90 = 7'h54 == wire1[6:0] ? 8'h84 : _GEN_89; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_91 = 7'h55 == wire1[6:0] ? 8'h85 : _GEN_90; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_92 = 7'h56 == wire1[6:0] ? 8'h86 : _GEN_91; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_93 = 7'h57 == wire1[6:0] ? 8'h87 : _GEN_92; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_94 = 7'h58 == wire1[6:0] ? 8'h88 : _GEN_93; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_95 = 7'h59 == wire1[6:0] ? 8'h89 : _GEN_94; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_96 = 7'h5a == wire1[6:0] ? 8'h90 : _GEN_95; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_97 = 7'h5b == wire1[6:0] ? 8'h91 : _GEN_96; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_98 = 7'h5c == wire1[6:0] ? 8'h92 : _GEN_97; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_99 = 7'h5d == wire1[6:0] ? 8'h93 : _GEN_98; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_100 = 7'h5e == wire1[6:0] ? 8'h94 : _GEN_99; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_101 = 7'h5f == wire1[6:0] ? 8'h95 : _GEN_100; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_102 = 7'h60 == wire1[6:0] ? 8'h96 : _GEN_101; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_103 = 7'h61 == wire1[6:0] ? 8'h97 : _GEN_102; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_104 = 7'h62 == wire1[6:0] ? 8'h98 : _GEN_103; // @[SevenSegment.scala 43:{41,41}]
  wire [7:0] _GEN_105 = 7'h63 == wire1[6:0] ? 8'h99 : _GEN_104; // @[SevenSegment.scala 43:{41,41}]
  wire [3:0] _GEN_406 = _T_3 ? _GEN_105[7:4] : 4'h0; // @[SevenSegment.scala 42:20 46:26]
  wire [3:0] _GEN_407 = _T_2 ? _GEN_105[3:0] : _GEN_406; // @[SevenSegment.scala 42:20 45:26]
  wire [3:0] _GEN_408 = _T_1 ? _GEN_105[7:4] : _GEN_407; // @[SevenSegment.scala 42:20 44:26]
  wire [3:0] sevSegIn = _T ? _GEN_105[3:0] : _GEN_408; // @[SevenSegment.scala 42:20 43:26]
  wire [6:0] _GEN_410 = 4'h9 == sevSegIn ? 7'h6f : 7'h7f; // @[SevenSegment.scala 50:20 79:14]
  wire [6:0] _GEN_411 = 4'h8 == sevSegIn ? 7'h7f : _GEN_410; // @[SevenSegment.scala 50:20 76:14]
  wire [6:0] _GEN_412 = 4'h7 == sevSegIn ? 7'h7 : _GEN_411; // @[SevenSegment.scala 50:20 73:14]
  wire [6:0] _GEN_413 = 4'h6 == sevSegIn ? 7'h7d : _GEN_412; // @[SevenSegment.scala 50:20 70:14]
  wire [6:0] _GEN_414 = 4'h5 == sevSegIn ? 7'h6d : _GEN_413; // @[SevenSegment.scala 50:20 67:14]
  wire [6:0] _GEN_415 = 4'h4 == sevSegIn ? 7'h66 : _GEN_414; // @[SevenSegment.scala 50:20 64:14]
  wire [6:0] _GEN_416 = 4'h3 == sevSegIn ? 7'h4f : _GEN_415; // @[SevenSegment.scala 50:20 61:14]
  wire [6:0] _GEN_417 = 4'h2 == sevSegIn ? 7'h5b : _GEN_416; // @[SevenSegment.scala 50:20 58:14]
  wire [6:0] _GEN_418 = 4'h1 == sevSegIn ? 7'h6 : _GEN_417; // @[SevenSegment.scala 50:20 55:14]
  wire [6:0] sevSeg = 4'h0 == sevSegIn ? 7'h3f : _GEN_418; // @[SevenSegment.scala 50:20 52:14]
  assign io_seg = ~sevSeg; // @[SevenSegment.scala 90:13]
  assign io_an = ~select; // @[SevenSegment.scala 91:12]
  always @(posedge clock) begin
    if (reset) begin // @[Counter.scala 61:40]
      counter_value <= 17'h0; // @[Counter.scala 61:40]
    end else if (wrap) begin // @[Counter.scala 87:20]
      counter_value <= 17'h0; // @[Counter.scala 87:28]
    end else begin
      counter_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[SevenSegment.scala 22:26]
      cntRegSel <= 2'h0; // @[SevenSegment.scala 22:26]
    end else if (wrap) begin // @[SevenSegment.scala 23:23]
      cntRegSel <= _cntRegSel_T_1; // @[SevenSegment.scala 24:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  counter_value = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  cntRegSel = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VStageProcessor(
  input        clock,
  input        reset,
  input        io_startPipeline,
  input        io_add,
  input        io_branchInst,
  input        io_jumpInst,
  output [6:0] io_seg,
  output [3:0] io_an,
  output       io_useImm,
  output       io_useAlu,
  output       io_branch,
  output       io_jump,
  output       io_load,
  output       io_store,
  output       io_changePC,
  output       io_writeEnable
);
  wire  IF_clock; // @[VStageProcessor.scala 33:18]
  wire  IF_reset; // @[VStageProcessor.scala 33:18]
  wire  IF_io_stallReg; // @[VStageProcessor.scala 33:18]
  wire  IF_io_flush; // @[VStageProcessor.scala 33:18]
  wire [31:0] IF_io_out_inst; // @[VStageProcessor.scala 33:18]
  wire [31:0] IF_io_out_pc; // @[VStageProcessor.scala 33:18]
  wire [31:0] IF_io_newPCValue; // @[VStageProcessor.scala 33:18]
  wire  IF_io_changePC; // @[VStageProcessor.scala 33:18]
  wire  IF_io_memIO_ready; // @[VStageProcessor.scala 33:18]
  wire [31:0] IF_io_memIO_writeData; // @[VStageProcessor.scala 33:18]
  wire  IF_io_startPC; // @[VStageProcessor.scala 33:18]
  wire  ID_clock; // @[VStageProcessor.scala 34:18]
  wire  ID_reset; // @[VStageProcessor.scala 34:18]
  wire  ID_io_stallReg; // @[VStageProcessor.scala 34:18]
  wire  ID_io_flush; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_in_inst; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_in_pc; // @[VStageProcessor.scala 34:18]
  wire [4:0] ID_io_wbIn_rd; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_wbIn_muxOut; // @[VStageProcessor.scala 34:18]
  wire  ID_io_wbIn_writeEnable; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_out_pc; // @[VStageProcessor.scala 34:18]
  wire [4:0] ID_io_out_rs1; // @[VStageProcessor.scala 34:18]
  wire [4:0] ID_io_out_rs2; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_out_val1; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_out_val2; // @[VStageProcessor.scala 34:18]
  wire [4:0] ID_io_out_rd; // @[VStageProcessor.scala 34:18]
  wire [31:0] ID_io_out_imm; // @[VStageProcessor.scala 34:18]
  wire [3:0] ID_io_out_aluOp; // @[VStageProcessor.scala 34:18]
  wire [3:0] ID_io_out_memOp; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_useImm; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_useALU; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_branch; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_jump; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_load; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_store; // @[VStageProcessor.scala 34:18]
  wire  ID_io_out_ctrl_changePC; // @[VStageProcessor.scala 34:18]
  wire  EX_clock; // @[VStageProcessor.scala 35:18]
  wire  EX_io_stallReg; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_in_pc; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_in_val1; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_in_val2; // @[VStageProcessor.scala 35:18]
  wire [4:0] EX_io_in_rd; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_in_imm; // @[VStageProcessor.scala 35:18]
  wire [3:0] EX_io_in_aluOp; // @[VStageProcessor.scala 35:18]
  wire [3:0] EX_io_in_memOp; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_useImm; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_useALU; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_branch; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_jump; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_load; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_store; // @[VStageProcessor.scala 35:18]
  wire  EX_io_in_ctrl_changePC; // @[VStageProcessor.scala 35:18]
  wire [4:0] EX_io_out_rd; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_out_aluOut; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_out_wrData; // @[VStageProcessor.scala 35:18]
  wire  EX_io_out_ctrl_writeEnable; // @[VStageProcessor.scala 35:18]
  wire  EX_io_out_ctrl_store; // @[VStageProcessor.scala 35:18]
  wire  EX_io_out_ctrl_load; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_hazardAluOut; // @[VStageProcessor.scala 35:18]
  wire  EX_io_changePC; // @[VStageProcessor.scala 35:18]
  wire [31:0] EX_io_newPCValue; // @[VStageProcessor.scala 35:18]
  wire  MEM_clock; // @[VStageProcessor.scala 36:19]
  wire [4:0] MEM_io_in_rd; // @[VStageProcessor.scala 36:19]
  wire [31:0] MEM_io_in_aluOut; // @[VStageProcessor.scala 36:19]
  wire [31:0] MEM_io_in_wrData; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_in_ctrl_writeEnable; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_in_ctrl_store; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_in_ctrl_load; // @[VStageProcessor.scala 36:19]
  wire [4:0] MEM_io_out_rd; // @[VStageProcessor.scala 36:19]
  wire [31:0] MEM_io_out_aluOut; // @[VStageProcessor.scala 36:19]
  wire [31:0] MEM_io_out_memOut; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_out_load; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_out_writeEnable; // @[VStageProcessor.scala 36:19]
  wire [4:0] MEM_io_mem_fwd_rd; // @[VStageProcessor.scala 36:19]
  wire [31:0] MEM_io_mem_fwd_stageOutput; // @[VStageProcessor.scala 36:19]
  wire  MEM_io_mem_fwd_writeEnable; // @[VStageProcessor.scala 36:19]
  wire [4:0] WB_io_in_rd; // @[VStageProcessor.scala 37:18]
  wire [31:0] WB_io_in_aluOut; // @[VStageProcessor.scala 37:18]
  wire [31:0] WB_io_in_memOut; // @[VStageProcessor.scala 37:18]
  wire  WB_io_in_load; // @[VStageProcessor.scala 37:18]
  wire  WB_io_in_writeEnable; // @[VStageProcessor.scala 37:18]
  wire [4:0] WB_io_out_rd; // @[VStageProcessor.scala 37:18]
  wire [31:0] WB_io_out_muxOut; // @[VStageProcessor.scala 37:18]
  wire  WB_io_out_writeEnable; // @[VStageProcessor.scala 37:18]
  wire [4:0] WB_io_wb_fwd_rd; // @[VStageProcessor.scala 37:18]
  wire [31:0] WB_io_wb_fwd_stageOutput; // @[VStageProcessor.scala 37:18]
  wire  WB_io_wb_fwd_writeEnable; // @[VStageProcessor.scala 37:18]
  wire [4:0] forwardingUnit_io_id_rs1; // @[VStageProcessor.scala 40:30]
  wire [4:0] forwardingUnit_io_id_rs2; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_id_val1; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_id_val2; // @[VStageProcessor.scala 40:30]
  wire [4:0] forwardingUnit_io_mem_fwd_rd; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_mem_fwd_stageOutput; // @[VStageProcessor.scala 40:30]
  wire  forwardingUnit_io_mem_fwd_writeEnable; // @[VStageProcessor.scala 40:30]
  wire [4:0] forwardingUnit_io_wb_fwd_rd; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_wb_fwd_stageOutput; // @[VStageProcessor.scala 40:30]
  wire  forwardingUnit_io_wb_fwd_writeEnable; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_val1; // @[VStageProcessor.scala 40:30]
  wire [31:0] forwardingUnit_io_val2; // @[VStageProcessor.scala 40:30]
  wire [31:0] hazardControl_io_EXaluOut; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_EXctrlBranch; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_EXctrlJump; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_EXctrlLoad; // @[VStageProcessor.scala 41:29]
  wire [4:0] hazardControl_io_EXrd; // @[VStageProcessor.scala 41:29]
  wire [4:0] hazardControl_io_IDrs1; // @[VStageProcessor.scala 41:29]
  wire [4:0] hazardControl_io_IDrs2; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_IDFlush; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_IFFlush; // @[VStageProcessor.scala 41:29]
  wire  hazardControl_io_IFStall; // @[VStageProcessor.scala 41:29]
  wire  sevenSegmentDisplay_clock; // @[VStageProcessor.scala 94:35]
  wire  sevenSegmentDisplay_reset; // @[VStageProcessor.scala 94:35]
  wire [6:0] sevenSegmentDisplay_io_rd; // @[VStageProcessor.scala 94:35]
  wire [6:0] sevenSegmentDisplay_io_val1; // @[VStageProcessor.scala 94:35]
  wire [6:0] sevenSegmentDisplay_io_seg; // @[VStageProcessor.scala 94:35]
  wire [3:0] sevenSegmentDisplay_io_an; // @[VStageProcessor.scala 94:35]
  wire  _GEN_0 = io_add | io_startPipeline; // @[VStageProcessor.scala 102:16 103:19 88:17]
  wire [31:0] _GEN_2 = io_add ? 32'h108093 : 32'h0; // @[VStageProcessor.scala 102:16 105:27 87:25]
  wire  _GEN_3 = io_branchInst | _GEN_0; // @[VStageProcessor.scala 108:23 109:19]
  wire  _GEN_4 = io_branchInst | io_add; // @[VStageProcessor.scala 108:23 110:23]
  wire [31:0] _GEN_5 = io_branchInst ? 32'h310863 : _GEN_2; // @[VStageProcessor.scala 108:23 111:27]
  IF IF ( // @[VStageProcessor.scala 33:18]
    .clock(IF_clock),
    .reset(IF_reset),
    .io_stallReg(IF_io_stallReg),
    .io_flush(IF_io_flush),
    .io_out_inst(IF_io_out_inst),
    .io_out_pc(IF_io_out_pc),
    .io_newPCValue(IF_io_newPCValue),
    .io_changePC(IF_io_changePC),
    .io_memIO_ready(IF_io_memIO_ready),
    .io_memIO_writeData(IF_io_memIO_writeData),
    .io_startPC(IF_io_startPC)
  );
  ID ID ( // @[VStageProcessor.scala 34:18]
    .clock(ID_clock),
    .reset(ID_reset),
    .io_stallReg(ID_io_stallReg),
    .io_flush(ID_io_flush),
    .io_in_inst(ID_io_in_inst),
    .io_in_pc(ID_io_in_pc),
    .io_wbIn_rd(ID_io_wbIn_rd),
    .io_wbIn_muxOut(ID_io_wbIn_muxOut),
    .io_wbIn_writeEnable(ID_io_wbIn_writeEnable),
    .io_out_pc(ID_io_out_pc),
    .io_out_rs1(ID_io_out_rs1),
    .io_out_rs2(ID_io_out_rs2),
    .io_out_val1(ID_io_out_val1),
    .io_out_val2(ID_io_out_val2),
    .io_out_rd(ID_io_out_rd),
    .io_out_imm(ID_io_out_imm),
    .io_out_aluOp(ID_io_out_aluOp),
    .io_out_memOp(ID_io_out_memOp),
    .io_out_ctrl_useImm(ID_io_out_ctrl_useImm),
    .io_out_ctrl_useALU(ID_io_out_ctrl_useALU),
    .io_out_ctrl_branch(ID_io_out_ctrl_branch),
    .io_out_ctrl_jump(ID_io_out_ctrl_jump),
    .io_out_ctrl_load(ID_io_out_ctrl_load),
    .io_out_ctrl_store(ID_io_out_ctrl_store),
    .io_out_ctrl_changePC(ID_io_out_ctrl_changePC)
  );
  EX EX ( // @[VStageProcessor.scala 35:18]
    .clock(EX_clock),
    .io_stallReg(EX_io_stallReg),
    .io_in_pc(EX_io_in_pc),
    .io_in_val1(EX_io_in_val1),
    .io_in_val2(EX_io_in_val2),
    .io_in_rd(EX_io_in_rd),
    .io_in_imm(EX_io_in_imm),
    .io_in_aluOp(EX_io_in_aluOp),
    .io_in_memOp(EX_io_in_memOp),
    .io_in_ctrl_useImm(EX_io_in_ctrl_useImm),
    .io_in_ctrl_useALU(EX_io_in_ctrl_useALU),
    .io_in_ctrl_branch(EX_io_in_ctrl_branch),
    .io_in_ctrl_jump(EX_io_in_ctrl_jump),
    .io_in_ctrl_load(EX_io_in_ctrl_load),
    .io_in_ctrl_store(EX_io_in_ctrl_store),
    .io_in_ctrl_changePC(EX_io_in_ctrl_changePC),
    .io_out_rd(EX_io_out_rd),
    .io_out_aluOut(EX_io_out_aluOut),
    .io_out_wrData(EX_io_out_wrData),
    .io_out_ctrl_writeEnable(EX_io_out_ctrl_writeEnable),
    .io_out_ctrl_store(EX_io_out_ctrl_store),
    .io_out_ctrl_load(EX_io_out_ctrl_load),
    .io_hazardAluOut(EX_io_hazardAluOut),
    .io_changePC(EX_io_changePC),
    .io_newPCValue(EX_io_newPCValue)
  );
  MEM MEM ( // @[VStageProcessor.scala 36:19]
    .clock(MEM_clock),
    .io_in_rd(MEM_io_in_rd),
    .io_in_aluOut(MEM_io_in_aluOut),
    .io_in_wrData(MEM_io_in_wrData),
    .io_in_ctrl_writeEnable(MEM_io_in_ctrl_writeEnable),
    .io_in_ctrl_store(MEM_io_in_ctrl_store),
    .io_in_ctrl_load(MEM_io_in_ctrl_load),
    .io_out_rd(MEM_io_out_rd),
    .io_out_aluOut(MEM_io_out_aluOut),
    .io_out_memOut(MEM_io_out_memOut),
    .io_out_load(MEM_io_out_load),
    .io_out_writeEnable(MEM_io_out_writeEnable),
    .io_mem_fwd_rd(MEM_io_mem_fwd_rd),
    .io_mem_fwd_stageOutput(MEM_io_mem_fwd_stageOutput),
    .io_mem_fwd_writeEnable(MEM_io_mem_fwd_writeEnable)
  );
  WB WB ( // @[VStageProcessor.scala 37:18]
    .io_in_rd(WB_io_in_rd),
    .io_in_aluOut(WB_io_in_aluOut),
    .io_in_memOut(WB_io_in_memOut),
    .io_in_load(WB_io_in_load),
    .io_in_writeEnable(WB_io_in_writeEnable),
    .io_out_rd(WB_io_out_rd),
    .io_out_muxOut(WB_io_out_muxOut),
    .io_out_writeEnable(WB_io_out_writeEnable),
    .io_wb_fwd_rd(WB_io_wb_fwd_rd),
    .io_wb_fwd_stageOutput(WB_io_wb_fwd_stageOutput),
    .io_wb_fwd_writeEnable(WB_io_wb_fwd_writeEnable)
  );
  ForwardingUnit forwardingUnit ( // @[VStageProcessor.scala 40:30]
    .io_id_rs1(forwardingUnit_io_id_rs1),
    .io_id_rs2(forwardingUnit_io_id_rs2),
    .io_id_val1(forwardingUnit_io_id_val1),
    .io_id_val2(forwardingUnit_io_id_val2),
    .io_mem_fwd_rd(forwardingUnit_io_mem_fwd_rd),
    .io_mem_fwd_stageOutput(forwardingUnit_io_mem_fwd_stageOutput),
    .io_mem_fwd_writeEnable(forwardingUnit_io_mem_fwd_writeEnable),
    .io_wb_fwd_rd(forwardingUnit_io_wb_fwd_rd),
    .io_wb_fwd_stageOutput(forwardingUnit_io_wb_fwd_stageOutput),
    .io_wb_fwd_writeEnable(forwardingUnit_io_wb_fwd_writeEnable),
    .io_val1(forwardingUnit_io_val1),
    .io_val2(forwardingUnit_io_val2)
  );
  HazardControl hazardControl ( // @[VStageProcessor.scala 41:29]
    .io_EXaluOut(hazardControl_io_EXaluOut),
    .io_EXctrlBranch(hazardControl_io_EXctrlBranch),
    .io_EXctrlJump(hazardControl_io_EXctrlJump),
    .io_EXctrlLoad(hazardControl_io_EXctrlLoad),
    .io_EXrd(hazardControl_io_EXrd),
    .io_IDrs1(hazardControl_io_IDrs1),
    .io_IDrs2(hazardControl_io_IDrs2),
    .io_IDFlush(hazardControl_io_IDFlush),
    .io_IFFlush(hazardControl_io_IFFlush),
    .io_IFStall(hazardControl_io_IFStall)
  );
  SevenSegment sevenSegmentDisplay ( // @[VStageProcessor.scala 94:35]
    .clock(sevenSegmentDisplay_clock),
    .reset(sevenSegmentDisplay_reset),
    .io_rd(sevenSegmentDisplay_io_rd),
    .io_val1(sevenSegmentDisplay_io_val1),
    .io_seg(sevenSegmentDisplay_io_seg),
    .io_an(sevenSegmentDisplay_io_an)
  );
  assign io_seg = sevenSegmentDisplay_io_seg; // @[VStageProcessor.scala 95:10]
  assign io_an = sevenSegmentDisplay_io_an; // @[VStageProcessor.scala 96:9]
  assign io_useImm = ID_io_out_ctrl_useImm; // @[VStageProcessor.scala 141:13]
  assign io_useAlu = ID_io_out_ctrl_useALU; // @[VStageProcessor.scala 142:13]
  assign io_branch = ID_io_out_ctrl_branch; // @[VStageProcessor.scala 143:13]
  assign io_jump = ID_io_out_ctrl_jump; // @[VStageProcessor.scala 144:11]
  assign io_load = ID_io_out_ctrl_load; // @[VStageProcessor.scala 145:11]
  assign io_store = ID_io_out_ctrl_store; // @[VStageProcessor.scala 146:12]
  assign io_changePC = ID_io_out_ctrl_changePC; // @[VStageProcessor.scala 147:15]
  assign io_writeEnable = WB_io_in_writeEnable; // @[VStageProcessor.scala 148:18]
  assign IF_clock = clock;
  assign IF_reset = reset;
  assign IF_io_stallReg = hazardControl_io_IFStall; // @[VStageProcessor.scala 77:18]
  assign IF_io_flush = hazardControl_io_IFFlush; // @[VStageProcessor.scala 74:15]
  assign IF_io_newPCValue = EX_io_newPCValue; // @[VStageProcessor.scala 62:20]
  assign IF_io_changePC = EX_io_changePC; // @[VStageProcessor.scala 61:18]
  assign IF_io_memIO_ready = io_jumpInst | _GEN_4; // @[VStageProcessor.scala 126:21 128:23]
  assign IF_io_memIO_writeData = io_jumpInst ? 32'h280006f : _GEN_5; // @[VStageProcessor.scala 126:21 129:27]
  assign IF_io_startPC = io_jumpInst | _GEN_3; // @[VStageProcessor.scala 126:21 127:19]
  assign ID_clock = clock;
  assign ID_reset = reset;
  assign ID_io_stallReg = hazardControl_io_IFStall; // @[VStageProcessor.scala 78:18]
  assign ID_io_flush = hazardControl_io_IDFlush; // @[VStageProcessor.scala 75:15]
  assign ID_io_in_inst = IF_io_out_inst; // @[VStageProcessor.scala 44:13]
  assign ID_io_in_pc = IF_io_out_pc; // @[VStageProcessor.scala 44:13]
  assign ID_io_wbIn_rd = WB_io_out_rd; // @[VStageProcessor.scala 48:13]
  assign ID_io_wbIn_muxOut = WB_io_out_muxOut; // @[VStageProcessor.scala 48:13]
  assign ID_io_wbIn_writeEnable = WB_io_out_writeEnable; // @[VStageProcessor.scala 48:13]
  assign EX_clock = clock;
  assign EX_io_stallReg = hazardControl_io_IFStall; // @[VStageProcessor.scala 79:18]
  assign EX_io_in_pc = ID_io_out_pc; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_val1 = forwardingUnit_io_val1; // @[VStageProcessor.scala 59:17]
  assign EX_io_in_val2 = forwardingUnit_io_val2; // @[VStageProcessor.scala 60:17]
  assign EX_io_in_rd = ID_io_out_rd; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_imm = ID_io_out_imm; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_aluOp = ID_io_out_aluOp; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_memOp = ID_io_out_memOp; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_useImm = ID_io_out_ctrl_useImm; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_useALU = ID_io_out_ctrl_useALU; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_branch = ID_io_out_ctrl_branch; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_jump = ID_io_out_ctrl_jump; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_load = ID_io_out_ctrl_load; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_store = ID_io_out_ctrl_store; // @[VStageProcessor.scala 45:13]
  assign EX_io_in_ctrl_changePC = ID_io_out_ctrl_changePC; // @[VStageProcessor.scala 45:13]
  assign MEM_clock = clock;
  assign MEM_io_in_rd = EX_io_out_rd; // @[VStageProcessor.scala 46:13]
  assign MEM_io_in_aluOut = EX_io_out_aluOut; // @[VStageProcessor.scala 46:13]
  assign MEM_io_in_wrData = EX_io_out_wrData; // @[VStageProcessor.scala 46:13]
  assign MEM_io_in_ctrl_writeEnable = EX_io_out_ctrl_writeEnable; // @[VStageProcessor.scala 46:13]
  assign MEM_io_in_ctrl_store = EX_io_out_ctrl_store; // @[VStageProcessor.scala 46:13]
  assign MEM_io_in_ctrl_load = EX_io_out_ctrl_load; // @[VStageProcessor.scala 46:13]
  assign WB_io_in_rd = MEM_io_out_rd; // @[VStageProcessor.scala 47:14]
  assign WB_io_in_aluOut = MEM_io_out_aluOut; // @[VStageProcessor.scala 47:14]
  assign WB_io_in_memOut = MEM_io_out_memOut; // @[VStageProcessor.scala 47:14]
  assign WB_io_in_load = MEM_io_out_load; // @[VStageProcessor.scala 47:14]
  assign WB_io_in_writeEnable = MEM_io_out_writeEnable; // @[VStageProcessor.scala 47:14]
  assign forwardingUnit_io_id_rs1 = ID_io_out_rs1; // @[VStageProcessor.scala 54:28]
  assign forwardingUnit_io_id_rs2 = ID_io_out_rs2; // @[VStageProcessor.scala 55:28]
  assign forwardingUnit_io_id_val1 = ID_io_out_val1; // @[VStageProcessor.scala 56:29]
  assign forwardingUnit_io_id_val2 = ID_io_out_val2; // @[VStageProcessor.scala 57:29]
  assign forwardingUnit_io_mem_fwd_rd = MEM_io_mem_fwd_rd; // @[VStageProcessor.scala 51:29]
  assign forwardingUnit_io_mem_fwd_stageOutput = MEM_io_mem_fwd_stageOutput; // @[VStageProcessor.scala 51:29]
  assign forwardingUnit_io_mem_fwd_writeEnable = MEM_io_mem_fwd_writeEnable; // @[VStageProcessor.scala 51:29]
  assign forwardingUnit_io_wb_fwd_rd = WB_io_wb_fwd_rd; // @[VStageProcessor.scala 52:28]
  assign forwardingUnit_io_wb_fwd_stageOutput = WB_io_wb_fwd_stageOutput; // @[VStageProcessor.scala 52:28]
  assign forwardingUnit_io_wb_fwd_writeEnable = WB_io_wb_fwd_writeEnable; // @[VStageProcessor.scala 52:28]
  assign hazardControl_io_EXaluOut = EX_io_hazardAluOut; // @[VStageProcessor.scala 65:29]
  assign hazardControl_io_EXctrlBranch = EX_io_in_ctrl_branch; // @[VStageProcessor.scala 68:33]
  assign hazardControl_io_EXctrlJump = EX_io_in_ctrl_jump; // @[VStageProcessor.scala 69:31]
  assign hazardControl_io_EXctrlLoad = EX_io_in_ctrl_load; // @[VStageProcessor.scala 67:31]
  assign hazardControl_io_EXrd = EX_io_in_rd; // @[VStageProcessor.scala 66:25]
  assign hazardControl_io_IDrs1 = ID_io_out_rs1; // @[VStageProcessor.scala 70:26]
  assign hazardControl_io_IDrs2 = ID_io_out_rs2; // @[VStageProcessor.scala 71:26]
  assign sevenSegmentDisplay_clock = clock;
  assign sevenSegmentDisplay_reset = reset;
  assign sevenSegmentDisplay_io_rd = ID_io_out_val2[6:0]; // @[VStageProcessor.scala 98:29]
  assign sevenSegmentDisplay_io_val1 = ID_io_out_val1[6:0]; // @[VStageProcessor.scala 97:31]
endmodule
