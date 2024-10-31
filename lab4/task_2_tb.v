`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_2_tb;
	
	reg clk, shift_ena, count_ena, data;

    wire[3:0] q;

	task_2 tsk0
	(
		.clk(clk),
        .shift_ena(shift_ena),
		.count_ena(count_ena),
		.data(data),
		.q(q)
	);


	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	shift_ena = 1;
	count_ena = 0;
	data = 0;
	end

	initial 
	begin
		$dumpfile ("wave.vcd");
		$dumpvars(0, task_2_tb);
	end

	always
		#5 clk = !clk;

	initial begin

		@ (posedge clk);
		@ (posedge clk);
		@ (posedge clk);
		@ (posedge clk);

		shift_ena <= 0;
		data <= 'x;

		@ (posedge clk);
		@ (posedge clk);

		shift_ena <= 1;
		data <= 1;

		@ (posedge clk);

		data <= 0;

		@ (posedge clk);
		@ (posedge clk);

		data <= 1;

		@ (posedge clk);

		shift_ena <= 0;
		data <= 'x;

		@ (posedge clk);
		@ (posedge clk);
		@ (posedge clk);

		count_ena <= 1;

		repeat(5) begin
			@ (posedge clk);
		end

		count_ena <= 0;

		@ (posedge clk);
		@ (posedge clk);

		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %h, shift_ena = %h, count_ena = %h, data = %h, q = %d", $time, clk, shift_ena, count_ena, data, q);
	end

endmodule