module Display
#(parameter n=6)(
	output [6:0] out,
	input [n-1:0] cur_floor_output
);
	wire [3:0] bin_w;
	OnehotToBin OTB(
		.bin(bin_w),
		.cur_floor_output(cur_floor_output)
	);
	BCDToHex B_1
	(
		.in(bin_w),
		.out(out)
	);
endmodule