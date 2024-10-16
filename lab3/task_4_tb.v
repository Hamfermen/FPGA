`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_4_tb;
	
	reg a, clock;

    wire q, p;


	task_4 tsk0
	(
		.clock(clock),
        .a(a),
		.p(p),
		.q(q)
	);



	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clock = 1;
	a = 0;
	end

	 initial 
	begin
		$dumpfile ("task_4.vcd");
		$dumpvars(0, task_4_tb);
	end

	always
		#30 clock = !clock;

	initial begin
		#1
		clock = 0;
		a = 0;

		#9 
		repeat(14) begin
			#5 a = !a;
		end

		#25
		repeat(8) begin
			#5 a = !a;
		end

		#10
		a = 1;
		#10
		a = 0;
		repeat(4) begin
			#5 a = !a;
		end
		#10
		a = 1;
		#10
		a = 0;
		#10
		a = 1;

		#5 
		$display ("###################################################");
		#1 
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clock = %b, a = %b, p = %b, q = %b", $time, clock, a, p, q);
	end
endmodule