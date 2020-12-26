module ForwardingUnit (
  input [3:0] src1, src2, wb_dest, mem_dest,
  input wb_wb_en, mem_wb_en, enable,
  output [1:0] sel_src1, sel_src2
  );

  assign sel_src1 = (mem_wb_en && mem_dest == src1 && enable) ? 1 :
                    (wb_wb_en && wb_dest == src1 && enable) ? 2 : 0;


  assign sel_src2 = (mem_wb_en && mem_dest == src2 && enable) ? 1 :
                    (wb_wb_en && wb_dest == src2 && enable) ? 2 : 0;



endmodule // forward_unit
