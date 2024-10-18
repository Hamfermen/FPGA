

module task_1(
	input clk, reset,
    output reg[9:0] q);

always @(posedge clk) begin
    if (reset) begin
            q <= 10'd0;
    end
    else begin
        q <= (q==10'd999) ? 0:q+1;
    end
end

endmodule