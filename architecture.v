module riscv_top(input clk
output wire [63:0] d,e,Writedata, RD1,RD2, Mux1output, shiftoutput,Mux10output;
output wire [31:0] RD, PC, PCPlus4;
output wire [31:0] branchaddress,PCinput;
output wire [3:0] Control; 
output wire [1:0] Aluop,WBSel;
output wire [2:0] funct3;
output wire [31:0]PCaddress;
output wire BrEq,BrLT,Zero;
output wire jump;
output wire Bsel,RegWEn,MemRead,MemWrite,Asel,PCSel;
output wire [31:0]Bselout,Aselout,immediateout,ALUOut, DataOutput;
//wire b;
Controller Control_Signal(
BrEq,BrLT,
RD[14:12],
RD[6:0],
PCSel,
Bsel,WBSel,RegWEn, MemRead, MemWrite, jump,Asel,Aluop);
MUX #(32)M9(PCPlus4,ALUOut[31:0],PCSel,PCinput);
PCCounter P1(clk,PCinput,PC);
adder A1(PC,PCPlus4);
IMEM I1(PC,RD);
Regfile R1(clk,RegWrite,RD[19:15],RD[24:20],RD[11:7],Writedata,RD1,RD2);
Imm_gen S1(RD[31:0],immediateout);
branch_compare BC(RD1,RD2,BrEq,BrLT);
MUX Bsel_Mux(RD2,immediateout,Bsel,Bselout);
ALUControl A3(Aluop,RD[30],RD[14:12],Control);
MUX Asel_Mux(RD1,PC,Asel,Aselout);
ALU A2(Control,Aselout,Bselout,ALUOut,Zero);
DMEM D1(clk,MemWrite,MemRead,ALUOut,RD2,DataOutput);

MUX1 #(32)WBMux(DataOutput,ALUOut,PCPlus4,WBSel,Writedata);



endmodule
