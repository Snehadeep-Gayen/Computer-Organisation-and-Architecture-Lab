`timescale 1ns/1ns

module BarrelShift(result, inp, diff);

    input wire[7:0] inp;
    input wire[2:0] diff;
    output wire[7:0] result;
    supply1 one;
    supply0 zero;

    wire [7:0] mint [7:0];

    buf b5[7:0] (mint[0], inp);

    buf b19 (mint[1][7], zero);
    buf b6[6:0] (mint[1][6:0], inp[7:1]);

    buf b7[1:0] (mint[2][7:6], zero);
    buf b8[5:0] (mint[2][5:0], inp[7:2]);

    buf b9[2:0] (mint[3][7:5], zero);
    buf b10[4:0] (mint[3][4:0], inp[7:3]);

    buf b11[3:0] (mint[4][7:4], zero);
    buf b12[3:0] (mint[4][3:0], inp[7:4]);

    buf b13[4:0] (mint[5][7:3], zero);
    buf b14[2:0] (mint[5][2:0], inp[7:5]);

    buf b15[5:0] (mint[6][7:2], zero);
    buf b16[1:0] (mint[6][1:0], inp[7:6]);

    buf b17[6:0] (mint[7][7:1], zero);
    buf b18[0:0] (mint[7][0:0], inp[7:7]);

    //MUX8 m31 [7:0] (result[7:0], diff[2:0], [7:0]mint[7:0]);
	MUX8 M30 (result[0], diff[2:0], mint[0]);
	MUX8 M31 (result[1], diff[2:0], mint[1]);
	MUX8 M32 (result[2], diff[2:0], mint[2]);
	MUX8 M33 (result[3], diff[2:0], mint[3]);
	MUX8 M34 (result[4], diff[2:0], mint[4]);
	MUX8 M35 (result[5], diff[2:0], mint[5]);
	MUX8 M36 (result[6], diff[2:0], mint[6]);
	MUX8 M37 (result[7], diff[2:0], mint[7]);

endmodule