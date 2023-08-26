module memory(clk, reset, wr_en, data_in,q);

	input clk, reset;
	input wr_en;
	input [7:0] data_in;
	output [7:0] q;
	
	wire [7:0] data_in_sync;
	wire wr_en_sync;
	 
	reg [7:0] memory_array;
	
	dff_behav #(.width(8)) d0 (clk, data_in, data_in_sync);
	dff_behav #(.width(1)) d2 (clk, wr_en, wr_en_sync);

	always @(data_in_sync or wr_en_sync or reset) 
	begin
		if(reset | (~wr_en_sync))
			memory_array <= 0;
		else if (wr_en_sync)
				memory_array <= data_in_sync;
	end
	
	assign q = memory_array;
	

endmodule