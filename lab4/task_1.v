

module task_1(
	input clk, reset,
    output reg[15:0] q);

always @(posedge clk) begin
    if (reset) begin
            q <= 16'd0;
    end
    else begin
        q <= (q==16'd999) ? 0:q+1;
    end
end

endmodule