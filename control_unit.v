module control_unit(
input clk, reset,
input close_button, open_button,// nut dong cua va mo cua ben ngoai thang may
input delay_3s_done, delay_5s_done, 	// bao hieu da dem du 3s, 5s o khoi datapath
input req_current,      //req_in_cur, req_up_cur, req_down_cur,	 // xet trang thai hien tai ben trong, len và xuong ben ngoai
input req_up_in, req_down_in, req_up_out, req_down_out, req_up_max, req_down_min,	// kiem tra cac yeu cau cua thang may
output reg count_down, count_up, 	// dem so tang len va xuong
output reg sign_open,// mo cua, dong cua
output reg clear_down, clear_up, clear_all_down, clear_all_up, clear_door, clear_stop,	// xoa cac yeu cau khi thu hien
output reg [1:0]dir,	// tin hieu chi huong di cua thang may
output reg delay_3s, delay_5s 	// bao hieu tu control cho datapath dem 3s, 5s
);

 reg [1:0]flag_dir;
 localparam start = 4'b0000;
 localparam stop = 4'b0001;
 localparam open = 4'b0010;
 localparam up =4'b0011;
 localparam down =4'b0100;
 localparam checkmoveup = 4'b0101;
 localparam checkrequestup = 4'b0110;
 localparam checkmovedown= 4'b0111;
 localparam checkrequestdown = 4'b1000;
 localparam checkdelay = 4'b1001;
 localparam checkdirect =4'b1010;
 
 reg [3:0]state, next_state;
 reg [1:0]n_dir, n_flag_dir;
 reg n_delay_5s, n_delay_3s;
 reg n_sign_open;
 
 always @(posedge clk or negedge reset)
 begin
	if(!reset)
	begin 
		state <= start;
		dir =2'b0;
		flag_dir <= 2'b00;
		delay_5s <=0;
		delay_3s <=0;
		sign_open <=1'b0;	
	end
	else begin
		state <= next_state;
		dir <= n_dir;
		flag_dir <= n_flag_dir;
		delay_3s <= n_delay_3s;
		delay_5s <= n_delay_5s;
		sign_open <= n_sign_open;
	end
 end
 
 always @(req_current)
 begin
	case(state)
		start: //khoi tao cac gia tri
		begin
			clear_all_down =0;
			clear_all_up =0;
			clear_stop = 0;
			count_down =0;
			count_up =0;
			clear_door =0;
			n_delay_3s = delay_3s;
			n_delay_5s = delay_5s;
			next_state = stop;
			n_flag_dir = flag_dir;
			n_dir = dir;
			end
		stop: 
		begin
			//khoi tao clear_down =0;
			if(req_current)//( req_in_cur==1 || req_up_cur==1|| req_down_cur==1)// kiem tra trang thai hien tai cua thang may
			begin
				n_dir =1'b00;
				n_sign_open =1;
				clear_stop = 1'b0;// xoa cac yeu cau hien tai khi dung
				next_state = open;
			end
			else if(req_up_in ==1)
			begin
				n_dir =2'b01;
				n_delay_3s =1;
				next_state = up;
			end
			else if(req_down_in ==1)
			begin
				n_dir = 2'b10;
				n_delay_3s=1;
				next_state = down;
			end
			else if(req_up_out==1)
			begin
				n_dir = 2'b01;
				n_delay_3s=1;
				next_state = up;
			end 
			else if(req_down_out==1)
			begin
				n_dir =2'b10;
				n_delay_3s =1;
				next_state = down;
			end
			else next_state = stop;
		end
		up:
		begin
			n_delay_3s =1'b1;
			next_state = checkmoveup;
		end
		checkmoveup:
		begin
			if(delay_3s_done ==1)
			begin
				n_delay_3s =1'b0;
				next_state = checkrequestup;
			end
			else next_state = checkmoveup;
		end
		checkrequestup: 
		begin
			if(req_up_max ==1)
			begin
				clear_all_up =1;
				n_dir =2'b00;
				n_sign_open =1;
				next_state = open;
			end
			else if(req_current==1)
			begin
				clear_up = 1;
				n_dir = 2'b00;
				n_sign_open=1;
				next_state = open;
			end
			else
			begin
				n_dir = 2'b01;
				next_state = up;
			end
		end
		
		down:
		begin
			n_delay_3s=1'b1;
			next_state = checkmovedown;
		end
		checkmovedown:
		begin
			if(delay_3s_done ==1)
			begin
				n_delay_3s =1;
				next_state = checkrequestdown;
			end
		end
		
		checkrequestdown:
		begin
			if(req_down_min==1)
			begin
				clear_all_down =1;
				n_dir =2'b00;
				n_sign_open =1;
				next_state = open;
			end
			else if(req_current==1)
			begin
				clear_down=1;
				n_dir =2'b00;
				n_sign_open=1;
				next_state = open;
			end
			else
			begin
				n_dir=2'b00;
				next_state =up;
			end
		end
		
		open:
		begin
			n_delay_5s=1'b1;
			clear_door=1'b1;// xoa tin hieu mo cua////////////////////////////////////////////// chu y them phan nay
			next_state = checkdelay;
		end 
		checkdelay: 
		begin
			if(delay_5s_done==1)
			begin
				if(open_button ==1)
				begin
					n_delay_5s =1'b1;
					n_sign_open =1'b1;
					clear_door =1'b1;
					next_state = open;
				end
				else begin
					clear_door = 1'b1;
					n_delay_5s = 1'b0;
					next_state = checkdirect;
				end
			end
			else if(close_button ==1)
			begin
				clear_door =1'b1;
				n_delay_5s =1'b1;
				next_state = checkdirect;
			end
			else if(open_button==1)
			begin
				n_sign_open =1'b1;
				clear_door = 1'b1;
				n_delay_5s = 1'b0;
				next_state = open;
			end
			else next_state = checkdelay;
		end
		checkdirect:
		begin
			case(flag_dir)
			2'b00: next_state = stop;
			2'b01: next_state = up;
			2'b10: next_state = down;
			default: next_state = stop;
			endcase
		end
		default:
		begin
			 next_state = start;
		end
		endcase
 end
endmodule 