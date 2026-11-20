
`timescale 1ns / 1ps

module RISC_V_tb;

    reg clk;
    reg reset;

    wire [31:0] PC;
    wire [31:0] Instruction;
    wire [31:0] ALUResult;
    wire [31:0] MemoryOut;

    integer pass_count;
    integer fail_count;
    integer i;

    reg [31:0] expected_alu [0:22];
    reg [31:0] expected_load [0:8];

    // DUT
    RISC_V DUT (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .Instruction(Instruction),
        .ALUResult(ALUResult),
        .MemoryOut(MemoryOut)
    );

    // Clock: 10 ns period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Self-checking task
    task check_word;
        input [8*40-1:0] test_name;
        input [31:0] actual;
        input [31:0] expected;

        begin
            if (actual === expected) begin
                $display("PASS: %0s | Expected=%08h Actual=%08h",
                         test_name, expected, actual);
                pass_count = pass_count + 1;
            end
            else begin
                $display("FAIL: %0s | Expected=%08h Actual=%08h",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask
    
    task check_masked;
    input [8*40-1:0] test_name;
    input [31:0] actual;
    input [31:0] expected;
    input [31:0] mask;

    begin
        if ((actual & mask) === (expected & mask)) begin
            $display("PASS: %0s", test_name);
            pass_count = pass_count + 1;
        end
        else begin
            $display("FAIL: %0s | Expected=%08h Actual=%08h",
                     test_name, expected, actual);
            fail_count = fail_count + 1;
        end
    end
endtask

    // Main simulation
    initial begin

        pass_count = 0;
        fail_count = 0;
        reset = 1'b1;

        // Expected arithmetic and logical results.
        // These correspond to registers x4 through x26.

        expected_alu[0]  = 32'd13;          // ADD
        expected_alu[1]  = 32'd7;           // SUB
        expected_alu[2]  = 32'd24;          // SLL
        expected_alu[3]  = 32'd1;           // SLT
        expected_alu[4]  = 32'd1;           // SLTU
        expected_alu[5]  = 32'd9;           // XOR
        expected_alu[6]  = 32'd1;           // SRL
        expected_alu[7]  = 32'hFFFFFFFE;    // SRA
        expected_alu[8]  = 32'd11;          // OR
        expected_alu[9]  = 32'd2;           // AND
        expected_alu[10] = 32'hFFFFFFF0;    // x14 = -16
        expected_alu[11] = 32'hFFFF8000;    // x15
        expected_alu[12] = 32'd7;           // ADDI
        expected_alu[13] = 32'd1;           // SLTI
        expected_alu[14] = 32'd1;           // SLTIU
        expected_alu[15] = 32'd5;           // XORI
        expected_alu[16] = 32'd15;          // ORI
        expected_alu[17] = 32'd2;           // ANDI
        expected_alu[18] = 32'd12;          // SLLI
        expected_alu[19] = 32'h3FFFFFFC;    // SRLI
        expected_alu[20] = 32'hFFFFFFFC;    // SRAI
        expected_alu[21] = 32'h12345000;    // LUI
        expected_alu[22] = 32'h00001060;    // AUIPC

        // Expected load results.
        expected_load[0] = 32'h00000078;     // LB
        expected_load[1] = 32'h00000056;     // LBU
        expected_load[2] = 32'h00005678;     // LH
        expected_load[3] = 32'h00001234;     // LHU
        expected_load[4] = 32'h12345678;     // LW
        expected_load[5] = 32'hFFFFFF80;     // LB negative
        expected_load[6] = 32'h00000080;     // LBU
        expected_load[7] = 32'hFFFF8000;     // LH negative
        expected_load[8] = 32'h00008000;     // LHU

        // Hold reset for two clock cycles.
        repeat (2) @(negedge clk);
        reset = 1'b0;

        $display("\n======================================");
        $display("       RV32I SELF-CHECKING TEST");
        $display("======================================\n");

        // Wait until the final completion instruction writes x31 = 90.
        wait (DUT.RF.registers[31] === 32'd90);
        wait (Instruction === 32'h0000006f);
        #1;

        // Allow all nonblocking assignments to settle.
        #1;

        $display("\n--- ARITHMETIC / LOGICAL / U-TYPE ---");

        // x4 through x26 were saved at memory indices 128 through 150.
        for (i = 0; i < 23; i = i + 1) begin
            check_word("ALU / immediate / U-type result",
                       DUT.DM.data[128+i],
                       expected_alu[i]);
        end

        $display("\n--- LOAD INSTRUCTIONS ---");

        // Load results were saved at memory indices 152 through 160.
        for (i = 0; i < 9; i = i + 1) begin
            check_word("Load result",
                       DUT.DM.data[152+i],
                       expected_load[i]);
        end

        $display("\n--- STORE INSTRUCTIONS ---");

        check_word("SW memory word",
                   DUT.DM.data[64],
                   32'h12345678);

        check_masked("SB and SH memory word",
             DUT.DM.data[65],
             32'h80000080,
             32'hFFFF00FF);

        $display("\n--- BRANCH INSTRUCTIONS ---");

        // 2 means branch taken; 1 means branch not taken.
        check_word("BEQ taken",     DUT.DM.data[192], 32'd2);
        check_word("BEQ not taken", DUT.DM.data[193], 32'd1);

        check_word("BNE taken",     DUT.DM.data[194], 32'd2);
        check_word("BNE not taken", DUT.DM.data[195], 32'd1);

        check_word("BLT taken",     DUT.DM.data[196], 32'd2);
        check_word("BLT not taken", DUT.DM.data[197], 32'd1);

        check_word("BGE taken",     DUT.DM.data[198], 32'd2);
        check_word("BGE not taken", DUT.DM.data[199], 32'd1);

        check_word("BLTU taken",    DUT.DM.data[200], 32'd2);
        check_word("BLTU not taken",DUT.DM.data[201], 32'd1);

        check_word("BGEU taken",    DUT.DM.data[202], 32'd2);
        check_word("BGEU not taken",DUT.DM.data[203], 32'd1);

        $display("\n--- JUMP INSTRUCTIONS ---");

        check_word("JAL return address",
                   DUT.DM.data[212],
                   32'h00000248);

        check_word("JAL target execution",
                   DUT.DM.data[213],
                   32'd55);

        check_word("JALR return address",
                   DUT.DM.data[214],
                   32'h00000260);

        check_word("JALR target execution",
                   DUT.DM.data[215],
                   32'd66);

        $display("\n--- REGISTER ZERO ---");

        check_word("Final x31 completion marker",
                   DUT.RF.registers[31],
                   32'd90);

        // The current instruction is JAL x0,0.
        // Both register-file read ports must return zero.
        check_word("x0 read port 1",
                   DUT.ReadData1,
                   32'd0);

        check_word("x0 read port 2",
                   DUT.ReadData2,
                   32'd0);

        $display("\n======================================");
        $display("           TEST SUMMARY");
        $display("======================================");

        $display("Total Passed : %0d", pass_count);
        $display("Total Failed : %0d", fail_count);

        if (fail_count == 0)
            $display("\nRESULT: ALL TESTS PASSED!");
        else
            $display("\nRESULT: SOME TESTS FAILED!");

        $display("======================================\n");

        $finish;
    end

    // Prevent an infinite simulation if the completion marker is
    // never reached.
    initial begin
        #50000;
        $display("\nERROR: TESTBENCH TIMEOUT!");
        $display("Check PC, branch logic, jump logic and program.hex.");
        $finish;
    end

endmodule
