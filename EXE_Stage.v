module EXE_stage #(parameter BIT_NUMBER = 32) (
  input clk,
  input [3:0] exe_cmd,
  input mem_r_en, mem_w_en, sel_src1, sel_src2,
  input [31:0] pc, val_rn, val_rm_in,
  input imm,
  input [11:0] shift_operand,
  input [23:0] signed_imm_24,
  input [3:0] sr, wb_dest, mem_addr,
  output [31:0] alu_result, br_addr,
  output [3:0] status, val_rm
  );
  wire mem_en_out;
  wire [31:0] val1, val2;

  assign mem_en_out = mem_r_en | mem_w_en;
  assign br_addr = pc + signed_imm_24;

  MUX3 val_rm_mux (
    .first(val_rm_in), .second(mem_addr), .third(wb_dest), .sel(sel_src1), .out(val_rm)
    );


  MUX3 val1_mux (
    .first(val_rn), .second(mem_addr), .third(wb_dest), .sel(sel_src2), .out(val1)
    );

  ValGenerate val_gen (
    .val_rm(val_rm),
    .imm(imm),
    .shift_operand(shift_operand),
    .is_memory_ins(mem_en_out),
    .val2(val2)
    );

  ALU alu (
    .first(val1), .second(val2),
    .exe_cmd(exe_cmd), .sr(sr),
    .alu_result(alu_result),
    .status(status)
  );

endmodule
