# RV32I Single-Cycle RISC-V Processor

A 32-bit single-cycle RISC-V processor designed and implemented using **Verilog HDL**, following the RV32I base instruction set architecture.

This project focuses on understanding processor architecture, RTL design, datapath implementation, control logic, and functional verification using a self-checking testbench.

## Project Overview

The processor implements a single-cycle datapath in which each instruction completes its execution within one clock cycle.

The design includes instruction fetching, instruction decoding, register operations, ALU execution, memory access, and write-back.

**Project Status:** Single-cycle RTL design and simulation verification completed.

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

The processor supports the following RV32I instruction categories:

| Instruction Type | Supported Instructions |
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
- Register x0 is hardwired to zero.
- Immediate generation for I, S, B, U, and J instruction formats.
- Arithmetic and logical operations.
- Signed and unsigned comparisons.
- Byte, halfword, and word memory operations.
- Sign extension and zero extension for load instructions.
- Conditional branching and jump operations.
- JAL and JALR return address handling.

## Verification and Testing

The processor was verified using a **self-checking Verilog testbench**.

The testbench checks:
- ALU operations and immediate instructions.
- Load and store operations.
- Conditional branch instructions.
- JAL and JALR operations.
- Register x0 behaviour.
- Expected memory and register values.

### Simulation Results

**Total Test Cases: 53**

**Passed: 53**

**Failed: 0**

**Result: ALL TESTS PASSED**

### Simulation Waveforms

The following waveforms demonstrate the processor's operation.

#### 1. Reset and Instruction Fetch
![Reset and Instruction Fetch](Waveforms/01_Reset_Instruction_Fetch.png)

#### 2. ALU Operations
![ALU Operations](Waveforms/02_ALU_Operations.png)

#### 3. Load and Store Operations
![Load and Store](Waveforms/03_Load_Store.png)

#### 4. Branch Instructions
![Branch Instructions](Waveforms/04_Branch_Instructions.png)

#### 5. JAL and JALR Instructions
![Jump Instructions](Waveforms/05_JAL_JALR.png)

#### 6. Verification Summary
![Verification Summary](Waveforms/06_Test_Summary.png)

## Tools and Technologies

- **HDL:** Verilog
- **Simulation:** Xilinx Vivado / XSim
- **Design Approach:** RTL Design
- **Architecture:** RISC-V RV32I
- **Verification:** Self-checking Testbench

## Repository Structure

```text
RV32I-Single-Cycle-Processor/
│
├── RTL/
│   ├── RISC_V.v
│   ├── ALU.v
│   ├── RegisterFile.v
│   ├── InstructionMemory.v
│   ├── DataMemory.v
│   ├── MainDecoder.v
│   ├── ALUDecoder.v
│   ├── ImmGen.v
│   ├── PC.v
│   └── ...
│
├── Simulation/
│   ├── RISC_V_tb.v
│   └── program.hex
│
├── Verification/
│   └── Self_Checking_Testbench.v
│
├── Waveforms/
│   ├── 01_Reset_Instruction_Fetch.png
│   ├── 02_ALU_Operations.png
│   ├── 03_Load_Store.png
│   ├── 04_Branch_Instructions.png
│   ├── 05_JAL_JALR.png
│   └── 06_Test_Summary.png
│
├── Documentation/
│
└── README.md
```

*The file names and folder structure can be adjusted to match the actual uploaded files.*

## How to Run the Simulation

1. Clone or download this repository.
2. Open Xilinx Vivado.
3. Create or open a Vivado project.
4. Add the Verilog RTL files.
5. Add the testbench as a simulation source.
6. Ensure `program.hex` is available at the path expected by `$readmemh`.
7. Run Behavioral Simulation.
8. Execute the self-checking testbench and inspect the simulation results.

## Future Improvements

The current implementation is the first stage of a larger RISC-V processor development project.

Planned improvements include:

- Multi-cycle RISC-V processor implementation.
- Five-stage pipelined RISC-V architecture.
- Hazard detection and data forwarding.
- UART, SPI, and I2C peripheral integration.
- Wishbone bus interface.
- Hardware accelerator integration.
- FPGA implementation and hardware demonstration.

## Learning Outcomes

Through this project, I gained practical experience in:

- RISC-V ISA and processor architecture.
- Verilog RTL design.
- Datapath and control unit implementation.
- ALU and memory design.
- Functional verification using self-checking testbenches.
- Simulation and waveform analysis using Vivado.

---

**Project Focus:** Digital Design | RTL Design | RISC-V | Verilog | Functional Verification
