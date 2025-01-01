module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.

	reg [3:0] scorevalue;

	wire [3:0] scorevalue1; //internal signals for scorehand
	wire [3:0] scorevalue2;
	wire [3:0] scorevalue3;
	


	cardvalue cv1(card1,scorevalue1); // using cardvalue module to calculate scorevalues
	cardvalue cv2(card2,scorevalue2);
	cardvalue cv3(card3,scorevalue3);

		always@(*)begin
			
			total=(scorevalue1 + scorevalue2 + scorevalue3)% 10; //logic for the total score
		
		end
		

endmodule


module cardvalue(input wire [3:0] card, output reg [3:0] value);

	always@(*)begin
		
		case(card) //case to decide what values stay
			
			4'b0001:value=4'b0001;
			4'b0010:value=4'b0010;
			4'b0011:value=4'b0011;
			4'b0100:value=4'b0100;
			4'b0101:value=4'b0101;
			4'b0110:value=4'b0110;
			4'b0111:value=4'b0111;
			4'b1000:value=4'b1000;
			4'b1001:value=4'b1001;
			default:value=4'b0000;
		
		endcase
		
	end
	
endmodule
	
