module MEM_stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst, WB_en_in, Mem_R_en_in,
  input [BIT_NUMBER-1:0] ALU_result_in, Mem_read_value_in,
  input [3:0] Dest_in,
  output WB_en, Mem_R_en, 
  output [BIT_NUMBER-1:0] ALU_result, Mem_read_value,
  output [3:0] Dest
  );
  Register #(.BIT_NUMBER(1)) wb_en_reg (.in(WB_en_in), .rst(rst), .clk(clk),
                                      	.freeze(1'b0), .out(WB_en));
  Register #(.BIT_NUMBER(1)) Mem_R_en_reg (.in(Mem_R_en_in), .rst(rst), .clk(clk),
                                          	.freeze(1'b0), .out(Mem_R_en));
  Register #(.BIT_NUMBER(BIT_NUMBER)) ALU_result_reg (.in(ALU_result_in), .rst(rst), .clk(clk),
                                       					.freeze(1'b0), .out(ALU_result));
  Register #(.BIT_NUMBER(BIT_NUMBER)) Mem_read_value_reg (.in(Mem_read_value_in), .rst(rst), .clk(clk),
                                                   		.freeze(1'b0), .out(Mem_read_value));
  Register #(.BIT_NUMBER(4)) dest_reg (.in(Dest_in), .rst(rst), .clk(clk),
                   							.freeze(1'b0), .out(Dest));
endmodule
