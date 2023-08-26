module Datapath
#(parameter n= 6)
(
	input clk, reset, ps2d, ps2c, 
	input count_down, count_up,// tin hieu dem tang tu control_unit dieu khien
	input delay_5s, delay_3s,
	input clear_up, clear_down, clear_all_up, clear_all_down, clear_door, clear_stop,
	
	output cur_floor_output,
	output req_current,
	output req_up_in, req_down_in, req_up_out, req_down_out, req_up_max, req_down_min, // dau vao cac yeu cau trong khoi stop
	output req_up_cur, req_down_cur,
	output open_button, close_button,
	output delay_3s_done, delay_5s_done,// bao hieu hieu da dem du 3s, 5s cho control_unit
	output [5:0] state_led_in_req, state_led_up, state_led_down,
	output state_led_open, state_led_close
);

	wire [n-1:0] up_wire, down_wire, req_in_wire;
	wire open_bt_wire, close_bt_wire;
	wire [7:0] key_code_wire;
	wire [n-1:0] cur_floor_wire;

UpdateRequest UR(
	.key_code(key_code_wire),
	.cur_floor(cur_floor_wire),
	.clk(clk),
	.reset(reset),
	.clear_down(clear_down),
	.clear_up(clear_up),
	.clear_all_down(clear_all_down),
	.clear_all_up(clear_all_up),
	.clear_door(clear_door),
	.clear_stop(clear_stop),
	.up(up_wire),
	.down(down_wire),
	.req_in(req_in_wire),
	.close_button(close_bt_wire),
	.open_button(open_bt_wire)
);

MoveFloor MF(
	.clk(clk),
	.reset(reset),
	.count_up(count_up),
	.count_down(count_down),
	.cur_floor(cur_floor_wire)
);

ProcessingRequest PR(
	.cur_floor(cur_floor_wire),
	.req_in(req_in_wire),
	.up(up_wire),
	.down(down_wire),
	.open_bt(open_bt_wire),
	.close_bt(close_bt_wire),
	.req_up_in(req_up_in),
	.req_down_in(req_down_in),
	.req_up_out(req_up_out),
	.req_down_out(req_down_out),
	.req_up_max(req_up_max),
	.req_down_min(req_down_min),
	.req_down_cur(req_down_cur),
	.req_up_cur(req_up_cur),
	.req_current(req_current),
	.open_button(open_button),
	.close_button(close_button)
);
ReceiveInput RI(
	.clk(clk),
	.ps2c(ps2c),
	.ps2d(ps2d),
	.reset(reset),
	.key_code(key_code_wire),
);
delay delay_1(
	.delay_5s_done(delay_5s_done), 
	.delay_3s_done(delay_3s_done),
	.clk_50M(clk), 
	.rst_n(reset), 
	.delay_5s(delay_5s), 
	.delay_3s(delay_3s)	
	);
	assign state_led_in_req = req_in_wire;
	assign state_led_up = up_wire;
	assign state_led_down = down_wire;
	assign state_led_open = open_bt_wire;
	assign state_led_close = close_bt_wire;
	assign cur_floor_output = cur_floor_wire;
endmodule







