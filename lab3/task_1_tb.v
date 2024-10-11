`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_1_tb;
	reg a=0, b=0, c=0, d=0;

    wire q;

	task_1 tsk0
	(
		.a(a),
        .b(b),
        .c(c),
        .d(d),
		.q(q)
	);

	initial begin
		$dumpfile("wave.vcd");		// create a VCD waveform dump called "wave.vcd"
		$dumpvars(0, task_1_tb);		// dump variable changes in the testbench
									// and all modules under it
		#5 a=0; b=0; c=0; d=0;
		#5;a=0; b=0; c=0; d=1;
		#5;a=0; b=0; c=1; d=0;
		#5;a=0; b=0; c=1; d=1;
		#5;a=0; b=1; c=0; d=0;
		#5;a=0; b=1; c=0; d=1;
		#5;a=0; b=1; c=1; d=0;
		#5;a=0; b=1; c=1; d=1;
		#5;a=1; b=0; c=0; d=0;
		#5;a=1; b=0; c=0; d=1;
		#5;a=1; b=0; c=1; d=0;
		#5;a=1; b=0; c=1; d=1;
		#5;a=1; b=1; c=0; d=0;
		#5;a=1; b=1; c=0; d=1;
		#5;a=1; b=1; c=1; d=0;
		#5;a=1; b=1; c=1; d=1;
		#5;a=0; b=0; c=0; d=0;
		#5;a=0; b=0; c=0; d=1;
        #5
	
		$finish();
	end

	initial begin
		$monitor("t=%-4d: a = %d, b = %d, c = %d, d = %d, q = %d", $time, a, b, c, d, q);
	end
endmodule