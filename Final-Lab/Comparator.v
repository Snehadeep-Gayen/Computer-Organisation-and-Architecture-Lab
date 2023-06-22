`timescale 1ns/100ps

module Comparator(A,B,result);
	input[7:0] A,B;
	output[7:0] result;
	xor x[7:0](result,A,B);
endmodule