` timescale 1ns/1ns
module DflipflopB_HRsync(input D,clk,rst, output logic Q,Q_bar);
    always @(negedge clk) begin
        if(rst) #32 Q <= 1'b0;
        else #32 Q <= D;
    end
    assign Q_bar = ~Q;
endmodule

module DFF_B_HRsync_TB();
    logic clk = 1, rst = 1, D;
    wire Q, Q_bar;

    DflipflopB_HRsync CUT(D,clk,rst, Q,Q_bar);

    always #89 clk = ~clk;

    initial begin
        D = 1;
        #150 rst = 0;
        #267 D = 0;
        #44 D = 1; #26;
        #89 rst = 1;
        #178 rst = 0;
        repeat(10) #178 D = ~D;
        #89 $stop;
    end
endmodule

/*module DflipflopB_HRsync(input D,clk,rst, output logic Q,Q_bar);
    logic T;

    always @(negedge clk) begin
        if(rst) #32 Q <= 1'b0;
        else begin
            T = D;
            #32 Q <= T;
        end 
    end
    assign Q_bar = ~Q;
endmodule*/