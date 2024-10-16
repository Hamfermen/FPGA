

module task_4(
	input clock, a,
    output reg p, q );

always @(*) begin
    p = clock ? a : p;
end

always @(negedge clock) begin
    q <= p;
end

endmodule