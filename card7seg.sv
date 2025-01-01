module card7seg(input logic [3:0] SW, output logic [6:0] HEX0);
		
	always@(*)begin

		case(SW)
		
			//4'b0000:HEX0=7'b1000000; no ZERO
			4'b0001:HEX0=7'b0001000; //ACE
			4'b0010:HEX0=7'b0100100; //TWO
			4'b0011:HEX0=7'b0110000; //THREE
			4'b0100:HEX0=7'b0011001; //FOUR
			4'b0101:HEX0=7'b0010010; //FIVE
			4'b0110:HEX0=7'b0000010; //SIX
			4'b0111:HEX0=7'b1111000; //SEVEN
			4'b1000:HEX0=7'b0000000; //EIGHT
			4'b1001:HEX0=7'b0010000; //NINE
			4'b1010:HEX0=7'b1000000; //ZERO FOR TEN
			4'b1011:HEX0=7'b1100001; //JACk
			4'b1100:HEX0=7'b0011000; //QUEEN
			4'b1101:HEX0=7'b0001001; //KING
			default:HEX0=7'b1111111; //DEFAULT
			
		endcase	
		
	end
	
endmodule

