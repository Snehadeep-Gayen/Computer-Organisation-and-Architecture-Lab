`timescale 1ns/100ps

//`include "Subtractor.v"
`include "Multiplexer.v"

module ExpDiff(
    output wire XeLTYe, 
    output wire [3:0] XeminusYe,
    input wire [3:0] Xe, Ye
);
    input wire [3:0] diff1, diff2;

    supply0 __low;
    buf(low, __low);

    RBS4bit r1 (diff1, XeLTYe, Xe, Ye, low);
    RBS4bit r2 (diff2, temp, Ye, Xe, low);

    MUX m [3:0] (XeminusYe, XeLTYe, diff1, diff2);
endmodule
