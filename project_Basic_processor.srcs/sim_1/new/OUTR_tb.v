`timescale 1ns / 1ps

module OUTR_tb();

    // Testbench signals
    reg clk;
    reg rst;
    reg load_OUTR;
    reg [7:0] OUTR_in;
    wire [7:0] OUTR_out;

    // Instantiate the DUT (Device Under Test)
    OUTR uut (
        .clk(clk),
        .rst(rst),
        .load_OUTR(load_OUTR),
        .OUTR_in(OUTR_in),
        .OUTR_out(OUTR_out)
    );
    
   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Dump for GTKWave
        $dumpfile("OUTR_tb.vcd");
        $dumpvars(0, OUTR_tb);

        // Initial reset
        rst = 1;
        load_OUTR = 0;
        OUTR_in = 8'b00000000;

        #10 rst = 0; // Deassert reset

        // Try to write while load_OUTR is 0 (should not change OUTR_out)
        OUTR_in = 8'b11110000;
        load_OUTR = 0;

        #10 load_OUTR = 1; // Load data
        #10 load_OUTR = 0; // Stop loading

        #10 OUTR_in = 8'b01010101; // Change input
         load_OUTR = 1; // Load new data
        load_OUTR = 0;

        // Reset again
        #10 rst = 1;
        #10 rst = 0;

        #10;
    end

endmodule
