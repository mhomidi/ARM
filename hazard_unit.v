module HazardUnit(
  input [3:0] src1, src2,
  input [3:0] Exe_Dest,Mem_Dest,
  input two_src, forward_en,
  input Exe_WB_En, Mem_WB_En,
  output hazard_Detected
  );
	 assign hazard_not_forwarding = ( (src1 == Exe_Dest) && Exe_WB_En) ? 1'b1:
	 						  ( (src1 == Mem_Dest) && Mem_WB_En ) ? 1'b1:
	 						  ( (src2 == Exe_Dest) && Exe_WB_En && two_src) ? 1'b1:
	 						  ( (src2 == Mem_Dest) && Mem_WB_En && two_src) ? 1'b1:1'b0;

  assign hazard_forwarding = ( (src1 == Exe_Dest) && Exe_WB_En) ? 1'b1:
            ( (src2 == Exe_Dest) && Exe_WB_En && two_src) ? 1'b1:1'b0;
  assign hazard_Detected = (forward_en) ? hazard_forwarding : hazard_not_forwarding;

endmodule
