module tb_task5();
reg CLOCK_50;
reg [3:0] KEY;
wire [9:0] LEDR;
wire [6:0] HEX5;
reg [6:0] HEX4;
reg [6:0] HEX3;
reg [6:0] HEX2;
reg [6:0] HEX1;
reg [6:0] HEX0;

reg error;

task5 dut(.CLOCK_50(CLOCK_50),.KEY(KEY),.LEDR(LEDR),.HEX5(HEX5),.HEX4(HEX4),.HEX3(HEX3),.HEX2(HEX2),.HEX1(HEX1),.HEX0(HEX0));

task test;
input [9:0] LEDR_test;
input [6:0] HEX5_test;
input [6:0] HEX4_test;
input [6:0] HEX3_test;
input [6:0] HEX2_test;
input [6:0] HEX1_test;
input [6:0] HEX0_test;

error=1'b0;

	if(tb_task5.dut.LEDR!=LEDR_test)begin
	error=1'b1;
	$display("LEDR error");
	end
	
	if(tb_task5.dut.HEX5!=HEX5_test)begin
	error=1'b1;
	$display("HEX5 error");
	end
	
	if(tb_task5.dut.HEX4!=HEX4_test)begin
	error=1'b1;
	$display("HEX4 error");
	end
	
	if(tb_task5.dut.HEX3!=HEX3_test)begin
	error=1'b1;
	$display("HEX3 error");
	end
	
		if(tb_task5.dut.HEX2!=HEX2_test)begin
	error=1'b1;
	$display("HEX2 error");
	end
	
	if(tb_task5.dut.HEX1!=HEX1_test)begin
	error=1'b1;
	$display("HEX1 error");
	end
	
	if(tb_task5.dut.HEX0!=HEX0_test)begin
	error=1'b1;
	$display("HEX0 error");
	end
	
endtask

initial begin
KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0;
#5;
KEY[0]=1'b1;
CLOCK_50=1'b1;
#5;
KEY[3]=1'b1;
CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#5

//test a full game with the cards being ACES step by step
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0001000); //should be one ace in PC1, score also updated


KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000010001,7'b1111111,7'b1111111,7'b0001000,7'b1111111,7'b1111111,7'b0001000);//should be second card in DC1, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000010010,7'b1111111,7'b1111111,7'b0001000,7'b1111111,7'b0001000,7'b0001000);//should be third card in PC2, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000100010,7'b1111111,7'b0001000,7'b0001000,7'b1111111,7'b0001000,7'b0001000);//should be fourth card in DC2, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000100011,7'b1111111,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000);//should be fifth card in PC3, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b1100110011,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000);//should be sixth card in DC3, score also updated, win light on


//Game reset
KEY[3]=1'b0;
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[3]=1'b1;

//load desired card, Trying the case 10, nine, Ace, Ace, Ace, Ace, test case to make sure DC2 score is used

//to get a 10, cylce fastclock 9 times, no need to wait
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//two
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//three
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//four
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//five
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//six
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//seven
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//eight
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//nine
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//ten
#1
CLOCK_50=1'b0;


//loading 10 in pcard
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1000000); //test pc1 is 10, score is 0

CLOCK_50=1'b1;//jack
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//queen
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//king
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//ace
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//two
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//three
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//four
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//five
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//six
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//seven
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//eight
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//nine
#1
CLOCK_50=1'b0;



//loading 9 into d card

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0010010000,7'b1111111,7'b1111111,7'b0010000,7'b1111111,7'b1111111,7'b1000000); //DC1 should have a nine, score should update



CLOCK_50=1'b1;//ten
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//jack
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//queen
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//king
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//ace
#1
CLOCK_50=1'b0;

//load Ace pcard2

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0010010001,7'b1111111,7'b1111111,7'b0010000,7'b1111111,7'b0001000,7'b1000000); //PC2 should hold and Ace, score update

//load Ace dcard2

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000001,7'b1111111,7'b0001000,7'b0010000,7'b1111111,7'b0001000,7'b1000000); //DC2 should hold and Ace, score update

//load Ace pcard3

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000010,7'b1111111,7'b0001000,7'b0010000,7'b0001000,7'b0001000,7'b1000000); //PC3 should hold and Ace, score update

