module BCDToHex(
	output reg [6:0] out,
	input [3:0] in 
	);
	always @(in)
		begin
			case(in)
			/*4'b0000: out = 7'b000_0001;
			4'b0001: out = 7'b100_1111;
			4'b0010: out = 7'b001_0010;
			4'b0011: out = 7'b000_0110;

			4'b0100: out = 7'b100_1100;
			4'b0101: out = 7'b010_0100;
			4'b0110: out = 7'b110_0000;
			4'b0111: out = 7'b000_1111;
			4'b1000: out = 7'b000_0000;

			4'b1001: out = 7'b000_1100;
			default: out = 7'dx;*/
			
			
			4'b0000: out = 7'b100_0000;
			4'b0001: out = 7'b111_1001;
			4'b0010: out = 7'b010_0100;
			4'b0011: out = 7'b011_0000;

			4'b0100: out = 7'b001_1001;
			4'b0101: out = 7'b001_0010;
			4'b0110: out = 7'b000_0011;
			4'b0111: out = 7'b111_1000;
			4'b1000: out = 7'b000_0000;

			4'b1001: out = 7'b001_1000;
			default: out = 7'dx;
			endcase
		end
endmodule