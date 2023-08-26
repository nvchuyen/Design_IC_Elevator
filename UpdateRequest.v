module UpdateRequest
#(parameter n =6)// so tang cau thang may
(// **c bao hieu co sua doi
	input [7:0] key_code,
	input [n-1:0] cur_floor,//**c
	input clk, reset, 
	input clear_down, clear_up, clear_all_down, clear_all_up, clear_door, clear_stop,// xoa cac hieu cau hien tai, chieu xuong, len, thap nhat, cao nhat, tin hieu mo cua, tin hieu dong cua
	output reg [n-1:0] up, down, req_in,//**c
	output reg close_button, open_button
);
	reg [n-1:0] next_up, next_down, next_req_in;
	reg n_close, n_open;
	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			up <= 6'b0;
			down <= 6'b0;
			req_in <= 6'b0;
			close_button <= 1'b0;
			open_button <= 1'b0;
		end
		else begin
			up <= next_up;
			down <= next_down;
			req_in <= next_req_in;
			close_button <= n_close;
			open_button <= n_open;
		end
	end
	
	//always @(key_code or up or down or cur_floor or req_in or clear_down or clear_in_down_req or clear_in_up_req or clear_up)
	always @(*)
	begin
		next_up = up;
		next_down = down;
		next_req_in = req_in;
		n_close = close_button;
		n_open  = open_button;
		case(key_code)
		// yeu cau ben trong
		8'h16 : next_req_in[0] = 1'b1; // 1 
		8'h1E : next_req_in[1] = 1'b1; // 2
		8'h26 : next_req_in[2] = 1'b1; // 3
		8'h25 : next_req_in[3] = 1'b1; // 4
		8'h2E : next_req_in[4] = 1'b1; // 5
		8'h36 : next_req_in[5] = 1'b1; // 6
		
		// yeu cau len ben ngoai
		8'h15 : next_up[0] = 1'b1; // Q
		8'h1D : next_up[1] = 1'b1; // W
		8'h24 : next_up[2] = 1'b1; // E
		8'h2D : next_up[3] = 1'b1; // R
		8'h2C : next_up[4] = 1'b1; // T
		8'h35 : next_up[5] = 1'b0; // Y
		
		// yeu cau xuong ben ngoai
		8'h1C : next_down[0] = 1'b0; // A
		8'h1B : next_down[1] = 1'b1; // S
		8'h23 : next_down[2] = 1'b1; // D
		8'h2B : next_down[3] = 1'b1; // F
		8'h34 : next_down[4] = 1'b1; // G
		8'h33 : next_down[5] = 1'b1; // H
		
		// close, open
		8'h1A : n_close = 1'b1;  // Z
		8'h22 : n_open = 1'b1;   // X
		default: ;
		endcase
		
		if (clear_door) begin
			n_close = 1'b0;
			n_open = 1'b0;
		end
		else if(clear_stop) begin // xoa yeu cau hien tai
			next_req_in = ((~cur_floor) & req_in);// xoa yeu cau ben trong tai tang do
			next_down = ((~cur_floor) & down);//xoa yeu cau ben ngoai len va xuong tai tang do
			next_up = ((~cur_floor) & up);//
		end
		else if(clear_up) begin // xoa yeu cau hien tai chieu len
				next_req_in = (~cur_floor) & req_in;
				next_up = ~cur_floor & up;
		end
		else if(clear_down) // xoa yeu cau hien tai chieu xuong 
			begin
				next_req_in = (~cur_floor) & req_in;
				next_down = (~cur_floor) & down;
			end
		else if(clear_all_up) begin // xoa yeu cau khi dat yeu cau max
				next_req_in = 6'b0;
				next_up = ~cur_floor & up;// xoa yeu cau tai tang cao nhat va cap nhat yeu cau
				next_down = (~(cur_floor-1)&up == 0) ? (~cur_floor & down) : down;// ??????
				next_down[n-1] = 1'b0; // cho tang cao nhat bang khong	
		end
		else if(clear_all_down) begin// xoa yeu cau khi dat yeu cau min
				next_req_in = 6'b0;
				next_down = ~cur_floor & down;
				next_up = ((((cur_floor -1) | cur_floor) & down) == 0) ? (~cur_floor & up) : up;
				next_up[0] = 1'b0;
		end
	end
endmodule
