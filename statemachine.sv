module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);
						  
	reg [2:0] state; //used to control state logic						 

	// The code describing your state machine will go here.  Remember that
	// a state machine consists of next state logic, output logic, and the 
	// registers that hold the state.  You will want to review your notes from
	// CPEN 211 or equivalent if you have forgotten how to write a state machine.

	`define reset_state 3'b000 //reset state
	`define pc1_state 3'b001 //Player Card 1 state
	`define dc1_state 3'b010 //Dealer Card 1 state
	`define pc2_state 3'b011 //Player Card 2 state
	`define dc2_state 3'b100 //Dealer Card 2 state
	`define pc3_state 3'b101 //Player Card 3 state
	`define dc3_state 3'b110 //Dealer Card 3 state
	`define winner_state 3'b111 //Winner state

	always_ff@(posedge slow_clock)begin //FF at posedge of clock, used to change between states based off desired cases
		
		if(resetb==0)begin
		state=`reset_state; //if reset, reest the state machine
		end else begin

			case(state)
			
				`reset_state:state<=`pc1_state;  //default state transtions
				`pc1_state:state<=`dc1_state;
				`dc1_state:state<=`pc2_state;
				`pc2_state:state<=`dc2_state;
				`dc3_state:state<=`winner_state;
				
				

				`dc2_state:if(pscore>=4'd8 || dscore>=4'd8)begin  //dealer card 2 trasistions, dependent on both the curretn player score and dealer score
					 
						state<=`winner_state; 
					 
					 end else if(pscore<=4'd5 && dscore<=4'd7)begin
						
						state<=`pc3_state;
					 
					 end else if(dscore<=4'd5&&pscore<=4'd7)begin
					 
						state<=`dc3_state;
						
					end else begin
					
						state=`winner_state;
					end
				
	
						
				`pc3_state: if(dscore==4'd6 && (pcard3==4'd6 || pcard3==4'd7))begin  //player card 3 transistions, dependent on dealer score and the card recivied only
						
						state<=`dc3_state;
						
					end else if(dscore==4'd5 && (pcard3==4'd6 || pcard3==4'd7||pcard3==4'd5 || pcard3==4'd4))begin
					
						state<=`dc3_state;
						
					end else if(dscore==4'd4 && (pcard3==4'd6 || pcard3==4'd7||pcard3==4'd5 || pcard3==4'd4||pcard3==4'd3 || pcard3==4'd2))begin
					
						state<=`dc3_state;
						
					end else if(dscore==4'd3 && pcard3==4'd8)begin
					
						state<=`winner_state;
						
					end else if(dscore==4'd3)begin
					
						state<=`dc3_state;
						
					end else if(dscore==4'd7)begin
					
						state<=`winner_state;
						
					end else begin
					
						state<=`dc3_state;
						
					end
					
				default:state<=`winner_state;
				
			endcase
			
		end
		
	end

	always@(*)begin //logic of the state machine
	
		load_pcard1=1'b0;
		load_pcard2=1'b0; 
		load_pcard3=1'b0;
		
		load_dcard1=1'b0;
		load_dcard2=1'b0;
		load_dcard3=1'b0;
		
		player_win_light=1'b0;
		dealer_win_light=1'b0;
		
			case(state) //case statemetn for assigining loadcards and win lights
			
				`pc1_state:load_pcard1=1'b1;
				`pc2_state:load_pcard2=1'b1;
				`pc3_state:load_pcard3=1'b1;
				
				`dc1_state:load_dcard1=1'b1;
				`dc2_state:load_dcard2=1'b1;
				`dc3_state:load_dcard3=1'b1;
				
				`winner_state:if(pscore==dscore)begin
				
					player_win_light=1'b1;
					dealer_win_light=1'b1;
					
					end else if(pscore>=dscore)begin
					
					player_win_light=1'b1;
					
					end else	begin
					
					dealer_win_light=1'b1;
					
					end
					
			endcase
	end

endmodule

