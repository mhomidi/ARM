module ID_Stage_reg_main (
  input clk, rst, flush,
  input wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in,
  input [3:0] exe_cmd_in,
  input [31:0] pc_in, val_rn_in, val_rm_in,
  input imm_in,
  input [11:0] shift_operand_in,
  input [23:0] signed_imm_24_in,
  input [3:0] dest_in, sr_in,
  output reg wb_en, mem_r_en, mem_w_en, b, s,
  output reg [3:0] exe_cmd,
  output reg [31:0] pc, val_rn, val_rm,
  output reg imm,
  output reg [11:0] shift_operand,
  output reg [23:0] signed_imm_24,
  output reg [3:0] dest, sr
  );

  always @ ( posedge clk, posedge rst ) begin
    if (rst || flush == 1) begin
      {wb_en, mem_r_en, mem_w_en, b, s,exe_cmd,
        pc, val_rn, val_rm,
        imm,
        shift_operand,
        signed_imm_24,
        dest} = 100'b0;
    end
    else begin
    {wb_en, mem_r_en, mem_w_en, b, s,exe_cmd,
      pc, val_rn, val_rm,
      imm,
      shift_operand,
      signed_imm_24,
      dest, sr} = {wb_en_in, mem_r_en_in, mem_w_en_in, b_in, s_in,exe_cmd_in,
              pc_in, val_rn_in, val_rm_in,
              imm_in,
              shift_operand_in,
              signed_imm_24_in,
              dest_in, sr_in};
    end
  end
endmodule // ID_Stage_reg_main






module ID_Stage_reg #(parameter BIT_NUMBER = 32) (
  input clk, rst,
  input [BIT_NUMBER-1:0] pc_in, instruction_in,
  output [BIT_NUMBER-1:0] reg pc, instruction
  );
  Register #(.BIT_NUMBER(BIT_NUMBER)) pc_reg (.in(pc_in), .rst(rst), .clk(clk),
                                              .freeze(1'b0), .out(pc));

  Register #(.BIT_NUMBER(BIT_NUMBER)) instruction_reg (.in(instruction_in), .rst(rst), .clk(clk),
                                                       .freeze(1'b0), .out(instruction));
endmodule
