module tb_datapath();
reg slow_clock;
reg  fast_clock;
reg resetb;
reg load_pcard1;
reg load_pcard2;
reg load_pcard3;
reg load_dcard1;
reg load_dcard2;
reg load_dcard3;
wire [3:0] pcard3_out;
wire [3:0] pscore_out;
wire [3:0] dscore_out;
wire [6:0] HEX5;
wire [6:0] HEX4;
wire [6:0] HEX3;
wire [6:0] HEX2;
wire [6:0] HEX1;
wire [6:0] HEX0;

reg error;


// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

datapath dut(.slow_clock(slow_clock),.fast_clock(fast_clock),.resetb(resetb),.load_pcard1(load_pcard1),.load_pcard2(load_pcard2),.load_pcard3(load_pcard3),.load_dcard1(load_dcard1),.load_dcard2(load_dcard2),.load_dcard3(load_dcard3),.pcard3_out(pcard3_out),.pscore_out(pscore_out),.dscore_out(dscore_out),.HEX5(HEX5),.HEX4(HEX4),.HEX3(HEX3),.HEX2(HEX2),.HEX1(HEX1),.HEX0(HEX0));


task test;
input [3:0] pcard3_out_test;
input [3:0] pscore_out_test;
input [3:0] dscore_out_test;
input [6:0] HEX5_test;
input [6:0] HEX4_test;
input [6:0] HEX3_test;
input [6:0] HEX2_test;
input [6:0] HEX1_test;
input [6:0] HEX0_test;

error=1'b0;
	
	if(tb_datapath.dut.pscore_out!=pscore_out_test)begin
		error=1'b1;
		$display("pscore_out_error");
	end
	
	if(tb_datapath.dut.dscore_out!=dscore_out_test)begin
		error=1'b1;
		$display("dscore_out_error");
	end
	
	if(tb_datapath.dut.pcard3_out!=pcard3_out_test)begin
		error=1'b1;
		$display("pcard3_out_error");
	end
	
	if(tb_datapath.dut.HEX5!=HEX5_test)begin
		error=1'b1;
		$display("HEX5_error");
	end
	
	if(tb_datapath.dut.HEX4!=HEX4_test)begin
		error=1'b1;
		$display("HEX4_error");
	end
	
	if(tb_datapath.dut.HEX3!=HEX3_test)begin
		error=1'b1;
		$display("HEX3_error");
	end
	
	if(tb_datapath.dut.HEX2!=HEX2_test)begin
		error=1'b1;
		$display("HEX3_error");
	end
	
	if(tb_datapath.dut.HEX1!=HEX1_test)begin
		error=1'b1;
		$display("HEX3_error");
	end
	
	if(tb_datapath.dut.HEX0!=HEX0_test)begin
		error=1'b1;
		$display("HEX0_error");
	end
	
	
endtask	
	
	
	
initial begin
//initalizing all outputs for 0s
resetb=1'b1;
slow_clock=1'b0;
fast_clock=1'b0;
#5;
resetb=1'b0;	
slow_clock=1'b1;
fast_clock=1'b1;
#5
resetb=1'b1;
#5
//setting all inputs to 0	
load_pcard1=1'b0;
load_pcard2=1'b0;
load_pcard3=1'b0;
load_dcard1=1'b0;
load_dcard2=1'b0;
load_dcard3=1'b0;
slow_clock=1'b0;
fast_clock=1'b0;
#5


//test to ensure the registers don't pass values when they aren't supposed to
slow_clock=1'b1;
test(4'b0,4'b0,4'b0,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
load_pcard1=1'b1;
#5

//test to pcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0000,4'b0001,4'b0000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0001000);
load_pcard1=1'b0;
load_dcard1=1'b1;
#5

//test to dcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0001,4'b0001,7'b1111111,7'b1111111,7'b0001000,7'b1111111,7'b1111111,7'b0001000);
load_dcard1=1'b0;
load_pcard2=1'b1;
#5

//test to pcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0010,4'b0001,7'b1111111,7'b1111111,7'b0001000,7'b1111111,7'b0001000,7'b0001000);
load_dcard2=1'b1;
load_pcard2=1'b0;
#5

//test to dcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0010,4'b0010,7'b1111111,7'b0001000,7'b0001000,7'b1111111,7'b0001000,7'b0001000);
load_dcard2=1'b0;
load_pcard3=1'b1;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0001,4'b0011,4'b0010,7'b1111111,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000);
load_dcard3=1'b1;
load_pcard3=1'b0;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0001,4'b0011,4'b0011,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000,7'b0001000);
load_dcard3=1'b0;
load_pcard3=1'b0;



