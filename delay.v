module delay(
	output delay_5s_done, delay_3s_done,
	input clk_50M, rst_n, delay_5s, delay_3s	
);
	
	delay_5s delay_5s_(
		.clk_50M(clk_50M),
		.rst_n(rst_n),
		.enable(delay_5s),
		.delay_5s_done(delay_5s_done)	
	);
	delay_3s delay_3s_(
		.clk_50M(clk_50M),
		.rst_n(rst_n),
		.enable(delay_3s),
		.delay_3s_done(delay_3s_done)	
	);
endmodule


/*module delay(
	output delay_5s_done, delay_3s_done,
	input clk_1Hz, rst_n, delay_5s, delay_3s	
);
	delay_5s delay_5s_(
		.clk_1Hz(clk_1Hz),
		.rst_n(rst_n),
		.enable(delay_5s),
		.delay_5s_done(delay_5s_done)	
	);
	delay_3s delay_3s_(
		.clk_1Hz(clk_1Hz),
		.rst_n(rst_n),
		.enable(delay_3s),
		.delay_3s_done(delay_3s_done)	
	);
endmodule

*/