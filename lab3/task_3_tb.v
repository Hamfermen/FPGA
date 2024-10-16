`timescale 1ns/100ps // 1 ns time unit, 100 ps resolution
// `include "task_1.v"

module task_3_tb;
	
	reg[3:0] a, b, c, d, e;

    wire[3:0] q;

	task_3 tsk0
	(
		.a(a),
        .b(b),
        .c(c),
        .d(d),
		.e(e),
		.q(q)
	);


	initial
	begin
	$display ("###################################################");
	$display ("Start TestBench");
	end

	 initial 
	begin
		$dumpfile ("task_3.vcd");
		$dumpvars(0, task_3_tb);
	end

	event second;
	event third;

	initial begin

		a = 'ha; 
		b = 'hb; 
		d = 'hd; 
		e = 'he; 
		c ='h0;

		repeat (18)
		begin
			#5 c = (c+'h1);
		end
	
		#5 -> second;
	end

	initial begin
		@(second);
		a = 'h1; 
		b = 'h2; 
		d = 'h3; 
		e = 'h4; 
		c ='h0;

		repeat (8)
		begin
			#5 c = (c+'h1);
		end
	
		#5 -> third;
	end

	initial begin
		@(third);
		a = 'h5; 
		b = 'h6; 
		d = 'h7; 
		e = 'h8; 
		c ='h0;

		repeat (7)
		begin
			#5 c = (c+'h1);
		end
		
		#5 
		$display ("###################################################");
		#1 
		$finish();
	end

	initial begin
		$monitor("t=%-4d: a = %h, b = %h, c = %h, d = %h, e = %h, q = %h", $time, a, b, c, d, e, q);
	end
endmodule