//load Ace dcard3

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0100010010,7'b0001000,7'b0001000,7'b0010000,7'b0001000,7'b0001000,7'b1000000); //DC3 should hold and Ace, score update

//Game reset
KEY[3]=1'b0;
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[3]=1'b1;

//test natural win so dealer 9-0

//to get a 10, cylce fastclock 9 times, no need to wait
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//two
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//three
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//four
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//five
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//six
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//seven
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//eight
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//nine
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//ten
#1
CLOCK_50=1'b0;


//loading 10 in pcard
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1000000); //test pc1 is 10, score is 0

CLOCK_50=1'b1;//jack
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//queen
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//king
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//ace
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//two
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//three
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//four
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//five
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//six
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//seven
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//eight
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//nine
#1
CLOCK_50=1'b0;



//loading 9 into d card

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0010010000,7'b1111111,7'b1111111,7'b0010000,7'b1111111,7'b1111111,7'b1000000); //DC1 should have a nine, score should update

CLOCK_50=1'b1;//ten
#1
CLOCK_50=1'b0;
#1
CLOCK_50=1'b1;//jack
#1
CLOCK_50=1'b0;

//loading jack into PC2
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0010010000,7'b1111111,7'b1111111,7'b0010000,7'b1111111,7'b1100001,7'b1000000); //DC1 should have a nine, score should update

//loading jack into DC2
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b1010010000,7'b1111111,7'b1100001,7'b0010000,7'b1111111,7'b1100001,7'b1000000); //DC1 should have a nine, score should update, win for dealer should appear

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b1010010000,7'b1111111,7'b1100001,7'b0010000,7'b1111111,7'b1100001,7'b1000000); //Test to make sure game ended, AE no extra cards

//test for all HEX outputs starting with two

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0;
#5;
KEY[0]=1'b1;
CLOCK_50=1'b1;
#5;
KEY[3]=1'b1;
CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#5

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
//test a full game with the cards being two step by step
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000000010,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100100); //should be one ace in PC1, score also updated


KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000100010,7'b1111111,7'b1111111,7'b0100100,7'b1111111,7'b1111111,7'b0100100);//should be second card in DC1, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0000100100,7'b1111111,7'b1111111,7'b0100100,7'b1111111,7'b0100100,7'b0100100);//should be third card in PC2, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0001000100,7'b1111111,7'b0100100,7'b0100100,7'b1111111,7'b0100100,7'b0100100);//should be fourth card in DC2, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b0001000110,7'b1111111,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100);//should be fifth card in PC3, score also updated

