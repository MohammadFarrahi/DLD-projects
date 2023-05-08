` timescale 1ns/1ns
module RegisterS_8bit(input [7:0] D, input clk,rst, output [7:0] Q);
    genvar k;
    wire [7:0] Q_bar;
    
    generate
        for(k = 7; k >= 0; k = k - 1) begin: DFFs
            DflipflopS_HRsync DFF(D[k],clk,rst, Q[k],Q_bar[k]);
        end
    endgenerate
endmodule

module ShiftRegister_8bit_v2(input sIn,clk,rst, output [7:0] Q, output sOut);
    wire [7:0] IN;
    genvar k;
    
    RegisterS_8bit REG_8bit(IN, clk,rst, Q);
    assign IN[7] = sIn;
    assign sOut = Q[0];
    generate
        for(k = 6; k >= 0; k = k - 1) begin: CONNECTIONS
            assign IN[k] = Q[k + 1];
        end
    endgenerate
endmodule

module ShiftRegister_v2_TB();
    logic clk = 1, rst = 1, sIn;
    logic [7:0] D;
    wire [7:0] Q_REG, Q_SHIFT;
    wire sOut;

    RegisterS_8bit CUT1(D, clk,rst, Q_REG);
    ShiftRegister_8bit_v2 CUT2(sIn,clk,rst, Q_SHIFT, sOut);

    always #101 clk = ~clk;
    initial begin
        sIn = 0;
        #150 rst = 0; D = 8'd0;
        #606 rst = 1;
        #404 rst = 0; D = 8'd0;
    end
    always@(negedge clk) begin
        if(rst == 1'b0) begin
            #50;
            if(Q_REG !== D) $display("data didn't latch at time = %0t", $realtime);
            D = $random;
        end
    end

    initial begin
        sIn = 1;
        #1160;
        repeat(10) #1616 sIn = ~sIn;
        #202 $stop;
    end
endmodule
