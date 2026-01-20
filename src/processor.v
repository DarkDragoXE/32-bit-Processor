`timescale 1ns / 1ps

//============================================================================
// 32-bit RISC Processor
// Author: Debtonu Bose
// Description: A simple 32-bit processor with arithmetic and logic operations
//============================================================================

//============================================================================
// Instruction Register Fields
//============================================================================
`define opertype IR[31:27]  // Operation code (5 bits)
`define rdst     IR[26:22]  // Destination register (5 bits)
`define rsrc1    IR[21:17]  // Source register 1 (5 bits)
`define immemode IR[16]     // Immediate mode flag (1 bit)
`define rsrc2    IR[15:11]  // Source register 2 (5 bits)
`define isrc     IR[15:0]   // Immediate value (16 bits)

//============================================================================
// Opcode Definitions - Arithmetic Operations
//============================================================================
`define movsgpr     5'b00000  // Move from special register (multiplication MSB)
`define mov         5'b00001  // Move data
`define add         5'b00010  // Addition
`define sub         5'b00011  // Subtraction
`define mul         5'b00100  // Multiplication

//============================================================================
// Opcode Definitions - Logical Operations
//============================================================================
`define ror         5'b00101  // Bitwise OR
`define rand        5'b00110  // Bitwise AND
`define rxor        5'b00111  // Bitwise XOR
`define rxnor       5'b01000  // Bitwise XNOR
`define rnand       5'b01001  // Bitwise NAND
`define rnor        5'b01010  // Bitwise NOR
`define rnot        5'b01011  // Bitwise NOT

//============================================================================
// Processor Module
//============================================================================
module processor();

    //------------------------------------------------------------------------
    // Registers
    //------------------------------------------------------------------------
    reg [31:0] IR;              // 32-bit Instruction Register
    reg [15:0] GPR [31:0];      // 32 General Purpose Registers (16-bit each)
    reg [15:0] SGPR;            // Special Register (stores MSB of multiplication)
    reg [31:0] mulres;          // Multiplication result (32-bit)

    //------------------------------------------------------------------------
    // Condition Flags
    //------------------------------------------------------------------------
    reg sign = 0;               // Sign flag
    reg zero = 0;               // Zero flag
    reg overflow = 0;           // Overflow flag
    reg carry = 0;              // Carry flag
    reg [16:0] tempsum;         // Temporary sum for carry detection

    //------------------------------------------------------------------------
    // ALU - Arithmetic and Logic Operations
    //------------------------------------------------------------------------
    always @(*) begin
        case(`opertype)
            //----------------------------------------------------------------
            // Arithmetic Operations
            //----------------------------------------------------------------
            `movsgpr: begin
                GPR[`rdst] = SGPR;
            end

            `mov: begin
                if(`immemode)
                    GPR[`rdst] = `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1];
            end

            `add: begin
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] + `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] + GPR[`rsrc2];
            end

            `sub: begin
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] - `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] - GPR[`rsrc2];
            end

            `mul: begin
                if(`immemode)
                    mulres = GPR[`rsrc1] * `isrc;
                else
                    mulres = GPR[`rsrc1] * GPR[`rsrc2];
                GPR[`rdst] = mulres[15:0];   // LSB to destination
                SGPR = mulres[31:16];         // MSB to special register
            end

            //----------------------------------------------------------------
            // Logical Operations
            //----------------------------------------------------------------
            `ror: begin  // Bitwise OR
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] | `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] | GPR[`rsrc2];
            end

            `rand: begin  // Bitwise AND
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] & `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] & GPR[`rsrc2];
            end

            `rxor: begin  // Bitwise XOR
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] ^ `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] ^ GPR[`rsrc2];
            end

            `rxnor: begin  // Bitwise XNOR
                if(`immemode)
                    GPR[`rdst] = GPR[`rsrc1] ~^ `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] ~^ GPR[`rsrc2];
            end

            `rnand: begin  // Bitwise NAND
                if(`immemode)
                    GPR[`rdst] = ~(GPR[`rsrc1] & `isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1] & GPR[`rsrc2]);
            end

            `rnor: begin  // Bitwise NOR
                if(`immemode)
                    GPR[`rdst] = ~(GPR[`rsrc1] | `isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1] | GPR[`rsrc2]);
            end

            `rnot: begin  // Bitwise NOT
                if(`immemode)
                    GPR[`rdst] = ~(`isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1]);
            end
        endcase
    end

    //------------------------------------------------------------------------
    // Condition Flag Logic
    //------------------------------------------------------------------------
    always @(*) begin
        // Sign flag
        if(`opertype == `mul)
            sign = SGPR[15];
        else
            sign = GPR[`rdst][15];

        // Carry flag (for addition only)
        if(`opertype == `add) begin
            if(`immemode) begin
                tempsum = GPR[`rsrc1] + `isrc;
                carry = tempsum[16];
            end else begin
                tempsum = GPR[`rsrc1] + GPR[`rsrc2];
                carry = tempsum[16];
            end
        end else begin
            carry = 1'b0;
        end

        // Zero flag
        if(`opertype == `mul)
            zero = ~((|SGPR[15]) | (|GPR[`rdst]));
        else
            zero = ~(|GPR[`rdst]);

        // Overflow flag (for addition only)
        if(`opertype == `add) begin
            if(`immemode)
                overflow = ((~GPR[`rsrc1][15] & ~IR[15] & GPR[`rdst][15]) | 
                           (GPR[`rsrc1][15] & IR[15] & ~GPR[`rdst][15]));
        end
    end

endmodule
