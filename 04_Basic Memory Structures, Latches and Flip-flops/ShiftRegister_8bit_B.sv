` timescale 1ns/1ns
module ShiftRegisterB_8bit(input sIn,clk,rst, output [7:0] Q, output sOut);
    wire [8:0] J, J_bar;
    genvar k;

    assign J[8] = sIn;
    assign sOut = J[0];
    generate
        for(k = 7; k >= 0; k = k - 1) begin: DFFs
            DflipflopB_HRsync DFF(J[k + 1],clk,rst, J[k],J_bar[k]);
            assign Q[k] = J[k];
        end
    endgenerate
endmodule

module final_TB();
    logic sIn, clk = 1, rst = 1;
    wire sOut_S, sOut_B;
    wire [7:0] Q_S, Q_B;

    ShiftRegister_8bit_v2 CUT1(sIn,clk,rst, Q_S, sOut_S);
    ShiftRegisterB_8bit CUT2(sIn,clk,rst, Q_B, sOut_B);


    always #101 clk = ~clk;
    
    initial begin
        sIn = 0;
        #150; rst = 0; 
        #606; rst = 1;
        #404; rst = 0;
    end

    initial begin
        #150; sIn = 1;
        repeat(60) #404 sIn = $random;
        #202 $stop;
    end
endmodule
