module ElevatorController
#(parameter n=6)
(
	//output [5:0] cur_floor,
	output [6:0] out_hex,
	output [n-1:0] state_led_in_req, state_led_up, state_led_down,
	output state_led_open, state_led_close,
	output [1:0] direction,
	output sign_open,
	input clk_50M, rst_n,
	input ps2d, ps2c
);
	wire [n-1:0] cur_floor_w;
	wire req_current_w;
	wire req_up_in_w, req_down_in_w, req_up_out_w, req_down_out_w;
	wire req_up_max_w, req_down_min_w; 
	wire req_up_cur_w, req_down_cur_w;
	wire open_button_w, close_button_w;
	wire delay_5s_done_w, delay_3s_done_w;
	wire count_up_w, count_down_w;
	wire delay_5s_w, delay_3s_w;
	wire clear_up_w, clear_down_w; 
	wire clear_all_down_w, clear_all_up_w, clear_door_w, clear_stop_w;
	
	Datapath DT(
		.clk(clk_50M),
		.reset(rst_n),
		.ps2d(ps2d), 
		.ps2c(ps2c),
		.count_down(count_down_w),
		.count_up(count_up_w),
		.delay_5s(delay_5s_w),
		.delay_3s(delay_3s_w),
		.clear_up(clear_up_w),
		.clear_down(clear_down_w),
		.clear_all_up(clear_all_up_w),
		.clear_all_down(clear_all_down_w),
		.cur_floor_output(cur_floor_w),
		.req_current(req_current_w),
		.req_up_in(req_up_in_w),
		.req_down_in(req_down_in_w),
		.req_up_out(req_up_out_w),
		.req_down_out(req_down_out_w),
		.req_up_max(req_up_max_w),
		.req_down_min(req_down_min_w),
		.req_up_cur(req_up_cur_w),
		.req_down_cur(req_down_cur_w),
		.open_button(open_button_w),
		.close_button(close_button_w),
		.delay_3s_done(delay_3s_done_w),
		.delay_5s_done(delay_5s_done_w),
		.state_led_in_req(state_led_in_req), 
		.state_led_up(state_led_up), 
		.state_led_down(state_led_down),
		.state_led_open(state_led_open), 
		.state_led_close(state_led_close)
);

	control_unit CU(
		.clk(clk_50M),
		.reset(rst_n),
		.close_button(close_button_w),
		.open_button(open_button_w),
		.delay_3s_done(delay_3s_done_w),
		.delay_5s_done(delay_5s_done_w),
		.req_current(req_current_w),
		.req_up_in(req_up_in_w),
		.req_down_in(req_down_in_w),
		.req_up_out(req_up_out_w),
		.req_down_out(req_down_out_w),
		.req_up_max(req_up_max_w),
		.req_down_min(req_down_min_w),
		.count_down(count_down_w),
		.count_up(count_up_w),
		.sign_open(sign_open),
		.clear_down(clear_down_w),
		.clear_up(clear_up_w),
		.clear_all_down(clear_all_down_w),
		.clear_all_up(clear_all_up_w),
		.clear_door(clear_door_w),
		.clear_stop(clear_stop_w),
		.dir(direction),//chu y
		.delay_3s(delay_3s_w),
		.delay_5s(delay_5s_w)
);
	
	Display DP(
		.cur_floor_output(cur_floor_w),
		.out(out_hex)
	);
	
	
endmodule
