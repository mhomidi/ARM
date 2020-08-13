module WB_stage #(parameter BIT_NUMBER = 32) (
  input [BIT_NUMBER-1:0] ALU_result, Mem_result,
  input Mem_R_en, WB_en_in,
  input [3:0] Dest_in,
  output reg [BIT_NUMBER-1:0] out,
  output reg WB_en,
  output reg [3:0] Dest
  );
	MUX #(.BIT_NUMBER(BIT_NUMBER)) wb_mux (.first(Mem_result0), .second(ALU_result), .sel(Mem_R_en), .out(out));
	assign WB_en = WB_en_in;
	assign Dest = Dest_in;
endmodule
