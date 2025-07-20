`timescale 1ns / 1ps

module Shift_reg_ti_tb;

    // Inputs
    reg clk;
    reg rst;
    reg En;
    reg exe_done;

    // Output
    wire [3:0] t;

    // Instantiate the Unit Under Test (UUT)
    Shift_reg_ti uut (
        .clk(clk),
        .rst(rst),
        .En(En),
        .exe_done(exe_done),
        .t(t)
    );

   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        clk = 0;
        rst = 1;
        En = 0;
        exe_done = 0;

        // Apply global reset
        #10;
        rst = 0;

        // Enable shifting (should start from t0 = 4'b0001)
        En = 1;
        #40;  // Allow a few clock cycles to shift through t1, t2, t3

        // stop shifting
        exe_done = 1;
        #20;

        // Deassert exe_done 
        exe_done = 0;
        #20;

    end

endmodule
