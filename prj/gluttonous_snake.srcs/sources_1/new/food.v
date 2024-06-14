module food
(
	input             lcd_pclk,     //时钟
    input             rst_n,        //复位，低电平有效
    input			move_en,
    input			add,
	output	reg [10:0]	foodx,
	output	reg [10:0]	foody
);

//reg [2:0] cnt;
reg	[10:0]	randomnum;

always@(posedge lcd_pclk)
	randomnum <= randomnum + 998;  
	
always @ (posedge lcd_pclk or negedge rst_n) begin
	if(!rst_n) begin
		foodx <= 11'd24;
		foody <= 11'd14;
		//cnt <= 3'b0;
	end
	else begin
		if(add) begin
			foodx <= (randomnum[10:5] > 38) ? (randomnum[10:5] - 28) : (randomnum[10:5] == 0) ? 2 : randomnum[10:5];
			foody <= (randomnum[4:0] > 28) ? (randomnum[4:0] - 5) : (randomnum[4:0] == 0) ? 2 :randomnum[4:0];
		end	
		else begin
			foodx <= foodx;
			foody <= foody;
		end
	end
end
		//if(move_en) begin
//			if(add && cnt == 3'b0) begin
//				foodx <= 11'd10;
//				foody <= 11'd26;
//				cnt <= 3'b1;
//			end
//			else if(add && cnt == 3'b1) begin
//				foodx <= 11'd10;
//				foody <= 11'd20;
//				cnt <= 3'd2;
//			end
//			else if(add && cnt == 3'd2) begin
//				foodx <= 11'd38;
//				foody <= 11'd23;
//			end
//			else begin
//				foodx <= foodx;
//				foody <= foody;
//				cnt <= cnt;
//			end



endmodule