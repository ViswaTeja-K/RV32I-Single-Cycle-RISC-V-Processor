# RV32I Single-Cycle RISC-V Processor

A 32-bit single-cycle RISC-V processor designed and implemented using **Verilog HDL**, following the RV32I base instruction set architecture.

The project focuses on RTL design, processor datapath implementation, control logic, memory operations, and functional verification using a self-checking testbench.

## Project Overview

The processor implements a single-cycle datapath in which each instruction completes its execution within one clock cycle.

**Project Status:** RTL design and simulation verification completed.

## Architecture

The processor consists of the following major components:

- Program Counter (PC)
- Instruction Memory
- Register File (32 × 32-bit registers)
- Main Control Decoder
- ALU Decoder
- Immediate Generator
- Arithmetic Logic Unit (ALU)
- Data Memory
- Result Multiplexer
- PC Selection Logic

## Supported Instructions

| Category | Instructions |
|---|---|
| R-Type | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU |
| I-Type | ADDI, ANDI, ORI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU |
| Load | LB, LH, LW, LBU, LHU |
| Store | SB, SH, SW |
| Branch | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| Jump | JAL, JALR |
| Upper Immediate | LUI, AUIPC |

## Design Features

- 32-bit RISC-V architecture.
- 32 general-purpose registers.
- Register x0 hardwired to zero.
- Immediate generation for I, S, B, U, and J formats.
- Arithmetic and logical operations.
- Signed and unsigned comparisons.
- Byte, halfword, and word memory operations.
- Sign extension and zero extension for load instructions.
- Conditional branching and jump operations.

## Verification

The processor was verified using a self-checking Verilog testbench in Xilinx Vivado / XSim.

| Metric | Result |
|---|---:|
| Total checks | 53 |
| Passed | 53 |
| Failed | 0 |

**Verification Status: ALL TESTS PASSED**

## Simulation Waveforms

### 1. Reset and Instruction Fetch
![Reset and Instruction Fetch](Waveforms/01_Reset.png)

### 2. ALU Operations
![ALU Operations](Waveforms/02_ALU.png)

### 3. Load and Store
![Load and Store](Waveforms/03_Memory.png)

### 4. Branch Instructions
![Branch Instructions](Waveforms/04_Branch.png)

### 5. JAL and JALR
![JAL and JALR](Waveforms/05_Jumps.png)

### 6. Verification Results
![Verification Results](Waveforms/06_Results.png)

## Tools and Technologies

- Verilog HDL
- Xilinx Vivado
- XSim Simulator
- RTL Design
- Self-checking Functional Verification

## Repository Structure

```text
RV32I-Single-Cycle-Processor/
│
├── RTL/
├── Simulation/
├── Verification/
├── Waveforms/
├── Documentation/
│   └── Project_Overview.md
└── README.md
```

## How to Run

1. Clone or download this repository.
2. Open Xilinx Vivado.
3. Create a project and add the RTL source files.
4. Add the self-checking testbench as a simulation source.
5. Make sure `program.hex` is available at the path expected by `$readmemh`.
6. Run Behavioral Simulation.
7. Check the simulation results and waveforms.

## Future Improvements

- Multi-cycle RISC-V processor.
- Five-stage pipelined architecture.
- Data forwarding and hazard detection.
- UART, SPI, and I2C peripheral integration.
- Wishbone bus interface.
- Hardware accelerator integration.
- FPGA implementation and hardware demonstration.

## Learning Outcomes

- RISC-V instruction set architecture.
- Verilog RTL design.
- Processor datapath and control unit design.
- ALU and memory implementation.
- Self-checking testbench development.
- Simulation and waveform analysis.

---

**Project Focus:** Digital Design | RTL Design | RISC-V | Verilog | Functional Verification
