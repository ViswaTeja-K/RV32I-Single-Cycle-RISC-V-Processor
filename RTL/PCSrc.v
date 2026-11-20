`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2026 18:21:03
// Design Name: 
// Module Name: PCSrc
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


module PCSrc(
    input Branch,
    input Jump,
    input JALR,
    input BranchTaken,
    output PCSrc
    );
    assign PCSrc = Jump | JALR | (Branch & BranchTaken);
endmodule
