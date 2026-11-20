`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2026 19:01:21
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ScrA,
    input [31:0] ScrB,
    input [3:0] ALUcontrol,
    output Zero,
    output Negative,
    output overflow,
    output reg Borrow,
    output reg [31:0] ALUoutput
    );
    always@(*) begin
    Borrow=1'b0;
    case(ALUcontrol)
    4'b0000 : ALUoutput = ScrA + ScrB;//ADD
    4'b0001 : begin Borrow = ScrA < ScrB ;
                    ALUoutput= ScrA - ScrB;//Sub
                    end
   4'b0010: ALUoutput = ScrA & ScrB; // AND: Bitwise AND operation
   4'b0011: ALUoutput = ScrA | ScrB; // OR: Bitwise OR operation
   4'b0100: ALUoutput = ScrA ^ ScrB; // XOR: Bitwise exclusive OR operation
   4'b0101: ALUoutput = ScrA << ScrB[4:0]; // SLL: Shift left logical
   4'b0110: ALUoutput = ScrA >> ScrB[4:0]; // SRL: Shift right logical (fills with zeros)
   4'b0111: ALUoutput = $signed(ScrA) >>> ScrB[4:0]; // SRA: Shift right arithmetic (preserves sign bit)
   4'b1000: ALUoutput = ($signed(ScrA) < $signed(ScrB)) ? 32'b1 : 32'b0; // SLT: Set less than (signed comparison)
   4'b1001: ALUoutput = (ScrA < ScrB) ? 32'b1 : 32'b0; // SLTU: Set less than unsigned (unsigned comparison)
   default: ALUoutput = 32'b0; // Default: Output zero for an undefined ALU control
endcase
     end
     assign Negative = ALUoutput[31];
     assign Zero = (ALUoutput == 32'b0);
     assign overflow = (ALUcontrol == 4'b0000)? ((ScrA[31] == ScrB[31])&&(ScrA[31] != ALUoutput[31])):(ALUcontrol == 4'b0001)? ((ScrA[31] != ScrB[31])&&(ScrA[31] != ALUoutput[31])):1'b0; 
                 
endmodule
