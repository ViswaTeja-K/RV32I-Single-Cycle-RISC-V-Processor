`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 17:07:57
// Design Name: 
// Module Name: PCMux
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



module PCMux(
    input PCSrc,
    input JALR,
    input [31:0] PCPlus4,
    input [31:0] TargetAddress,
    input [31:0] JALRTarget,
    output [31:0] PCNext
);

    assign PCNext = JALR  ? JALRTarget :
                    PCSrc ? TargetAddress :
                            PCPlus4;

endmodule

