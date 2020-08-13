module DataMemory #(parameter  BIT_NUMBER = 8, parameter MEM_VOL = 2**32) (
  input clk, rst,
  input [4*BIT_NUMBER-1:0] alu_result,
  input [BIT_NUMBER-1:0] addr,
  input mem_w_en, mem_r_en,
  output [4*BIT_NUMBER-1:0] out
  );
reg [BIT_NUMBER-1:0] my_memory [0:4 * MEM_VOL - 1];

assign out = (mem_r_en)?{my_memory[addr + 3],
                        my_memory[addr + 2],
                        my_memory[addr + 1],
                        my_memory[addr]}:0;
integer i;
always @ ( posedge clk, posedge rst ) begin
  if (rst) begin
    for (i = 0; i < 4 * MEM_VOL; i = i + 1) begin
      my_memory[i] = 0;
    end
  end
  else begin
    if (mem_w_en) begin
      my_memory[addr] = alu_result[BIT_NUMBER-1:0];
      my_memory[addr + 1] = alu_result[2*BIT_NUMBER-1:1*BIT_NUMBER];
      my_memory[addr + 2] = alu_result[3*BIT_NUMBER-1:2*BIT_NUMBER];
      my_memory[addr + 3] = alu_result[4*BIT_NUMBER-1:3*BIT_NUMBER];
    end
  end
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
