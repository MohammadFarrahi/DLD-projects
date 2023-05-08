` timescale 1ns/1ns
module final_TB();
    logic [7:0] a, prev_a;
    logic [7:0] b, prev_b;
    logic [15:0] test_vectors [0:33];
    wire EQ1, EQ2, GT1, GT2;
    logic prev_EQ1, prev_EQ2, prev_GT1, prev_GT2;
    integer i;
    localparam NUM_OF_CASES = 33;
    shortreal delay_EQ1, delay_EQ2;
    shortreal delay_GT1, delay_GT2;

    comparator_8bit_ver1 CUT1(a,b, EQ1,GT1);
    comparator_8bit_ver2 CUT2(a,b, EQ2,GT2);

    initial begin
        $readmemb("final_test_vectors.txt", test_vectors);
        i = 0;
    end
   always @(EQ1) begin
        delay_EQ1 = $realtime - delay_EQ1;
        #20;
        $display("EQ1 : %b -> %b delay: %0t ns", prev_EQ1, EQ1, delay_EQ1);
    end
    always @(GT1) begin
        delay_GT1 = $realtime - delay_GT1;
        #80;
        $display("GT1 : %b -> %b delay: %0t ns", prev_GT1, GT1, delay_GT1);
    end
   always @(EQ2) begin
        delay_EQ2 = $realtime - delay_EQ2;
        #40;
        $display("EQ2 : %b -> %b delay: %0t ns", prev_EQ2, EQ2, delay_EQ2);
    end
    always @(GT2) begin
        delay_GT2 = $realtime - delay_GT2;
        #60;
        $display("GT2 : %b -> %b delay: %0t ns", prev_GT2, GT2, delay_GT2);
    end
    initial begin
        #20;
        for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
            prev_a = a; prev_b = b;
            prev_EQ1 = EQ1; prev_GT1 = GT1;
            prev_EQ2 = EQ2; prev_GT2 = GT2;
            {a,b} = test_vectors[i];

            delay_EQ1 = $realtime; delay_EQ2 = $realtime;
            delay_GT1 = $realtime; delay_GT2 = $realtime;
            $display("inputs changing:");
            $display("a : %b --> %b , b : %b --> %b", prev_a, a, prev_b, b);
            
            #450;
            $display("");
            if({EQ1,GT1} !== {EQ2,GT2}) begin
                $display("Error: a = %b  and b = %b and outputs : comp1 = %b   comp2 = %b", a, b, {EQ1,GT1}, {EQ2,GT2});
            end
            $display("");
            #50;
        end
        #20 $stop;
    end
endmodule
