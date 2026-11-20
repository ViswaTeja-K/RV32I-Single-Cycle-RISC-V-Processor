`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.10.2026 19:22:43
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
    input [24:0] Inst,
    input [2:0] ImmSrc,
    output reg [31:0]  ImmExt
    );
    always@(*)begin
    case(ImmSrc)
    3'b000:ImmExt= {{20{Inst[24]}},Inst[24:13]};// I type
    3'b001: ImmExt={{20{Inst[24]}},Inst[24:18],Inst[4:0]};// Stype
    3'b010: ImmExt= {{20{Inst[24]}},Inst[0],Inst[23:18],Inst[4:1],1'b0};// B type
    3'b011: ImmExt= {{12{Inst[24]}},Inst[12:5],Inst[13],Inst[23:14],1'b0};// J type
    3'b100: ImmExt = {Inst[24:5],12'b0};// U type
    default:ImmExt = 32'b0;
    endcase
    end
endmodule
