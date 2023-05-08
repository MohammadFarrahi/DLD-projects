module mycounter(input clk,rst, init,en, output logic [3:0] Q, output cnt_overflow);
    always @(posedge clk, posedge rst) begin
        if(rst) Q <= 4'd0;
        else begin
            Q <= init ? 4'd0 : en ? Q + 1 : Q;
        end
    end
    assign cnt_overflow = ~(|Q);
endmodule
