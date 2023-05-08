` timescale 1ns/1ns
module SISO_ShiftRegister_8bit(input sIn,clk,rst, output sOut);
    wire [8:0] J, J_bar;
    genvar k;

    assign J[8] = sIn;
    assign sOut = J[0];
    generate
        for(k = 7; k >= 0; k = k - 1) begin: DLatches
            DlatchS_LR DLS(J[k + 1],clk,rst, J[k],J_bar[k]);
        end
    endgenerate
endmodule

module SISO_ShiftRegister_TB();
    logic clk = 1, rst = 0, sIn;
    wire sOut;

    SISO_ShiftRegister_8bit CUT(sIn,clk,rst, sOut);

    always #127 clk = ~clk;
    initial #155 rst = 1;

    initial begin
        sIn = 0; #185;
        repeat(10) begin
            sIn = ~sIn;
            #2032;
        end
        $stop;
    end
endmodule
