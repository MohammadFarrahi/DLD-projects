module ShiftRegister_8bit(input sIn,Shen,clk,rst, output logic [7:0] Q, output sOut);
    always @(posedge clk, posedge rst) begin
        if(rst) Q <= 8'd0;
        else Q <= (Shen) ? {sIn, Q[7:1]} : Q;
    end
    assign sOut = Q[0];
endmodule
