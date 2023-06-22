`timescale 1ns/1ns
`include "RegisterFile.v"
module DFFtb();
    reg d;
    wire p;
    reg clk;

    DFF myd (clk, d, p);

    initial
        begin

            $dumpfile("DFF_tb.vcd");
            $dumpvars(0, DFFtb);

            clk = 0;
            d = 1;
            #20
            clk = 1;
            #20
            clk = 0;
            d = 0;
            #20
            clk = 1;
            #20
            $finish;
        end

endmodule