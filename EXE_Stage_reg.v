module EXE_Stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] reg pc, instruction
  );
  Register #(.BIT_NUMBER(BIT_NUMBER)) pc_reg (.in(pc_in), .rst(rst), .clk(clk),
                                              .freeze(1'b0), .out(pc));

  Register #(.BIT_NUMBER(BIT_NUMBER)) instruction_reg (.in(instruction_in), .rst(rst), .clk(clk),
                                                       .freeze(1'b0), .out(instruction));
endmodule
