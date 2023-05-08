module MyDFF(input D,clk,rst, output logic Q);
    always @(posedge clk, posedge rst) begin
        if(rst) Q <= 1'b0;
        else Q <= D;
    end
endmodule
