`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2026 17:20:18
// Design Name: 
// Module Name: ALUDecoder
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


module ALUDecoder(
    input [2:0] funct3,
    input Zero,
    input Negative,
    input Overflow,
    input Borrow,
    input [6:0] funct7,
    input [1:0] ALUOp,
    input Branch,
    input RType,
    output reg [3:0]  ALUControl,
    output reg BranchTaken
    );
    always@(*) begin
     ALUControl = 4'b0000;
     BranchTaken = 1'b0;
    case(ALUOp)
    2'b00 :  ALUControl = 4'b0000;
    2'b01 : ALUControl = 4'b0001;
    2'b10 : begin
        case(funct3) 
   3'b000: begin
    if (RType == 1'b1) begin
        case(funct7)
            7'b0000000: ALUControl = 4'b0000; // ADD
            7'b0100000: ALUControl = 4'b0001; // SUB
            default:    ALUControl = 4'b0000; // Invalid encoding
        endcase
    end
    else
        ALUControl = 4'b0000; // ADDI
end
       3'b001: begin if(funct7 == 7'b0000000)
                      ALUControl = 4'b0101;//SLL / SLLI
                      end
      3'b010: begin
           if (RType == 1'b1) begin
              if (funct7 == 7'b0000000)
                 ALUControl = 4'b1000; // SLT
                end
           else
               ALUControl = 4'b1000; // SLTI
           end
       3'b011: begin
              if (RType == 1'b1) begin
                if (funct7 == 7'b0000000)
                    ALUControl = 4'b1001; // SLTU
                    end
                  else
                     ALUControl = 4'b1001; // SLTIU
               end
       3'b100: begin
            if (RType == 1'b1) begin
               if (funct7 == 7'b0000000)
                   ALUControl = 4'b0100; // XOR
               end
           else
             ALUControl = 4'b0100; // XORI
           end
       3'b101:begin
        if ( funct7 == 7'b0000000)
                   ALUControl = 4'b0110;//SRL
               else if ( funct7 == 7'b0100000)
                  ALUControl = 4'b0111;//SRA  
              end      
      3'b110: begin
             if (RType == 1'b1) begin
               if (funct7 == 7'b0000000)
                   ALUControl = 4'b0011; // OR
                  end
              else
                  ALUControl = 4'b0011; // ORI
              end
       3'b111: begin
            if (RType == 1'b1) begin
               if (funct7 == 7'b0000000)
                ALUControl = 4'b0010; // AND
               end
            else
                 ALUControl = 4'b0010; // ANDI
            end
       endcase
       end
     default: ALUControl = 4'b0000;
     endcase
     if( Branch == 1'b1 && (ALUOp == 2'b01))begin
     case(funct3)
        3'b000: BranchTaken = Zero;                  // BEQ
        3'b001: BranchTaken = ~Zero;                 // BNE
        3'b100: BranchTaken = Negative ^ Overflow;   // BLT
        3'b101: BranchTaken = ~(Negative ^ Overflow);// BGE
        3'b110: BranchTaken = Borrow;                // BLTU
        3'b111: BranchTaken = ~Borrow;               // BGEU
        default: BranchTaken = 1'b0;
       endcase
       end 
     end                    
    
endmodule
