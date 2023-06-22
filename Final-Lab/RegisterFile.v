`timescale 1ns/1ns
`include "Multiplexer.v"
`include "Demux.v"
module Registers (
    input wire clk,
    input [2:0] read1Addr,
    input [2:0] read2Addr,
    input [2:0] writeAddr,
    input [11:0] writeData,
    output wire [11:0] readData1,
    output wire [11:0] readData2
);
    reg [11:0] myreg [7:0];
    initial 
        begin
            myreg[0] = 30;
            myreg[1] = 40;
            myreg[5] = 12'b010111000000;
            myreg[6] = 12'b001111000000;
            // 010111001100 is the result
        end
    reg [11:0] tempReadData1;
    reg [11:0] tempReadData2;
    always @(posedge clk)
        begin
            myreg[writeAddr] <= writeData;
            tempReadData1 <= myreg[read1Addr];
            tempReadData2 <= myreg[read2Addr];
        end
    assign readData1 = tempReadData1;
    assign readData2 = tempReadData2;
endmodule

//  d flip flop
module DFF (
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) 
        begin
            q <= d;
        end
    
    always @(negedge clk)
        begin
            q <= d;
        end
endmodule

module Register (
    input wire clk,
    input wire we,
    input wire [11:0] data,
    output wire [11:0] out
);
    wire myclk;
    and (myclk, clk, we);
    DFF d [11:0] (myclk, data, out);
endmodule

module RegisterFile (
    input wire clk,
    input wire we,
    input [2:0] read1Addr,
    input [2:0] read2Addr,
    input [2:0] writeAddr,
    input [11:0] writeData,
    output wire [11:0] readData1,
    output wire [11:0] readData2
);
    wire [7:0] we_all;

    Demux d (writeAddr, we, we_all);

    wire [7:0][11:0] val;
    Register myreg [7:0] (clk, we_all, writeData, val);

    MUX8 m1 [11:0] (readData1, read1Addr, val);
    MUX8 m2 [11:0] (readData2, read2Addr, val);
endmodule
