module C_X_Controller(input clk,rst, start, lt_comp,cnt_co,sub_flag,
                      output logic x_ld,y_ld, r_ld,r_init, t_ld,t_init, cnt_en,cnt_init, add_sub_crl, bus1_sel,bus2_sel,bus3_sel, ready);
    logic [2:0] ps, ns;
    localparam [2:0] Idle=0, init=1, load=2, prepare=3, cal1=4, cal2=5, cal3=6;
   
    always @(ps, start, lt_comp, cnt_co, sub_flag) begin
        ns = Idle;
        {x_ld,y_ld,r_ld,r_init,t_ld,t_init,cnt_en,cnt_init,add_sub_crl,bus1_sel,bus2_sel,bus3_sel,ready} = 13'd0;
        
        case(ps)
            Idle: begin
                ns = start ? init : Idle;
                ready = 1;
            end
            init: begin
                ns = start ? init : load;
                t_init = 1; r_init = 1; cnt_init = 1;
            end
            load: begin
                ns = prepare;
                x_ld = 1; y_ld = 1; bus1_sel = 1;
            end
            prepare: begin
                ns = cal1;
                x_ld = 1; bus2_sel = 1; bus3_sel = 1;
            end
            cal1: begin
                ns = cal2;
                cnt_en = 1; t_ld = 1;
            end
            cal2: begin
                ns = cal3;
                cnt_en = 1; bus2_sel = 1; t_ld = 1;
            end
            cal3: begin
                ns = (lt_comp | cnt_co) ? Idle : cal1;
                t_ld = 1; r_ld = ~lt_comp; add_sub_crl = sub_flag;
            end
            default: ns = Idle;
        endcase
    end
    always @(posedge clk, posedge rst) begin
        if(rst) ps <= Idle;
        else ps <= ns;
    end
endmodule