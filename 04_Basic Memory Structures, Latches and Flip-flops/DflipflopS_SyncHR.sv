` timescale 1ns/1ns
module DflipflopS(input D,clk, output Q,Q_bar);
    wire master_Q, master_Q_bar;
    wire clk_bar;

    not #(6,6) NOT(clk_bar, clk);
    DlatchS dlatch1(D,clk, master_Q,master_Q_bar);
    DlatchS dlatch2(master_Q,clk_bar, Q,Q_bar);
endmodule

module DflipflopS_HRsync(input D,clk,rst, output Q,Q_bar);
    wire D_bar, FF_in;

    not #(6,6) NOT(D_bar, D);
    nor #(12,12) NOR(FF_in, rst, D_bar);
    DflipflopS DFF(FF_in,clk, Q,Q_bar);
endmodule

module DFF_S_HRsync_TB();
    logic clk = 1, rst = 1, D = 1;
    wire Q, Q_bar;

    DflipflopS_HRsync CUT(D,clk,rst, Q,Q_bar);

    always #101 clk = ~clk;
    
    initial begin
        #150 rst = 0;
        #202 rst = 1;
        #303 D = 0;
        #101 rst = 0;
        #101 D = 1;
        repeat(10) begin
            #101; D = ~D;
            #202; D = ~D;
        end
        #202 $stop;
    end
    initial begin
        #1500;
        repeat(20) #503 rst = $random();
    end
endmodule
