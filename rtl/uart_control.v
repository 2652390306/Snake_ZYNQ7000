module uart_control(
	input             lcd_pclk,     //时钟
    input             rst_n,        //复位，低电平有效
    input	[7:0]	  rx_data_t,
    input			  rx_data_done,
    
    output	reg		key_up,
    output	reg		key_down,
    output	reg		key_left,
    output	reg		key_right
    );

// 按键方向


//按键控制
//当方块移动到边界时，改变移动方向
always @(posedge lcd_pclk or negedge rst_n) begin         
    if(!rst_n) begin
        key_up		<= 1'b0;   
		key_down	<= 1'b0;
		key_left	<= 1'b0;
		key_right	<= 1'b0;
    end
    else begin
		if(rx_data_done) begin
			case(rx_data_t)
				8'd5 : key_up <= 1'b1;
				8'd2 : begin 
					key_down <= 1'b1;
				end
				8'd1 : key_left <= 1'b1;
				8'd3 : key_right <= 1'b1;
				default : begin
					key_up		<= 1'b0;   
					key_down	<= 1'b0;
					key_left	<= 1'b0;
					key_right	<= 1'b0;
				end
			endcase
		end else begin
			key_up		<= 1'b0;   
			key_down	<= 1'b0;
			key_left	<= 1'b0;
			key_right	<= 1'b0;
		end
    end
end

endmodule
