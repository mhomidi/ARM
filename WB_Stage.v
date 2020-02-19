module WB_Stage #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] pc, instruction
  );
  assign pc = pc_in;
  assign instruction = instruction_in;
endmodule
