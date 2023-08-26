module MoveFloor
	#(	parameter n = 6)
	(
	input clk, reset, count_up, count_down, // bien dem tang
	output reg [n-1:0]cur_floor	
	);

	reg [n-1:0]n_cur_floor;
	always @(posedge clk or negedge reset)
	begin
		if(~reset)begin
			cur_floor <= 6'b000001;// tang 1
			end
		else begin
			cur_floor <= n_cur_floor;
			end
	end
	always @(count_down or count_up or cur_floor)
	begin
		if(count_up && (cur_floor != 6'b100000)) n_cur_floor = (cur_floor <<1);// neu co tin hieu dem tang chua phai cao nhat thuc hien luu tru gia tri tai gia tri dich 
		else if(count_down &&(cur_floor != 6'b000001)) n_cur_floor = (cur_floor >>1); //tin hieu nho nhat chua co luu gia tri
		else n_cur_floor = cur_floor;// giu nguyen neu khong co tin hieu nao
	end
endmodule