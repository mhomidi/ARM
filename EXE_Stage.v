
`include "alu.v"
`include "val_generate.v"

module EXE_Stage_main #(parameter BIT_NUMBER = 32) (
  input clk,
  input [3:0] exe_cmd,
  input mem_r_en, mem_w_en,
  input [31:0] pc, val_rn, val_rm,
  input imm,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input [3:0] sr,
  output [31:0] alu_result, br_addr,
  output [3:0] status
  );
  wire mem_en_out;
  wire [31:0] val2;

  assign mem_en_out = mem_r_en | mem_w_en;
  assign br_addr = pc + signed_imm_24;

  // TODO: should be implemented
  ValGenerate val_gen (
    .val_rm(val_rm),
    .imm(imm),
    .shift_operand(shift_operand),
    .or_out(mem_en_out),
    .val2(val2)
    );

    ALU alu1 (
      .first(val_rn), .second(val2),
      .exe_cmd(exe_cmd), .sr(sr),
      .alu_result(alu_result),
      .status(status)
      );

endmodule






module EXE_Stage #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] pc, instruction
  );
  assign pc = pc_in;
  assign instruction = instruction_in;
endmodule
