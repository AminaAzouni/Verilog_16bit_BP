`timescale 1ns / 1ps

module AC_tb;

    reg clk;
    reg rst;
    reg [7:0] INRP_in;
    reg [15:0] ac_in;
    reg sel_source;
    reg load_ac;
    wire [15:0] AC_out;

    AC uut (
        .clk(clk),
        .rst(rst),
        .INRP_in(INRP_in),
        .ac_in(ac_in),
        .sel_source(sel_source),
        .load_ac(load_ac),
        .AC_out(AC_out)
    );

   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Dump for GTKWave
        $dumpfile("AC_tb.vcd");
        $dumpvars(0, AC_tb);

        // Initialization
        rst = 1;
        INRP_in = 8'h00;
        ac_in = 16'h0000;
        sel_source = 0;
        load_ac = 0;

        #10 rst = 0;

        // Test 1: Load from INPR (sel_source = 0)
        #10 INRP_in = 8'h55;
            ac_in = 16'hABCD;
            sel_source = 0;
            load_ac = 1;
        #10 load_ac = 0;

        // Test 2: Load from ALU (sel_source = 1)
        #10 ac_in = 16'hABCD;
            INRP_in = 8'h54;
            sel_source = 1;
            load_ac = 1;
        #10 load_ac = 0;

        // Test 3: sel_source = 0 again, overwrite lower 8 bits only
        #10 INRP_in = 8'hF0;
            sel_source = 0;
            load_ac = 1;
        #10 load_ac = 0;

        // Test 4: No load_ac active (output should remain unchanged)
        #10 INRP_in = 8'hAA;
            ac_in = 16'hDEAD;
            sel_source = 1;
            load_ac = 0;

        #20; 
    end

endmodule
