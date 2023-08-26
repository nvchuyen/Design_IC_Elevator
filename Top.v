module Top(
	input PS2_DAT, PS2_CLK,
	input CLOCK_50, 
	input [3:0] KEY,
	output  [6:0] HEX0,
	output [17:0] LEDR,
	output [7:0] LEDG
);
	ElevatorController EC(
	.out_hex(HEX0),
	.state_led_in_req(LEDR [5:0]), 
	.state_led_up(LEDR [11:6]), 
	.state_led_down(LEDR [17:12]),
	.state_led_open(LEDG[0]),
	.state_led_close(LEDG[1]),
	.direction(LEDG[5:4]),
	.sign_open(LEDG[2]),
	.clk_50M(CLOCK_50), 
	.rst_n(KEY[1]),
	.ps2d(PS2_DAT),
	.ps2c(PS2_CLK)
	);
endmodule