`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2026 05:07:19
// Design Name: 
// Module Name: RISC_V
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_V(
    input clk,
    input reset,
    output [31:0] PC,
    output [31:0] Instruction,
    output [31:0] ALUResult,
    output [31:0] MemoryOut
    );
    wire [31:0] PCNext, PCPlus4,TargetAddress,ReadData1,ReadData2,ImmExt,ALUScrB,Result,JALRTarget;
    wire [3:0] ALUControl;
    wire [2:0] ImmSrc, ResultSrc;
    wire [1:0] ALUOp;
    wire [1:0] MemSize;
    wire UnsignedLoad;
    wire Zero,Negative,Overflow,Borrow,RegWrite,ALUSrc,MemWrite,Branch,Jump,JALR,BranchTaken,PCSrc,RType;
    
    
    assign JALRTarget = {ALUResult[31:1], 1'b0};
    
    PC P (.clk(clk),.reset(reset),.PCNext(PCNext),.PC(PC));
    
    PCPlus4 P4 (.PC(PC),.PCPlus4(PCPlus4));
    
    InstructionMemory IM (.Address(PC),.Instruction(Instruction));
    
    MainDecoder D (.OpCode(Instruction[6:0]),.Funct3(Instruction[14:12]),.RegWrite(RegWrite),.ImmSrc(ImmSrc),.ALUSrc(ALUSrc),.MemWrite(MemWrite),.ResultSrc(ResultSrc),.ALUOp(ALUOp),.Branch(Branch),.Jump(Jump),.JALR(JALR),.RType(RType),.MemSize(MemSize),.UnsignedLoad(UnsignedLoad));
    
    ALUDecoder AD (.funct3(Instruction[14:12]),.Zero(Zero),.Negative(Negative),.Overflow(Overflow),.Borrow(Borrow),.funct7(Instruction[31:25]),.ALUOp(ALUOp),.Branch(Branch),.RType(RType),.ALUControl(ALUControl),.BranchTaken(BranchTaken));
    
    RegisterFile RF (.clk(clk),.WriteEnable(RegWrite),.ReadReg1(Instruction[19:15]),.ReadReg2(Instruction[24:20]),.WriteReg(Instruction[11:7]),.Readdata1(ReadData1),.Readdata2(ReadData2),.WriteData(Result));
    
    ImmGen I (.Inst(Instruction[31:7]),.ImmSrc(ImmSrc),.ImmExt(ImmExt));
    
    ALUMux AM (.ReadData2(ReadData2),.ImmExt(ImmExt),.ALUSrc(ALUSrc),.ALUInput(ALUScrB));
    
    ALU A (.ScrA(ReadData1),.ScrB(ALUScrB),.ALUcontrol(ALUControl),.Zero(Zero),.Negative(Negative),.overflow(Overflow),.Borrow(Borrow),.ALUoutput(ALUResult));
    
    DataMemory DM (.Address(ALUResult),.WriteData(ReadData2),.clk(clk),.WriteEnable(MemWrite),.MemSize(MemSize),.UnsignedLoad(UnsignedLoad),.ReadData(MemoryOut));
    
    ResultMux RM (.ALUoutput(ALUResult),.ReadData(MemoryOut),.TargetAddress(TargetAddress),.ImmExt(ImmExt),.PCPlus4(PCPlus4),.ResultSrc(ResultSrc),.Result(Result));
    
    PCSrc PCS (.Branch(Branch),.Jump(Jump),.JALR(JALR),.BranchTaken(BranchTaken),.PCSrc(PCSrc));
    
    PCMux PCM (.PCSrc(PCSrc),.JALR(JALR),.PCPlus4(PCPlus4),.TargetAddress(TargetAddress),.JALRTarget(JALRTarget),.PCNext(PCNext));
    
    PCTarget PCT (.PCCurrent(PC),.ImmExt(ImmExt),.TargetAddress(TargetAddress));
endmodule
