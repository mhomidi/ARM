module Memory #(parameter  BIT_NUMBER = 32, parameter MEM_VOL = 2**32) (
  input [BIT_NUMBER-1:0] in, output reg [BIT_NUMBER-1:0] out
  );
reg [BIT_NUMBER-1:0] my_memory [0:MEM_VOL-1];
always @ ( * ) begin
  out <= my_memory[in];
end
endmodule
