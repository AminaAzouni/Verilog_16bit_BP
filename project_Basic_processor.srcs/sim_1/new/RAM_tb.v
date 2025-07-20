`timescale 1ns / 1ps

module RAM_tb();

    reg clk;
    reg rst;
    reg [11:0] addr;
    reg [15:0] data;
    reg RD;
    reg WR;
    wire [15:0] read_data;

    RAM uut(
        .clk(clk),
        .rst(rst),
        .addr(addr),
        .data(data),
        .RD(RD),
        .WR(WR),
        .read_data(read_data)
    );

   initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Dump for GTKWave
        $dumpfile("RAM_tb.vcd");
        $dumpvars(0, RAM_tb);

        clk = 0;
        rst = 1;
        addr = 0;
        data = 0;
        RD = 0;
        WR = 0;

        #10 rst = 0;

        addr = 12'h000;
        RD = 1;
        #10;
        RD = 0;

        addr = 12'h001;
        RD = 1;
        #10;
        RD = 0;
    
        addr = 12'h101;
        RD=1;
        #10;
        RD=0;
        
        addr = 12'h101;
        data = 16'h0003;
        WR = 1;
        #10;
        WR = 0;
    
        addr = 12'h101;
        RD=1;
        #10;
        RD=0;
        
        addr = 12'h100;
        RD = 1;
        #10;
        RD = 0;

        #20;
    end

endmodule
