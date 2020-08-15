
module ARM(input clk, rst, forward_en);
wire freeze, flush, wb_wb_en, id_wb_en, id_mem_r_en, id_mem_w_en, id_b, id_s, id_imm, id_two_src,
	 id_reg_wb_en, id_reg_mem_r_en, id_reg_mem_w_en, id_reg_s, id_reg_imm, exe_reg_wb_en, exe_reg_mem_r_en,
	 exe_reg_mem_w_en, mem_mem_r_en, mem_wb_en, mem_reg_wb_en, mem_reg_mem_r_en, sel_src1, sel_src2;
wire [3:0] status_register_out, dest_wb, id_exe_cmd, id_dest, id_src1, id_src2, id_reg_exe_cmd, id_reg_dest, id_reg_sr,
			exe_sr, exe_reg_dest, mem_dest, mem_reg_dest, id_rn, id_reg_src1, id_reg_src2, exe_val_rm;

wire [11:0] id_shift_operand, id_reg_shift_operand;
wire [23:0] id_signed_imm_24, id_reg_signed_imm_24;
wire [31:0] branch_address, if_pc, id_pc, if_instruction, id_instruction, wb_value, id_val_rn, id_val_rm,
			id_reg_pc, id_reg_val_rn, id_reg_val_rm, exe_alu_result, exe_reg_alu_result, exe_reg_val_rm,
			mem_alu_result, mem_mem_data, mem_data, mem_reg_alu_result, mem_reg_mem_data;


IF_stage #(.BIT_NUMBER(32), .MEM_VOL(2**10)) if_unit(
  .clk(clk), .rst(rst), .freeze(freeze), .branch_taken(flush),
  .branch_address(branch_address),
  .pc(if_pc), .instruction(if_instruction)
);
IF_stage_reg #(.BIT_NUMBER(32)) if_reg_unit(
  .clk(clk), .rst(rst), .freeze(freeze), .flush(flush),
  .pc_in(if_pc), .instruction_in(if_instruction),
  .pc(id_pc), .instruction(id_instruction)
);
ID_stage #(.BIT_NUMBER(32),.REG_NUM_BITS(4)) id_unit(
  .clk(clk), .rst(rst), .wb_wb_en(wb_wb_en), .hazard(freeze),
  .dest_wb(dest_wb), .sr(status_register_out),
  .instruction(id_instruction), .result_wb(wb_value),
  .wb_en(id_wb_en), .mem_r_en(id_mem_r_en), .mem_w_en(id_mem_w_en), .b(id_b), .s(id_s), .imm(id_imm), .two_src(id_two_src),
  .exe_cmd(id_exe_cmd), .dest(id_dest), .first_src(id_src1), .second_src(id_src2),
  .shift_operand(id_shift_operand),
  .signed_imm_24(id_signed_imm_24),
  .val_rn(id_val_rn), .val_rm(id_val_rm)
  );
ID_stage_reg id_reg_unit(
  .clk(clk), .rst(rst), .flush(flush),
  .wb_en_in(id_wb_en), .mem_r_en_in(id_mem_r_en), .mem_w_en_in(id_mem_w_en), .b_in(id_b), .s_in(id_s),
  .exe_cmd_in(id_exe_cmd),
  .pc_in(id_pc), .val_rn_in(id_val_rn), .val_rm_in(id_val_rm),
  .imm_in(id_imm),
  .shift_operand_in(id_shift_operand),
  .signed_imm_24_in(id_signed_imm_24),
  .dest_in(id_dest), .sr_in(id_dest), .src1_in(id_src1), .src2_in(id_src2),
  .wb_en(id_reg_wb_en), .mem_r_en(id_reg_mem_r_en), .mem_w_en(id_reg_mem_w_en), .b(flush), .s(id_reg_s),
  .exe_cmd(id_reg_exe_cmd),
  .pc(id_reg_pc), .val_rn(id_reg_val_rn), .val_rm(id_reg_val_rm),
  .imm(id_reg_imm),
  .shift_operand(id_reg_shift_operand),
  .signed_imm_24(id_reg_signed_imm_24),
  .dest(id_reg_dest), .sr(id_reg_sr), .src1(id_reg_src1), .src2(id_reg_src2)
  );
