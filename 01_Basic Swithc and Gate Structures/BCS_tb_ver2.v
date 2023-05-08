` timescale 1ns/1ns
module BCS_ver2_tb();
    reg aa1, bb1, ee0, gg0;
    reg [0:1] expected_e1_g1;
    reg [0:5] test_vectors [0:15];
    wire gg1_1, gg1_2, ee1_1, ee1_2;
    integer i;
    localparam NUM_OF_CASES = 16;

    BCS_circuit_ver1 CUT1(aa1,bb1,ee0,gg0, ee1_1,gg1_1);
    BCS_circuit_ver2 CUT2(aa1,bb1,ee0,gg0, ee1_2,gg1_2);

    initial begin
        $readmemb("testvectors.txt", test_vectors);
        i = 0;
    end

    initial begin
        #20;
        for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
            {aa1,bb1,ee0,gg0, expected_e1_g1} = test_vectors[i];
            #80
            if({ee1_1,gg1_1} !== expected_e1_g1) begin
                $display("Error_in_CUT1: inputs = %b  outputs = %b (exp %b)", {aa1,bb1,ee0,gg0}, {ee1_1,gg1_1}, expected_e1_g1);
            end
            if({ee1_2,gg1_2} !== expected_e1_g1) begin
                $display("Error_in_CUT2: inputs = %b  outputs = %b (exp %b)", {aa1,bb1,ee0,gg0}, {ee1_2,gg1_2}, expected_e1_g1);
            end
            #20;
        end
        #20 $stop;
    end
endmodule
