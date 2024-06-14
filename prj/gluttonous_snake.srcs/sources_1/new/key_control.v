module key_control(
	input				lcd_pclk,     //ʱ��
    input				rst_n,        //��λ���͵�ƽ��Ч
    
    input				up_key,
    input				left_key,
    
    output	reg			up_press,
    output	reg			left_press
    );

//parameter define
parameter  CNT_MAX = 20'd100_0000;    //����ʱ��20ms

//reg define
reg [19:0] cnt ;
reg        key_d0_up;            //�������ź��ӳ�һ��ʱ������
reg        key_d1_up;            //�������ź��ӳ�����ʱ������
reg        key_d0_left;            //�������ź��ӳ�һ��ʱ������
reg        key_d1_left;            //�������ź��ӳ�����ʱ������

//*****************************************************
//**                    main code
//*****************************************************

//�԰����˿ڵ������ӳ�����ʱ������
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

//����ֵ����
always @ (posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n) begin
        cnt <= 20'd0;
	end
    else begin
        if(key_d1_up != key_d0_up || key_d1_left != key_d0_left)    //��⵽����״̬�����仯
            cnt <= CNT_MAX;     //�򽫼�������Ϊ20'd100_0000��
                                //����ʱ100_0000 * 20ns(1s/50MHz) = 20ms
        else begin              //�����ǰ����ֵ��ǰһ������ֵһ����������û�з����仯
            if(cnt > 20'd0)     //��������ݼ���0
                cnt <= cnt - 1'b1;  
            else
                cnt <= 20'd0;
        end
    end
end

//������������յİ���ֵ�ͳ�ȥ
always @ (posedge lcd_pclk or negedge rst_n) begin
    if(!rst_n) begin
        up_press <= 1'b1;
        left_press <= 1'b1;
    end
	//�ڼ������ݼ���1ʱ�ͳ�����ֵ
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
