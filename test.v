module test(
	input PS2_DAT, PS2_CLK,
	input CLOCK_50, 
	input [0:0] KEY,
	output  [6:0] HEX0,
	output [17:0] LEDR,
	output [7:0] LEDG,
	input[17:0] SW
);
	wire [7:0] key_code_wire;
	wire [5:0] cur_floor_wire;

	ReceiveInput RI(
		.clk(CLOCK_50),
		.ps2c(PS2_CLK),
		.ps2d(PS2_DAT),
		.reset(KEY[0:0]),
		.key_code(key_code_wire),
	);

	UpdateRequest UR(
		.key_code(key_code_wire),
		.cur_floor(cur_floor_wire),
		.clk(CLOCK_50),
		.reset(KEY[0:0]),
		.clear_down(SW[0]),
		.clear_up(SW[1]),
		.clear_all_down(SW[2]),
		.clear_all_up(SW[3]),
		.clear_door(SW[4]),
		.clear_stop(SW[5]),
		.up(LEDR[17:12]),
		.down(LEDR[11:6]),
		.req_in(LEDR[5:0]),
		.close_button(LEDG[0]),
		.open_button(LEDG[1])
	);
	
	MoveFloor MF(
		.clk(CLOCK_50),
		.reset(KEY[0:0]),
		.count_up(SW[17]),
		.count_down(SW[16]),
		.cur_floor(cur_floor_wire)
	);
	floor2hex(
		.out(HEX0[6:0]),
		.in(cur_floor_wire) 
	);
	
endmodule
