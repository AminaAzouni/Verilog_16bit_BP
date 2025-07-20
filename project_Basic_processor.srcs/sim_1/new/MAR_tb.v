// tb_MAR.v
`timescale 1ns / 1ps

module MAR_tb();
    reg clk;
    reg rst;
    reg [11:0] addr_in;
    reg load_MAR;

    wire [11:0] addr_out;

    MAR uut(
        .clk(clk),
        .rst(rst),
        .addr_in(addr_in),
        .load_MAR(load_MAR),
        .addr_out(addr_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        // Dump for GTKWave
        $dumpfile("MAR_tb.vcd");
        $dumpvars(0, MAR_tb);

        rst = 1;
        addr_in = 12'hFFF;
        load_MAR = 0;
        #20;
        
        rst = 0;

        addr_in = 12'h123;
        load_MAR = 1;
        #10; 
        
        #10; 
        load_MAR = 0; 

        addr_in = 12'hABC;
        #30;

        addr_in = 12'hDEF;
        load_MAR = 1;
        #10;

        load_MAR = 0;
       
        #50; 
    
    end

endmodule