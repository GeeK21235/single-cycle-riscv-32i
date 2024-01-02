module DMEM #(parameter Width = 32)
(input clk,reset, MemWrite, MemRead, [Width-1:0] address,WriteData,
output reg [Width-1:0] ReadData);
reg [Width-1:0] mem1[511:0];
initial
begin
mem1[0] = 32'h00000000;
mem1[1] = 32'h00000001;
mem1[2] = 32'h00000002;
mem1[3] = 32'h00000003;
mem1[4] = 32'h00000004;
mem1[5] = 32'h00000005;
mem1[6] = 32'h00000006;
mem1[7] = 32'h00000007;
end
always @(*)
begin
if(MemRead == 1'b1)
ReadData <= mem1[address];
 
end
always @(posedge clk)
if (reset)
begin
mem1[0] = 32'h00000000;
mem1[1] = 32'h00000001;
mem1[2] = 32'h00000002;
mem1[3] = 32'h00000003;
mem1[4] = 32'h00000004;
mem1[5] = 32'h00000005;
mem1[6] = 32'h00000006;
mem1[7] = 32'h00000007;
end
else
if(MemWrite == 1'b1)
mem1[address] = WriteData;
endmodule
