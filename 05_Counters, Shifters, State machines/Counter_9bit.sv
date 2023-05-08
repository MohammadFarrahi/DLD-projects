module Counter_9bit(input [8:0] PL, input ld,init,en,clk,rst, output logic [8:0] Q, output co);
    always @(posedge clk, posedge rst) begin
        if(rst) Q <= 9'd0;
        else begin
            if(ld) Q <= PL;
            else if(init) Q <= 9'd0;
                else if(en) Q <= Q + 1;
        end
    end
    assign co = &{en, Q};
endmodule