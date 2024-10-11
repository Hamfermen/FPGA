

module task_1(
	input a, b, c, d,
    output q );

assign q = b & (c | d) | a & (c | d);

endmodule