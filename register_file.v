module RegisterFile # (parameter BIT_NUMBER = 32, MEM_VOL = 16) (
  input clk, rst,
  input [3:0] src1, src2, dest_wb,
  input [31:0] result_wb,
  input wb_wb_en,
  output [31:0] reg1, reg2
  );

  reg [BIT_NUMBER-1:0] my_memory [0:MEM_VOL-1];

  assign reg1 = my_memory[src1];
  assign reg2 = my_memory[src2];

  genvar c;
  generate
      for (c = 0; c < MEM_VOL; c = c + 1) begin
          always @ (posedge rst) begin
              my_memory[c] <= c;
          end
      end
  endgenerate

  always @ (negedge clk ) begin
    if (wb_wb_en) my_memory[dest_wb] = result_wb;
  end
endmodule // RegisterFile
