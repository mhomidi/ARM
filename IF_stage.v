`include "memory.v"
`include "adder.v"
`include "register.v"
`include "mux.v"

module IF_Stage #(parameter BIT_NUMBER = 32, parameter MEM_VOL = 2**10)(
  input clk, rst, freeze, branch_taken,
  input [BIT_NUMBER-1:0] branch_address,
  output [BIT_NUMBER-1:0] pc, instruction
  );

  wire [BIT_NUMBER-1:0] pc_in, pc_out;

  Memory #(.BIT_NUMBER(BIT_NUMBER), .MEM_VOL(MEM_VOL)) instruction_memory(.in(pc_out), .out(instruction));
  Adder #(.BIT_NUMBER(BIT_NUMBER)) pc_adder(.first(32'd4), .second(pc_out), .out(pc));
  Register #(.BIT_NUMBER(BIT_NUMBER)) pc_reg(.in(pc_in), .freeze(freeze), .clk(clk), .rst(rst), .out(pc_out));
  MUX #(.BIT_NUMBER(BIT_NUMBER)) pc_mux (.first(pc), .second(branch_address), .sel(branch_taken), .out(pc_in));
endmodule