KEY[0]=1'b0;
#5
KEY[0]=1'b1;
#5
test(10'b1101100110,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100);//should be sixth card in DC3, score also updated, win light on



KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //getting the value of 3 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0;  


test(10'b1101100110,7'b1111111,7'b0110000,7'b0110000,7'b1111111,7'b0110000,7'b0110000);//test for 2 3s on both player and dealer
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 4 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0;  


test(10'b1110001000,7'b1111111,7'b0011001,7'b0011001,7'b1111111,7'b0011001,7'b0011001);//test for 2 4s on both player and dealer
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 5 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1101010101,7'b0010010,7'b0010010,7'b0010010,7'b0010010,7'b0010010,7'b0010010);//test for 3 5s on both player and dealer
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 6 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1110001000,7'b0000010,7'b0000010,7'b0000010,7'b0000010,7'b0000010,7'b0000010);//test for 3 6s on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 7 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1100010001,7'b1111000,7'b1111000,7'b1111000,7'b1111000,7'b1111000,7'b1111000);//test for 3 7s on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //getting the value of 8 loaded
//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1101100110,7'b1111111,7'b0000000,7'b0000000,7'b1111111,7'b0000000,7'b0000000);//test for 2 8s on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 9 loaded
//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1110001000,7'b1111111,7'b0010000,7'b0010000,7'b1111111,7'b0010000,7'b0010000);//test for 2 9s on both player and dealer
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 10 loaded
//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1100000000,7'b1000000,7'b1000000,7'b1000000,7'b1000000,7'b1000000,7'b1000000);//test for 3 10s on both player and dealer
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of jack loaded
//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1100000000,7'b1100001,7'b1100001,7'b1100001,7'b1100001,7'b1100001,7'b1100001);//test for 3 jacks on both player and dealer
#2;



KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of jack loaded
//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1100000000,7'b0011000,7'b0011000,7'b0011000,7'b0011000,7'b0011000,7'b0011000);//test for 3 Queens on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of jack loaded
//test a full game with the cards being Kings step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1100000000,7'b0001001,7'b0001001,7'b0001001,7'b0001001,7'b0001001,7'b0001001);//test for 3 Kings on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
// test case d4, p7, card being and 8
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;  KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;//three
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; //card is now four
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;  KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //four four
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0;

KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2;//gives 10
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; CLOCK_50=1'b1; #2; CLOCK_50=1'b0;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; CLOCK_50=1'b1; #2; CLOCK_50=1'b0;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; CLOCK_50=1'b1; #2; CLOCK_50=1'b0;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; 
#2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; 


test(10'b0100000111,7'b0000000,7'b0000000,7'b0011001,7'b1111111,7'b0011001,7'b0110000);//test for 3 card dealer, two card player
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;

KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;//give Ace
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //load 2
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //give 2
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //load 4
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;   KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //give both for so 5-6
//test a full game with the cards being Kings step by step
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//load 6
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; 


test(10'b1000100001,7'b0000010,7'b0011001,7'b0100100,7'b0000010,7'b0011001,7'b0001000);//test for 3 Kings on both player and dealer
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 4 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0;  


test(10'b1110011001,7'b0011001,7'b0011001,7'b0001000,7'b0011001,7'b0011001,7'b0001000);//test for 2 4s and aces both
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //getting the value of 3 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0;  


test(10'b1101110111,7'b0110000,7'b0110000,7'b0001000,7'b0110000,7'b0110000,7'b0001000);//test for 2 3s and aces both
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //getting the value of 2 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
#2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //load 8
KEY[0]=1'b0; #2; 


test(10'b1000110001,7'b1111111,7'b0100100,7'b0001000,7'b0000000,7'b0100100,7'b0001000);//test for 3s with the player 8
#2;

KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; //getting the value of 2 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1;
CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
#2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //load 8
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2;


test(10'b1100100010,7'b0010000,7'b0100100,7'b0001000,7'b0010000,7'b0100100,7'b0001000);//test for 3s with the player 8
#2;


KEY=4'b0; //reset values and test that everything was reset
CLOCK_50=1'b0; KEY[3]=1'b0; #2; KEY[0]=1'b1; CLOCK_50=1'b1; #2; KEY[0]=1'b0; #2; KEY[3]=1'b1; CLOCK_50=1'b0;
test(10'b0000000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
#2;
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2;//give triple aces

CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;//getting the value of 2 loaded

//test a full game with the cards being two step by step
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1;

 CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2; CLOCK_50=1'b1; #2; CLOCK_50=1'b0; #2;
#2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; //load 8
KEY[0]=1'b0; #2; KEY[0]=1'b1; #2; KEY[0]=1'b0; #2;


test(10'b0101111000,7'b1111111,7'b1111000,7'b0001000,7'b1111000,7'b0001000,7'b0001000);//test for 3s with the player 8
#2;

test(10'b0101011001,7'b1110111,7'b0000010,7'b0001100,7'b0000010,7'b0001100,7'b0101000);//test for 3s with the player 8
#2;

test(10'b1111111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);//test for 3s with the player 8
#2;

test(10'b0000000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000);//test for 3s with the player 8
#2;

test(10'b1111111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);//test for 3s with the player 8
#2;

test(10'b0000000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000);//test for 3s with the player 8
#2;

KEY=4'b1111;
#2;
KEY=4'b0000;
#2;
KEY=4'b1111;
#2;
KEY=4'b0000;
#2;
CLOCK_50=1'b1;
#2;
CLOCK_50=1'b0;
#2;
error=1'b0;
#2;
error=1'b1;
#2;
error=1'b0;
#2;
error=1'b1;

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").
end
endmodule
