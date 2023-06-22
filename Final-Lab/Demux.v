`include "Decoder.v"

module Demux(
	input [2:0] inp,
    input sel,
	output [7:0] result
);

    wire[7:0] interm;
    wire[7:0] result;

    Decoder myDec1(inp[2:0], interm[7:0]);
    and myAnd2[7:0] (result[7:0], interm[7:0], sel);

endmodule