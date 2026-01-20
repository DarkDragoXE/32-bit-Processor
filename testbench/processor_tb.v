`timescale 1ns / 1ps

//============================================================================
// Processor Testbench
// Author: Debtonu Bose
// Description: Testbench for verifying processor operations
//============================================================================

module processor_tb;

    integer i = 0;
    
    // Instantiate the processor
    processor dut();

    //------------------------------------------------------------------------
    // Initialize all GPRs to value 2
    //------------------------------------------------------------------------
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            dut.GPR[i] = 2;
        end
    end

    //------------------------------------------------------------------------
    // Test Cases
    //------------------------------------------------------------------------
    initial begin
        $display("==========================================================");
        $display("           32-bit Processor Testbench Results             ");
        $display("==========================================================");
        
        //--------------------------------------------------------------------
        // Test 1: ADD Immediate (ADI)
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 1;           // immemode = 1
        dut.IR[31:27] = 5'b00010; // opertype = ADD
        dut.IR[21:17] = 2;        // rsrc1 = GPR[2]
        dut.IR[26:22] = 0;        // rdst = GPR[0]
        dut.IR[15:0] = 4;         // isrc = 4
        #10;
        $display("TEST 1: ADD Immediate");
        $display("  GPR[2] + 4 = GPR[0]");
        $display("  Result: %0d + 4 = %0d", 2, dut.GPR[0]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 2: MOV Immediate (MOVI)
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 1;           // immemode = 1
        dut.IR[31:27] = 5'b00001; // opertype = MOV
        dut.IR[26:22] = 4;        // rdst = GPR[4]
        dut.IR[15:0] = 55;        // isrc = 55
        #10;
        $display("TEST 2: MOV Immediate");
        $display("  55 -> GPR[4]");
        $display("  Result: GPR[4] = %0d", dut.GPR[4]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 3: MOV Register
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 0;           // immemode = 0
        dut.IR[31:27] = 5'b00001; // opertype = MOV
        dut.IR[26:22] = 4;        // rdst = GPR[4]
        dut.IR[21:17] = 7;        // rsrc1 = GPR[7]
        #10;
        $display("TEST 3: MOV Register");
        $display("  GPR[7] -> GPR[4]");
        $display("  Result: GPR[4] = %0d", dut.GPR[4]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 4: AND Immediate
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 1;           // immemode = 1
        dut.IR[31:27] = 5'b00110; // opertype = AND
        dut.IR[21:17] = 7;        // rsrc1 = GPR[7]
        dut.IR[26:22] = 4;        // rdst = GPR[4]
        dut.IR[15:0] = 56;        // isrc = 56
        #10;
        $display("TEST 4: AND Immediate");
        $display("  GPR[7] & 56 = GPR[4]");
        $display("  Result: %8b & %8b = %8b", dut.GPR[7], 8'd56, dut.GPR[4]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 5: XOR Immediate
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 1;           // immemode = 1
        dut.IR[31:27] = 5'b00111; // opertype = XOR
        dut.IR[21:17] = 7;        // rsrc1 = GPR[7]
        dut.IR[26:22] = 4;        // rdst = GPR[4]
        dut.IR[15:0] = 56;        // isrc = 56
        #10;
        $display("TEST 5: XOR Immediate");
        $display("  GPR[7] ^ 56 = GPR[4]");
        $display("  Result: %8b ^ %8b = %8b", dut.GPR[7], 8'd56, dut.GPR[4]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 6: OR Register
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 0;           // immemode = 0
        dut.IR[31:27] = 5'b00101; // opertype = OR
        dut.IR[21:17] = 16;       // rsrc1 = GPR[16]
        dut.IR[26:22] = 0;        // rdst = GPR[0]
        dut.IR[15:11] = 4;        // rsrc2 = GPR[4]
        #10;
        $display("TEST 6: OR Register");
        $display("  GPR[16] | GPR[4] = GPR[0]");
        $display("  Result: %8b | %8b = %8b", dut.GPR[16], dut.GPR[4], dut.GPR[0]);
        $display("----------------------------------------------------------");

        //--------------------------------------------------------------------
        // Test 7: NOR Register
        //--------------------------------------------------------------------
        dut.IR = 0;
        dut.IR[16] = 0;           // immemode = 0
        dut.IR[31:27] = 5'b01010; // opertype = NOR
        dut.IR[21:17] = 16;       // rsrc1 = GPR[16]
        dut.IR[26:22] = 0;        // rdst = GPR[0]
        dut.IR[15:11] = 4;        // rsrc2 = GPR[4]
        #10;
        $display("TEST 7: NOR Register");
        $display("  ~(GPR[16] | GPR[4]) = GPR[0]");
        $display("  Result: ~(%8b | %8b) = %8b", dut.GPR[16], dut.GPR[4], dut.GPR[0]);
        $display("----------------------------------------------------------");

        $display("==========================================================");
        $display("                    Tests Complete                        ");
        $display("==========================================================");
        $finish;
    end

endmodule
