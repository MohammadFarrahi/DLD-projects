module mymux_2to1 #(parameter N = 8) (input s, input [1:0][N-1:0] J, output [N-1:0] w);

	assign w = J[s];

endmodule