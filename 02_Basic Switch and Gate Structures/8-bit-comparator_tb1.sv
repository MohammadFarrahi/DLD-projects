` timescale 1ns/1ns
module comparator_8bit_tb1();
    logic [7:0] aa, previous_aa;
    logic [7:0] bb, previous_bb;
    logic [17:0] test_vectors [0:17];
    logic [0:1] expected_answer;
    wire EE, GG;
    logic prev_EE, prev_GG;
    integer i;
    localparam NUM_OF_CASES = 17;
    shortreal delay_EE, delay_GG;

    comparator_8bit_ver1 CUT(aa,bb, EE,GG);

    always @(EE) begin
        delay_EE = $realtime - delay_EE;
        #5;
        $display("EE : %b -> %b delay: %0t ns", prev_EE, EE, delay_EE);
    end
    always @(GG) begin
        delay_GG = $realtime - delay_GG;
        #5;
        $display("GG : %b -> %b delay: %0t ns", prev_GG, GG, delay_GG);
    end
    initial begin
        $readmemb("8-bit-comparator_testvectors.txt", test_vectors);
        i = 0;
    end
    initial begin
        #20;
        for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
            previous_aa = aa; previous_bb = bb;
            prev_EE = EE; prev_GG = GG;
            {aa,bb, expected_answer} = test_vectors[i];
            
            $display("inputs changing:");
            $display("aa : %b --> %b , bb : %b --> %b", previous_aa, aa, previous_bb, bb);
            delay_EE = $realtime;
            delay_GG = $realtime;
            #450;
            if({EE,GG} !== expected_answer) begin
                $display("Error: aa = %b  and bb = %b and outputs = %b (exp %b)", aa, bb, {EE,GG}, expected_answer);
            end
            $display("\n");
            #50;
        end
        #20 $stop;
    end
endmodule
