`timescale 1ns/100ps

//`include "Adder.v"

module CSA (
    input wire [7:0] X, Y,
    input wire sign,
    output wire [7:0] result,
    output wire overflow
);
    wire [7:0] unRes, siRes, res1, res2;
    CSA_unsigned Cun (X, Y, unRes, unOv);
    CSA_signed Csi (X, Y, siRes, siOv);
    not (signBar, sign);

    and (ov1, unOv, signBar);
    and (ov2, siOv, sign);
    or (overflow, ov1, ov2);

    and aa1[7:0] (res1, unRes, signBar);
    and aa2[7:0] (res2, siRes, sign);
    or  oo[7:0] (result, res1, res2);
endmodule


module CSA_unsigned_all (
    input wire [7:0] X, Y,
    output wire [15:0] Z
    // output wire overflow
);
    wire [15:0] s0[7:0], s1[5:0], s2[3:0], s3[2:0], s4[1:0];

    // pulling down all values to zero
    genvar i;
    for(i = 0; i < 8; i = i + 1)
        pulldown p [15:0] (s0[i]);
    for(i = 0; i < 6; i = i + 1)
        pulldown p [15:0] (s1[i]);
    for(i = 0; i < 4; i = i + 1)
        pulldown p [15:0] (s2[i]);
    for(i = 0; i < 3; i = i + 1)
        pulldown p [15:0] (s3[i]);
    for(i = 0; i < 2; i = i + 1)
        pulldown p [15:0] (s4[i]);
    
    // generating partial products
    and a0 [7:0] (s0[0][7:0], X[7:0], Y[0]);
    and a1 [7:0] (s0[1][8:1], X[7:0], Y[1]);
    and a2 [7:0] (s0[2][9:2], X[7:0], Y[2]);
    and a3 [7:0] (s0[3][10:3], X[7:0], Y[3]);
    and a4 [7:0] (s0[4][11:4], X[7:0], Y[4]);
    and a5 [7:0] (s0[5][12:5], X[7:0], Y[5]);
    and a6 [7:0] (s0[6][13:6], X[7:0], Y[6]);
    and a7 [7:0] (s0[7][14:7], X[7:0], Y[7]);

    // level 0 
    reducer3to2unsigned r01 (s1[0], s1[1], s0[0], s0[1], s0[2]);
    reducer3to2unsigned r02 (s1[2], s1[3], s0[3], s0[4], s0[5]);
    buf b0[15:0] (s1[4], s0[6]);
    buf b1[15:0] (s1[5], s0[7]);

    // level 1
    reducer3to2unsigned r11 (s2[0], s2[1], s1[0], s1[1], s1[2]);
    reducer3to2unsigned r12 (s2[2], s2[3], s1[3], s1[4], s1[5]);

    // level 2
    reducer3to2unsigned r21 (s3[0], s3[1], s2[0], s2[1], s2[2]);
    buf b2[15:0] (s3[2], s2[3]);

    // level 3
    reducer3to2unsigned r31 (s4[0], s4[1], s3[0], s3[1], s3[2]);

    wire [15:0] ans;
    wire ov;
    supply0 s;

    CLA16_higher C (ans[15:0], ov, s4[0][15:0], s4[1][15:0], s, s);
    // CLA_NoHigher C (ans[15:0], ov, s4[0][15:0], s4[1][15:0], s, s);

    buf bb[15:0] (Z, ans);

    // overflow

    // unsigned overflow
    // or (overflow, ans[8], ans[9], ans[10], ans[11], ans[12], ans[13], ans[14], ans[15]);
    
endmodule