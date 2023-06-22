`include "Adder.v"
`include "Subtractor.v"
`include "UnsignedMultiplier.v"
`include "SignedMultiplier.v"
`include "FPAdder.v"
`include "FPMultiplier.v"
`include "Comparator.v"
`include "Decoder.v"

`timescale 1ns/100ps

module ALU
(
	input wire[2:0] opcode,
	input wire[11:0] operand1,
	input wire[11:0] operand2,
	output wire[11:0] out
);

	wire[7:0] select;
	Decoder Dec(opcode[2:0], select[7:0]);
	
	wire[11:0] Addition;
	wire[11:0] Subtraction;
	wire[11:0] UnsignedMultiplication;
	wire[11:0] SignedMultiplication;
	wire[11:0] FPAddition;
	wire[11:0] FPMultiplication;
	wire[11:0] Comparison;
	
	wire[11:0] sAddition;
	wire[11:0] sSubtraction;
	wire[11:0] sUnsignedMultiplication;
	wire [11:0] sSignedMultiplication;
	wire [11:0] sFPAddition;
	wire[11:0] sFPMultiplication;
	wire[11:0] sComparison;
	wire[11:0] sNoChange;
	
	supply0 __low;
	buf(low,__low);
	wire carry;
	RCA8bit ADD(Addition[7:0],carry, operand1[7:0], operand2[7:0], low);
	buf B1[3:0](Addition[11:8],Addition[7]);
	
	wire borrow;
	RBS8bit SUB(Subtraction[7:0],borrow,operand1[7:0], operand2[7:0], low);
	buf B2[3:0](Subtraction[11:8], Subtraction[7]);
	
	wire ovflow1;
	CSA_unsigned SMultiplier(operand1[7:0], operand2[7:0], UnsignedMultiplication[7:0], ovflow1);
	buf B3[3:0](UnsignedMultiplication[11:8], __low);
	
	wire ovflow2;
	CSA_signed USMultiplier(operand1[7:0], operand2[7:0], SignedMultiplication[7:0], ovflow2);
	buf B4[3:0](SignedMultiplication[11:8], SignedMultiplication[7]);
	
	FPAdd FPAdder(operand1[11:0],operand2[11:0],low, FPAddition);

	wire ovflow3;
	FloatingPointMultiplier FPMultiplier(operand1,operand2, FPMultiplication, ovflow3);
	
	Comparator Compare(operand1[7:0], operand2[7:0], Comparison[7:0]);
	buf B5[3:0](Comparison[11:8], __low);
	
	and A0[11:0](sNoChange, select[0], operand1);
	and A1[11:0](sAddition, select[1],Addition);
	and A2[11:0](sSubtraction, select[2], Subtraction);
	and A3[11:0](sUnsignedMultiplication, select[3], UnsignedMultiplication);
	and A4[11:0](sSignedMultiplication, select[4], SignedMultiplication);
	and A5[11:0](sFPAddition, select[5], FPAddition);
	and A6[11:0](sFPMultiplication, select[6], FPMultiplication);
	and A7[11:0](sComparison, select[7], Comparison);
	
	or FINAL[11:0](out, sAddition,sSubtraction,sUnsignedMultiplication,sSignedMultiplication,sFPAddition,sFPMultiplication,sComparison,sNoChange);
	
	
	
endmodule
