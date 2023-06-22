`timescale 1ns/100ps
//`include "Multiplexer.v"
//`include "Subtractor.v"
`include "BarrelShift.v"
//`include "Adder.v"

module NormandExpGen (
    output wire [3:0] Ze,
    output wire [6:0] Zm,
    input wire XeLTYe,
    input wire [3:0] Xe, Ye,
    input wire [8:0] sum
);
    wire [3:0] Ge, GePlus;
    MUX m[3:0] (Ge, XeLTYe, Xe, Ye);

    // supply1 __high;
    supply0 __low;
    // buf (high, __high);
    buf (low, __low);
    wire [3:0] all_low;
    buf pullitdown [3:0] (all_low, low);
    RCA4bit r (GePlus, temp_cout, Ge, all_low, sum[8]);

    wire [3:0] LDZshift;
    buf low__ [3:0] (LDZshift[3:0], low);
    wire [7:0] BarrelOut;
    // PEncoder P (sum[7:0], LDZshift[2:0]);

    BarrelShift BB(BarrelOut, sum[7:0], LDZshift[2:0]);

    MUX mm [6:0] (Zm, sum[8], BarrelOut[6:0], sum[7:1]);

    wire [3:0] Ze_temp;
    RBS4bit RR (Ze_temp, temp_borrow, Ge, LDZshift, low);
    MUX mm2 [3:0] (Ze, sum[8], Ze_temp, GePlus);
endmodule