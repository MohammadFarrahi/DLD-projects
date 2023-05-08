` timescale 1ns/1ns
module structure1_tb();
    reg a1, b1;
    wire a1_bar, j1;
    
    mynot NOT(a1, a1_bar);
    mymux MUX(a1_bar,a1,b1, j1);

    initial begin
        #10;
        //verifying worst to1 delay
        a1 = 1; b1 = 0;
        #20; b1 = 1; #20;
        //verifying worst to0 delay
        a1 = 0; b1 = 0;
        #20; b1 = 1; #20;
        
        # 10; $stop;
    end
endmodule
