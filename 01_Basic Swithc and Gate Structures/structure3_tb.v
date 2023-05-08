` timescale 1ns/1ns
module structure3_tb();
    reg a1, b1, e0;
    wire a1_bar, k1, k1_bar;

    mynot NOT1(a1, a1_bar);
    mynand_3 NAND_3IN(e0,b1,a1_bar, k1_bar);
    mynot NOT2(k1_bar, k1);

    initial begin
       #10;
       //verifying worst to1 delay
        a1 = 1; b1 = 1; e0 = 1;
        #40; a1 = 0; #40;
        //verifying worst to0 delay
        #10 a1 = 1; #40;
       
        #10; $stop;
    end
endmodule
