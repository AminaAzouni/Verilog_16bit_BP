`timescale 1ns / 1ps

module ALU_tb();

    reg [15:0] a;
    reg [15:0] b;
    reg [2:0] sel_op;
    reg carry_e;
    wire [15:0] alu_result;
    wire carry_s;

    ALU uut (
        .a(a),
        .b(b),
        .sel_op(sel_op),
        .alu_result(alu_result),
        .carry_e(carry_e),
        .carry_s(carry_s)
    );

    initial begin
        // Create dump for GTKWave
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);
        
                 
        // 1. Test AND
        a = 16'hFFFF; b = 16'h0F0F; sel_op = 3'b000; carry_e = 0;
        #10;

        // 2. Test ADD without carry_e
        a = 16'h00FF; b = 16'h0001; sel_op = 3'b001; carry_e = 0;
        #10;

        // 3. Test ADD with carry_e = 1
        a = 16'h00FF; b = 16'h0001; sel_op = 3'b001; carry_e = 1;
        #10;

        // 4. Test NOT
        a = 16'hAAAA; b = 0; sel_op = 3'b010; carry_e = 0;
        #10;

        // 5. Test a - 1
        a = 16'h0000; sel_op = 3'b011;
        #10;

        // 6. Test b - 1
        b = 16'h0000; sel_op = 3'b100;
        #10;

        // 7. Test pass b
        b = 16'h1234; sel_op = 3'b101;
        #10;

        // 8. Test increment a
        a = 16'hFFFF; sel_op = 3'b110;
        #10;

        // 9. Test MAZ (reset)
        sel_op = 3'b111;
        #10;

    end

endmodule