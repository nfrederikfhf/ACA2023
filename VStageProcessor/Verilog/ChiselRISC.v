module IF(
  input   io_stallReg
);
endmodule
module ID(
  input        clock,
  input        io_stallReg,
  input        io_flush,
  output [3:0] io_out_aluOp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _io_out_ctrl_branch_T_1 = ~io_stallReg; // @[ID.scala 59:86]
  reg [3:0] io_out_aluOp_r; // @[Reg.scala 19:16]
  assign io_out_aluOp = io_out_aluOp_r; // @[ID.scala 73:16]
  always @(posedge clock) begin
    if (_io_out_ctrl_branch_T_1) begin // @[Reg.scala 20:18]
      if (io_flush) begin // @[ID.scala 73:32]
        io_out_aluOp_r <= 4'h0;
      end else begin
        io_out_aluOp_r <= 4'h1;
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
  io_out_aluOp_r = _RAND_0[3:0];
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
  output [31:0] io_aluOut
);
  wire [31:0] _GEN_0 = 4'hf == io_aluOp ? 32'h1 : 32'h0; // @[ALU.scala 17:13 21:13 41:31]
  wire [31:0] _GEN_1 = 4'he == io_aluOp ? 32'h0 : _GEN_0; // @[ALU.scala 21:13 40:31]
  wire [31:0] _GEN_2 = 4'h0 == io_aluOp ? 32'h0 : _GEN_1; // @[ALU.scala 21:13 39:30]
  wire [31:0] _GEN_3 = 4'hd == io_aluOp ? 32'h1 : _GEN_2; // @[ALU.scala 21:13 38:30]
  wire [31:0] _GEN_4 = 4'hc == io_aluOp ? 32'h0 : _GEN_3; // @[ALU.scala 21:13 37:30]
  wire [31:0] _GEN_5 = 4'hb == io_aluOp ? 32'h1 : _GEN_4; // @[ALU.scala 21:13 36:30]
  wire [31:0] _GEN_6 = 4'ha == io_aluOp ? 32'h0 : _GEN_5; // @[ALU.scala 21:13 35:31]
  wire [31:0] _GEN_7 = 4'h9 == io_aluOp ? 32'h0 : _GEN_6; // @[ALU.scala 21:13 34:30]
  wire [62:0] _GEN_8 = 4'h8 == io_aluOp ? 63'h0 : {{31'd0}, _GEN_7}; // @[ALU.scala 21:13 32:30]
  wire [62:0] _GEN_9 = 4'h7 == io_aluOp ? 63'h0 : _GEN_8; // @[ALU.scala 21:13 31:30]
  wire [62:0] _GEN_10 = 4'h6 == io_aluOp ? 63'h0 : _GEN_9; // @[ALU.scala 21:13 30:30]
  wire [62:0] _GEN_11 = 4'h5 == io_aluOp ? 63'h0 : _GEN_10; // @[ALU.scala 21:13 28:30]
  wire [62:0] _GEN_12 = 4'h4 == io_aluOp ? 63'h0 : _GEN_11; // @[ALU.scala 21:13 27:29]
  wire [62:0] _GEN_13 = 4'h3 == io_aluOp ? 63'h0 : _GEN_12; // @[ALU.scala 21:13 26:30]
  wire [62:0] _GEN_14 = 4'h2 == io_aluOp ? 63'h0 : _GEN_13; // @[ALU.scala 21:13 24:30]
  wire [62:0] _GEN_15 = 4'h1 == io_aluOp ? 63'h0 : _GEN_14; // @[ALU.scala 21:13 23:30]
  assign io_aluOut = _GEN_15[31:0];
endmodule
module EX(
  input         clock,
  input  [4:0]  io_in_rd,
  input  [3:0]  io_in_aluOp,
  input         io_in_ctrl_branch,
  input         io_in_ctrl_jump,
  input         io_in_ctrl_load,
  output [31:0] io_out_aluOut,
  output [31:0] io_hazardAluOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] ALU_io_aluOp; // @[EX.scala 20:19]
  wire [31:0] ALU_io_aluOut; // @[EX.scala 20:19]
  reg [31:0] outReg_aluOut; // @[Reg.scala 19:16]
  ALU ALU ( // @[EX.scala 20:19]
    .io_aluOp(ALU_io_aluOp),
    .io_aluOut(ALU_io_aluOut)
  );
  assign io_out_aluOut = outReg_aluOut; // @[EX.scala 83:17]
  assign io_hazardAluOut = ALU_io_aluOut; // @[EX.scala 25:19]
  assign ALU_io_aluOp = io_in_aluOp; // @[EX.scala 27:16]
  always @(posedge clock) begin
    outReg_aluOut <= ALU_io_aluOut; // @[EX.scala 28:23]
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
  outReg_aluOut = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MEM(
  input         clock,
  input  [31:0] io_in_aluOut,
  output [31:0] io_out_aluOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] outReg_aluOut; // @[Reg.scala 19:16]
  assign io_out_aluOut = outReg_aluOut; // @[MEM.scala 54:17]
  always @(posedge clock) begin
    outReg_aluOut <= io_in_aluOut; // @[MEM.scala 22:17]
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
  outReg_aluOut = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module WB(
  input  [31:0] io_in_aluOut,
  output [31:0] io_out_muxOut
);
  assign io_out_muxOut = io_in_aluOut; // @[WB.scala 19:19]
endmodule
module HazardControl(
  input  [31:0] io_EXaluOut,
  input         io_EXctrlBranch,
  input         io_EXctrlJump,
  input         io_EXctrlLoad,
  input  [4:0]  io_EXrd,
  output        io_IDFlush,
  output        io_IFStall
);
  wire  use_load = io_EXctrlLoad & (io_EXrd == 5'h0 | io_EXrd == 5'h0) & io_EXrd != 5'h0; // @[HazardControl.scala 27:82]
  wire  branch_jump = io_EXaluOut == 32'h1 & io_EXctrlBranch | io_EXctrlJump; // @[HazardControl.scala 28:62]
  assign io_IDFlush = branch_jump | use_load; // @[HazardControl.scala 32:29]
  assign io_IFStall = io_EXctrlLoad & (io_EXrd == 5'h0 | io_EXrd == 5'h0) & io_EXrd != 5'h0; // @[HazardControl.scala 27:82]
endmodule
module SevenSegment(
  input         clock,
  input         reset,
  input  [15:0] io_in,
  output [6:0]  io_seg,
  output [3:0]  io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [18:0] ticker; // @[SevenSegment.scala 19:23]
  wire  tick = ticker == 19'h12; // @[SevenSegment.scala 20:21]
  wire [18:0] _ticker_T_1 = ticker + 19'h1; // @[SevenSegment.scala 21:35]
  reg [1:0] cntReg; // @[SevenSegment.scala 24:23]
  wire [1:0] _cntReg_T_2 = cntReg + 2'h1; // @[SevenSegment.scala 26:47]
  wire [3:0] _GEN_1 = 2'h3 == cntReg ? io_in[3:0] : 4'h0; // @[SevenSegment.scala 29:17 43:13]
  wire [3:0] _GEN_2 = 2'h3 == cntReg ? 4'he : 4'hf; // @[SevenSegment.scala 29:17 44:14 14:9]
  wire [3:0] _GEN_3 = 2'h2 == cntReg ? io_in[7:4] : _GEN_1; // @[SevenSegment.scala 29:17 39:12]
  wire [3:0] _GEN_4 = 2'h2 == cntReg ? 4'hd : _GEN_2; // @[SevenSegment.scala 29:17 40:13]
  wire [3:0] _GEN_5 = 2'h1 == cntReg ? io_in[11:8] : _GEN_3; // @[SevenSegment.scala 29:17 35:12]
  wire [3:0] _GEN_6 = 2'h1 == cntReg ? 4'hb : _GEN_4; // @[SevenSegment.scala 29:17 36:13]
  wire [3:0] data = 2'h0 == cntReg ? io_in[15:12] : _GEN_5; // @[SevenSegment.scala 29:17 31:12]
  wire [6:0] _GEN_9 = 4'hf == data ? 7'h47 : 7'h7f; // @[SevenSegment.scala 13:11 48:16 95:14]
  wire [6:0] _GEN_10 = 4'he == data ? 7'h4f : _GEN_9; // @[SevenSegment.scala 48:16 92:14]
  wire [6:0] _GEN_11 = 4'hd == data ? 7'h3d : _GEN_10; // @[SevenSegment.scala 48:16 89:14]
  wire [6:0] _GEN_12 = 4'hc == data ? 7'h4e : _GEN_11; // @[SevenSegment.scala 48:16 86:14]
  wire [6:0] _GEN_13 = 4'hb == data ? 7'h1f : _GEN_12; // @[SevenSegment.scala 48:16 83:14]
  wire [6:0] _GEN_14 = 4'ha == data ? 7'h77 : _GEN_13; // @[SevenSegment.scala 48:16 80:14]
  wire [6:0] _GEN_15 = 4'h9 == data ? 7'h73 : _GEN_14; // @[SevenSegment.scala 48:16 77:14]
  wire [6:0] _GEN_16 = 4'h8 == data ? 7'h7f : _GEN_15; // @[SevenSegment.scala 48:16 74:14]
  wire [6:0] _GEN_17 = 4'h7 == data ? 7'h70 : _GEN_16; // @[SevenSegment.scala 48:16 71:14]
  wire [6:0] _GEN_18 = 4'h6 == data ? 7'h5f : _GEN_17; // @[SevenSegment.scala 48:16 68:14]
  wire [6:0] _GEN_19 = 4'h5 == data ? 7'h5b : _GEN_18; // @[SevenSegment.scala 48:16 65:14]
  wire [6:0] _GEN_20 = 4'h4 == data ? 7'h33 : _GEN_19; // @[SevenSegment.scala 48:16 62:14]
  wire [6:0] _GEN_21 = 4'h3 == data ? 7'h79 : _GEN_20; // @[SevenSegment.scala 48:16 59:14]
  wire [6:0] _GEN_22 = 4'h2 == data ? 7'h6d : _GEN_21; // @[SevenSegment.scala 48:16 56:14]
  wire [6:0] _GEN_23 = 4'h1 == data ? 7'h30 : _GEN_22; // @[SevenSegment.scala 48:16 53:14]
  assign io_seg = 4'h0 == data ? 7'h7e : _GEN_23; // @[SevenSegment.scala 48:16 50:14]
  assign io_an = 2'h0 == cntReg ? 4'h7 : _GEN_6; // @[SevenSegment.scala 29:17 32:13]
  always @(posedge clock) begin
    if (reset) begin // @[SevenSegment.scala 19:23]
      ticker <= 19'h0; // @[SevenSegment.scala 19:23]
    end else if (tick) begin // @[SevenSegment.scala 21:16]
      ticker <= 19'h0;
    end else begin
      ticker <= _ticker_T_1;
    end
    if (reset) begin // @[SevenSegment.scala 24:23]
      cntReg <= 2'h0; // @[SevenSegment.scala 24:23]
    end else if (tick) begin // @[SevenSegment.scala 25:14]
      if (cntReg == 2'h3) begin // @[SevenSegment.scala 26:18]
        cntReg <= 2'h0;
      end else begin
        cntReg <= _cntReg_T_2;
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
  ticker = _RAND_0[18:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ChiselRISC(
  input        clock,
  input        reset,
  input        io_startPipeline,
  output [6:0] io_seg,
  output [3:0] io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  IF_io_stallReg; // @[ChiselRISC.scala 27:20]
  wire  ID_clock; // @[ChiselRISC.scala 28:20]
  wire  ID_io_stallReg; // @[ChiselRISC.scala 28:20]
  wire  ID_io_flush; // @[ChiselRISC.scala 28:20]
  wire [3:0] ID_io_out_aluOp; // @[ChiselRISC.scala 28:20]
  wire  EX_clock; // @[ChiselRISC.scala 29:20]
  wire [4:0] EX_io_in_rd; // @[ChiselRISC.scala 29:20]
  wire [3:0] EX_io_in_aluOp; // @[ChiselRISC.scala 29:20]
  wire  EX_io_in_ctrl_branch; // @[ChiselRISC.scala 29:20]
  wire  EX_io_in_ctrl_jump; // @[ChiselRISC.scala 29:20]
  wire  EX_io_in_ctrl_load; // @[ChiselRISC.scala 29:20]
  wire [31:0] EX_io_out_aluOut; // @[ChiselRISC.scala 29:20]
  wire [31:0] EX_io_hazardAluOut; // @[ChiselRISC.scala 29:20]
  wire  MEM_clock; // @[ChiselRISC.scala 30:21]
  wire [31:0] MEM_io_in_aluOut; // @[ChiselRISC.scala 30:21]
  wire [31:0] MEM_io_out_aluOut; // @[ChiselRISC.scala 30:21]
  wire [31:0] WB_io_in_aluOut; // @[ChiselRISC.scala 31:20]
  wire [31:0] WB_io_out_muxOut; // @[ChiselRISC.scala 31:20]
  wire [31:0] hazardControl_io_EXaluOut; // @[ChiselRISC.scala 34:31]
  wire  hazardControl_io_EXctrlBranch; // @[ChiselRISC.scala 34:31]
  wire  hazardControl_io_EXctrlJump; // @[ChiselRISC.scala 34:31]
  wire  hazardControl_io_EXctrlLoad; // @[ChiselRISC.scala 34:31]
  wire [4:0] hazardControl_io_EXrd; // @[ChiselRISC.scala 34:31]
  wire  hazardControl_io_IDFlush; // @[ChiselRISC.scala 34:31]
  wire  hazardControl_io_IFStall; // @[ChiselRISC.scala 34:31]
  wire  sevenSeg_clock; // @[ChiselRISC.scala 106:26]
  wire  sevenSeg_reset; // @[ChiselRISC.scala 106:26]
  wire [15:0] sevenSeg_io_in; // @[ChiselRISC.scala 106:26]
  wire [6:0] sevenSeg_io_seg; // @[ChiselRISC.scala 106:26]
  wire [3:0] sevenSeg_io_an; // @[ChiselRISC.scala 106:26]
  reg [15:0] sevenSeg_io_in_REG; // @[ChiselRISC.scala 107:30]
  IF IF ( // @[ChiselRISC.scala 27:20]
    .io_stallReg(IF_io_stallReg)
  );
  ID ID ( // @[ChiselRISC.scala 28:20]
    .clock(ID_clock),
    .io_stallReg(ID_io_stallReg),
    .io_flush(ID_io_flush),
    .io_out_aluOp(ID_io_out_aluOp)
  );
  EX EX ( // @[ChiselRISC.scala 29:20]
    .clock(EX_clock),
    .io_in_rd(EX_io_in_rd),
    .io_in_aluOp(EX_io_in_aluOp),
    .io_in_ctrl_branch(EX_io_in_ctrl_branch),
    .io_in_ctrl_jump(EX_io_in_ctrl_jump),
    .io_in_ctrl_load(EX_io_in_ctrl_load),
    .io_out_aluOut(EX_io_out_aluOut),
    .io_hazardAluOut(EX_io_hazardAluOut)
  );
  MEM MEM ( // @[ChiselRISC.scala 30:21]
    .clock(MEM_clock),
    .io_in_aluOut(MEM_io_in_aluOut),
    .io_out_aluOut(MEM_io_out_aluOut)
  );
  WB WB ( // @[ChiselRISC.scala 31:20]
    .io_in_aluOut(WB_io_in_aluOut),
    .io_out_muxOut(WB_io_out_muxOut)
  );
  HazardControl hazardControl ( // @[ChiselRISC.scala 34:31]
    .io_EXaluOut(hazardControl_io_EXaluOut),
    .io_EXctrlBranch(hazardControl_io_EXctrlBranch),
    .io_EXctrlJump(hazardControl_io_EXctrlJump),
    .io_EXctrlLoad(hazardControl_io_EXctrlLoad),
    .io_EXrd(hazardControl_io_EXrd),
    .io_IDFlush(hazardControl_io_IDFlush),
    .io_IFStall(hazardControl_io_IFStall)
  );
  SevenSegment sevenSeg ( // @[ChiselRISC.scala 106:26]
    .clock(sevenSeg_clock),
    .reset(sevenSeg_reset),
    .io_in(sevenSeg_io_in),
    .io_seg(sevenSeg_io_seg),
    .io_an(sevenSeg_io_an)
  );
  assign io_seg = sevenSeg_io_seg; // @[ChiselRISC.scala 108:12]
  assign io_an = sevenSeg_io_an; // @[ChiselRISC.scala 109:11]
  assign IF_io_stallReg = hazardControl_io_IFStall; // @[ChiselRISC.scala 69:20]
  assign ID_clock = clock;
  assign ID_io_stallReg = IF_io_stallReg; // @[ChiselRISC.scala 51:20]
  assign ID_io_flush = hazardControl_io_IDFlush; // @[ChiselRISC.scala 68:17]
  assign EX_clock = clock;
  assign EX_io_in_rd = 5'h0; // @[ChiselRISC.scala 43:17]
  assign EX_io_in_aluOp = ID_io_out_aluOp; // @[ChiselRISC.scala 45:20]
  assign EX_io_in_ctrl_branch = 1'h0; // @[ChiselRISC.scala 46:19]
  assign EX_io_in_ctrl_jump = 1'h0; // @[ChiselRISC.scala 46:19]
  assign EX_io_in_ctrl_load = 1'h0; // @[ChiselRISC.scala 46:19]
  assign MEM_clock = clock;
  assign MEM_io_in_aluOut = EX_io_out_aluOut; // @[ChiselRISC.scala 48:15]
  assign WB_io_in_aluOut = MEM_io_out_aluOut; // @[ChiselRISC.scala 49:16]
  assign hazardControl_io_EXaluOut = EX_io_hazardAluOut; // @[ChiselRISC.scala 70:31]
  assign hazardControl_io_EXctrlBranch = EX_io_in_ctrl_branch; // @[ChiselRISC.scala 71:35]
  assign hazardControl_io_EXctrlJump = EX_io_in_ctrl_jump; // @[ChiselRISC.scala 72:33]
  assign hazardControl_io_EXctrlLoad = EX_io_in_ctrl_load; // @[ChiselRISC.scala 73:33]
  assign hazardControl_io_EXrd = EX_io_in_rd; // @[ChiselRISC.scala 74:27]
  assign sevenSeg_clock = clock;
  assign sevenSeg_reset = reset;
  assign sevenSeg_io_in = sevenSeg_io_in_REG; // @[ChiselRISC.scala 107:20]
  always @(posedge clock) begin
    sevenSeg_io_in_REG <= WB_io_out_muxOut[15:0]; // @[ChiselRISC.scala 107:47]
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
  sevenSeg_io_in_REG = _RAND_0[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
