`ifndef DECODER
`define DECODER
module Decoder(
	input [2:0] inp,
	output [7:0] result
	);

    wire[2:0] inpBar;
    not n[2:0] (inpBar, inp);

    and a0(result[0], inpBar[2], inpBar[1], inpBar[0]);
    and a1(result[1], inpBar[2], inpBar[1], inp[0]);
    and a2(result[2], inpBar[2], inp[1], inpBar[0]);
    and a3(result[3], inpBar[2], inp[1], inp[0]);
    and a4(result[4], inp[2], inpBar[1], inpBar[0]);
    and a5(result[5], inp[2], inpBar[1], inp[0]);
    and a6(result[6], inp[2], inp[1], inpBar[0]);
    and a7(result[7], inp[2], inp[1], inp[0]);

endmodule
`endif 