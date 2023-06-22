`timescale 1ns/1ns

module MantissaAdder(Sm, Pm, Qm, MAS);

    input[7:0] Pm, Qm;
    input MAS;
    output[8:0] Sm;
    supply0 zero;

    wire[8:0] sum, diff;
    wire cout, bout;

    RCA8bit RC(sum[7:0], cout, Pm[7:0], Qm[7:0], zero);
    RBS8bit RB(diff[7:0], bout, Pm[7:0], Qm[7:0], zero);

    buf b1(sum[8], cout);
    buf b2(diff[8], zero);

    MUX m[8:0] (Sm[8:0], MAS, sum[8:0], diff[8:0]);

endmodule