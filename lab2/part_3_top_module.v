
    module bit16_adder(input [15:0]a, input [15:0]b, input cin, output [15:0] sum, output cout);

    assign sum = a + b + cin, cout = a[15] & b[15] & sum[15] | (a[15] ^ b[15]) & ~sum[15];

    endmodule

    module part_3_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum, output cout);

    wire noth, cout;

    bit16_adder fr(a[15:0], b[15:0], 1'b0, sum[15:0], cout);
    bit16_adder sc(a[31:16], b[31:16], cout, sum[31:16], noth);

endmodule