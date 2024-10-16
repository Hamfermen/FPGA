`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_6_tb;
	
	reg a, b, clk;

    wire q, state;


	task_6 tsk0
	(
		.clk(clk),
        .a(a),
		.b(b),
		.state(state),
		.q(q)
	);

	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	a = 0;
	b = 0;
	end

	 initial 
	begin
		$dumpfile ("task_6.vcd");
		$dumpvars(0, task_6_tb);
	end

	always
		#5 clk = !clk;

	initial begin
		#25.1
		b = 1;
		#10
		a = 1;
		b = 0;
		#10
		b = 1;
		#10
		a = 0;
		b = 0;
		#10
		a = 1;
		b = 1;
		#30
		b = 0;
		#10
		a = 0;
		b = 1;
		#10
		b = 0;
		#25
		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %b, a = %b, q = %d", $time, clk, a, q);
	end
endmodule