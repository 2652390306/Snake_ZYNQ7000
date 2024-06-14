`timescale 1ns / 1ps
module tb_food();

reg	lcd_pclk;
reg	rst_n;
reg	move_en;
wire	[10:0]	foodx ;
wire	[10:0]	foody ;
reg		add;

initial begin
	lcd_pclk = 1'b0;
	rst_n = 1'b0;
	move_en = 1'b0;
	add = 1'b0;
	#40
		rst_n = 1'b1;
	#40	move_en = 1'b1;
	#40 move_en = 1'b0;

	#200 
		move_en = 1'b1;
		add = 1'b1;
	#40 move_en = 1'b0;
		add = 1'b0;
	#200 
		move_en = 1'b1;
		add = 1'b0;
	#40 move_en = 1'b0;
		add = 1'b0;
	#200 
		move_en = 1'b1;
		add = 1'b1;
	#40 move_en = 1'b0;
	
	#200 
		move_en = 1'b1;
		add = 1'b0;
	#40 move_en = 1'b0;
	
	#200 
		move_en = 1'b1;
		add = 1'b1;
	#40 move_en = 1'b0;
	
	#200 
		move_en = 1'b1;
		add = 1'b0;
	#40 move_en = 1'b0;
	
	#200 
		move_en = 1'b1;
		add = 1'b1;
	#40 move_en = 1'b0;
	
	#200 
		move_en = 1'b1;
		add = 1'b0;
	#40 move_en = 1'b0;
end

always #20 lcd_pclk = ~lcd_pclk;

food u_food(
	.lcd_pclk      (lcd_pclk  ),
    .rst_n         (rst_n ),
    .move_en		(move_en),
	.foodx			(foodx),
	.foody			(foody),
	.add			(add)
);

endmodule
