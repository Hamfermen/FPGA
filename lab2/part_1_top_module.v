module d_trigger(input d, input clk, output q);

reg q;

always@(posedge clk) begin
    q <= d;
end

endmodule


module part_1_top_module (input d, output q, input clk);

wire q1, q2;

d_trigger d_1(
    .d(d),
    .clk(clk),
    .q(q1)
);

d_trigger d_2(
    .d(q1),
    .clk(clk),
    .q(q2)
);

d_trigger d_3(
    .d(q2),
    .clk(clk),
    .q(q)
);

endmodule