module C_X_DataPath(input clk,rst, x_ld,y_ld, r_ld,r_init, t_ld,t_init, cnt_en,cnt_init, add_sub_crl, bus1_sel,bus2_sel,bus3_sel,
                    input [9:0] x, input [7:0] y, output lt_comp,cnt_co,sub_flag, output [9:0] result);
    wire [3:0] cnt_out;
    wire [19:0] mult_out;
    wire [7:0] y_reg_out, LUT_out;
    wire [9:0] x_reg_out, t_reg_out, add_sub_out, bus1_out, bus2_out, bus3_out;


    myregister #(.N(10), .M()) x_reg(.clk(clk), .rst(rst), .ld(x_ld), .init(), .PL(bus1_out), .Q(x_reg_out));
    myregister #(.N(10), .M(10'b0011111111)) t_reg(.clk(clk), .rst(rst), .ld(t_ld), .init(t_init), .PL(mult_out[17:8]), .Q(t_reg_out)); 
    myregister #(.N(10), .M(10'b0011111111)) r_reg(.clk(clk), .rst(rst), .ld(r_ld), .init(r_init), .PL(add_sub_out), .Q(result));
    myregister y_reg(.clk(clk), .rst(rst), .ld(y_ld), .init(), .PL(y), .Q(y_reg_out));

    mymultiplier mult(bus2_out,bus3_out, mult_out);
    myAddSubtract add_sub(add_sub_crl, result,mult_out[17:8], add_sub_out);
    mycomparator comp(mult_out[17:8], {2'b00,y_reg_out}, lt_comp);

    mycounter cnt(clk,rst, cnt_init,cnt_en, cnt_out, cnt_co);
    myROM LUT(cnt_out, clk, LUT_out);

     mymux_2to1 #10 bus1(bus1_sel, {x,mult_out[17:8]}, bus1_out), bus2(bus2_sel, {x_reg_out,{2'b00,LUT_out}}, bus2_out), bus3(bus3_sel, {x_reg_out,t_reg_out} ,bus3_out);
    assign sub_flag = cnt_out[1];
endmodule
                