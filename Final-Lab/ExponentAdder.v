`timescale 1ns/1ns

//`include "Adder.v"
//`include "Subtractor.v"

module ExpAdder (
    output wire [3:0] Ze,
    output wire overflow,
    input wire [3:0] Xe, Ye,
    input wire PM15
);
    supply0 low;
    supply1 high;

    // adding both exponents
    wire [4:0] intermediate_sum;
    RCA4bit add1 (intermediate_sum[3:0], intermediate_sum[4], Xe, Ye, low);
    
    // subtracting bias
    wire [4:0] bias;
    buf (bias[4], low);
    buf (bias[3], low);
    buf (bias[2], high);
    buf (bias[1], high);
    buf (bias[0], high);

    // generating Ze
    wire [4:0] tempZe1;
    RBS5bit sub1 (tempZe1, borrow_out, intermediate_sum[4:0], bias[4:0], low);

    
    // subtracting bias-1
    wire [4:0] biasminus1;
    buf (biasminus1[4], low);
    buf (biasminus1[3], low);
    buf (biasminus1[2], high);
    buf (biasminus1[1], high);
    buf (biasminus1[0], low);

    // generating Ze
    wire [4:0] tempZe2;
    RBS5bit sub2 (tempZe2, borrow_out, intermediate_sum[4:0], biasminus1[4:0], low);

    wire [4:0] tempZe;
    MUX mm[4:0] (tempZe, PM15, tempZe1, tempZe2);

    // answer
    buf bb[3:0] (Ze, tempZe[3:0]);
    
    // generating overflow (when answer is negative, answer is zero 
    // or answer is greater than or equal to 15)
    or (notsubnormal, tempZe[0], tempZe[1], tempZe[2], tempZe[3]);
    not (subnormal, notsubnormal);

    and (notinfinityorNan, tempZe[0], tempZe[1], tempZe[2], tempZe[3]);
    buf (infinityorNaN, notinfinityorNan);
    
    or (overflow, borrow_out, tempZe[4], subnormal, infinityorNaN);
endmodule