module OnehotToBin(
	output reg [3:0] bin,
	input [5:0] cur_floor_output
);
	always @(cur_floor_output)
	begin
		bin = 4'b00001;
		case(cur_floor_output)
		6'b000_001: bin = 4'b0001;
		6'b000_010: bin = 4'b0010;
		6'b000_100: bin = 4'b0011;
		6'b001_000: bin = 4'b0100;
		6'b010_000: bin = 4'b0101;
		6'b100_000: bin = 4'b0110;
		default: ;
		endcase
	end
endmodule
