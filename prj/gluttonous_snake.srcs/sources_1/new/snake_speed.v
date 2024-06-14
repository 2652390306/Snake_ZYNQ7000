module snake_speed(
	input             lcd_pclk,     //ʱ��
    input             rst_n,        //��λ���͵�ƽ��Ч
    output			 move_en
    );


parameter  DIV_CNT = 32'd7500000;				//��Ƶ������ control the speed of the snake

reg [31:0] div_cnt;                             //ʱ�ӷ�Ƶ������

//*****************************************************
//**                    main code
//*****************************************************
assign move_en = (div_cnt == DIV_CNT) ? 1'b1 : 1'b0;

//ͨ����div����ʱ�Ӽ�����ʵ��ʱ�ӷ�Ƶ
always @(posedge lcd_pclk or negedge rst_n) begin         
    if (!rst_n)
        div_cnt <= 32'd0;
    else begin
        if(div_cnt < DIV_CNT) 
            div_cnt <= div_cnt + 1'b1;
        else
            div_cnt <= 32'd0;                   //������10ms������
    end
end
    
endmodule
