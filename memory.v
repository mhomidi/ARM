module DataMemory #(parameter  BIT_NUMBER = 8, parameter MEM_VOL = 2**10) (
  input clk, rst,
  input [4*BIT_NUMBER-1:0] value,
  input [4*BIT_NUMBER-1:0] addr,
  input mem_w_en, mem_r_en,
  output [4*BIT_NUMBER-1:0] out
  );
reg [BIT_NUMBER-1:0] my_memory [0:4 * MEM_VOL - 1];

assign out = (mem_r_en)?{my_memory[addr + 3],
                        my_memory[addr + 2],
                        my_memory[addr + 1],
                        my_memory[addr]}:0;
integer i;
always @ ( posedge clk, posedge rst ) begin
  if (rst) begin
    for (i = 0; i < 4 * MEM_VOL; i = i + 1) begin
      my_memory[i] = 0;
    end
  end
  else begin
    if (mem_w_en) begin
      my_memory[addr] = value[BIT_NUMBER-1:0];
      my_memory[addr + 1] = value[2*BIT_NUMBER-1:1*BIT_NUMBER];
      my_memory[addr + 2] = value[3*BIT_NUMBER-1:2*BIT_NUMBER];
      my_memory[addr + 3] = value[4*BIT_NUMBER-1:3*BIT_NUMBER];
    end
  end
end
endmodule


