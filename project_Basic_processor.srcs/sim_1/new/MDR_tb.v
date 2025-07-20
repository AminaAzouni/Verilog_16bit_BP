// tb_MDR.v
`timescale 1ns / 1ps

module MDR_tb();

    reg clk;
    reg rst;
    reg [15:0] data_in;
    reg load_MDR;

    wire [15:0] data_out;

    MDR uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .load_MDR(load_MDR),
        .data_out(data_out)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
       // Dump for GTKWave
        $dumpfile("MDR_tb.vcd");
        $dumpvars(0, MDR_tb);

        // Initialization
        rst = 1;
        data_in = 16'hFFFF;
        load_MDR = 0;
        #20; 
        rst = 0;

        data_in = 16'hABCD;
        load_MDR = 1;
        #10;

        #10; 
        load_MDR = 0; 

        data_in = 16'h1111; 
        #30;
        
        data_in = 16'h5555;
        load_MDR = 1;
        #10;
        
        load_MDR = 0;
        
        #50;
    end

endmodule