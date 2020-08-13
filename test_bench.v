`timescale 1ns/1ns

module test_bench();
    reg clk = 0, rst;

    ARM uut(clk, rst);

    always #100 clk = ~clk;

    initial begin
        rst = 1;
        #100;
        rst = 0;
    end

endmodule

