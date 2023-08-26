module delay_5s(
	output reg delay_5s_done,
	input clk_50M, rst_n, enable	
);
	reg [27:0] cnt;
	//assign delay_3s_done = (cnt == 3);
	always @(posedge clk_50M or negedge rst_n)
	begin
		if(!rst_n) cnt <= 28'd0;
		else if(enable) begin
			if(cnt < 28'd250000000) begin
				delay_5s_done <= 1'b0;
				cnt <= cnt + 28'd1;
				end
			else begin
				delay_5s_done <= 1'b1;
				cnt <= 28'd250000000;
			end
		end
		else begin
			delay_5s_done <= 1'b0;
			cnt <= 28'd0;
		end
	end
endmodule
