module platformer_display (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [2:0] speed_select,
	 input wire [2:0] control,
    output wire hsync,
    output wire vsync,
    output reg [23:0] rgb,
    output wire [9:0] h_count,
    output wire [9:0] v_count
);

//Declare wires
wire [2:0] player_moves;
wire [19:0] speed;
wire [15:0] rand;
wire [9:0] active_column;
wire [9:0] note_y_position;
wire note_active;
wire note_visible_1;
wire [2:0]level;

//Assign speed_select which is assigned to switches 3-1 to certain speeds. This allows for different dificulties.
assign speed = (speed_select == 3'b000) ? 20'hFFFFF :
               (speed_select == 3'b001) ? 20'h7FFFF :
               (speed_select == 3'b010) ? 20'h3FFFF :
               20'h1FFFF;  // Default to fastest speed to removed infered latches.
					
					
// //Assign control which is assigned to keys 2-0 to certain moves. This allows for different movement.
assign player_moves = control;

					
// Instantiate the VGA driver
vga_driver vga_inst (
    .clk(clk),
    .rst(rst),
	 .hsync(hsync),
	 .vsync(vsync),
	 .h_count(h_count),
	 .v_count(v_count)
);


//Updates player
player_update p_u (
    .clk(clk),
	 .rst(rst),
	 .start(start),
	 .speed(speed),
	 .rand(rand),
	 .player_input(player_moves),
	 .active_column(active_column), /////////////////////////////////// 
	 .note_y_position(note_y_position),
	 .note_active(note_active),
	 .level(level)
);

// Instantiate the player
player_init player_one (
    .h_count(h_count),
	 .v_count(v_count), 
	 .column_start(active_column),
	 .note_y_position(note_y_position),
	 .note_active(1),                              
	 .note_visible(note_visible_1)
);


// RGB logic to draw the platforms and player.
    always @(posedge clk or posedge rst) begin
	 
        if (rst) begin
		  
            rgb <= 24'h000000;
				
        end else if ((h_count < 640) && (v_count < 480) && (level == 2'b00) ) begin
		  
		  
				// Red square
            if (note_visible_1) begin
                rgb <= 24'hFF0000; 
					 
					 
				// red outline bottom
				end else if ((v_count >= 470) && (v_count < 480) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000; 
					// red outline top
				end else if ((v_count >= 0) && (v_count < 3) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000;	 
					 
				// horizontal cyan line plat 1 top
            end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 150) && (h_count > 0)) begin			
                rgb <= 24'h00FFFF; 					 					 
				// horizontal cyan line plat 1 bottom
            end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 150) && (h_count > 0)) begin				
                rgb <= 24'h00FFFF;

					 
				// platform 2 level 1 top	 
				end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 350) && (h_count > 200)) begin				
                rgb <= 24'h00FFFF;	 					 					 
				// platform 2 level 1 bottom
				end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 350) && (h_count > 200)) begin				
                rgb <= 24'h00FFFF;
					 
					 
				// platform 3 level 1 top	 
				end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 475) && (h_count > 425)) begin				
                rgb <= 24'h00FFFF;	 					 
				// platform 3 level 1 bottom
				end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 475) && (h_count > 425)) begin		
                rgb <= 24'h00FFFF;	
			
			
			   // platform 4 level 1 top	 
				end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 600) && (h_count > 550)) begin
                rgb <= 24'h00FFFF;	  
				// platform 4 level 1 bottom
				end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 600) && (h_count > 550)) begin
                rgb <= 24'h00FFFF;
					 
					 
				// platform 5 level 1 top	 
				end else if ((v_count >= 290) && (v_count < 291) && (h_count <= 600) && (h_count > 550)) begin
                rgb <= 24'h00FFFF;	 
				// platform 5 level 1 bottom
				end else if ((v_count >= 293) && (v_count < 294) && (h_count <= 600) && (h_count > 550)) begin
                rgb <= 24'h00FFFF;
					 
					 
			   // platform 6 level 1 top	 
				end else if ((v_count >= 240) && (v_count < 241) && (h_count <= 500) && (h_count > 425)) begin				
                rgb <= 24'h00FFFF;	 					 
				// platform 6 level 1 bottom
				end else if ((v_count >= 243) && (v_count < 244) && (h_count <= 500) && (h_count > 425)) begin			
                rgb <= 24'h00FFFF;
					 
					 
				 // platform 7 level 1 top	 
				end else if ((v_count >= 165) && (v_count < 166) && (h_count <= 375) && (h_count > 315)) begin				
                rgb <= 24'h00FFFF;	 					 
				// platform 7 level 1 bottom
				end else if ((v_count >= 168) && (v_count < 169) && (h_count <= 375) && (h_count > 315)) begin			
                rgb <= 24'h00FFFF;
					 
					 
				 // platform 8 level 1 top	 
				end else if ((v_count >= 129) && (v_count < 130) && (h_count <= 250) && (h_count > 220)) begin				
                rgb <= 24'h00FFFF;	 					 
				// platform 8 level 1 bottom
				end else if ((v_count >= 132) && (v_count < 133) && (h_count <= 250) && (h_count > 220)) begin			
                rgb <= 24'h00FFFF;
					 
					 
				 // platform 9 level 1 top	 
				end else if ((v_count >= 247) && (v_count < 248) && (h_count <= 200) && (h_count > 170)) begin				
                rgb <= 24'hFFD700;	 					 
				// platform 9 level 1 bottom
				end else if ((v_count >= 250) && (v_count < 251) && (h_count <= 200) && (h_count > 170)) begin			
                rgb <= 24'hFFD700;
			


			/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
            end else begin
				
                rgb <= 24'h000000; // Right side of the screen (Black)
					 
            end
				
		  end else if ((h_count < 640) && (v_count < 480) && (level == 2'b01) ) begin 
		  // Red square
            if (note_visible_1) begin
                rgb <= 24'hFF0000; 
					 
					 
				// red outline bottom
				end else if ((v_count >= 470) && (v_count < 480) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000; 
					// red outline top
				end else if ((v_count >= 0) && (v_count < 3) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000;	 
					 
				// horizontal cyan line plat 1 top
            end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 75) && (h_count > 0)) begin			
                rgb <= 24'h00FFFF; 					 					 
				// horizontal cyan line plat 1 bottom
            end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 75) && (h_count > 0)) begin				
                rgb <= 24'h00FFFF;

					 
				// platform 2 level 2 top	 
				end else if ((v_count >= 380) && (v_count < 381) && (h_count <= 200) && (h_count > 150)) begin				
                rgb <= 24'h00FFFF;	 					 					 
				// platform 2 level 2 bottom
				end else if ((v_count >= 383) && (v_count < 384) && (h_count <= 200) && (h_count > 150)) begin				
                rgb <= 24'h00FFFF;
					 
					 
				// platform 3 level 2 top
            end else if ((v_count >= 270) && (v_count < 274) && (h_count <= 75) && (h_count > 30)) begin			
                rgb <= 24'h00FFFF; 

					 
				// platform 4 level 2 top
            end else if ((v_count >= 160) && (v_count < 164) && (h_count <= 45) && (h_count > 0)) begin			
                rgb <= 24'h00FFFF;
					 
					 
			   // platform 5 level 2 top
            end else if ((v_count >= 50) && (v_count < 54) && (h_count <= 150) && (h_count > 30)) begin			
                rgb <= 24'h00FFFF;
					 
					 
					 
				// platform 6 level 2 top
            end else if ((v_count >= 220) && (v_count < 224) && (h_count <= 250) && (h_count > 175)) begin			
                rgb <= 24'h00FFFF;
				
		
				// horizontal cyan line plat 7 top
            end else if ((v_count >= 430) && (v_count < 431) && (h_count <= 600) && (h_count > 350)) begin			
                rgb <= 24'h00FFFF; 					 					 
				// horizontal cyan line plat 7 bottom
            end else if ((v_count >= 433) && (v_count < 434) && (h_count <= 600) && (h_count > 350)) begin				
                rgb <= 24'h00FFFF;

					 
				 // horizontal green line plat 10 top
            end else if ((v_count >= 400) && (v_count < 401) && (h_count <= 600) && (h_count > 580)) begin			
                rgb <= 24'h39FF14; 					 					 
				// horizontal green line plat 10 bottom
            end else if ((v_count >= 403) && (v_count < 405) && (h_count <= 600) && (h_count > 580)) begin				
                rgb <= 24'h39FF14;
					 
				 // verticle green  line  right
            end else if ((v_count >= 405) && (v_count < 430) && (h_count <= 599) && (h_count > 598)) begin			
                rgb <= 24'h39FF14; 					 					 
				// verticle green line  left
            end else if ((v_count >= 405) && (v_count < 430) && (h_count <= 582) && (h_count > 581)) begin				
                rgb <= 24'h39FF14;
					 
					 
				 // platform 11 level 2 top	 
				end else if ((v_count >= 250) && (v_count < 251) && (h_count <= 430) && (h_count > 400)) begin				
                rgb <= 24'hFFD700;	 					 
				// platform 11 level 2 bottom
				end else if ((v_count >= 253) && (v_count < 254) && (h_count <= 430) && (h_count > 400)) begin			
                rgb <= 24'hFFD700;
					 
				 // platform 12 level 2 top	 
				end else if ((v_count >= 220) && (v_count < 221) && (h_count <= 500) && (h_count > 480)) begin				
                rgb <= 24'h00FFFF;	 					 
				// platform 12 level 2 bottom
				end else if ((v_count >= 223) && (v_count < 224) && (h_count <= 500) && (h_count > 480)) begin			
                rgb <= 24'h00FFFF;
	
					 
				end else begin
				
                rgb <= 24'h000000; // Right side of the screen (Black)
					 
            end
				
			end else if ((h_count < 640) && (v_count < 480) && (level == 2'b10) ) begin
					 
				 // Red square
            if (note_visible_1) begin
                rgb <= 24'hFF0000; 
					 
					 
				// red outline bottom
				end else if ((v_count >= 470) && (v_count < 480) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000; 
					// red outline top
				end else if ((v_count >= 0) && (v_count < 3) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000;	 
					 
				
					 
					 
					 
					 
					 
					 
				 // horizontal cyan line plat 1 top
            end else if ((v_count >= 440) && (v_count < 441) && (h_count <= 470) && (h_count > 420)) begin			
                rgb <= 24'h00FFFF; 					 					 
				// horizontal cyan line plat 1 bottom
            end else if ((v_count >= 443) && (v_count < 444) && (h_count <= 470) && (h_count > 420)) begin				
                rgb <= 24'h00FFFF;
					 
					 
				  // horizontal green line plat 10 top
            end else if ((v_count >= 410) && (v_count < 411) && (h_count <= 470) && (h_count > 450)) begin			
                rgb <= 24'h39FF14; 					 					 
				// horizontal green line plat 10 bottom
            end else if ((v_count >= 413) && (v_count < 415) && (h_count <= 470) && (h_count > 450)) begin				
                rgb <= 24'h39FF14;
					 
				 // verticle green  line  right
            end else if ((v_count >= 415) && (v_count < 440) && (h_count <= 469) && (h_count > 468)) begin			
                rgb <= 24'h39FF14; 					 					 
				// verticle green line  left
            end else if ((v_count >= 415) && (v_count < 440) && (h_count <= 452) && (h_count > 451)) begin				
                rgb <= 24'h39FF14;
					 
					 
					 
					 
					 
					 
					 
					 // horizontal cyan line plat 2 top
            end else if ((v_count >= 235) && (v_count < 236) && (h_count <= 570) && (h_count > 480)) begin			
                rgb <= 24'h00FFFF; 					 					 
				// horizontal cyan line plat 2 bottom
            end else if ((v_count >= 238) && (v_count < 239) && (h_count <= 570) && (h_count > 480)) begin				
                rgb <= 24'h00FFFF;
					 
					 
				  // horizontal green line plat 2 top
            end else if ((v_count >= 205) && (v_count < 206) && (h_count <= 570) && (h_count > 550)) begin			
                rgb <= 24'h39FF14; 					 					 
				// horizontal green line plat 2 bottom
            end else if ((v_count >= 208) && (v_count < 210) && (h_count <= 570) && (h_count > 550)) begin				
                rgb <= 24'h39FF14;
					 
				 // verticle green  line  right
            end else if ((v_count >= 210) && (v_count < 235) && (h_count <= 569) && (h_count > 568)) begin			
                rgb <= 24'h39FF14; 					 					 
				// verticle green line  left
            end else if ((v_count >= 210) && (v_count < 235) && (h_count <= 552) && (h_count > 551)) begin				
                rgb <= 24'h39FF14;
					 
					 
					 
				  
					 
					 
				// platform 4 level 3 top	 
				end else if ((v_count >= 25) && (v_count < 26) && (h_count <= 570) && (h_count > 360)) begin				
                rgb <= 24'h228B22;	 					 					 
				// platform 4 level 3 bottom
				end else if ((v_count >= 28) && (v_count < 29) && (h_count <= 570) && (h_count > 360)) begin				
                rgb <= 24'h228B22; 
					 
					 
					 
				 
				 // platform 5 level 3 top	 
				end else if ((v_count >= 450) && (v_count < 451) && (h_count <= 300) && (h_count > 270)) begin				
                rgb <= 24'hFF10F0;	 					 					 
				// platform 5 level 3 bottom
				end else if ((v_count >= 453) && (v_count < 454) && (h_count <= 300) && (h_count > 270)) begin				
                rgb <= 24'hFF10F0;
					 
				 // platform 6 level 3 top	 
				end else if ((v_count >= 450) && (v_count < 451) && (h_count <= 220) && (h_count > 190)) begin				
                rgb <= 24'hFF10F0;	 					 					 
				// platform 6 level 3 bottom
				end else if ((v_count >= 453) && (v_count < 454) && (h_count <= 220) && (h_count > 190)) begin				
                rgb <= 24'hFF10F0;
					 
				 // platform 7 level 3 top	 
				end else if ((v_count >= 450) && (v_count < 451) && (h_count <= 140) && (h_count > 110)) begin				
                rgb <= 24'hFF10F0;	 					 					 
				// platform 7 level 3 bottom
				end else if ((v_count >= 453) && (v_count < 454) && (h_count <= 140) && (h_count > 110)) begin				
                rgb <= 24'hFF10F0;
					 
				 // platform 8 level 3 top	 
				end else if ((v_count >= 450) && (v_count < 451) && (h_count <= 60) && (h_count > 30)) begin				
                rgb <= 24'hFF10F0;	 					 					 
				// platform 8 level 3 bottom
				end else if ((v_count >= 453) && (v_count < 454) && (h_count <= 60) && (h_count > 30)) begin				
                rgb <= 24'hFF10F0;
					 
					 // platform 9 level 3 top	 
				end else if ((v_count >= 350) && (v_count < 351) && (h_count <= 20) && (h_count > 0)) begin				
                rgb <= 24'h00FFFF;	 					 					 
				// platform 9 level 3 bottom
				end else if ((v_count >= 353) && (v_count < 354) && (h_count <= 20) && (h_count > 0)) begin				
                rgb <= 24'h00FFFF;
					 
					 // platform 10 level 3 top	 
				end else if ((v_count >= 250) && (v_count < 251) && (h_count <= 90) && (h_count > 60)) begin				
                rgb <= 24'hFFD700;	 					 					 
				// platform 10 level 3 bottom
				end else if ((v_count >= 253) && (v_count < 254) && (h_count <= 90) && (h_count > 60)) begin				
                rgb <= 24'hFFD700;
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
				end else begin
				
                rgb <= 24'h000000; // Right side of the screen (Black)
				 end
					
				
				
				
			end else if ((h_count < 640) && (v_count < 480) && (level == 2'b11) ) begin
					 
				 // Red square
            if (note_visible_1) begin
                rgb <= 24'hFF0000; 
					 
					 
				// red outline bottom
				end else if ((v_count >= 470) && (v_count < 480) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000; 
					// red outline top
				end else if ((v_count >= 0) && (v_count < 3) && (h_count <= 639) && (h_count > 0)) begin
					rgb <= 24'hFF0000;	 
					 
				
					 
					 
					 
					 
					 
					 
				 // letter y
            end else if ((v_count >= 40) && (v_count < 60) && (h_count <= 20) && (h_count > 10)) begin			
                rgb <= 24'hFFFFFF; 
				// letter Y
            end else if ((v_count >= 40) && (v_count < 60) && (h_count <= 40) && (h_count > 30)) begin				
                rgb <= 24'hFFFFFF;
				  // letter Y
            end else if ((v_count >= 60) && (v_count < 80) && (h_count <= 30) && (h_count > 20)) begin			
                rgb <= 24'hFFFFFF;
					
				
				
				 // letter O
            end else if ((v_count >= 45) && (v_count < 75) && (h_count <= 60) && (h_count > 50)) begin			
                rgb <= 24'hFFFFFF; 
				// letter O
            end else if ((v_count >= 40) && (v_count < 45) && (h_count <= 75) && (h_count > 60)) begin				
                rgb <= 24'hFFFFFF;
				  // letter o
            end else if ((v_count >= 45) && (v_count < 75) && (h_count <= 85) && (h_count > 75)) begin			
                rgb <= 24'hFFFFFF; 
				 // letter O
            end else if ((v_count >= 75) && (v_count < 80) && (h_count <= 75) && (h_count > 60)) begin				
                rgb <= 24'hFFFFFF;
					 
					 
					 
				// letter U
            end else if ((v_count >= 40) && (v_count < 75) && (h_count <= 105) && (h_count > 95)) begin			
                rgb <= 24'hFFFFFF; 
				// letter U
            end else if ((v_count >= 75) && (v_count < 80) && (h_count <= 120) && (h_count > 105)) begin				
                rgb <= 24'hFFFFFF;
				  // letter U
            end else if ((v_count >= 40) && (v_count < 75) && (h_count <= 130) && (h_count > 120)) begin			
                rgb <= 24'hFFFFFF; 
				
					 
				 // letter W
            end else if ((v_count >= 40) && (v_count < 60) && (h_count <= 160) && (h_count > 150)) begin			
                rgb <= 24'hFFFFFF; 
				// letter W
            end else if ((v_count >= 50) && (v_count < 60) && (h_count <= 180) && (h_count > 170)) begin				
                rgb <= 24'hFFFFFF;
				  // letter W
            end else if ((v_count >= 60) && (v_count < 80) && (h_count <= 170) && (h_count > 160)) begin			
                rgb <= 24'hFFFFFF;
				// letter W
            end else if ((v_count >= 60) && (v_count < 80) && (h_count <= 190) && (h_count > 180)) begin			
                rgb <= 24'hFFFFFF;
				// letter W
            end else if ((v_count >= 40) && (v_count < 60) && (h_count <= 200) && (h_count > 190)) begin			
                rgb <= 24'hFFFFFF;	
					
				
					// letter i
            end else if ((v_count >= 50) && (v_count < 80) && (h_count <= 220) && (h_count > 210)) begin			
                rgb <= 24'hFFFFFF;
					 // letter i
            end else if ((v_count >= 40) && (v_count < 45) && (h_count <= 220) && (h_count > 210)) begin			
                rgb <= 24'hFFFFFF;
					 
				 // letter N
            end else if ((v_count >= 40) && (v_count < 80) && (h_count <= 240) && (h_count > 230)) begin			
                rgb <= 24'hFFFFFF; 
				// letter N
            end else if ((v_count >= 50) && (v_count < 55) && (h_count <= 245) && (h_count > 240)) begin				
                rgb <= 24'hFFFFFF;
				  // letter N
            end else if ((v_count >= 55) && (v_count < 60) && (h_count <= 250) && (h_count > 245)) begin			
                rgb <= 24'hFFFFFF;
				// letter N
            end else if ((v_count >= 60) && (v_count < 65) && (h_count <= 255) && (h_count > 250)) begin			
                rgb <= 24'hFFFFFF;
				// letter N
            end else if ((v_count >= 65) && (v_count < 70) && (h_count <= 260) && (h_count > 255)) begin			
                rgb <= 24'hFFFFFF;
					 // letter N
            end else if ((v_count >= 40) && (v_count < 80) && (h_count <= 270) && (h_count > 260)) begin			
                rgb <= 24'hFFFFFF;
					 
					 
					 
					 
					 
					// horizontal cyan line plat 1 top
            end else if ((v_count >= 440) && (v_count < 441) && (h_count <= 470) && (h_count > 420)) begin			
                rgb <= 24'h00FFFF; 
				// horizontal cyan line plat 1 bottom
            end else if ((v_count >= 443) && (v_count < 444) && (h_count <= 470) && (h_count > 420)) begin				
                rgb <= 24'h00FFFF;
					 

					 

					 
					 
					 
					 
					 
					 
					 
				end else begin
				
                rgb <= 24'h000000; // Right side of the screen (Black)
				 end
				
        end else begin
		  
            rgb <= 24'h000000; // Outside the active area
				
        end
    end

endmodule
