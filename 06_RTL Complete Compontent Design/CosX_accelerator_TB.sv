` timescale 1ns/1ns
module CosX_accelerator_TB();
    logic clk = 1, rst = 1, start = 1;
    logic [7:0] y; logic [9:0] x;
    wire [9:0] result1, result2; wire ready1, ready2;

    integer i;
    localparam TV_size = 10, clk_period = 20;
    logic [27:0] testvectors [TV_size - 1:0];

    shortreal ready1_change_point = 0, max_CUT2_delay = 0;

    CosX_accelerator_Pre CUT1(clk,rst, start, x, y, result1, ready1);
    CosX_accelerator CUT2(clk,rst, start, x, y, result2, ready2);


    always #clk_period clk = ~clk;
    initial begin
        $readmemb("test_vectors.txt", testvectors); i = 0;
        #(clk_period*1.5)  rst = 0; start = 1;
        #(clk_period*4) start = 0;
        #(clk_period*2);
        for(i = 0; i < TV_size; i = i + 1) begin
            {x,y} = testvectors[i][27:10];
            #(clk_period*2*27) start = 1;
            #(2*clk_period) start = 0;
            #(clk_period*2);
        end
        $display("            **********<<DAELAY>>**********             ");
        $display("max of output of Pos (relative delay to Pre) is : %0t ps", max_CUT2_delay);
        $display("            **********<<<<<>>>>>**********             ");
        $stop;
    end
    always @(posedge ready2) begin
        if(!rst && result1 !== result2) $display("--->ERROR: outputs below are different.(at time=%0t ps)", $realtime);
        $display("***outputs: result1 = %b | result2 = %b. expected = %b.(case i = %0d)\n\n", result1, result2, testvectors[i][9:0], i);
    end
    always @(posedge ready1) begin
        if(!rst) ready1_change_point = $realtime;
    end
    always @(posedge ready2) begin
        if(!rst) max_CUT2_delay = (($realtime - ready1_change_point) > max_CUT2_delay) ? ($realtime - ready1_change_point) : max_CUT2_delay;
    end
endmodule
