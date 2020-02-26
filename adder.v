
module Adder #(parameter  BIT_NUMBER = 32)
  (input [BIT_NUMBER-1:0] first, second, output [BIT_NUMBER-1:0] out);
  assign out = first + second;
endmodule
