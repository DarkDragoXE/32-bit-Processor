# 32-bit Processor (Verilog / Basys-3)

A 32-bit RISC-style processor implemented in synthesizable Verilog and deployed on a Digilent Basys-3 (Artix-7). The design focuses on a clear, teachable microarchitecture: a classic 5-stage pipeline, BRAM-backed memories, and simple memory-mapped GPIO. No caches or branch prediction.

## Overview
This project implements a from-scratch 32-bit CPU with a clean datapath and minimal control complexity suitable for FPGA bring-up and coursework. Programs execute from on-chip BRAM, with LEDs/switches mapped as simple I/O to validate arithmetic, control flow, and load/store behavior on hardware.

## Features
- 32-bit datapath: register file, ALU, program counter
- 5-stage pipeline: IF / ID / EX / MEM / WB
- ISA subset: arithmetic (ADD/SUB), logic (AND/OR/XOR), shifts, immediates, loads/stores, branches, jumps
- Hazard handling: data forwarding; stall on load-use and control hazards
- Instruction/Data memories in BRAM (no cache)
- Memory-mapped GPIO (LEDs/switches) for quick hardware tests
- Vivado project targeting Basys-3 (Artix-7 XC7A35T)

## Microarchitecture
- Datapath: 32-bit operands, ALU ops + shifts
- Control: hardwired decoder generates pipeline control signals
- Pipeline registers between stages; branch resolved in ID/EX
- Simple branch scheme; bubbles inserted on hazards
- Clocking/Reset: external 100 MHz clock, synchronous reset


## Build & Run (Vivado 2023.x)
1. Open/create a Vivado project; add sources from `rtl/` and testbenches from `sim/`.
2. Set Basys-3 part (XC7A35T-1CPG236C). Add `fpga/*.xdc` as constraints.
3. Set the top module (e.g., `top_fpga`), synthesize, implement, generate bitstream.
4. Program the board; connect a 100 MHz clock, reset, and verify LEDs/switches.

## Testing
- BRAM initialized with small assembly tests (arithmetic loops, branches, loads/stores).
- LEDs display register/ALU states or success patterns; switches feed input data.
- Simulation testbenches validate ALU, register file, control, hazards, and branch paths.

## Future Work
- Add multiplier/divider, CSR/timer, UART TX/RX
- Simple assembler/build scripts for programs
- Optional compressed instructions or basic debug UART monitor

## Author
Debtonu Bose • Electronics and Communication Engineering • VIT University (2025)



