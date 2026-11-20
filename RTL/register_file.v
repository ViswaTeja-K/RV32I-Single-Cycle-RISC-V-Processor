`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2026 15:20:26
// Design Name: 
// Module Name: register_file
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


module RegisterFile(
    input clk,
    input WriteEnable,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    output [31:0] Readdata1,
    output [31:0] Readdata2
    );
    reg [31:0] registers [31:0];
    always@(posedge clk)begin
    if(WriteEnable ==1 && WriteReg != 0)begin
      registers[WriteReg]<= WriteData;
      end
      end
    assign Readdata1 = (ReadReg1 == 0) ? 32'b0 : registers[ReadReg1];
    assign Readdata2 = (ReadReg2 == 0) ? 32'b0 : registers[ReadReg2];
endmodule
