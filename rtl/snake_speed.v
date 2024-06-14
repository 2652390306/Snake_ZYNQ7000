module snake_speed(
	input             lcd_pclk,     //时钟
    input             rst_n,        //复位，低电平有效
    output			 move_en
    );


parameter  DIV_CNT = 32'd7500000;				//分频计数器 control the speed of the snake

reg [31:0] div_cnt;                             //时钟分频计数器

//*****************************************************
//**                    main code
//*****************************************************
assign move_en = (div_cnt == DIV_CNT) ? 1'b1 : 1'b0;

//通过对div驱动时钟计数，实现时钟分频
always @(posedge lcd_pclk or negedge rst_n) begin         
    if (!rst_n)
        div_cnt <= 32'd0;
    else begin
        if(div_cnt < DIV_CNT) 
            div_cnt <= div_cnt + 1'b1;
        else
            div_cnt <= 32'd0;                   //计数达10ms后清零
    end
end
    
endmodule
