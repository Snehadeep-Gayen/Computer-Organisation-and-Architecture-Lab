`ifndef SUBTRACTOR
`define SUBTRACTOR
`timescale 1ns/100ps

module fullsubtractor (
    output wire diff, bout, /*p, g,*/
    input wire a, b, bin
);
    xor (diff, a, b, bin);
    not (abar, a);
    not (bbar, b);
    not (binbar, bin);
    and (g, abar, b);
    and (abarbin, abar, bin);
    and (binb, bin, b);
    or (bout, binb, g, abarbin);
    or (p, abar, b);

endmodule

module RBS8bit (
    output wire [7:0] ans,
    output wire borrow,
    input wire [7:0] X, Y, 
    input wire bin
);
    wire [8:0] intermediate_borrows;
    buf (intermediate_borrows[0], bin);
    fullsubtractor f[7:0] (ans[7:0], intermediate_borrows[8:1], X[7:0], Y[7:0], intermediate_borrows[7:0]); 
    buf(borrow, intermediate_borrows[8]);
endmodule


module RBS5bit (
    output wire [4:0] ans,
    output wire borrow,
    input wire [4:0] X, Y, 
    input wire bin
);
    wire [5:0] intermediate_borrows;
    buf (intermediate_borrows[0], bin);
    fullsubtractor f[4:0] (ans[4:0], intermediate_borrows[5:1], X[4:0], Y[4:0], intermediate_borrows[4:0]);
    buf(borrow, intermediate_borrows[5]);
endmodule

module RBS4bit (
    output wire [3:0] ans,
    output wire borrow,
    input wire [3:0] X, Y, 
    input wire bin
);
    wire [4:0] intermediate_borrows;
    buf (intermediate_borrows[0], bin);
    fullsubtractor f[3:0] (ans[3:0], intermediate_borrows[4:1], X[3:0], Y[3:0], intermediate_borrows[3:0]); 
    buf(borrow, intermediate_borrows[4]);
endmodule

`endif