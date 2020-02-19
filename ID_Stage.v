// module  ID_Stage #(parameter BIT_NUMBER=32, parameter REG_NUM_BITS = 4) (
//   input clk, rst, write_back_en, hazard,
//   input[REG_NUM_BITS-1:0] dest_wb, sr,
//   input[BIT_NUMBER-1:0] instruction, result_wb,
//   output wb_en, mem_r_en, mem_w_ren, b, s, imm, two_src,
//   output[REG_NUM_BITS-1:0] exe_cmd, dest, first_src, second_src,
//   output[11:0] shift_operand,
//   output[23:0] signed_imm_24,
//   output[BIT_NUMBER-1:0] val_rn, val_rm
//   );
//
// endmodule
module ID_Stage #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] pc, instruction
  );
  assign pc = pc_in;
  assign instruction = instruction_in;
endmodule
