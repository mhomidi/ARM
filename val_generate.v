module ValGenerate (
  input [31:0] val_rm,
  input imm,
  input [11:0] shift_operand,
  input is_memory_ins,
  output [31:0] val2
  );
  reg [31:0] immediate_number;
  integer i;
  always @ ( * ) begin
    immediate_number = {24'b0, shift_operand[7:0]};
    for (i = 0; i < 2 * {1'b0, shift_operand[11:8]}; i = i + 1) begin
      immediate_number = {immediate_number[0], immediate_number[31:1]};
    end
  end
  reg [31:0] rm_right_rotated;
  always @ ( * ) begin
    rm_right_rotated = val_rm;
    for (i = 0; i < {1'b0, shift_operand[11:7]}; i = i + 1) begin
      rm_right_rotated = {rm_right_rotated[0], rm_right_rotated[31:2]};
    end
  end
  wire [1:0] shift_status = shift_operand[6:5];
  assign val2 = is_memory_ins ? {20'b0, shift_operand} :(
      imm ? immediate_number : (
          (shift_status == 2'b00) ? val_rm << {1'b0, shift_operand[11:7]} :
          (shift_status == 2'b01) ? val_rm >> {1'b0, shift_operand[11:7]} :
          (shift_status == 2'b10) ? val_rm >>> {1'b0, shift_operand[11:7]} :
          (shift_status == 2'b11) ? rm_right_rotated : val_rm
        )
  );
endmodule // ValGenerate
