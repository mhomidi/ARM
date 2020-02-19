
module MUX #(parameter  BIT_NUMBER = 32)
  (input [BIT_NUMBER-1:0] first, second, input sel, output [BIT_NUMBER-1:0] out);
  assign out = (sel)?first:second;
endmodule
