module IF_stage #(parameter BIT_NUMBER = 32, parameter MEM_VOL = 2**10)(
  input clk, rst, freeze, branch_taken,
  input [BIT_NUMBER-1:0] branch_address,
  output [BIT_NUMBER-1:0] pc, instruction
  );

  wire [BIT_NUMBER-1:0] pc_in, pc_out;

  InstructionMemory #(.BIT_NUMBER(8), .MEM_VOL(MEM_VOL)) instruction_memory(.rst(rst), .in(pc_out), .out(instruction));
  Adder #(.BIT_NUMBER(BIT_NUMBER)) pc_adder(.first(32'd4), .second(pc_out), .out(pc));
  Register #(.BIT_NUMBER(BIT_NUMBER)) pc_reg(.in(pc_in), .freeze(freeze), .clk(clk), .rst(rst), .out(pc_out));
  MUX #(.BIT_NUMBER(BIT_NUMBER)) pc_mux (.first(branch_address), .second(pc), .sel(branch_taken), .out(pc_in));
endmodule
