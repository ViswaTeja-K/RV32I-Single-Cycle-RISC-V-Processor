# RV32I Single-Cycle RISC-V Processor – Project Overview

## 1. Objective

To design and implement a 32-bit single-cycle RISC-V processor using Verilog HDL, supporting the RV32I base instruction set.

## 2. Architecture

The processor consists of:
- Program Counter
- Instruction Memory
- Register File
- Main Decoder
- ALU Decoder
- Immediate Generator
- Arithmetic Logic Unit
- Data Memory
- Result Selection Logic

## 3. Instruction Support

The implementation covers:
- Arithmetic and logical instructions
- Immediate instructions
- Load and store instructions
- Conditional branch instructions
- JAL and JALR
- LUI and AUIPC

## 4. Verification

The design was tested using a self-checking Verilog testbench in Xilinx Vivado.

| Verification metric | Result |
|---|---:|
| Total checks | 53 |
| Passed | 53 |
| Failed | 0 |

## 5. Development Tools

- Verilog HDL
- Xilinx Vivado
- XSim Simulator

## 6. Future Scope

- Multi-cycle processor
- Five-stage pipelined processor
- Hazard detection and forwarding
- UART, SPI and I2C interfaces
- Wishbone bus integration
- Hardware accelerator
- FPGA implementation
