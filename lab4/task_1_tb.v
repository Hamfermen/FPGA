`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_1_tb;
	
	reg clk, reset;

    wire[9:0] q;

	task_1 tsk0
	(
		.clk(clk),
        .reset(reset),
		.q(q)
	);


	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	reset <= 1;
	end

	 initial 
	begin
		$dumpfile ("wave.vcd");
		$dumpvars(0, task_1_tb);
	end

	always
		#5 clk = !clk;

	initial begin

		#5

		reset <= 0;

		repeat (2004)
		begin
			#5;
		end

		reset <= 1;
	
		#10
		reset <= 0;
		#20

		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %h, reset = %h, q = %d", $time, clk, reset, q);
	end
endmodule