module myregister #(parameter N = 8, parameter [N-1:0] M = 0) (input clk,rst, ld,init, input [N-1:0] PL, output logic [N-1:0] Q);
	 always @(posedge clk, posedge rst) begin
        if(rst) Q <= 0;
        else if(ld) Q <= PL;
		  else if (init === 1'b1) Q <= M;
    end
endmodule