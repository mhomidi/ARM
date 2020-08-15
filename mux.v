
module MUX2 #(parameter  BIT_NUMBER = 32)(input [BIT_NUMBER-1:0] first, second, input sel, output [BIT_NUMBER-1:0] out);
  assign out = (~sel)?first:second;
endmodule // MUX 2


module MUX3 #(parameter  BIT_NUMBER = 32) (
  input [BIT_NUMBER-1:0] first, second, third, input sel, output [BIT_NUMBER-1:0] out);

  assign out = (sel == 1) ? second : (sel == 2) ? third : first;
endmodule // MUX3
