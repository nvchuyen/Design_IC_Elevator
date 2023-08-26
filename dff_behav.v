module dff_behav #(parameter width = 8) (clk, D, Q); 
	
	input [width -1 :0] D; 
	input clk; 
	output reg [width -1:0] Q;
	
	always@ (posedge clk) 
		Q= D; 
endmodule
