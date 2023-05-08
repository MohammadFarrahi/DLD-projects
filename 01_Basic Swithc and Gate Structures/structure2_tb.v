` timescale 1ns/1ns
module structure2_tb();
    reg j1, e0;
    wire e1, e1_bar;

    mynand_2 NAND_2IN(e0,j1, e1_bar);
    mynot NOT(e1_bar, e1);
    
    initial begin
        #10;
        //verifying worst to1 delay
        j1 = 0; e0 = 1;
        #25; j1 = 1; #25;
        //verifying worst to0 delay
        #10 j1 = 0; #25;
       
        #10; $stop;   
    end
endmodule
