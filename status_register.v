module status_register (input [3:0] in, input S, clk, rst, output reg [3:0] out);
  always @ (negedge clk, posedge rst) begin
    if (rst)
      out <= 4'b0;
    else if (S) begin
      out <= in;
    end
  end
endmodule
