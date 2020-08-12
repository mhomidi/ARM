
module ControlUnit (
  input [3:0] op_code,
  input [1:0] mode,
  input s_in,
  output s, b, mem_w_en, mem_r_en, wb_en,
  output [3:0] exe_cmd
  );

  always @ ( * ) begin
    {s, b, mem_w_en, mem_r_en, wb_en, exe_cmd} = 9'b0;
    s = s_in;
    case (mode)

      // Calculational Command
      2'b00: begin
      case (op_code)
          //MOV
          4'b1101: begin
            exe_cmd = 4'b0001;
            wb_en = 1;
          end

          //MVN
          4'b1111: begin
            exe_cmd = 4'b1001;
            wb_en = 1;
          end

          //ADD
          4'b0100: begin
            exe_cmd = 4'b0010;
            wb_en = 1;
          end

          //ADC
          4'b0101: begin
            exe_cmd = 4'b0011;
            wb_en = 1;
          end

          //SUB
          4'b0010: begin
            exe_cmd = 4'b0100;
            wb_en = 1;
          end

          //SBC
          4'b0110: begin
            exe_cmd = 4'b0101;
            wb_en = 1;
          end

          //AND
          4'b0000: begin
            exe_cmd = 4'b0110;
            wb_en = 1;
          end

          //ORR
          4'b1100: begin
            exe_cmd = 4'b0111;
            wb_en = 1;
          end

          //EOR
          4'b0001: begin
            exe_cmd = 4'b1000;
          end

          //CMP
          4'b1010: begin
            exe_cmd = 4'b0100;
          end

          //TST
          4'b1000: begin
            exe_cmd = 4'b0110;
          end
        endcase
      end

      // Memorial Command
      2'b01: begin
        exe_cmd = 4'b0010;
        case (s)
          // STR
          1'b0: begin
            mem_w_en = 1;
          end

          // LDR
          1'b1: begin
            mem_r_en = 1;
            wb_en = 1;
          end
        endcase
      end

      // Brach Command
      2'b10: begin
        b = 1;
        exe_cmd = 4'bxxxx;
      end
    endcase
  end
endmodule // ControlUnit