EXE_stage #(.BIT_NUMBER(32)) exe_unit (
  .clk(clk),
  .exe_cmd(id_reg_exe_cmd),
  .mem_r_en(id_reg_mem_r_en), .mem_w_en(id_reg_mem_w_en),
  .pc(id_reg_pc), .val_rn(id_reg_val_rn), .val_rm_in(id_reg_val_rm),
  .imm(id_reg_imm),
  .shift_operand(id_reg_shift_operand),
  .signed_imm_24(id_reg_signed_imm_24),
  .sr(id_reg_sr), .sel_src1(sel_src1), .sel_src2(sel_src2),
	.wb_dest(wb_value), .mem_addr(exe_reg_alu_result),
  .alu_result(exe_alu_result), .br_addr(branch_address),
  .status(exe_sr), .val_rm(exe_val_rm)
  );
EXE_stage_reg #(.BIT_NUMBER(32)) exe_reg_unit (
  .clk(clk), .rst(rst),
  .wb_en_in(id_reg_wb_en), .mem_r_en_in(id_reg_mem_r_en), .mem_w_en_in(id_reg_mem_w_en),
  .alu_result_in(exe_alu_result), .val_rm_in(exe_val_rm),
  .dest_in(id_reg_dest),
  .wb_en(exe_reg_wb_en), .mem_r_en(exe_reg_mem_r_en), .mem_w_en(exe_reg_mem_w_en),
  .alu_result(exe_reg_alu_result), .val_rm(exe_reg_val_rm),
  .dest(exe_reg_dest)
  );
MEM_stage #(.BIT_NUMBER(32)) mem_unit (
  .clk(clk), .rst(rst),
  .wb_en_in(exe_reg_wb_en), .mem_r_en_in(exe_reg_mem_r_en), .mem_w_en(exe_reg_mem_w_en),
  .alu_result_in(exe_reg_alu_result), .val_rm(exe_reg_val_rm),
  .dest_in(exe_reg_dest),
  .mem_r_en_out(mem_mem_r_en), .wb_en_out(mem_wb_en),
  .alu_result_out(mem_alu_result), .mem_data(mem_mem_data),
  .dest_out(mem_dest)
  );
MEM_stage_reg #(.BIT_NUMBER(32)) mem_reg_unit(
  .clk(clk), .rst(rst), .WB_en_in(mem_wb_en), .Mem_R_en_in(mem_mem_r_en),
  .ALU_result_in(mem_alu_result), .Mem_read_value_in(mem_mem_data),
  .Dest_in(mem_dest),
  .WB_en(mem_reg_wb_en), .Mem_R_en(mem_reg_mem_r_en),
  .ALU_result(mem_reg_alu_result), .Mem_read_value(mem_reg_mem_data),
  .Dest(mem_reg_dest)
  );
WB_stage #(.BIT_NUMBER(32)) wb_unit(
  .ALU_result(mem_reg_alu_result), .Mem_result(mem_reg_mem_data),
  .Mem_R_en(mem_reg_mem_r_en), .WB_en_in(mem_reg_wb_en),
  .Dest_in(mem_reg_dest),
  .out(wb_value),
  .WB_en(wb_wb_en),
  .Dest(dest_wb)
  );
status_register status_register_unit(.in(exe_sr), .S(id_reg_s), .clk(clk), .rst(rst), .out(status_register_out));
hazard_unit hazard_detector(.src1(id_src1), .src2(id_src2), .Exe_Dest(id_reg_dest), .Mem_Dest(exe_reg_dest),
							.two_src(id_two_src),.Exe_WB_En(id_reg_wb_en), .Mem_WB_En(exe_reg_wb_en), .hazard_Detected(freeze));


ForwardingUnit forward_unit(
	.src1(id_reg_src1), .src2(id_reg_src2), .wb_dest(dest_wb), .mem_dest(exe_reg_dest),
	.wb_wb_en(wb_wb_en), .mem_wb_en(mem_wb_en), .enable(forward_en),
	.sel_src1(sel_src1), .sel_src2(sel_src2)
);
endmodule
