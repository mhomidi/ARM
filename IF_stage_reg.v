module IF_stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst, freeze, flush,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output reg [BIT_NUMBER-1:0] pc, instruction
  );

  always @ (posedge clk, posedge rst) begin
    if (rst) begin
      pc <= 0;
      instruction <= 0;
    end
    else begin
      if (~freeze) begin
        if (flush) begin
          instruction <= 0;
          pc <= 0;
        end
        else begin
          instruction <= instruction_in;
          pc <= pc_in;
        end
      end
    end
  end
endmodule
