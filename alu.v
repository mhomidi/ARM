module ALU (
  input [31:0] first, second,
  input [3:0] exe_cmd, sr,
  output [31:0] alu_result,
  output [3:0] status
  );

  wire c;

  assign c = sr[2];
  assign alu_result = (exe_cmd == 4'b0001) ? second :
                      (exe_cmd == 4'b1001) ? ~second :
                      (exe_cmd == 4'b0010) ? first + second :
                      (exe_cmd == 4'b0011) ? first + second + c :
                      (exe_cmd == 4'b0100) ? first - second :
                      (exe_cmd == 4'b0101) ? first - second - 1 :
                      (exe_cmd == 4'b0110) ? first & second :
                      (exe_cmd == 4'b0111) ? first | second :
                      (exe_cmd == 4'b1000) ? first ^ second : 32'bz;

// TODO: assign status;

endmodule // ALU
