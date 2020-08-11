module Memory #(parameter  BIT_NUMBER = 8, parameter MEM_VOL = 2**32) (
  input [BIT_NUMBER-1:0] in, output reg [BIT_NUMBER-1:0] out
  );
reg [BIT_NUMBER-1:0] my_memory [0:4 * MEM_VOL - 1];
always @ ( * ) begin
  out <= {my_memory[in], my_memory[in + 1], my_memory[in + 2], my_memory[in + 3]};
end
endmodule


module InstructionMemory #(parameter  BIT_NUMBER = 8, parameter MEM_VOL = 2**32) (
  input [BIT_NUMBER-1:0] in, output reg [BIT_NUMBER-1:0] out
  );
reg [BIT_NUMBER-1:0] my_memory [0:4 * MEM_VOL - 1];
always @ ( * ) begin
  out <= {my_memory[in], my_memory[in + 1], my_memory[in + 2], my_memory[in + 3]};
end
endmodule
