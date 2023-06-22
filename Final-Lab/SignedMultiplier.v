`timescale 1ns/100ps

//`include "Adder.v"

/*module reducer3to2unsigned (
    output wire [15:0] carry, sum,
    input wire [15:0] A, B, C
);
    wire [15:0] carry_temp;
    FullAdder f [15:0] (carry_temp, sum, A, B, C);
    buf b[14:0] (carry[15:1], carry_temp[14:0]);
    supply0 s;
    buf (carry[0], s);
endmodule*/

module CSA_signed (
    input wire [7:0] X, Y,
    output wire [7:0] Z,
    output wire overflow
);
    wire [15:0] s0[8:0], s1[5:0], s2[3:0], s3[2:0], s4[1:0];
    // pulldown pull [15:0][7:0] (s0);
    wire sign;
    supply1 sss;
    buf (sign, sss);

    // pulling down all values to zero
    genvar i;
    for(i = 0; i <= 8; i = i + 1)
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
    // seventh partial product
    wire [7:0] temp;
    and a7 [7:0] (temp, X[7:0], Y[7]);
    xor n0 [7:0] (s0[7][14:7], temp, sign);
    // carry partial product
    buf (s0[8][7], sign);

    // extending the sign bit of each partial product
    buf b0 [7:0] (s0[0][15:8], s0[0][7]);
    buf b1 [6:0] (s0[1][15:9], s0[1][8]);
    buf b2 [5:0] (s0[2][15:10], s0[2][9]);
    buf b3 [4:0] (s0[3][15:11], s0[3][10]);
    buf b4 [3:0] (s0[4][15:12], s0[4][11]);
    buf b5 [2:0] (s0[5][15:13], s0[5][12]);
    buf b6 [1:0] (s0[6][15:14], s0[6][13]);
    buf (s0[7][15], s0[7][14]);

    // level 0 
    reducer3to2unsigned r01 (s1[0], s1[1], s0[0], s0[1], s0[2]);
    reducer3to2unsigned r02 (s1[2], s1[3], s0[3], s0[4], s0[5]);
    reducer3to2unsigned r03 (s1[4], s1[5], s0[6], s0[7], s0[8]);

    // level 1
    reducer3to2unsigned r11 (s2[0], s2[1], s1[0], s1[1], s1[2]);
    reducer3to2unsigned r12 (s2[2], s2[3], s1[3], s1[4], s1[5]);

    // level 2
    reducer3to2unsigned r21 (s3[0], s3[1], s2[0], s2[1], s2[2]);
    buf bb2[15:0] (s3[2], s2[3]);

    // level 3
    reducer3to2unsigned r31 (s4[0], s4[1], s3[0], s3[1], s3[2]);

    wire [15:0] ans;
    wire ov;
    supply0 s;

    CLA16_higher C (ans[15:0], ov, s4[0][15:0], s4[1][15:0], s, s);
    // CLA_NoHigher C (ans[15:0], ov, s4[0][15:0], s4[1][15:0], s, s);

    buf bb[7:0] (Z, ans[7:0]);

    // overflow

    //signed overflow
    wire bothsame, bothdiff;
    xnor (bothsame, X[7], Y[7]);
    xor (bothdiff, X[7], Y[7]);
    wire bothsameterm, bothdiffterm;
    or (bothsameterm, ans[7], ans[8], ans[9], ans[10], ans[11], ans[12], ans[13], ans[14], ans[15]);
    
    not (notans7, ans[7]);
    not (notans8, ans[8]);
    not (notans9, ans[9]);
    not (notans10, ans[10]);
    not (notans11, ans[11]);
    not (notans12, ans[12]);
    not (notans13, ans[13]);
    not (notans14, ans[14]);
    not (notans15, ans[15]);

    or (bothdiffterm, notans7, notans8, notans9, notans10, notans11, notans12, notans13, notans14, notans15);
    
    and (term11, bothsame, bothsameterm);
    and (term22, bothdiff, bothdiffterm);

    or (overflow, term11, term22);
    
endmodule