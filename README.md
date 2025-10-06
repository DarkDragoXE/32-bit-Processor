# 32-bit-Processor
32-bit RISC-style processor for Basys-3 in Verilog. Five-stage pipeline (IF/ID/EX/MEM/WB) with forwarding and stalls for load/branch hazards. BRAM-backed instruction/data memories and memory-mapped GPIO for LEDs/switches. Built and tested in Vivado; no caches or branch prediction to keep the core focused.
