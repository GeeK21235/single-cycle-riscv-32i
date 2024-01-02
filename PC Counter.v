module PCCounter 
(input clk,reset,[31:0] PC1, output reg [31:0] PC);

always@(posedge clk or posedge reset)
if (reset) PC=0;
else
begin
PC <= PC1;
end
endmodule
