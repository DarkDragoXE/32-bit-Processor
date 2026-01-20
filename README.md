<div align="center">

# 32-bit RISC Processor

[![Verilog](https://img.shields.io/badge/Language-Verilog-blue)](/)
[![FPGA](https://img.shields.io/badge/FPGA-Xilinx%20Artix--7-red)](https://www.xilinx.com/products/silicon-devices/fpga/artix-7.html)
[![Vivado](https://img.shields.io/badge/Tool-Vivado%202023.x-orange)](https://www.xilinx.com/products/design-tools/vivado.html)
[![Board](https://img.shields.io/badge/Board-Basys--3-green)](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/)

**A from-scratch 32-bit RISC-style CPU with clean datapath and minimal control complexity**

[Features](#features) | [Architecture](#architecture) | [Instruction Set](#instruction-set) | [Getting Started](#getting-started)

</div>

---

## Overview

This project implements a **32-bit RISC processor** in Verilog, targeting the Digilent Basys-3 FPGA board.

### Key Highlights

- **32-bit instruction word** with fixed-format encoding
- **32 general-purpose registers** (16-bit each)
- **Special register (SGPR)** for multiplication overflow
- **12 ALU operations** (5 arithmetic + 7 logical)
- **Condition flags**: Sign, Zero, Overflow, Carry

---

## Features

| Feature | Description |
|---------|-------------|
| **Architecture** | 32-bit RISC with 5-bit opcode |
| **Register File** | 32 x 16-bit general purpose registers |
| **ALU Operations** | ADD, SUB, MUL, MOV + 7 logic ops |
| **Addressing Modes** | Register-to-Register, Immediate |
| **Condition Flags** | Sign, Zero, Carry, Overflow |
| **Target FPGA** | Xilinx Artix-7 (XC7A35T) |

---

## Architecture

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

### Condition Flags

| Flag | Description |
|------|-------------|
| **Sign (S)** | MSB of result = 1 |
| **Zero (Z)** | Result = 0 |
| **Carry (C)** | ADD produces carry-out |
| **Overflow (O)** | Signed overflow |

---

## Instruction Set

### Arithmetic Operations

| Opcode | Mnemonic | Description |
|--------|----------|-------------|
| 00000 | MOVSGPR | Move from special register |
| 00001 | MOV | Move data |
| 00010 | ADD | Addition |
| 00011 | SUB | Subtraction |
| 00100 | MUL | Multiplication |

### Logical Operations

| Opcode | Mnemonic | Description |
|--------|----------|-------------|
| 00101 | OR | Bitwise OR |
| 00110 | AND | Bitwise AND |
| 00111 | XOR | Bitwise XOR |
| 01000 | XNOR | Bitwise XNOR |
| 01001 | NAND | Bitwise NAND |
| 01010 | NOR | Bitwise NOR |
| 01011 | NOT | Bitwise NOT |

---

## Project Structure

    32-bit-Processor/
    +-- README.md
    +-- ProcessorDesign.xpr
    +-- src/
    |   +-- processor.v
    +-- testbench/
    |   +-- processor_tb.v
    +-- docs/

---

## Getting Started

### Prerequisites

- **Xilinx Vivado** 2023.x or later
- **Digilent Basys-3** FPGA board (optional)

### Usage

1. Clone this repository
2. Open ProcessorDesign.xpr in Vivado
3. Run synthesis and implementation

---

## Technical Specifications

| Parameter | Value |
|-----------|-------|
| Instruction Width | 32 bits |
| Data Width | 16 bits |
| Register Count | 32 GPRs + 1 SGPR |
| Target FPGA | Xilinx Artix-7 XC7A35T |
| Target Board | Digilent Basys-3 |

---

## Author

**Debtonu Bose**  
Electronics and Communication Engineering  
VIT University, Class of 2025

---

<div align="center">

**If you find this project useful, please consider giving it a star!**

</div>
