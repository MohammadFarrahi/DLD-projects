` timescale 1ns/1ns
module TCS_circuit_tb();
    logic [0:1] expected_answers [0:2][0:15];
    logic [0:1] input_eq_gt;
    logic [1:0] a;
    logic [1:0] b;
    wire [0:1] output_EQ_GT;
    integer i;

    TCS_circuit CUT(a,b, input_eq_gt[0], input_eq_gt[1], output_EQ_GT[0], output_EQ_GT[1]);

    initial begin
        $readmemb("TCS_test_vectors.txt", expected_answers);
        i = 0;
    end
    initial begin
        #20;
        {a, b} = 4'b0000;
        input_eq_gt = 2'b00;
        for(i = 0; i < 16; i = i + 1) begin
            #90;
            if(output_EQ_GT !== expected_answers[0][i]) begin
                $display("Error: a = %b, b = %b, eq_gt = 00 and output = %b (exp %b)", a, b,
                        output_EQ_GT, expected_answers[0][i]);
            end
            #10;
            {a, b} = {a, b} + 1'b1;
        end
        {a, b} = 4'b0000;
        input_eq_gt = 2'b01;
        for(i = 0; i < 16; i = i + 1) begin
            #90;
            if(output_EQ_GT !== expected_answers[1][i]) begin
                $display("Error: a = %b, b = %b, eq_gt = 01 and output = %b (exp %b)", a, b,
                        output_EQ_GT, expected_answers[1][i]);
            end
            #10;
            {a, b} = {a, b} + 1'b1;
        end
        {a, b} = 4'b0000;
        input_eq_gt = 2'b10;
        for(i = 0; i < 16; i = i + 1) begin
            #90;
            if(output_EQ_GT !== expected_answers[2][i]) begin
                $display("Error: a = %b, b = %b, eq_gt = 10 and output = %b (exp %b)", a, b,
                        output_EQ_GT, expected_answers[2][i]);
            end
            #10;
            {a, b} = {a, b} + 1'b1;
        end
        $stop;
    end
endmodule
