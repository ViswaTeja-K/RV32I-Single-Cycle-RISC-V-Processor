
`timescale 1ns / 1ps

module DataMemory(
    input [31:0] Address,
    input [31:0] WriteData,
    input clk,
    input WriteEnable,
    input [1:0] MemSize,
    input UnsignedLoad,
    output reg [31:0] ReadData
);

    reg [31:0] data [0:16383];

    wire [13:0] select = Address[15:2];

    wire ValidAddress = (Address <= 65535);

    wire ValidAlignment =
        (MemSize == 2'b00) ||
        (MemSize == 2'b01 && Address[0] == 1'b0) ||
        (MemSize == 2'b10 && Address[1:0] == 2'b00);

    // WRITE OPERATION
    always @(posedge clk) begin

        if (WriteEnable && ValidAddress && ValidAlignment) begin

            case (MemSize)

                // Store Byte
                2'b00: begin
                    case (Address[1:0])
                        2'b00: data[select][7:0]   <= WriteData[7:0];
                        2'b01: data[select][15:8]  <= WriteData[7:0];
                        2'b10: data[select][23:16] <= WriteData[7:0];
                        2'b11: data[select][31:24] <= WriteData[7:0];
                    endcase
                end

                // Store Halfword
                2'b01: begin
                    if (Address[1] == 1'b0)
                        data[select][15:0] <= WriteData[15:0];
                    else
                        data[select][31:16] <= WriteData[15:0];
                end

                // Store Word
                2'b10: begin
                    data[select] <= WriteData;
                end

                default: begin
                end

            endcase
        end
    end

    // READ OPERATION
    always @(*) begin

        ReadData = 32'b0;

        if (ValidAddress && ValidAlignment) begin

            case (MemSize)

                // Load Byte
                2'b00: begin
                    case (Address[1:0])
                        2'b00: ReadData = UnsignedLoad ?
                            {24'b0, data[select][7:0]} :
                            {{24{data[select][7]}}, data[select][7:0]};

                        2'b01: ReadData = UnsignedLoad ?
                            {24'b0, data[select][15:8]} :
                            {{24{data[select][15]}}, data[select][15:8]};

                        2'b10: ReadData = UnsignedLoad ?
                            {24'b0, data[select][23:16]} :
                            {{24{data[select][23]}}, data[select][23:16]};

                        2'b11: ReadData = UnsignedLoad ?
                            {24'b0, data[select][31:24]} :
                            {{24{data[select][31]}}, data[select][31:24]};
                    endcase
                end

                // Load Halfword
                2'b01: begin
                    if (Address[1] == 1'b0)
                        ReadData = UnsignedLoad ?
                            {16'b0, data[select][15:0]} :
                            {{16{data[select][15]}}, data[select][15:0]};
                    else
                        ReadData = UnsignedLoad ?
                            {16'b0, data[select][31:16]} :
                            {{16{data[select][31]}}, data[select][31:16]};
                end

                // Load Word
                2'b10: begin
                    ReadData = data[select];
                end

                default: ReadData = 32'b0;

            endcase
        end
    end

endmodule
