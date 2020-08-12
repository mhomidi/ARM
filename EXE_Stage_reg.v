module EXE_Stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input wb_en_in, mem_r_en_in, mem_w_en_in,
  input [BIT_NUMBER - 1:0] alu_result_in, st_val_in,
  input [3:0] dest_in,
  output reg wb_en, mem_r_en, mem_w_en,
  output reg [BIT_NUMBER - 1:0] alu_result, st_val,
  output reg [3:0] dest
  );
  always @ ( posedge clk, posedge rst ) begin
    if (rst) begin
      {wb_en, mem_r_en, mem_w_en,
      alu_result, st_val,
      dest} = 100'b0;
    end
    else begin
      {wb_en, mem_r_en, mem_w_en,
        alu_result, st_val,
        dest} = {wb_en_in, mem_r_en_in, mem_w_en_in,
                  alu_result_in, st_val_in,
                  dest_in};
    end
  end
endmodule
