
module task_4(
	input clk, reset, data, ack,
    output reg counting, done, output reg[3:0] count);

parameter s0 = 'd0, s1 = 'd1, s2 = 'd2, s3 = 'd3, shifting = 'd4, counting_n = 'd5, waiting = 'd6;

reg[2:0] st, n_st;
reg[2:0] cn_bit;
reg[3:0] delay;
reg[15:0] cn;

reg start_shifting, tm_n, st_t, st_s, done_c;

// task_3 srch(
//     .clk(clk), 
//     .reset(st_s), 
//     .data(data),
//     .start_shifting(start_shifting)
// );

// task_2 cnt(
//     .clk(clk), 
//     .shift_ena(start_shifting), 
//     .count_ena(1'b0), 
//     .data(data),
//     .q(count)
// );

// timer tm(
//     .clk(clk), 
//     .st(counting),
//     .tm(delay),
//     .q(cn)
// );

always @(*) begin

    case(st)

        s0: n_st = data? s1: s0;
        s1: n_st = data ? s2: s0;
        s2: n_st = !data ? s3: s2;
        s3: n_st = data ? shifting: s0;

        shifting: n_st = cn_bit==4 ? counting_n : shifting;

        counting_n: n_st = done ? waiting : counting_n;

        waiting: n_st = ack ? s0 : waiting;

        default: n_st = s0;

    endcase
end

always @(posedge clk) begin
    st <= reset ? s0: n_st;    
end

//logic gates
always @(posedge clk) begin
    if (reset) begin
        start_shifting <= 0;
    end else begin
        start_shifting <= n_st == shifting;
    end
end

always @(posedge clk) begin
    if (reset) begin
        done <= 0;
    end else begin
        done <= n_st == waiting;
    end
end

always @(posedge clk) begin

    if (reset) begin
            
        cn_bit <= 0;

    end else if(cn_bit == 4) begin
        
        cn_bit <= 0;

    end else begin
        
        cn_bit <= n_st == shifting ? cn_bit + 1 : 0;

    end

end

always @(posedge clk) begin

    if (reset) begin
        counting <= 0; 
    end else begin
        counting <= n_st == counting_n;
    end

end

always @(posedge clk) begin

    if (reset || ack) begin

        done <= 0;

    end

end

always @(posedge clk) begin
    if (reset) begin
        cn <= 16'd0;
    end else begin 
        cn <= counting ? cn+1:0;
    end
end

always @(posedge clk) begin
    if (reset) begin
        delay <= 0;
        count <= 0;
    end else if (start_shifting) begin
        delay <= {delay[2:0],data};
    end 
end

always @(delay) begin
    count <= !start_shifting ? delay : 0;
end

always@(posedge clk) begin
    if(reset)begin
        done <= 0;
    end else if (counting) begin
        if (cn+1 == 16'(delay+1)*1000) begin
            counting <= 0;
            done <= 1;
            delay <= 0;
        end
    end
end


 


    // case(st)
    //     searching: n_st = start_shifting ? shifting: searching;
        
    //     shifting: 
    //     if (cn_bit == 4) begin
    //         n_st = counting_n;
    //         counting = 1;
    //         cn_bit = 0;
    //         delay = 16'((count + 1)*1000);
    //     end else begin
    //         n_st = shifting;
    //         cn_bit = cn_bit + 1;
    //     end
        
    //     counting_n: 
    //     if (cn == delay) begin 
    //         n_st = waiting;
    //         counting = 0;
    //         done = 1;
    //     end else begin
    //         n_st = counting_n;
    //     end
        
    //     waiting: 
    //     if (ack) begin
    //         n_st = searching;
    //         done = 0;
    //     end else begin
    //         n_st = waiting;
    //     end
    //     default: n_st = searching;
    // endcase




endmodule