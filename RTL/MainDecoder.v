
`timescale 1ns / 1ps

module MainDecoder(
    input [6:0] OpCode,
    input [2:0] Funct3,

    output reg RegWrite,
    output reg [2:0] ImmSrc,
    output reg ALUSrc,
    output reg MemWrite,
    output reg [2:0] ResultSrc,
    output reg [1:0] ALUOp,
    output reg Branch,
    output reg Jump,
    output reg JALR,
    output reg RType,

    output reg [1:0] MemSize,
    output reg UnsignedLoad
);

    always @(*) begin

        RegWrite = 1'b0;
        ImmSrc = 3'b000;
        ALUSrc = 1'b0;
        MemWrite = 1'b0;
        ResultSrc = 3'b000;
        ALUOp = 2'b00;
        Branch = 1'b0;
        Jump = 1'b0;
        JALR = 1'b0;
        RType = 1'b0;

        MemSize = 2'b10;
        UnsignedLoad = 1'b0;

        case(OpCode)

            7'b0110011: begin // R Type
                RegWrite = 1'b1;
                ALUSrc = 1'b0;
                ALUOp = 2'b10;
                RType = 1'b1;
            end

            7'b0010011: begin // I Type
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                ALUOp = 2'b10;
            end

            7'b0000011: begin // Load

                ALUSrc = 1'b1;
                ResultSrc = 3'b001;

                case(Funct3)

                    3'b000: begin // LB
                        RegWrite = 1'b1;
                        MemSize = 2'b00;
                    end

                    3'b001: begin // LH
                        RegWrite = 1'b1;
                        MemSize = 2'b01;
                    end

                    3'b010: begin // LW
                        RegWrite = 1'b1;
                        MemSize = 2'b10;
                    end

                    3'b100: begin // LBU
                        RegWrite = 1'b1;
                        MemSize = 2'b00;
                        UnsignedLoad = 1'b1;
                    end

                    3'b101: begin // LHU
                        RegWrite = 1'b1;
                        MemSize = 2'b01;
                        UnsignedLoad = 1'b1;
                    end

                    default: begin
                        RegWrite = 1'b0;
                    end

                endcase
            end

            7'b0100011: begin // Store

                ImmSrc = 3'b001;
                ALUSrc = 1'b1;

                case(Funct3)

                    3'b000: begin // SB
                        MemWrite = 1'b1;
                        MemSize = 2'b00;
                    end

                    3'b001: begin // SH
                        MemWrite = 1'b1;
                        MemSize = 2'b01;
                    end

                    3'b010: begin // SW
                        MemWrite = 1'b1;
                        MemSize = 2'b10;
                    end

                    default: begin
                        MemWrite = 1'b0;
                    end

                endcase
            end

            7'b1100011: begin // B Type
                ImmSrc = 3'b010;
                ALUOp = 2'b01;
                Branch = 1'b1;
            end

            7'b1101111: begin // JAL
                RegWrite = 1'b1;
                ImmSrc = 3'b011;
                ResultSrc = 3'b010;
                Jump = 1'b1;
            end

            7'b1100111: begin // JALR
                RegWrite = 1'b1;
                ImmSrc = 3'b000;
                ALUSrc = 1'b1;
                ResultSrc = 3'b010;
                JALR = 1'b1;
            end

            7'b0110111: begin // LUI
                RegWrite = 1'b1;
                ImmSrc = 3'b100;
                ResultSrc = 3'b011;
            end

            7'b0010111: begin // AUIPC
                RegWrite = 1'b1;
                ImmSrc = 3'b100;
                ResultSrc = 3'b100;
            end

        endcase

    end

endmodule
