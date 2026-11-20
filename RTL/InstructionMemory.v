`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2026 10:28:51
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input [31:0] Address,
    output [31:0] Instruction
    );
    reg [31:0] memory [0:16383];
    wire [13:0] address = Address[15:2];
    initial begin
    $readmemh("program.hex", memory);
   end
    assign Instruction = memory[address];
    
endmodule
