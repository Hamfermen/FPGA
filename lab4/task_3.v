

module task_3(
	input clk, reset, data,
    output reg start_shifting);

parameter s0 = 'd0, s1 = 'd1, s2 = 'd2, s3 = 'd3;

reg[1:0] st, n_st;

always @(posedge clk) begin

    st = reset ? s0: n_st;

    case(st)
        s0: n_st = data? s1: s0;
        s1: n_st = data ? s2: s0;
        s2: n_st = ~data ? s3: s2;
        s3: n_st = s0;
        default: n_st = s0;
    endcase

    if (reset) begin
        start_shifting <= 0;
    end else begin
        start_shifting <= st == s3 && n_st == s0 ? 1:start_shifting;
    end

end



endmodule