module ProcessingRequest
	#(parameter n=6)
	(
	input [n-1:0] cur_floor,
	input [n-1:0] req_in, up, down,
	input open_bt, close_bt,// tin hieu yeu cau mo cua
	output reg req_up_in, req_down_in,
	output reg req_up_out, req_down_out, //require_out
	output reg req_up_max, req_down_min,
	output reg req_down_cur,req_up_cur, req_current,
	output reg open_button, close_button
	);
	
	reg max_req_in, max_require;
	reg min_req_in, min_require;
	
	always@(cur_floor or req_in or up or down or open_bt or close_bt)
	begin	
		//*** req = !((!(up | req_in| down)) & (~open_bt)); //***
		req_current = (cur_floor & req_in) || (cur_floor & up) || (cur_floor & down) || (open_bt == 1'b1) ; 
		req_up_in = (req_in > cur_floor) ; 
		req_down_in = (req_in < cur_floor ) && (req_in); 
		req_up_out = (up > cur_floor ) ; //********c// yeu cau ben ngoai lơn hơn tang hien tai
		req_down_out =(down < cur_floor ) ; ///*********c// yeu cau ben ngoai nho hon yeu cau tang hien tai ; 
		
		//max_req_in = ((req_in >> 1) < (cur_floor)) && (req_in & cur_floor);//kiem tra xem cac yeu cau co nho hon tang hien tai---- kiem tra xem co yeu cau hien tai hay khong
		//max_require = (((req_in|up|down) >>1) < cur_floor) && ((req_in|up|down) & cur_floor);
		//req_up_max = max_req_in | max_require;
		
		req_up_max = (((req_in|up|down) >>1) < cur_floor) && ((req_in|up|down) & cur_floor);
		
		//min_req_in = (!(req_in  & (cur_floor - 1))) && (req_in & cur_floor);
		//min_require = (!((req_in|up|down) & (cur_floor - 1))) && ((req_in|up|down) & cur_floor);
		//req_down_min = min_req_in | min_require;
		req_down_min = (!((req_in|up|down) & (cur_floor - 1))) && ((req_in|up|down) & cur_floor);
		
		req_up_cur = (cur_floor & req_in) || (cur_floor & up) ; 
		req_down_cur = (cur_floor & req_in) || (cur_floor & down); 	
		open_button = open_bt; 
		close_button = close_bt; 
	end
	
endmodule
