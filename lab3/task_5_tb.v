`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_5_tb;
	
	reg a, clk;

    wire[2:0] q;


	task_5 tsk0
	(
		.clk(clk),
        .a(a),
		.q(q)
	);


	event reset;
	event reset_done;


	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	a = 1;
	end

	 initial 
	begin
		$dumpfile ("task_5.vcd");
		$dumpvars(0, task_5_tb);
	end

	always
		#5 clk = !clk;

	initial begin
		#10
		a <= 1;
		#15
		a <= 0;
		#115
		a <= 1;
		#25
		a <= 0;

		#40
		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %b, a = %b, q = %d", $time, clk, a, q);
	end
endmodule