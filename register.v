module Register #(parameter  BIT_NUMBER = 32)
  (input [BIT_NUMBER-1:0] in, input freeze, clk, rst, output reg [BIT_NUMBER-1:0] out);
  always @ (posedge clk, posedge rst) begin
    if (rst)
      out <= 0;
    else if (freeze == 0) begin
      out <= in;
    end
  end
endmodule
