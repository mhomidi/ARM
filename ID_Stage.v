`include "mux.v"
`include "register_file.v"
`include "control_unit.v"

module  ID_Stage #(parameter BIT_NUMBER=32, parameter REG_NUM_BITS = 4) (
  input clk, rst, write_back_en, hazard,
  input[REG_NUM_BITS-1:0] dest_wb, sr,
  input[BIT_NUMBER-1:0] instruction, result_wb,
  output wb_en, mem_r_en, mem_w_en, b, s, imm, two_src,
  output[REG_NUM_BITS-1:0] exe_cmd, dest, first_src, second_src,
  output[11:0] shift_operand,
  output[23:0] signed_imm_24,
  output[BIT_NUMBER-1:0] val_rn, val_rm
  );
  wire [3:0] op_code, rn, rd, cond, rm, mux_reg_out;
  wire [1:0] mode;
  wire imm, s_in, cond_haz_out, cond_out;
  wire [8:0] ctrl_out, mux_ctrl_out;

  assign mode = instruction[27:26];
  assign imm = instruction[25];
  assign s_in = instruction[20];
  assign op_code = instruction[24:21];
  assign cond = instruction[31:28];
  assign rn = instruction[19:16];
  assign rm = instruction[3:0];
  assign rd = instruction[15:12];


  assign dest = rd;
  assign signed_imm_24 = instruction[23:0];
  assign shift_operand = instruction[11:0];


  RegisterFile # (.BIT_NUMBER(32), .MEM_VOL(16)) regfile (
    .clk(clk), .rst(rst),
    .src1(rn), .src2(mux_reg_out), .dest_wb(dest_wb),
    .result_wb(result_wb),
    .write_back_en(write_back_en),
    .reg1(val_rn), .reg2(val_rm)
    );


  MUX # (.BIT_NUMBER(4)) mux_rm_rd
    (.first(rd), .second(rm), .sel(mem_w_en), .out(mux_reg_out));

  MUX # (.BIT_NUMBER(9)) mux_ctrl
    (.first(9'b0), .second(ctrl_out), .sel(cond_haz_out), .out(mux_ctrl_out));

  // Condition Check
  ConditionCheck cond_check (
    .cond(cond), .sr(sr), .out(cond_out)
    );

  assign cond_haz_ou = ~cond_out | hazard;

  assign two_src = ~imm | mem_w_en;

  ControlUnit ctrl_unit (
    .op_code(op_code),
    .mode(mode),
    .s_in(s_in),
    .s(ctrl_out[0]), .b(ctrl_out[1]), .exe_cmd(ctrl_out[5:2]), .mem_w_en(ctrl_out[6]),
    .mem_r_en(ctrl_out[7]), .wb_en(ctrl_out[8])
    );

    assign s = mux_ctrl_out[0];
    assign b = mux_ctrl_out[1];
    assign exe_cmd = mux_ctrl_out[5:2];
    assign mem_w_en = mux_ctrl_out[6];
    assign mem_r_en = mux_ctrl_out[7];
    assign wb_en = mux_ctrl_out[8];

endmodule
