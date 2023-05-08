module CosX_accelerator_Pre(input clk,rst, start, input [9:0] x, input [7:0] y, output [9:0] result, output ready);
    wire x_ld,y_ld, r_ld,r_init, t_ld,t_init, cnt_en,cnt_init, add_sub_crl, bus1_sel,bus2_sel,bus3_sel;
    wire lt_comp, cnt_co, sub_flag;

    C_X_DataPath DataPath(clk,rst, x_ld,y_ld, r_ld,r_init, t_ld,t_init, cnt_en,cnt_init, add_sub_crl, bus1_sel,bus2_sel,bus3_sel,
                          x, y, lt_comp,cnt_co,sub_flag, result);

    C_X_Controller controller(clk,rst, start, lt_comp,cnt_co,sub_flag,
                              x_ld,y_ld, r_ld,r_init, t_ld,t_init, cnt_en,cnt_init, add_sub_crl, bus1_sel,bus2_sel,bus3_sel, ready);

endmodule
