` timescale 1ns/1ns
module structure4_tb();
    reg g0, k1;
    wire g1, g1_bar;

    mynor_2 NOR_2IN(g0,k1, g1_bar);
    mynot NOT(g1_bar, g1);

    initial begin
        #10;
        //verifying worst to1 delay
        g0 = 0; k1 = 0;
        #25; k1 = 1; #25;
        //verifying worst to0 delay
        #10; k1 = 0; #25;
 
        #10; $stop;
    end
endmodule
