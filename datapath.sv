module datapath(input logic slow_clock, input logic  fast_clock, input logic resetb,
                input logic load_pcard1, input logic load_pcard2, input logic load_pcard3,
                input logic load_dcard1, input logic load_dcard2, input logic load_dcard3,
                output logic [3:0] pcard3_out,
                output logic [3:0] pscore_out, output logic [3:0] dscore_out,
                output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
                output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);
					 
			
	wire [3:0] pcard1_out; //internal signals for the registers
	wire [3:0] pcard2_out;
	wire [3:0] dcard1_out;
	wire [3:0] dcard2_out;
	wire [3:0] dcard3_out;
	wire [3:0] new_card; //used for dealcard

	dealcard DEALCARD(.clock(fast_clock), .resetb(resetb),.new_card(new_card)); //new_card changes value at every fast clock cyle

	reg4 pcard1(.card_toggle(load_pcard1),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(pcard1_out)); //registers for player cards, using statemachine to control load_card
	reg4 pcard2(.card_toggle(load_pcard2),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(pcard2_out));
	reg4 pcard3(.card_toggle(load_pcard3),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(pcard3_out));
	reg4 dcard1(.card_toggle(load_dcard1),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(dcard1_out));
	reg4 dcard2(.card_toggle(load_dcard2),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(dcard2_out));
	reg4 dcard3(.card_toggle(load_dcard3),.load_card(new_card),.resetb(resetb),.slow_clock(slow_clock),.card_out(dcard3_out));

	card7seg HEX0_display(.SW(pcard1_out), .HEX0(HEX0)); //logic for the HEX display on the DE1-SoC
	card7seg HEX1_display(.SW(pcard2_out), .HEX0(HEX1));
	card7seg HEX2_display(.SW(pcard3_out), .HEX0(HEX2));
	card7seg HEX3_display(.SW(dcard1_out), .HEX0(HEX3));
	card7seg HEX4_display(.SW(dcard2_out), .HEX0(HEX4));
	card7seg HEX5_display(.SW(dcard3_out), .HEX0(HEX5));

	scorehand scorehand_player(.card1(pcard1_out), .card2(pcard2_out), .card3(pcard3_out), .total(pscore_out)); //computes score of player
	scorehand scorehand_dealer(.card1(dcard1_out), .card2(dcard2_out), .card3(dcard3_out), .total(dscore_out));




endmodule

module reg4(input wire card_toggle,input wire [3:0] load_card,input wire resetb, input wire slow_clock, output reg [3:0] card_out);

	always_ff@(negedge slow_clock)begin //Flip Flop for player cards, holding their value unless reset ot new card
	
		if(resetb==0)begin
		
		card_out<=4'b0000;
		
		end else if(card_toggle) begin
		
		card_out<=load_card;
		
		end else
		
		card_out<=card_out;
		
	end
	
endmodule




