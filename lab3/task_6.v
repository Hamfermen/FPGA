

module task_6(
	input clk, a, b,
    output q, output reg state);

assign q = a ^ b ^ state;

always @(posedge clk) begin
    state <= b==a ? a : state;
end

endmodule