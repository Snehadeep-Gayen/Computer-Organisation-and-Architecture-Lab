`timescale 1ns/1ns
`include "RegisterFile.v"
`include "ALU.v"

module CPU(
    input wire [11:0] instruction
);
    reg clk;
    reg [2:0] read1Addr;
    reg we;
    reg [2:0] read2Addr;
    reg [2:0] writeAddr;
    reg [11:0] writeData;
    wire [11:0] readData1;
    wire [11:0] readData2;
    RegisterFile r(clk, we, read1Addr, read2Addr, writeAddr, writeData, readData1, readData2);
    wire [2:0] opcode = instruction[11:9];
    wire [11:0] result;
    ALU a(opcode, readData1, readData2, result);
    initial begin
        
            clk = 0;
            writeAddr = 0;
            writeData = 3;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 1;
            writeData = 4;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 2;
            writeData = 5;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 3;
            writeData = 6;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 4;
            writeData = 7;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 5;
            writeData = 8;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 6;
            writeData = 9;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
            
            #20
            clk = 0;
            writeAddr = 7;
            writeData = 10;
            we = 1;
            read1Addr = 1;
            read1Addr = 2;
            clk = 1;
    end

    always @(instruction)
        begin
            #200

            // #1
            clk = 0;
            writeAddr = instruction[8:6];
            read1Addr = instruction[5:3];
            read2Addr = instruction[2:0];
            // #1
            clk = 1;
            // #1
            // operand1 = readData1;
            // operand2 = readData2;
            // #1
            writeData = result;
            // #1
            clk = 0;
            // #1
            clk = 1;            
        end
endmodule