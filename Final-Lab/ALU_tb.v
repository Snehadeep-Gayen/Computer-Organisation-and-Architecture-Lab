`timescale 1ns/100ps

module ALU_tb();

    reg[2:0] opcode;
	reg[11:0] A,B;
    wire[11:0] result;

    ALU F (opcode, A, B, result);
	
	initial begin
		
        $dumpfile("ALU_tb.vcd");
		$dumpvars(0, ALU_tb);

        //Case 1: Addition
        opcode = 001;
        A = 12'b000011011111;
        B = 12'b000010110110;

        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 000010010101\n");

        //Case 2: Subtraction
        opcode = 010;
        A = 12'b000011011111;
        B = 12'b000010110110;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 000000101001\n"); 

        //Case 3: Unsigned Multiplication
        opcode = 011;
        A = 12'b000000000111;
        B = 12'b000000000101;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 000000100011\n");

        //Case 4: Signed Multiplication
        opcode = 100;
        A = 12'b000000000111;
        B = 12'b111111111011;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 000011011101\n");

        //Case 5: Floating Point Addition
        opcode = 101;
        A = 12'b010111000000;
        B = 12'b001111000000;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 010111001100\n");

        //Case 6: Floating Point Multiplication
        opcode = 110;
        A = 12'b000101100000;
        B = 12'b110011000000;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 101010101000\n"); 

        //Case 7: Comparator
        opcode = 111;
        A = 12'b000101100000;
        B = 12'b000101100000;
        #20
        $display("A = %b, B = %b\n     result = %b", A, B, result);
        $display("Ans should be 000000000000\n");
		
	end

endmodule