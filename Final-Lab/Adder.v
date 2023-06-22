
`timescale 1ns/100ps

module HalfAdder(
	output wire carry, sum,
	input wire a, b
);
	xor (sum, a, b);
	and (carry, a, b);
endmodule

module FullAdder(
	output carry, sum,
	input a, b, c
);
	xor (sum, a, b, c);
	and (ab, a, b);
	and (bc, b, c);
	and (ca, c, a);
	or (carry, ab, bc, ca);
endmodule

module RCA4bit (
	output wire [3:0] ans,
	output wire cout,
	input wire [3:0] A, B,
	input wire cin
);
	wire [4:0] intermediate_carry;
	buf (intermediate_carry[0], cin);
	FullAdder f[3:0] (intermediate_carry[4:1], ans, A, B, intermediate_carry[3:0]);
	buf (cout, intermediate_carry[4]);
endmodule

module RCA8bit (
	output wire [7:0] ans,
	output wire cout,
	input wire [7:0] A, B,
	input wire cin
);
	wire [8:0] intermediate_carry;
	buf (intermediate_carry[0], cin);
	FullAdder f[7:0] (intermediate_carry[8:1], ans, A, B, intermediate_carry[7:0]);
	buf (cout, intermediate_carry[8]);
endmodule


module CLA16_higher(sum,overF,A,B,sub,sign);
	input wire [15:0] A;
	input wire [15:0] B;
	input sub;
	input sign;
	output wire [15:0] sum;
	output overF;
	
	wire[15:0] op3;

	xor XOR_op[15:0](op3,B,sub);
	wire[3:0] carry;
	wire Cin;
	buf(Cin,sub);
	wire[15:0] p;
	wire[15:0] g;
	and And[15:0](g[15:0],A[15:0],op3[15:0]);
	xor XOR[15:0](p[15:0],A[15:0],op3[15:0]);
	
	and(p0I,p[3],p[2],p[1],p[0]);
	and(p1I,p[7],p[6],p[5],p[4]);
	and(p2I,p[11],p[10],p[9],p[8]);
	and(p3I,p[15],p[14],p[13],p[12]);
	
	and(p3p2p1g0,p[3],p[2],p[1],g[0]);
	and(p3p2g1,p[3],p[2],g[1]);
	and(p3g2,p[3],g[2]);
	and(g0I,p3p2p1g0,p3p2g1,p3g2,g[3]);
	
	and(p7p6p5g4,p[7],p[6],p[5],g[4]);
	and(p7p6g5,p[7],p[6],g[5]);
	and(p7g6,p[7],g[6]);
	and(g1I,p7p6p5g4,p7p6g5,p7g6,g[7]);
	
	and(p11p10p9g8,p[11],p[10],p[9],g[8]);
	and(p11p10g9,p[11],p[10],g[9]);
	and(p11g10,p[11],g[10]);
	and(g2I,p11p10p9g8,p11p10g9,p11g10,g[11]);
	
	and(p15p14p13g12,p[15],p[14],p[13],g[12]);
	and(p15p14g13,p[15],p[14],g[13]);
	and(p15g14,p[15],g[14]);
	and(g3I,p15p14p13g12,p15p14g13,p15g14,g[15]);

	and(p0Ic0,p0I,Cin);
	or(carry[0],p0Ic0,g0I);
	
	and(p1Ip0Ic0,p1I,p0I,Cin);
	and(p1Ig0I,p1I,g0I);
	or(carry[1],p1Ip0Ic0,p1Ig0I,g1I);
	
	and(p2Ip1Ip0Ic0,p2I,p1I,p0I,Cin);
	and(p2Ip1Ig0I,p2I,p1I,g0I);
	and(p2Ig1I,p2I,g1I);
	or(carry[2],p2Ip1Ip0Ic0,p2Ip1Ig0I,p2Ig1I,g2I);
	
	and(p3Ip2Ip1Ip0Ic0,p3I,p2I,p1I,p0I,Cin);
	and(p3Ip2Ip1Ig0I,p3I,p2I,p1I,g0I);
	and(p3Ip2Ig1I,p3I,p2I,g1I);
	and(p3Ig2I,p3I,g2I);
	or(carry[3],p3Ip2Ip1Ip0Ic0,p3Ip2Ip1Ig0I,p3Ip2Ig1I,p3Ig2I,g3I);
	
	wire carry2[3:0];
	wire carry2L[3:0];
	
	CLA cla1(sum[3:0],carry2[0],carry2L[0],A[3:0],op3[3:0],Cin);
	CLA cla2(sum[7:4],carry2[1],carry2L[1],A[7:4],op3[7:4],carry[0]);
	CLA cla3(sum[11:8],carry2[2],carry2L[2],A[11:8],op3[11:8],carry[1]);
	CLA cla4(sum[15:12],carry2[3],carry2L[3],A[15:12],op3[15:12],carry[2]);

    wire sub_bar;
    not N2(sub_bar,sub);

	
	/*
	xor(check,carry[3],carry2[3]);
	xor XOR1(equal,carry2[3],carry2L[3]);
	not NOT3(equalC,equal);
	not NOT1(sign_bar,sign);
	not NOT2(sub_bar,sub);
	and And1(mint1,sign_bar,sub_bar);
	or OR1(mint2,sign,sub);
	
	and AND2(mint3,mint1,carry2[3]);
	and AND3(mint4,mint2,equalC);
	
	or ORF(overF,mint3,mint4);
	*/
	
	// wire o1,o2;
    // wire x1,x2;
    // wire last_bar, c2l_bar;
    // not Nott1(last_bar, carry2[3]);
    // not Nott2(c2l_bar, carry2L[3]);

    
    // buf Buf1 (o1,carry2[3]);
    // xor Xor1 (o2, carry2[3], carry2L[3]);

    // wire sign_bar;
    // not Not1 (sign_bar, sign); 

    // wire mint1, mint2;
    // and And1 (mint1, sign_bar, o1);
    // and And2 (mint2, sign,  o2);

    // or Or3 (overF, mint1, mint2);

	
    wire o1,o2;
    wire x1,x2;
    wire last_bar, c2l_bar;
    not Nott1(last_bar, carry[3]);
    not Nott2(c2l_bar, carry2L[3]);


    buf Buf1 (o1,carry2[3]);
    xor Xor1 (o2, carry2[3], carry2L[3]);

    wire sign_bar;
    not Not1 (sign_bar, sign); 

    wire mint1, mint2;
    and And1 (mint1, sign_bar, o1,sub_bar);
    and And2 (mint2, sign, o2);

    or Or (overF, mint1, mint2);
    and AAnd1 (mint1, sign_bar, o1);
    and AAnd2 (mint2, sign,  o2);

    or OOOr (overF, mint1, mint2);
    or OOr (OF, mint1, mint2);

endmodule
	
module CLA(sum,carry,C2L,A,B,Cin); 
	input wire [3:0]A;
	input wire [3:0]B;
	input wire Cin;
	output wire[3:0]sum;
	output carry;
	output C2L;

	wire [3:0]p;
	wire [3:0]g;
	and And[3:0](g[3:0],A[3:0],B[3:0]);
	xor Xor[3:0](p[3:0],A[3:0],B[3:0]);
	
	
	wire[3:0]c;
	
	buf(c[0],Cin);
	and(p0c0,p[0],c[0]);
	or(c[1],p0c0,g[0]);
	
	and(p1p0c0,p[1],p[0],c[0]);
	and(p1g0,p[1],g[0]);
	or(c[2],p1p0c0,p1g0,g[1]);
	
	and(p2p1p0c0,p[2],p[1],p[0],c[0]);
	and(p2p1g0,p[2],p[1],g[0]);
	and(p2g1,p[2],g[1]);
	or(c[3],p2p1p0c0,p2p1g0,p2g1,g[2]);
	
	buf(C2L,c[3]);
	
	and(p3p2p1p0c0,p[3],p[2],p[1],p[0],c[0]);
	and(p3p2p1g0,p[3],p[2],p[1],g[0]);
	and(p3p2g1,p[3],p[2],g[1]);
	and(p3g2,p[3],g[2]);
	or(carry,p3p2p1p0c0,p3p2p1g0,p3p2g1,p3g2,g[3]);
	
	xor XOR[3:0](sum,p,c);
	
endmodule	
