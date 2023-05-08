` timescale 1ns/1ns
module MSSD_TB();
    logic serIn, rst = 1, clk = 1;
    wire Vout1, Vout2, error1, error2;
    wire [3:0] P1, P2;
    wire [1:0] pn1, pn2;

    localparam TV_size = 9;
    logic [0:7] Info [0:TV_size - 1];

    shortreal P1_change_point = 0, max_P2_delay = 0;

    MSSDPre CUT1(serIn, clk, rst, P1, pn1, Vout1, error1);
    MSSDPos CUT2(serIn, clk, rst, P2, pn2, Vout2, error2);

    always #20 clk = ~clk;

    initial begin
        $readmemb("MSSD_testvectors.txt", Info);
        serIn = 1;
        #26 rst = 0;
        for(int i = 0; i < TV_size; i = i + 1) begin
            #40 serIn = 1;
            #40 serIn = 0;
            for(int j = 7; j >= 0; j = j - 1) begin
                #40 serIn = Info[i][j];
            end
            for(int t = Info[i][0:5] * 8; t >= 0; t = t - 1) begin
                #40 serIn = $random;
            end
        end
        #80;
        $display("max relative delay to P1 of output P2 is : %0t ps", max_P2_delay);
        $stop;
    end
    always @(posedge clk) begin
        if(Vout1 && Vout2 && pn1 !== pn2) $display("ERROR: Destination channel in cirsuits is different at time : %0t ps", $realtime);
        if(Vout1 && P1[pn1] !== serIn) $display("ERROR: Data didn't pass in selected channel in circut1 at time : %0t ps", $realtime);
        if(Vout2 && P2[pn2] !== serIn) $display("ERROR: Data didn't pass in selected channel in circut2 at time : %0t ps", $realtime);
    end

    always @(P1) begin
        if(~rst) P1_change_point = $realtime;
    end
    always @(P2) begin
        if(~rst) max_P2_delay = (($realtime - P1_change_point) > max_P2_delay) ? ($realtime - P1_change_point) : max_P2_delay;
    end
endmodule