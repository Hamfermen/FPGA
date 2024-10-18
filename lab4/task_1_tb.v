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
	reset = 0;
	end

	event reset_done;
	event reset_enable;

	initial 
	begin
		$dumpfile ("wave.vcd");
		$dumpvars(0, task_1_tb);
	end

	always
		#5 clk = !clk;

	initial begin

		#10->reset_enable;
		@(reset_done);
		@ (posedge clk);

		repeat (999)
		begin
			@(posedge clk);
		end

		#10 ->reset_enable;
		@(reset_done);
		@ (posedge clk);

		#10
		$display ("###################################################");
		$finish();
	end

	initial begin
		$monitor("t=%-4d: clk = %h, reset = %h, q = %d", $time, clk, reset, q);
	end

	initial forever begin				
	@ (reset_enable);
	@ (posedge clk)			
	$display ("Applying reset");
	reset <= 1;				
	@ (posedge clk)			
	reset <= 0;				
	$display ("Came out of Reset");
	-> reset_done;			
	end

endmodule