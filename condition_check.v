module ConditionCheck (
    input [3:0] cond,
    input [3:0] sr,
    output reg out
    );

    wire z, c, n, v;
    assign {z, c, n, v} = sr;

    always @(*) begin

        case(cond)
            4'b0000 : begin
                out <= z;
            end

            4'b0000 : begin
                out <= ~z;
            end

            4'b0010 : begin
                out <= c;
            end

            4'b0011 : begin
                out <= ~c;
            end

            4'b0100 : begin
                out <= n;
            end

            4'b0101 : begin
                out <= ~n;
            end

            4'b0110 : begin
                out <= v;
            end

            4'b0111 : begin
                out <= ~v;
            end

            4'b1000 : begin
                out <= c & ~z;
            end

            4'b1001 : begin
                out <= ~c & z;
            end

            4'b1010 : begin
                out <= (n & v) | (~n & ~v);
            end
            4'b1011 : begin
                out <= (n & ~v) | (~n & v);
            end

            4'b1100 : begin
                out <= ~z & ((n & v) | (~n & ~v));
            end

            4'b1101 : begin
                out <= z & ((n & ~v) | (~n & v));
            end

            4'b1110 : begin
                out <= 1'b1;
            end
            default : begin
              out <= 1'b0;
            end
        endcase
    end
endmodule
