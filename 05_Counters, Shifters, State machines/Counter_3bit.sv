module Counter_3bit(input init,en,clk,rst, output logic [2:0] Q, output co);
    always @(posedge clk, posedge rst) begin
        if(rst) Q <= 3'd0;
        else begin
            if(init) Q <= 3'd0;
            else Q <= en ? (Q + 1) : Q;
        end
    end
    assign co = &{en, Q};
endmodule