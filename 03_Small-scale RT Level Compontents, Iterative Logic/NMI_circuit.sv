` timescale 1ns/1ns
module TMI_circuit(input [1:0] a, input ci, output [1:0] s, output co);
    wire [3:0] s0_MUX_inputs;
    wire [3:0] s1_MUX_inputs;
    wire [3:0] co_MUX_inputs;
    wire ci_bar;
    logic ONE = 1'b1;
    logic ZERO = 1'b0;

    assign #7 ci_bar = ~ci;

    assign s0_MUX_inputs = {ci_bar,ci,ci_bar,ci};
    assign s1_MUX_inputs = {ci_bar,ONE,ci,ZERO};
    assign co_MUX_inputs = {ci,ZERO,ZERO,ZERO};

    CMOS_4to1_MUX s0_mux(s0_MUX_inputs, a, s[0]);
    CMOS_4to1_MUX s1_mux(s1_MUX_inputs, a, s[1]);
    CMOS_4to1_MUX co_mux(co_MUX_inputs, a, co);
endmodule

module NMI_circuit #(parameter N = 8) (input [N-1:0] a, input ci, output [N-1:0] s, output co);
	localparam NUM_OF_TMAes = (N + 1) / 2;
	wire cies [NUM_OF_TMAes:0];
	genvar k;

	assign co = cies[NUM_OF_TMAes];
    assign cies[0] = ci;

	generate
		for(k = 0; k < NUM_OF_TMAes; k = k + 1) begin: TMIes
			TMI_circuit TMI(a[k*2 + 1:k*2], cies[k], s[k*2 + 1:k*2], cies[k+1]);
		end
	endgenerate
endmodule
