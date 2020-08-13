`timescale 1ns/1ns

module zzzz();
    reg clk = 0, rst = 0;

    ARM uut(clk, rst);

    always #100 clk = ~clk;

    initial begin
    	#10
        rst = 1;
        #50;
        rst = 0;
    end

endmodule

