

module task_5(
	input clk, a,
    output reg[2:0] q);

always @(posedge clk) begin
    if (a) begin
            q <= 4'd4;
    end
    else begin
        q <= (q==4'd6) ? 0:q+1;
    end
end

endmodule