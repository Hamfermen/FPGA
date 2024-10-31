`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_3_tb;
	
	reg clk, reset, data;

    wire start_shifting;

	task_3 tsk0
	(
		.clk(clk),
        .reset(reset),
		.data(data),
		.start_shifting(start_shifting)
	);


	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	clk = 0;
	reset = 1;
	data = 0;
	end

	event reset_done;
	event reset_enable;

	initial 
	begin
		$dumpfile ("wave.vcd");
		$dumpvars(0, task_3_tb);
	end

	always
		#5 clk = !clk;

	initial begin


		@ (posedge clk);

		reset <= 0;

		@ (posedge clk);

		data <= 1;

		@ (posedge clk);

		data <= 0;

		@ (posedge clk);

		data <= 1;

		repeat (5)
		begin
			@(posedge clk);
		end

		data <= 0;

		@(posedge clk);

		data <= 1;

		repeat (2)
		begin
			@(posedge clk);
		end

		data <= 0;

		repeat (2)
		begin
			@(posedge clk);
		end

		data <= 1;
		reset <= 1;

		#20
		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %h, reset = %h, data = %h, start_shifting = %d", $time, clk, reset, data, start_shifting);
	end

endmodule