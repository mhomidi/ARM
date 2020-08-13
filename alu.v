module ALU (
  input [31:0] first, second,
  input [3:0] exe_cmd, sr,
  output reg [31:0] alu_result,
  output reg [3:0] status
  );

  wire cin;
  reg z, cout, n, v;

  assign cin = sr[2];

  always @ ( * ) begin
    {v, cout} = 2'b0;
    case(exe_cmd)
      4'b0001: begin
        alu_result = second;
      end

      4'b1001: begin
        alu_result = ~second;
      end

      4'b0010: begin
        {cout, alu_result} = first + second;
        v = ((first[31] == second[31]) & (alu_result[31] != first[31]));
      end

      4'b0011: begin
        {cout, alu_result} = first + second + cin;
        v = ((first[31] == second[31]) & (alu_result[31] != first[31]));
      end

      4'b0100: begin
        {cout ,alu_result} = first - second;
        v = ((first[31] == ~second[31]) & (alu_result[31] != first[31]));
      end

      4'b0101: begin
        {cout ,alu_result} = first - second - 1;
        v = ((first[31] == ~second[31]) & (alu_result[31] != first[31]));
      end

      4'b0110: begin
        alu_result = first & second;
      end

      4'b0111: begin
        alu_result = first | second;
      end

      4'b1000: begin
        alu_result = first ^ second;
      end

      default: begin
        alu_result = 32'bz;
      end
    endcase

    z = (alu_result == 32'b0) ? 1 : 0;
    n = alu_result[31];
    status = {z, cout, n, v};
  end
endmodule // ALU
