`include "Main.v"

`timescale 1ns/100ps

module CPU_tb();

	reg[11:0] instruction;
	
	CPU C(instruction);
	
	initial begin
		#200
		//ADD R2,R0,R1
		instruction = 12'b001010000001;
		$dumpfile("CPU_tb.vcd");
		$dumpvars(0,CPU_tb);
		
		#20
		//SUB R3,R0,R1
		instruction = 12'b010011000001;
		
		#20
		//MUL R4,R0,R1
		instruction = 12'b011100000001;
		
		#20
		//IMUL R4,R0,R1
		instruction = 12'b100100000001;
		
		#20
		//FADD R7,R5,R6
		instruction = 12'b101111101110;
		
		#20
		//FMUL R7,R5,R6
		instruction = 12'b110111101110;
		
		#20
		//CMP R2,R1,R0
		instruction = 12'b111010001000;
		
		#20
		$finish;
	end
endmodule
