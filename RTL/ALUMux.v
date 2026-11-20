`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2026 17:14:22
// Design Name: 
// Module Name: ALUMux
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


module ALUMux(
    input [31:0] ReadData2,
    input [31:0] ImmExt,
    input ALUSrc,
    output [31:0] ALUInput
    );
    assign ALUInput = ALUSrc ? ImmExt : ReadData2;
endmodule