module InstructionMemory #(parameter  BIT_NUMBER = 8, parameter MEM_VOL = 2**10) (
  input [BIT_NUMBER-1:0] in,
  input   rst, 
  output reg [BIT_NUMBER-1:0] out
  );

  reg [BIT_NUMBER-1:0] my_memory [0:4 * MEM_VOL - 1];

  always @(*) begin
    if (rst) begin
      my_memory[0] <= 8'b11100000;
      my_memory[1] <= 8'b00000000;
      my_memory[2] <= 8'b00000000;
      my_memory[3] <= 8'b00000000;
      
      {my_memory[4], my_memory[5], my_memory[6], my_memory[7]} = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
      {my_memory[8], my_memory[9], my_memory[10], my_memory[11]} = 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV R1 ,#4096 //R1 = 4096
      {my_memory[12], my_memory[13], my_memory[14], my_memory[15]} = 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
      {my_memory[16], my_memory[17], my_memory[18], my_memory[19]} = 32'b1110_00_0_0100_1_0010_0011_000000000010; //ADDS R3 ,R2,R2 //R3 = -2147483648
      {my_memory[20], my_memory[21], my_memory[22], my_memory[23]} = 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
      {my_memory[24], my_memory[25], my_memory[26], my_memory[27]} = 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
      {my_memory[28], my_memory[29], my_memory[30], my_memory[31]} = 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1 //R6 = 9
      {my_memory[32], my_memory[33], my_memory[34], my_memory[35]} = 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR R7 ,R5,R2,ASR #2 //R7 = -123
      {my_memory[36], my_memory[37], my_memory[38], my_memory[39]} = 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8 ,R7,R3 //R8 = -2147483648
      {my_memory[40], my_memory[41], my_memory[42], my_memory[43]} = 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9 ,R6 //R9 = -10
      {my_memory[44], my_memory[45], my_memory[46], my_memory[47]} = 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5 //R10 = -84
      {my_memory[48], my_memory[49], my_memory[50], my_memory[51]} = 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8 ,R6
      {my_memory[52], my_memory[53], my_memory[54], my_memory[55]} = 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1 ,R1,R1 //R1 = 8192
      {my_memory[56], my_memory[57], my_memory[58], my_memory[59]} = 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9 ,R8
      {my_memory[60], my_memory[61], my_memory[62], my_memory[63]} = 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ R2 ,R2,R2 //R2 = -1073741824
      {my_memory[64], my_memory[65], my_memory[66], my_memory[67]} = 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0 ,#1024 //R0 = 1024
      {my_memory[68], my_memory[69], my_memory[70], my_memory[71]} = 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1 ,[R0],#0 //MEM[1024] = 8192
      // {my_memory[72], my_memory[73], my_memory[74], my_memory[75]} = 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0 //R11 = 8192
      // {my_memory[76], my_memory[77], my_memory[78], my_memory[79]} = 32'b1110_01_0_0100_0_0000_0010_000000000100; //STR R2 ,[R0],#4 //MEM[1028] = -1073741824
      // {my_memory[80], my_memory[81], my_memory[82], my_memory[83]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR R3 ,[R0],#8 //MEM[1032] = -2147483648
      // {my_memory[84], my_memory[85], my_memory[86], my_memory[87]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR
      
      // {my_memory[88], my_memory[89], my_memory[90], my_memory[91]} = 32'b1110_01_0_0100_0_0000_0100_000000001101; //STR
      // {my_memory[92], my_memory[93], my_memory[94], my_memory[95]} = 32'b1110_01_0_0100_0_0000_0101_000000010000; //STR
      // {my_memory[96], my_memory[97], my_memory[98], my_memory[99]} = 32'b1110_01_0_0100_0_0000_0110_000000010100; //STR
      
      // {my_memory[100], my_memory[101], my_memory[102], my_memory[103]} = 32'b1110_01_0_0100_1_0000_1010_000000000100; //LDR
      // {my_memory[104], my_memory[105], my_memory[106], my_memory[107]} = 32'b1110_01_0_0100_0_0000_0111_000000011000; //STR
      // {my_memory[108], my_memory[109], my_memory[110], my_memory[111]} = 32'b1110_00_1_1101_0_0000_0001_000000000100; //MOV
      // {my_memory[112], my_memory[113], my_memory[114], my_memory[115]} = 32'b1110_00_1_1101_0_0000_0010_000000000000; //MOV
      // {my_memory[116], my_memory[117], my_memory[118], my_memory[119]} = 32'b1110_00_1_1101_0_0000_0011_000000000000; //MOV
      // {my_memory[120], my_memory[121], my_memory[122], my_memory[123]} = 32'b1110_00_0_0100_0_0000_0100_000100000011; //ADD
      // {my_memory[124], my_memory[125], my_memory[126], my_memory[127]} = 32'b1110_01_0_0100_1_0100_0101_000000000000; //LDR
      // {my_memory[128], my_memory[129], my_memory[130], my_memory[131]} = 32'b1110_01_0_0100_1_0100_0110_000000000100; //LDR
      // {my_memory[132], my_memory[133], my_memory[134], my_memory[135]} = 32'b1110_00_0_1010_1_0101_0000_000000000110; //CMP
      // {my_memory[136], my_memory[137], my_memory[138], my_memory[139]} = 32'b1100_01_0_0100_0_0100_0110_000000000000; //STRGT
      // {my_memory[140], my_memory[141], my_memory[142], my_memory[143]} = 32'b1100_01_0_0100_0_0100_0101_000000000100; //STRGT
      // {my_memory[144], my_memory[145], my_memory[146], my_memory[147]} = 32'b1110_00_1_0100_0_0011_0011_000000000001; //ADD
      
      // {my_memory[148], my_memory[149], my_memory[150], my_memory[151]} = 32'b1110_00_1_1010_1_0011_0000_000000000011; //CMP
      
      // {my_memory[152], my_memory[153], my_memory[154], my_memory[155]} = 32'b1011_10_1_0_111111111111111111110111 ; //BLT
      
      // {my_memory[156], my_memory[157], my_memory[158], my_memory[159]} = 32'b1110_00_1_0100_0_0010_0010_000000000001; //ADD
      // {my_memory[160], my_memory[161], my_memory[162], my_memory[163]} = 32'b1110_00_0_1010_1_0010_0000_000000000001; //CMP

      // {my_memory[164], my_memory[165], my_memory[166], my_memory[167]} = 32'b1011_10_1_0_111111111111111111110011 ; //BLT
      
      // {my_memory[168], my_memory[169], my_memory[170], my_memory[171]} = 32'b1110_01_0_0100_1_0000_0001_000000000000; //LDR
      // {my_memory[172], my_memory[173], my_memory[174], my_memory[175]} = 32'b1110_01_0_0100_1_0000_0010_000000000100; //LDR
      // {my_memory[176], my_memory[177], my_memory[178], my_memory[179]} = 32'b1110_01_0_0100_1_0000_0011_000000001000; //STR
      // {my_memory[180], my_memory[181], my_memory[182], my_memory[183]} = 32'b1110_01_0_0100_1_0000_0100_000000001100; //STR
      // {my_memory[184], my_memory[185], my_memory[186], my_memory[187]} = 32'b1110_01_0_0100_1_0000_0101_000000010000; //STR
      // {my_memory[188], my_memory[189], my_memory[190], my_memory[191]} = 32'b1110_01_0_0100_1_0000_0110_000000010100; //STR
      // {my_memory[192], my_memory[193], my_memory[194], my_memory[195]} = 32'b1110_10_1_0_111111111111111111111111 ; //B

      
      // my_memory[196] <= 8'b11100000;
      // my_memory[197] <= 8'b00000000;
      // my_memory[198] <= 8'b00000000;
      // my_memory[199] <= 8'b00000000;
          
      // my_memory[200] <= 8'b11100000;
      // my_memory[201] <= 8'b00000000;
      // my_memory[202] <= 8'b00000000;
      // my_memory[203] <= 8'b00000000;
      
      // my_memory[204] <= 8'b11100000;
      // my_memory[205] <= 8'b00000000;
      // my_memory[206] <= 8'b00000000;
      // my_memory[207] <= 8'b00000000;

      // my_memory[208] <= 8'b11100000;
      // my_memory[209] <= 8'b00000000;
      // my_memory[210] <= 8'b00000000;
      // my_memory[211] <= 8'b00000000;
  
    end
    else begin
      out <= {my_memory[in], my_memory[in + 1], my_memory[in + 2], my_memory[in + 3]};
    end
  end
endmodule
