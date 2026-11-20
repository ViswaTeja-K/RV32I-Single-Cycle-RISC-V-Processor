`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 17:24:53
// Design Name: 
// Module Name: ResultMux
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


module ResultMux(
    input [31:0] ALUoutput,
    input [31:0] ReadData,
    input [31:0] TargetAddress,
    input [31:0] ImmExt,
    input [31:0] PCPlus4,
    input [2:0] ResultSrc,
    output reg [31:0] Result
    );
    always@(*) begin
    case(ResultSrc)
     3'b000 : Result = ALUoutput;
     3'b001: Result = ReadData;
     3'b010: Result = PCPlus4;
     3'b011: Result = ImmExt;
     3'b100: Result = TargetAddress;
     default: Result = 32'b0;
     endcase
     end
endmodule
