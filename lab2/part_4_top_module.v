
module mux2(input [15:0]a, input [15:0]b, output reg [31:16]q, input sel);

always@(*) begin

    case(sel)
        2'b00: q <= a;
        2'b01: q <= b;
    endcase

end

endmodule

module bit16_adder(input [15:0]a, input [15:0]b, input cin, output [15:0] sum, output cout);

assign sum = a + b + cin, cout = a[15] & b[15] & sum[15] | (a[15] ^ b[15]) & ~sum[15];

endmodule

module part_4_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum, output cout);

wire q1, q2, cout;
wire [31:16]sm1, sm2;

bit16_adder fr(a[15:0], b[15:0], 1'b0, sum[15:0], cout);
bit16_adder sc(a[31:16], b[31:16], 1'b0, sm1[31:16], q1);
bit16_adder th(a[31:16], b[31:16], 1'b1, sm2[31:16], q2);

mux2 mx(sm1, sm2, sum[31:16], cout);

endmodule