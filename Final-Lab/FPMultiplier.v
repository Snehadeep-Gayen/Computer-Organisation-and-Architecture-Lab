`timescale 1ns/100ps

`include "ExponentAdder.v"
`include "MantissaMultiplier.v"

module FloatingPointMultiplier(A,B,result,overflow);

    input[11:0] A,B;
    output[11:0] result;
    output overflow;
    
    xor x1(result[11], A[11], B[11]);

    wire PM15;

    ManMul M1(result[6:0], PM15, A[6:0], B[6:0]);
    ExpAdder E1(result[10:7], overflow, A[10:7], B[10:7], PM15);
    

endmodule