module ValGenerate (
  input [31:0] val_rm,
  input imm,
  input [11:0] shift_operand,
  input or_out,
  output [31:0] val2
  );
  // TODO: val2 should be calculated.
  assign val2 = 2;
endmodule // ValGenerate
