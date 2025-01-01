module tb_statemachine();
reg slow_clock;
reg resetb;
reg [3:0] dscore;
reg [3:0] pscore;
reg [3:0] pcard3;
wire load_pcard1;
wire load_pcard2;
wire load_pcard3;
wire load_dcard1;
wire load_dcard2;
wire load_dcard3;
wire player_win_light;
wire dealer_win_light;

reg error;

statemachine dut(slow_clock,resetb,dscore,pscore,pcard3,load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light);

task test;
input player_win_light_test;
input dealer_win_light_test;
input load_pcard1_test;
input load_pcard2_test;
input load_pcard3_test;
input load_dcard1_test;
input load_dcard2_test;
input load_dcard3_test;

error=1'b0;

	if(tb_statemachine.dut.player_win_light!=player_win_light_test)begin
		error=1'b1;
		$display("player_win_light_error");
		end
		
	if(tb_statemachine.dut.dealer_win_light!=dealer_win_light_test)begin
		error=1'b1;
		$display("dealer_win_light_error");
		end
	
	if(tb_statemachine.dut.load_pcard1!=load_pcard1_test)begin
		error=1'b1;
		$display("load_pcard1");
		end
		
	if(tb_statemachine.dut.load_pcard2!=load_pcard2_test)begin
		error=1'b1;
		$display("load_pcard2");
		end
		
	if(tb_statemachine.dut.load_pcard3!=load_pcard3_test)begin
		error=1'b1;
		$display("load_pcard3");
		end
		
	if(tb_statemachine.dut.load_dcard1!=load_dcard1_test)begin
		error=1'b1;
		$display("load_dcard1");
		end
		
	if(tb_statemachine.dut.load_dcard2!=load_dcard2_test)begin
		error=1'b1;
		$display("load_dcard2");
		end
		
	if(tb_statemachine.dut.load_dcard3!=load_dcard3_test)begin
		error=1'b1;
		$display("load_dcard3");
		end
		
endtask

initial begin

	resetb=1'b0;
	slow_clock=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5

	slow_clock=1'b1; //testing a tie with two nines
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=9; pscore=9;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5
	
	slow_clock=1'b1; //testing a player win 9-8
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=8; pscore=9;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5
	
	slow_clock=1'b1; //testing a dealer win 8-9
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=9; pscore=9;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5
	
	slow_clock=1'b1; //testing a player win 7-5 aka 2 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=5; pscore=6;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;

	slow_clock=1'b1; //testing a dealer win 7-5 aka 3 card player 2 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=7; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	slow_clock=1'b1; //testing a dealer win 6-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=6; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	slow_clock=1'b1; //testing a dealer win 5-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=5; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	slow_clock=1'b1; //testing a dealer win 4-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=4; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	slow_clock=1'b1; //testing a dealer win 3-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=3; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	
	slow_clock=1'b1; //testing a dealer win 3-5 with the card being an 8
	#5

	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=3; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd8;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;

		slow_clock=1'b1; //testing a dealer win 2-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=2; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
		slow_clock=1'b1; //testing a dealer win 1-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=1; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
		slow_clock=1'b1; //testing a dealer win 0-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=0; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	slow_clock=1'b1; //testing a tie 7-7
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=7; pscore=7;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5
	
	slow_clock=1'b1; //testing a tie 7-7
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=7; pscore=4;
	#5
	slow_clock=1'b1;
	#5
	test(1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd6;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5
	
	slow_clock=1'b1; //testing a dealer win 6-5 aka 3 card player 3 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=6; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	pcard3=4'd2;
	pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	test(1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1);
	#2;
	pcard3=4'b1111;
	#1;
	pcard3=4'b0;
	#2;
	pscore=4'b1111;
	#1;
	pscore=4'b0;
	#2;
	dscore=4'b1111;
	#1;
	dscore=4'b0;
	
	slow_clock=1'b1; //testing a dealer win 7-5 aka 3 card player 2 card dealer
	#5
	test(1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0);
	slow_clock=1'b0;
	dscore=5; pscore=5;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	dscore=7;
	#5
	slow_clock=1'b1;
	#5
	test(1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0);
	slow_clock=1'b0;
	resetb=1'b0;
	#5;
	slow_clock=1'b1;
	#5
	slow_clock=1'b0;
	resetb=1'b1;
	#5;
	
	

end
// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

endmodule
