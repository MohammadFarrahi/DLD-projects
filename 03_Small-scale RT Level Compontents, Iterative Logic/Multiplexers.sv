` timescale 1ns/1ns
module CMOS_4to1_MUX(input [3:0] J, input [1:0] s, output w);

	assign #35 w = J[s];

endmodule

module PT_16to1_MUX(input [15:0] J, input [3:0] s, output w);

	assign #27 w = J[s];

endmodule

module CMOS_16to1_MUX(input [15:0] J, input [3:0] s, output w);

	assign #90 w = J[s];

endmodule

module Nbit_CMOS_2to1_MUX #(parameter N = 8) (input [1:0][N-1:0] J, input s, output [N-1:0] w);

	assign #23 w = J[s];

endmodule

module Nbit_Inverter #(parameter N = 8) (input [N-1:0] a, output [N-1:0] w);

	genvar k;
	generate
		for(k = 0; k < N; k = k + 1) begin: NOTs
			not #(7,7) NOT(w[k], a[k]);
		end
	endgenerate

endmodule
