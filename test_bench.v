`timescale 1ns/1ns

module zzzz();
    reg clk = 0, rst = 0, forward_en = 0;

    ARM uut(clk, rst, forward_en);

    initial begin
    	repeat (2000) #100 clk = ~clk;
    end

    initial begin
    	#10
      rst = 1;
      #50;
      rst = 0;
    end

endmodule


module zzz_forwarding ();
reg clk = 0, rst = 0, forward_en = 1;

ARM uut(clk, rst, forward_en);

initial begin
  repeat (2000) #100 clk = ~clk;
end

initial begin
  #10
  rst = 1;
  #50;
  rst = 0;
end

endmodule // zzz_forwarding
