` timescale 1ns/1ns
module BCS_ver1_tb();
    reg aa1, bb1, ee0, gg0;
    reg [0:1] expected_e1_g1;
    reg [0:5] test_vectors [0:15];
    wire gg1, ee1;
    integer i;
    localparam NUM_OF_CASES = 16;

    BCS_circuit_ver1 CUT1(aa1,bb1,ee0,gg0, ee1,gg1);

    initial begin
        $readmemb("testvectors.txt", test_vectors);
        i = 0;
    end

    initial begin
        #20;
        for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
            {aa1,bb1,ee0,gg0, expected_e1_g1} = test_vectors[i];
            #60;
            if({ee1,gg1} !== expected_e1_g1) begin
                $display("Error: inputs = %b  outputs = %b (exp %b)", {aa1,bb1,ee0,gg0}, {ee1,gg1}, expected_e1_g1);
            end
            #40;
        end
        #20 $stop;
    end
endmodule
