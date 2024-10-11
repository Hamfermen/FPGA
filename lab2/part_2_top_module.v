module d_trigger(input [7:0]d, input clk, output [7:0]q);

reg [7:0]q;

always@(posedge clk) begin
    q <= d;
end

endmodule

module mux4(input [7:0]d, input [7:0]d1, input [7:0]d2, input [7:0]d3, output [7:0]q, input [1:0]sel);

reg [7:0]q;

always@(*) begin

    case(sel)
        2'b00: q <= d;
        2'b01: q <= d1;
        2'b10: q <= d2;
        2'b11: q <= d3;
    endcase

end

endmodule

module part_2_top_module (input [7:0]d, input [1:0]sel, input clk, output [7:0]q);

wire [7:0]q1;
wire [7:0]q2;
wire [7:0]q3;

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
    .q(q3)
);

mux4 mx(
    .d(d),
    .d1(q1), 
    .d2(q2), 
    .d3(q3), 
    .q(q), 
    .sel(sel)
);

endmodule