#5;
slow_clock=1'b0;
resetb=1'b0;
#2;
fast_clock=1'b1; #1; fast_clock=1'b0; #1
slow_clock=1'b1;
#1;
resetb=1'b1;
#5;
slow_clock=1'b0;

fast_clock=1'b1; #1; fast_clock=1'b0; #1fast_clock=1'b1; #1; fast_clock=1'b0; #1 fast_clock=1'b1; #1; fast_clock=1'b0; #1  fast_clock=1'b1; #1; fast_clock=1'b0; #1 fast_clock=1'b1; #1; fast_clock=1'b0; #1 fast_clock=1'b1; #1; fast_clock=1'b0; #1  fast_clock=1'b1; #1; fast_clock=1'b0; #1//eight
#5;
//test to ensure the registers don't pass values when they aren't supposed to
slow_clock=1'b1;
test(4'b0,4'b0,4'b0,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
load_pcard1=1'b1;
#5

//test to pcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0000,4'b1000,4'b0000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0000000);
load_pcard1=1'b0;
load_dcard1=1'b1;
#5

//test to dcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b1000,4'b1000,7'b1111111,7'b1111111,7'b0000000,7'b1111111,7'b1111111,7'b0000000);
load_dcard1=1'b0;
load_pcard2=1'b1;
#5

//test to pcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0110,4'b1000,7'b1111111,7'b1111111,7'b0000000,7'b1111111,7'b0000000,7'b0000000);
load_dcard2=1'b1;
load_pcard2=1'b0;
#5

//test to dcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0110,4'b0110,7'b1111111,7'b0000000,7'b0000000,7'b1111111,7'b0000000,7'b0000000);
load_dcard2=1'b0;
load_pcard3=1'b1;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b1000,4'b0100,4'b0110,7'b1111111,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000);
load_dcard3=1'b1;
load_pcard3=1'b0;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b1000,4'b0100,4'b0100,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000,7'b0000000);
load_dcard3=1'b0;
load_pcard3=1'b0;
#5;

#5;
slow_clock=1'b0;
resetb=1'b0;
#2;
fast_clock=1'b1; #1; fast_clock=1'b0;
slow_clock=1'b1;
#1;
resetb=1'b1;
#5;
slow_clock=1'b0;

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1  //two
#5;
//test to ensure the registers don't pass values when they aren't supposed to
slow_clock=1'b1;
test(4'b0,4'b0,4'b0,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111);
load_pcard1=1'b1;
#5

//test to pcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0000,4'b0010,4'b0000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b0100100);
load_pcard1=1'b0;
load_dcard1=1'b1;
#5

//test to dcard_1 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0010,4'b0010,7'b1111111,7'b1111111,7'b0100100,7'b1111111,7'b1111111,7'b0100100);
load_dcard1=1'b0;
load_pcard2=1'b1;
#5

//test to pcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0100,4'b0010,7'b1111111,7'b1111111,7'b0100100,7'b1111111,7'b0100100,7'b0100100);
load_dcard2=1'b1;
load_pcard2=1'b0;
#5

//test to dcard_2 to see if it will change values, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0,4'b0100,4'b0100,7'b1111111,7'b0100100,7'b0100100,7'b1111111,7'b0100100,7'b0100100);
load_dcard2=1'b0;
load_pcard3=1'b1;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0010,4'b0110,4'b0100,7'b1111111,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100);
load_dcard3=1'b1;
load_pcard3=1'b0;
#5

//test to pcard_3 to see if it will change values and pcard3 output gives the right value, nothing else
slow_clock=1'b0;
#5
slow_clock=1'b1;
test(4'b0010,4'b0110,4'b0110,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100,7'b0100100);
load_dcard3=1'b0;
load_pcard3=1'b0;
#5;


load_pcard1=1'b1;
load_pcard2=1'b1;
load_pcard3=1'b1;
load_dcard1=1'b1;
load_dcard2=1'b1;
load_dcard3=1'b1;

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5;

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5;

resetb=1'b1;

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5;

resetb=1'b0;

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5

#1 fast_clock=1'b1; #1; fast_clock=1'b0; #1

slow_clock=1'b0;
#5
slow_clock=1'b1;
#5;

test(4'd15,4'd15,4'd15,7'b0,7'b0,7'b0,7'b0,7'b0,7'b0);
#10;

end

endmodule
