`include "register.v"

module IF_Stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst, freeze, flush,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] pc, instruction
  );

  Register #(.BIT_NUMBER(BIT_NUMBER)) pc_reg (.in(pc_in), .rst(rst), .clk(clk),
                            .freeze(freeze), .out(pc));

  Register #(.BIT_NUMBER(BIT_NUMBER)) instruction_reg (.in(instruction_in), .rst(rst), .clk(clk),
                            .freeze(freeze), .out(instruction));
endmodule
