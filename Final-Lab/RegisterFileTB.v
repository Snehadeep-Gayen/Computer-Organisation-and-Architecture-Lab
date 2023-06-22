`timescale 1ns/1ns
`include "RegisterFile.v"

module Register_tb();
    reg clk;
    reg we;
    reg [2:0] read1Addr;
    reg [2:0] read2Addr;
    reg [2:0] writeAddr;
    reg [11:0] writeData;
    wire [11:0] readData1;
    wire [11:0] readData2;
    RegisterFile r(clk, we, read1Addr, read2Addr, writeAddr, writeData, readData1, readData2);

    initial begin
        
        $dumpfile("Register_tb.vcd");
        $dumpvars(0, Register_tb);

        clk = 0;
        we = 1;
        read1Addr = 0;
        read2Addr = 1;
        writeAddr = 2;
        writeData = 2;

        #20

        clk = 1;

        #20

        clk = 0;
        we = 1;
        read1Addr = 2;
        read2Addr = 1;
        writeAddr = 0;
        writeData = 0;

        #20

        clk = 1;

        #20

        clk = 0;
        we = 1;
        read1Addr = 0;
        read2Addr = 2;
        writeAddr = 1;
        writeData = 1;

        #20

        clk = 1;

        #20

        $finish;
    end

endmodule