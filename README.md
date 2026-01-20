<div align="center">

# 32-bit RISC Processor

[![Verilog](https://img.shields.io/badge/Language-Verilog-blue)](/)
[![FPGA](https://img.shields.io/badge/FPGA-Xilinx%20Artix--7-red)](https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html)
[![Vivado](https://img.shields.io/badge/Tool-Vivado%202023.x-orange)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Board](https://img.shields.io/badge/Board-Basys--3-green)](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/)
[![Personal](https://img.shields.io/badge/Project-Personal-purple)](/)

**A from-scratch 32-bit RISC-style CPU with 5-state FSM pipelining and 25+ instruction support**

[Features](#features) | [Architecture](#architecture) | [Instruction Set](#instruction-set) | [Getting Started](#getting-started) | [Author](#author)

</div>

---

## About

This is a personal project developed from June 2025 to October 2025, implementing a complete 32-bit RISC processor from scratch in Verilog HDL.

| | |
|---|---|
| **Type** | Personal Project |
| **Duration** | June 2025 - October 2025 |
| **Team Size** | 1 |
| **Role** | Team Lead |
| **Tools** | Xilinx Vivado |

---

## Overview

This project implements a **32-bit RISC processor** in Verilog, targeting the Digilent Basys-3 FPGA board (Xilinx Artix-7).

### Key Highlights

- **32-bit instruction word** with fixed-format encoding
- **32 general-purpose registers** (16-bit each)
- **25+ instructions** including arithmetic, logical, memory operations, and conditional branching
- **5-state FSM** (idle, fetch, decode-execute, delay, sense-halt) for instruction pipelining
- **Condition flags** (carry, zero, overflow, sign) for branch control
- **16-word program memory** and **16-word data memory** architecture

---

## Features

| Feature | Description |
|---------|-------------|
| **Architecture** | 32-bit RISC with 5-bit opcode |
| **Register File** | 32 x 16-bit general purpose registers |
| **Instructions** | 25+ (arithmetic, logical, memory, branch) |
| **FSM States** | 5 states for instruction pipelining |
| **Addressing Modes** | Register-to-Register, Immediate |
| **Condition Flags** | Sign, Zero, Carry, Overflow |
| **Program Memory** | 16-word |
| **Data Memory** | 16-word |
| **Target FPGA** | Xilinx Artix-7 (XC7A35T) |

---

## Architecture

### 5-State FSM Pipeline

```
    +-------+     +-------+     +----------------+     +-------+     +------------+
    | IDLE  | --> | FETCH | --> | DECODE-EXECUTE | --> | DELAY | --> | SENSE-HALT |
    +-------+     +-------+     +----------------+     +-------+     +------------+
        ^                                                                  |
        |                                                                  |
        +------------------------------------------------------------------+
```

| State | Description |
|-------|-------------|
| **IDLE** | Processor initialization |
| **FETCH** | Instruction fetch from program memory |
| **DECODE-EXECUTE** | Decode opcode and execute operation |
| **DELAY** | Pipeline delay for timing |
| **SENSE-HALT** | Check for halt condition or continue |

### Instruction Format (32-bit)

| Bits | 31-27 | 26-22 | 21-17 | 16 | 15-0 |
|------|-------|-------|-------|-----|------|
| Field | OPCODE | RDST | RSRC1 | MODE | RSRC2/IMM |
| Width | 5-bit | 5-bit | 5-bit | 1-bit | 16-bit |

### Register Organization

| Register | Width | Description |
|----------|-------|-------------|
| GPR[0-31] | 16-bit | General Purpose Registers |
| SGPR | 16-bit | Special Register (MUL overflow) |
| IR | 32-bit | Instruction Register |
| PC | - | Program Counter |

### Condition Flags

| Flag | Description | Used For |
|------|-------------|----------|
| **Sign (S)** | MSB of result = 1 | Signed comparisons |
| **Zero (Z)** | Result = 0 | Equality checks |
| **Carry (C)** | ADD produces carry-out | Unsigned overflow |
| **Overflow (O)** | Signed overflow | Signed arithmetic |

---

## Instruction Set

### Arithmetic Operations

| Opcode | Mnemonic | Operation | Description |
|--------|----------|-----------|-------------|
| 00000 | MOVSGPR | RDST <- SGPR | Move from special register |
| 00001 | MOV | RDST <- RSRC1/IMM | Move data |
| 00010 | ADD | RDST <- RSRC1 + RSRC2/IMM | Addition |
| 00011 | SUB | RDST <- RSRC1 - RSRC2/IMM | Subtraction |
| 00100 | MUL | RDST <- LSB, SGPR <- MSB | Multiplication |

### Logical Operations

| Opcode | Mnemonic | Operation | Description |
|--------|----------|-----------|-------------|
| 00101 | OR | RDST <- RSRC1 \| RSRC2 | Bitwise OR |
| 00110 | AND | RDST <- RSRC1 & RSRC2 | Bitwise AND |
| 00111 | XOR | RDST <- RSRC1 ^ RSRC2 | Bitwise XOR |
| 01000 | XNOR | RDST <- ~(RSRC1 ^ RSRC2) | Bitwise XNOR |
| 01001 | NAND | RDST <- ~(RSRC1 & RSRC2) | Bitwise NAND |
| 01010 | NOR | RDST <- ~(RSRC1 \| RSRC2) | Bitwise NOR |
| 01011 | NOT | RDST <- ~RSRC1 | Bitwise NOT |

### Memory Operations

| Opcode | Mnemonic | Description |
|--------|----------|-------------|
| - | LOAD | Load from data memory |
| - | STORE | Store to data memory |

### Control Flow

| Opcode | Mnemonic | Description |
|--------|----------|-------------|
| - | JUMP | Unconditional jump |
| - | BRANCH | Conditional branch based on flags |

---

## Project Structure

```
32-bit-Processor/
├── README.md
├── ProcessorDesign.xpr       # Vivado project file
├── src/
│   └── processor.v           # Main processor RTL
├── testbench/
│   └── processor_tb.v        # Verification testbench
└── docs/                     # Additional documentation
```

---

## Getting Started

### Prerequisites

- **Xilinx Vivado** 2023.x or later
- **Digilent Basys-3** FPGA board (optional, for hardware testing)

### Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/DarkDragoXE/32-bit-Processor.git
   ```

2. Open Vivado and load the project:
   ```
   File -> Open Project -> ProcessorDesign.xpr
   ```

3. Run behavioral simulation with the testbench

4. Generate bitstream and program FPGA for hardware testing

---

## Technical Specifications

| Parameter | Value |
|-----------|-------|
| **Instruction Width** | 32 bits |
| **Data Width** | 16 bits |
| **Register Count** | 32 GPRs + 1 SGPR |
| **Program Memory** | 16 words |
| **Data Memory** | 16 words |
| **FSM States** | 5 |
| **Instruction Count** | 25+ |
| **Target FPGA** | Xilinx Artix-7 XC7A35T |
| **Target Board** | Digilent Basys-3 |

---

## Simulation Results

- Successfully simulated instruction execution cycles
- Verified jump operations and conditional branching
- Tested data memory transfers (load/store)
- Validated all arithmetic and logical operations
- Confirmed correct flag generation for branch control

---

## Author

**Debtonu Bose**
B.Tech Electronics and Communication Engineering
Vellore Institute of Technology (2021-2025)

[![GitHub](https://img.shields.io/badge/GitHub-DarkDragoXE-black?logo=github)](https://github.com/DarkDragoXE)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-debtonu--bose-blue?logo=linkedin)](https://linkedin.com/in/debtonu-bose)

---

## Future Enhancements

- [ ] Add pipeline stages (IF/ID/EX/MEM/WB)
- [ ] Implement data forwarding and hazard detection
- [ ] Add memory-mapped I/O for LED/switch control
- [ ] Create assembler for instruction encoding
- [ ] Extend program/data memory size

---

<div align="center">

**Custom CPU Design | Verilog HDL | Xilinx Vivado**

</div>
