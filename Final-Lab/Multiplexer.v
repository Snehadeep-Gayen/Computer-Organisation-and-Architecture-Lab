`ifndef MULTIPLEXER
`define MULTIPLEXER
`timescale 1ns/100ps

module MUX (
    output wire res, 
    input wire  sel, s0, s1
);
    not (selbar, sel);
    and (t0, s0, selbar);
    and (t1, s1, sel);
    or (res, t0, t1);
endmodule

module MUX4 (
    output wire res,
    input wire [1:0] sel,
    input wire [3:0] in
);
    MUX m1(ans1, sel[0], in[0], in[1]);
    MUX m2(ans2, sel[0], in[2], in[3]);
    MUX m3(res, sel[1], ans1, ans2);
endmodule

module MUX8 (
    output wire res,
    input wire [2:0] sel,
    input wire [7:0] in 
);
    MUX4 m1(ans1, sel[1:0], in[3:0]);
    MUX4 m2(ans2, sel[1:0], in[7:4]);
    MUX m3(res, sel[2], ans1, ans2);
endmodule

`endif 