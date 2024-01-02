module IMEM #(parameter Width = 32)(
    
    input [63:0] address,
    output reg [Width-1:0] RD,
    input [63:0] ins_addr,
    input [Width-1:0]instruction,
    input W_R,
    input clk
    );
//wire [3:0] add = address[3:0];
reg [Width-1:0] mem1[63:0];
//write
always @(posedge clk)
begin
if (!W_R) mem1[ins_addr]=instruction;
end
//assign RD = mem1[address>>2];
always @(*)
begin
if (W_R) RD = mem1[address>>2];
end
endmodule
