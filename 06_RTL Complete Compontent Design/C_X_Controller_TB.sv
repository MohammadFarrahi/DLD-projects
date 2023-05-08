` timescale 1ns/1ns
module TB();
    logic clk = 1, rst = 1, start = 0, lt_comp = 0, cnt_co = 0, sub_flag = 0;
    wire xld, yld, rld, tld, rinit, tinit, cen, cinit, addsubcrl, b1s,b2s,b3s,ready;

    C_X_Controller UUT(clk, rst, start, lt_comp, cnt_co, sub_flag,
                        xld,yld,rld,rinit,tld,tinit,cen,cinit,addsubcrl,b1s,b2s,b3s,ready);

    always #10 clk = ~clk;
    initial begin
        #15 rst = 0; start = 1;
        #20 start = 0;
        #160 sub_flag = 1;
        #40 sub_flag = 0;
        #20 lt_comp = 1;
        #60 $stop;
    end 
endmodule
