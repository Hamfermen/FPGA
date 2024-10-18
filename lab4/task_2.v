

module task_2(
	input clk, shift_ena, count_ena, data,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (shift_ena) begin
            q <= {q[2:0], data};
        end
        else begin
            q <= (count_ena) ? q-1:q;
        end
    end

endmodule