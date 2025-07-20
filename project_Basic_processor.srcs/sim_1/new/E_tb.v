`timescale 1ns / 1ps

module E_tb();

    reg clk;
    reg rst;
    reg carry_in;
    reg clr_E;
    reg load_E;


    wire E;


    E_FF uut (
        .clk(clk),
        .rst(rst),
        .carry_in(carry_in),
        .clr_E(clr_E),
        .load_E(load_E),
        .E(E)
    );

   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("E_tb.vcd");
        $dumpvars(0, E_tb);
   
        rst = 1;
        carry_in = 1;
        clr_E = 0;
        load_E = 0;

        #10 rst = 0;

        // E is currently 0. Set carry_in to 1, clr_E and load_E are 0.
        #10 carry_in = 1;

        // Change carry_in to 0, still loading
        #10 carry_in = 0;

        // clr_E high, should clear E
        #10 clr_E = 1;
        carry_in = 1;
        #10;
        clr_E = 0;
        
        // carry_in should be toogled to 1
        #10 load_E = 1;
        carry_in = 0;

        //  deassert load_E
        #10 load_E = 0;
        //test priority 
        clr_E = 1;
        load_E = 1; // Both asserted
        carry_in = 1;
        #10;
        
        clr_E = 0;
        load_E = 0;
        
        
        #40;
    end

endmodule
