 module Controller(
input BrEq,BrLT,
input [2:0]funct3,

input [6:0] Opcode,
output reg PCSel,BrUn,
output reg Bsel,RegWEn, MemRead, MemWrite,jump,Asel,reg[1:0] Aluop,reg [1:0]WBSel,
output reg [9:0]control);


always @(*)
begin
case(Opcode)
7'b0110011 : control = 10'b0011000010; // R-type
7'b0000011 : control = 10'b1001100000; // lw-type
7'b0100011 : control = 10'b1xx0010000; // sw-type
7'b1100011 : control = 10'b1xx0000100; // B-type
7'b0010011 : control = 10'b1011000011; // I-type
7'b1100111 : control = 10'b1101001000; // jalr-type
7'b1101111 : control = 10'b1101001100; // jal-type
7'b0110111 : control = 10'b1011000x01; // lui type
7'b0010111 : control = 10'b1011000100; // auipc type
default : control    = 10'bxxxxxxxxxx;
endcase
Bsel=control[9];
WBSel=control[8:7];
RegWEn=control[6];
MemRead=control[5];
MemWrite=control[4];
jump=control[3];
Asel=control[2];
Aluop=control[1:0];
end
always @(*)
begin
if (Opcode==7'b1100011) //B-Type
    
    case (funct3)
    3'b000:
    begin
  
    PCSel=(BrEq)?1:0;//beq
    
    end    
    3'b001:PCSel=(BrEq)?0:1;//bne
        
    3'b100:PCSel=(BrLT)?1:0;//blt
        
    3'b101:PCSel=(!BrLT)?1:0;//bge
    default: PCSel=0; 
    endcase
else if ((Opcode==7'b1101111)||(Opcode==7'b1100111)) PCSel=1;
else PCSel=0;               
end
endmodule
