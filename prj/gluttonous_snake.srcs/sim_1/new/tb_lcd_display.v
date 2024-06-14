`timescale 1ns / 1ps
module tb_lcd_display();

reg	lcd_pclk;
reg	rst_n;
reg	move_en;

reg	key_up;
reg	key_down;
reg	key_left;
reg	key_right;

reg	[10:0]	pixel_xpos;
reg	[10:0]	pixel_ypos;
reg	[23:0]	pixel_data;

wire	[10:0]	foodx ;
wire	[10:0]	foody ;
wire		add;

initial begin
	lcd_pclk = 1'b0;
	rst_n = 1'b0;
	move_en = 1'b0;
	#40
		rst_n = 1'b1;
	#40	move_en = 1'b1;
	#40 move_en = 1'b0;

end

always #20 lcd_pclk = ~lcd_pclk;

//LCDÏÔÊ¾Ä£¿é    
lcd_display u_lcd_display(
    .lcd_pclk       (lcd_pclk  ),
    .rst_n          (sys_rst_n ),
    
    .add(add),
    .foodx			(foodx),
    .foody			(foody),
    .key_up			(key_up	),
    .key_down	    (key_down),
    .key_left	    (key_left),
    .key_right      (key_right),
    .move_en        (move_en),
    .pixel_xpos     (pixel_xpos),
    .pixel_ypos     (pixel_ypos),
    .pixel_data     (pixel_data)
    );   

endmodule
