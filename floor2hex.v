module floor2hex(
	output reg [6:0] out,
	input [5:0] in 
	);
	always @(in)
		begin
			case(in)
				6'b000000: out = 7'b100_0000;
				6'b000001: out = 7'b111_1001;
				6'b000010: out = 7'b010_0100;
				6'b000100: out = 7'b011_0000;

				6'b001000: out = 7'b001_1001;
				6'b010000: out = 7'b001_0010;
				6'b100000: out = 7'b000_0011;
				default: out = 7'b0000000;
			endcase
		end
endmodule
