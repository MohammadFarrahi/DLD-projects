module DMUX_1to4(input IN,en, input [1:0] d, output logic [3:0] P, output Vout);
    always @(IN, d, en) begin
        P = 4'd0;
        if(en) P[d] = IN;
        else P = 4'd0;
    end
    assign Vout = en;
endmodule