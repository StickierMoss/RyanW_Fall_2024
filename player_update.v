module player_update(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [19:0] speed,
    input wire [15:0] rand,
	 input wire [2:0] player_input,
    output reg [9:0] active_column,
    output reg [9:0] note_y_position,
    output reg note_active,
	 output reg [2:0] level
);

    parameter SPAWN_THRESHOLD = 16'h8000;  // Adjust this to control how often notes are displayed.
    
    reg [19:0] counter; //Used to begin to control the speed.
	 
	 reg touch_v; // detects tops of platforms
	 
	 reg touch_w; // detects walls of platforms
	 
	 reg [19:0] gravity; // implements a gravity constant for better falling
	 
	 
    
    always @(posedge clk or posedge rst) begin
	 
        if (rst) begin
		  
            active_column <= 2;  //2'b00;
				
            note_y_position <= 100;
				
            note_active <= 0;
				
            counter <= 0;
				
				gravity <= 0;
				
				level <= 2'b00;
				
				
        end else if (start) begin
		  
            if (counter >= speed) begin
				
                counter <= 0;
					 
                if (note_active && (level == 2'b00)) begin
					 
						  note_y_position <= note_y_position + (gravity >> 3);
						  
						  touch_v = 0;
								
						  if (gravity != 25) begin
								
								gravity <= gravity + 1;
								
						  end
					 
						  ///////// move right logik//////////////////
			           if (((active_column >= 2) && (active_column <= 629)) && player_input[0] == 1'b0) begin ///////// move right logik
								
								active_column <= active_column + 1;
						  end
						  
						  //////////// move left logik ///////////////////// 
						  if (((active_column >= 3) && (active_column <= 630)) && player_input[2] == 1'b0) begin //////////// move left logik
								
								active_column <= active_column - 1;
						  end
						  
						  ///////////// dual movement imput logik ///////////////
						  if (((active_column >= 0) && (active_column <= 630)) && (player_input[2] == 1'b0 && player_input[0] == 1'b0)) begin //// 
								
								active_column <= active_column;
						  end
						  
							//////// off screen (bottom) logik //////////////
                    if (note_y_position >= 480) begin
						  
                        note_active <= 1;
								
								note_y_position <= 100;
								
								active_column <= 10;
								
						  end	
						  
							/////////// stop falliong on platform logik //////////////////	/////////// platform 1 ///////////////////
						  if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 150) && (active_column >= 0))) begin						  
						  //////// SNAP BACK LOGIK //////////////////////////////
								if (note_y_position != 373) begin								
									note_y_position <= 373;									
								end							
								//note_y_position <= note_y_position - (note_y_position - 370);								
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 2 ///////////////////
						   if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 350) && (active_column >= 190))) begin						
								if (note_y_position != 373) begin								
									note_y_position <= 373;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  
							/////////// platform 3 ///////////////////
							if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 475) && (active_column >= 415))) begin							
								if (note_y_position != 373) begin							
									note_y_position <= 373;									
								end								
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 4 ///////////////////
						  if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 600) && (active_column >= 540))) begin						
								if (note_y_position != 373) begin								
									note_y_position <= 373;									
								end								
								gravity <= 0;								
								touch_v = 1;
						  end
						  
						  
						  /////////// platform 5 ///////////////////
						  if (((note_y_position <= 290) && (note_y_position >= 281)) && ((active_column <= 600) && (active_column >= 540))) begin
								if (note_y_position != 283) begin
									note_y_position <= 283;
								end
								gravity <= 0;
								touch_v = 1;
						  end
						  
						  
						  /////////// platform 6 ///////////////////
						  if (((note_y_position <= 240) && (note_y_position >= 231)) && ((active_column <= 500) && (active_column >= 415))) begin							
								if (note_y_position != 233) begin								
									note_y_position <= 233;									
								end																
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 7 ///////////////////
						  if (((note_y_position <= 165) && (note_y_position >= 156)) && ((active_column <= 375) && (active_column >= 305))) begin							
								if (note_y_position != 158) begin								
									note_y_position <= 158;									
								end																
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 8 ///////////////////
						  if (((note_y_position <= 129) && (note_y_position >= 120)) && ((active_column <= 250) && (active_column >= 210))) begin							
								if (note_y_position != 122) begin								
									note_y_position <= 122;									
								end																
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 9 ///////////////////
						  if (((note_y_position <= 247) && (note_y_position >= 238)) && ((active_column <= 200) && (active_column >= 160))) begin							
								if (note_y_position != 240) begin								
									note_y_position <= 240;									
								end																
								gravity <= 0;								
								touch_v = 1;
								level <= 2'b01;
						  end

						  /////////////// collision logik ///////////////////
						  if ((player_input[1] == 1'b0) && (touch_v == 1)) begin
								if (gravity != -20) begin
								
								gravity <= gravity - 20'd10;
								
								end
								
								touch_v = 0;
							end
							
//////////////////////////////////////////////////////////////////////////////////// LEVEL 2 logik ////////////////////////////////////////////////////////		
					 end else if (note_active && (level == 2'b01)) begin
						  note_y_position <= note_y_position + (gravity >> 3);
						  
						  touch_v = 0;
						  
								
						  if (gravity != 25) begin
								
								gravity <= gravity + 1;
								
						  end
						  
						  ///////// move right logik//////////////////
			           if (((active_column >= 2) && (active_column <= 629)) && player_input[0] == 1'b0) begin ///////// move right logik
								
								active_column <= active_column + 1;
						  end
						  
						  //////////// move left logik ///////////////////// 
						  if (((active_column >= 3) && (active_column <= 630)) && player_input[2] == 1'b0) begin //////////// move left logik
								
								active_column <= active_column - 1;
						  end
						  
						  ///////////// dual movement imput logik ///////////////
						  if (((active_column >= 0) && (active_column <= 630)) && (player_input[2] == 1'b0 && player_input[0] == 1'b0)) begin //// 
								
								active_column <= active_column;
						  end
						  
							//////// off screen (bottom) logik //////////////
                    if (note_y_position >= 480) begin
						  
                        note_active <= 1;
								
								note_y_position <= 250;
								
								active_column <= 180;
								
						  end
						  
						  
							/////////// stop falliong on platform logik //////////////////	/////////// platform 1 ///////////////////
						  if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 75) && (active_column >= 0))) begin						  
						  //////// SNAP BACK LOGIK //////////////////////////////
								if (note_y_position != 373) begin								
									note_y_position <= 373;									
								end							
								//note_y_position <= note_y_position - (note_y_position - 370);								
								gravity <= 0;								
								touch_v = 1;								
						  end
						  
						  
						  /////////// platform 2 ///////////////////
						   if (((note_y_position <= 380) && (note_y_position >= 371)) && ((active_column <= 200) && (active_column >= 140))) begin						
								if (note_y_position != 373) begin								
									note_y_position <= 373;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 3 level 2 ///////////////////
						   if (((note_y_position <= 274) && (note_y_position >= 260)) && ((active_column <= 75) && (active_column >= 20))) begin						
								if (note_y_position != 263) begin								
									note_y_position <= 263;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 3 level 2 ///////////////////
						   if (((note_y_position <= 276) && (note_y_position >= 275)) && ((active_column <= 75) && (active_column >= 20))) begin														
								gravity <= 0;
									if (note_y_position != 277) begin								
									note_y_position <= 277;									
								end
						  end
						  
						  
						  
						  /////////// platform 4 level 2 ///////////////////
						   if (((note_y_position <= 164) && (note_y_position >= 150)) && ((active_column <= 45) && (active_column >= 0))) begin						
								if (note_y_position != 153) begin								
									note_y_position <= 153;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 4 level 2 ///////////////////
						   if (((note_y_position <= 166) && (note_y_position >= 165)) && ((active_column <= 45) && (active_column >= 0))) begin														
								gravity <= 0;
									if (note_y_position != 167) begin								
									note_y_position <= 167;									
								end
						  end
						  
						  
						  /////////// platform 5 level 2 ///////////////////
						   if (((note_y_position <= 54) && (note_y_position >= 40)) && ((active_column <= 150) && (active_column >= 20))) begin						
								if (note_y_position != 43) begin								
									note_y_position <= 43;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 5 level 2 ///////////////////
						   if (((note_y_position <= 56) && (note_y_position >= 55)) && ((active_column <= 150) && (active_column >= 20))) begin														
								gravity <= 0;
									if (note_y_position != 57) begin								
									note_y_position <= 57;									
								end
						  end
						  
						  
						  /////////// platform 6 level 2 ///////////////////
						   if (((note_y_position <= 224) && (note_y_position >= 210)) && ((active_column <= 250) && (active_column >= 165))) begin														
									if (note_y_position != 213) begin								
									note_y_position <= 213;									
								end
								gravity <= 0;
								touch_v = 1;
						  end
						  
						  
						  /////////// platform 6 level 2 ///////////////////
						   if (((note_y_position <= 226) && (note_y_position >= 225)) && ((active_column <= 250) && (active_column >= 165))) begin														
								if (note_y_position != 227) begin								
									note_y_position <= 227;									
								end
								gravity <= 0;
						  end
						  
						  /////////// platform 7 ///////////////////
						   if (((note_y_position <= 431) && (note_y_position >= 421)) && ((active_column <= 600) && (active_column >= 340))) begin						
								if (note_y_position != 423) begin								
									note_y_position <= 423;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 8 ///////////////////
						   if (((note_y_position <= 421) && (note_y_position >= 411)) && ((active_column <= 600) && (active_column >= 570))) begin						
								//if (note_y_position != 413) begin								
									//note_y_position <= 413;									
								//end								
								//gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 9 ///////////////////
						   if (((note_y_position <= 411) && (note_y_position >= 401)) && ((active_column <= 600) && (active_column >= 570))) begin						
								//if (note_y_position != 403) begin								
									//note_y_position <= 403;									
								//end								
								//gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 11 ///////////////////
						  if (((note_y_position <= 254) && (note_y_position >= 240)) && ((active_column <= 430) && (active_column >= 390))) begin							
								if (note_y_position != 243) begin								
									note_y_position <= 243;									
								end																
								gravity <= 0;								
								touch_v = 1;
								level <= 2'b10;
						  end
						  
						  /////////// platform 12 ///////////////////
						  if (((note_y_position <= 224) && (note_y_position >= 210)) && ((active_column <= 500) && (active_column >= 470))) begin							
								if (note_y_position != 213) begin								
									note_y_position <= 213;									
								end																
								gravity <= 0;								
								touch_v = 1;
								
						  end
						  
						  
						  /////////////// collision logik ///////////////////
						  if ((player_input[1] == 1'b0) && (touch_v == 1)) begin
								if (gravity != -20) begin
								
								gravity <= gravity - 20'd10;
								
								end
								
								touch_v = 0;
							end
							
							
/////////////////////////////////////////////////////////////////////////////////// level 2 logik ////////////////////////////////////////////////////////////////////////////////////////////////////////////				
					end else if (note_active && (level == 2'b10)) begin		
						 note_y_position <= note_y_position + (gravity >> 3);
						  
						  touch_v = 0;
						  
								
						  if (gravity != 25) begin
								
								gravity <= gravity + 1;
								
						  end
						  
						  ///////// move right logik//////////////////
			           if (((active_column >= 2) && (active_column <= 629)) && player_input[0] == 1'b0) begin ///////// move right logik
								
								active_column <= active_column + 1;
						  end
						  
						  //////////// move left logik ///////////////////// 
						  if (((active_column >= 3) && (active_column <= 630)) && player_input[2] == 1'b0) begin //////////// move left logik
								
								active_column <= active_column - 1;
						  end
						  
						  ///////////// dual movement imput logik ///////////////
						  if (((active_column >= 0) && (active_column <= 630)) && (player_input[2] == 1'b0 && player_input[0] == 1'b0)) begin //// 
								
								active_column <= active_column;
						  end
						  
							//////// off screen (bottom) logik //////////////
                    if (note_y_position >= 480) begin
						  
                        note_active <= 1;
								
								note_y_position <= 400;
								
								active_column <= 420;
								
						  end
						  
						  
						
						 
							
						  /////////// platform 1 ///////////////////
						   if (((note_y_position <= 441) && (note_y_position >= 431)) && ((active_column <= 470) && (active_column >= 410))) begin						
								if (note_y_position != 433) begin								
									note_y_position <= 433;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  
						  /////////// platform 1 cannon ///////////////////
						   if (((note_y_position <= 431) && (note_y_position >= 421)) && ((active_column <= 470) && (active_column >= 440))) begin						
								touch_v = 1;	
						  end
						  
						  /////////// platform 1 cannon ///////////////////
						   if (((note_y_position <= 421) && (note_y_position >= 411)) && ((active_column <= 470) && (active_column >= 440))) begin							
								touch_v = 1;	
						  end
						  
						  
						  
						  
						  
						  /////////// platform 2 ///////////////////
						   if (((note_y_position <= 236) && (note_y_position >= 226)) && ((active_column <= 570) && (active_column >= 470))) begin						
								if (note_y_position != 228) begin								
									note_y_position <= 228;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  /////////// platform 2 cannon ///////////////////
						   if (((note_y_position <= 226) && (note_y_position >= 216)) && ((active_column <= 570) && (active_column >= 540))) begin							
								touch_v = 1;	
						  end
						  
						  /////////// platform 2 cannon ///////////////////
						   if (((note_y_position <= 216) && (note_y_position >= 206)) && ((active_column <= 570) && (active_column >= 540))) begin						
								touch_v = 1;	
						  end
						  
					
						  
						  /////////// platform 3 level 3 ///////////////////
						   if (((note_y_position <= 13) && (note_y_position >= 5)) && ((active_column <= 570) && (active_column >= 570))) begin														
								gravity <= 0;
									if (note_y_position != 14) begin								
									note_y_position <= 14;									
								end
						  end
						  
						  
						  /////////// platform 4 ///////////////////
						   if (((note_y_position <= 26) && (note_y_position >= 15)) && ((active_column <= 570) && (active_column >= 350))) begin						
								if (note_y_position != 18) begin								
									note_y_position <= 18;									
								end								
								gravity <= 0;	
								touch_v = 0;	
						  end
						  
						  /////////// platform 5 ///////////////////
						   if (((note_y_position <= 451) && (note_y_position >= 442)) && ((active_column <= 300) && (active_column >= 260))) begin														
								gravity <= -40;		
						  end
						  
						  /////////// platform 6 ///////////////////
						   if (((note_y_position <= 451) && (note_y_position >= 442)) && ((active_column <= 220) && (active_column >= 180))) begin														
								gravity <= -40;		
						  end
						  
						  /////////// platform 7 ///////////////////
						   if (((note_y_position <= 451) && (note_y_position >= 442)) && ((active_column <= 140) && (active_column >= 100))) begin														
								gravity <= -40;		
						  end
						  
						  /////////// platform 8 ///////////////////
						   if (((note_y_position <= 451) && (note_y_position >= 442)) && ((active_column <= 60) && (active_column >= 20))) begin														
								gravity <= -40;		
						  end
						  
						  
						  
						  /////////// platform 9 ///////////////////
						   if (((note_y_position <= 351) && (note_y_position >= 341)) && ((active_column <= 20) && (active_column >= 0))) begin						
								if (note_y_position != 343) begin								
									note_y_position <= 343;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end
						  
						  
						  /////////// platform 10 ///////////////////
						   if (((note_y_position <= 251) && (note_y_position >= 241)) && ((active_column <= 90) && (active_column >= 50))) begin						
								if (note_y_position != 243) begin								
									note_y_position <= 243;									
								end								
								gravity <= 0;	
								touch_v = 1;
								level <= 2'b11;
						  end
					
				
			
			
						  
						  /////////////// collision logik ///////////////////
						  if ((player_input[1] == 1'b0) && (touch_v == 1)) begin
								if (gravity != -20) begin
								
								gravity <= gravity - 20'd10;
								
								end
								
								touch_v = 0;
							end


/////////////////////////////////////////////////////////////////////////////////// level 4 logik ////////////////////////////////////////////////////////////////////////////////////////////////////////////				
					end else if (note_active && (level == 2'b11)) begin		
						 note_y_position <= note_y_position + (gravity >> 3);
						  
						  touch_v = 0;
						  
								
						  if (gravity != 25) begin
								
								gravity <= gravity + 1;
								
						  end
						  
						  ///////// move right logik//////////////////
			           if (((active_column >= 2) && (active_column <= 629)) && player_input[0] == 1'b0) begin ///////// move right logik
								
								active_column <= active_column + 1;
						  end
						  
						  //////////// move left logik ///////////////////// 
						  if (((active_column >= 3) && (active_column <= 630)) && player_input[2] == 1'b0) begin //////////// move left logik
								
								active_column <= active_column - 1;
						  end
						  
						  ///////////// dual movement imput logik ///////////////
						  if (((active_column >= 0) && (active_column <= 630)) && (player_input[2] == 1'b0 && player_input[0] == 1'b0)) begin //// 
								
								active_column <= active_column;
						  end
						  
							//////// off screen (bottom) logik //////////////
                    if (note_y_position >= 480) begin
						  
                        note_active <= 1;
								
								note_y_position <= 400;
								
								active_column <= 430;
								
						  end
						  
						  
						
						 
							
						  /////////// platform 1 ///////////////////
						   if (((note_y_position <= 441) && (note_y_position >= 431)) && ((active_column <= 470) && (active_column >= 410))) begin						
								if (note_y_position != 433) begin								
									note_y_position <= 433;									
								end								
								gravity <= 0;	
								touch_v = 1;	
						  end


						  /////////////// collision logik ///////////////////
						  if ((player_input[1] == 1'b0) && (touch_v == 1)) begin
								if (gravity != -20) begin
								
								gravity <= gravity - 20'd10;
								
								end
								
								touch_v = 0;
							end							
						  
						  
                end else if (rand > SPAWN_THRESHOLD) begin
					 
                    note_active <= 1;
						  
                    note_y_position <= 100;
						  
                    active_column <= 5;  
						  
               end
					 
					 
					
				 
					 
            end else begin
				
                counter <= counter + 1;
					 
            end
        end
  end

endmodule