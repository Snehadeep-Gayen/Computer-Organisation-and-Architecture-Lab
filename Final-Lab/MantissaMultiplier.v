`timescale 1ns/1ns

`include "CSA.v"
//`include "Multiplexer.v"

module ManMul (
    output wire [6:0] Zm,
    output wire PM15,
    input wire [6:0] Xm, Ym
);
    // creating 1.Xm and 1.Ym
    wire [7:0] op1, op2;
    buf bb1[6:0] (op1[6:0], Xm);
    buf bb2[6:0] (op2[6:0], Ym);
    supply1 high;
    buf (op1[7], high);
    buf (op2[7], high);

    // generating answer
    wire [15:0] ans;
    CSA_unsigned_all MUL (op1, op2, ans);

    // generating PM15
    buf (PM15, ans[15]);

    // generating answer depending on PM15
    MUX m[6:0] (Zm, PM15, ans[13:7], ans[14:8]);

endmodule