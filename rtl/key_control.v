module key_control(
	input				lcd_pclk,     //时钟
    input				rst_n,        //复位，低电平有效
    
    input				up_key,
    input				left_key,
    
    output	reg			up_press,
    output	reg			left_press
    );

//parameter define
parameter  CNT_MAX = 20'd100_0000;    //消抖时间20ms

//reg define
reg [19:0] cnt ;
reg        key_d0_up;            //将按键信号延迟一个时钟周期
reg        key_d1_up;            //将按键信号延迟两个时钟周期
reg        key_d0_left;            //将按键信号延迟一个时钟周期
reg        key_d1_left;            //将按键信号延迟两个时钟周期

//*****************************************************
//**                    main code
//*****************************************************

//对按键端口的数据延迟两个时钟周期
always @ (posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n) begin
        key_d0_up	<= 1'b1;  
		key_d1_up	<= 1'b1	;  
		key_d0_left	<= 1'b1	;
		key_d1_left	<= 1'b1	;
    end
    else begin
       	key_d0_up	<= up_key;  
		key_d1_up	<= key_d0_up;  
		key_d0_left	<= left_key;
		key_d1_left	<= key_d0_left;
    end 
end

//按键值消抖
always @ (posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n) begin
        cnt <= 20'd0;
	end
    else begin
        if(key_d1_up != key_d0_up || key_d1_left != key_d0_left)    //检测到按键状态发生变化
            cnt <= CNT_MAX;     //则将计数器置为20'd100_0000，
                                //即延时100_0000 * 20ns(1s/50MHz) = 20ms
        else begin              //如果当前按键值和前一个按键值一样，即按键没有发生变化
            if(cnt > 20'd0)     //则计数器递减到0
                cnt <= cnt - 1'b1;  
            else
                cnt <= 20'd0;
        end
    end
end

//将消抖后的最终的按键值送出去
always @ (posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n) begin
        up_press <= 1'b1;
        left_press <= 1'b1;
    end
	//在计数器递减到1时送出按键值
    else if(cnt == 20'd1) begin
		up_press <= key_d1_up;
		left_press <= key_d1_left;
	end
    else begin
		up_press <= up_press;
		left_press <= left_press;
	end
end

endmodule
