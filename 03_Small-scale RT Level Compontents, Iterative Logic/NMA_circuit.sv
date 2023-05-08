` timescale 1ns/1ns
module TMA_circuit(input [1:0] a,b, input ci, output [1:0] s, output co);
    wire [3:0] s0_MUX_inputs;
    wire [15:0] s1_MUX_inputs;
    wire [15:0] co_MUX_inputs;
    wire b0_bar, ci_bar;
    logic ONE = 1'b1;
    logic ZERO = 1'b0;

    assign #7 b0_bar = ~b[0];
    assign #7 ci_bar = ~ci;

    assign s0_MUX_inputs = {ci,ci_bar,ci_bar,ci};
    assign s1_MUX_inputs = {ONE,b[0],ZERO,b0_bar,ZERO,b0_bar,ONE,b[0],b[0],ZERO,b0_bar,ONE,b0_bar,ONE,b[0],ZERO};
    assign co_MUX_inputs = {ONE,ONE,ONE,b[0],ONE,b[0],ZERO,ZERO,ONE,ONE,b[0],ZERO,b[0],ZERO,ZERO,ZERO};

    CMOS_4to1_MUX s0_mux(s0_MUX_inputs, {b[0],a[0]}, s[0]);
    PT_16to1_MUX s1_mux(s1_MUX_inputs, {ci,b[1],a[1],a[0]}, s[1]);
    CMOS_16to1_MUX co_mux(co_MUX_inputs, {ci,b[1],a[1],a[0]}, co);
endmodule

module NMA_circuit #(parameter N = 8) (input [N-1:0] a,b, input ci, output [N-1:0] s, output co);
	localparam NUM_OF_TMAes = (N + 1) / 2;
	wire cies [NUM_OF_TMAes:0];
	genvar k;

	assign co = cies[NUM_OF_TMAes];
    assign cies[0] = ci;

	generate
		for(k = 0; k < NUM_OF_TMAes; k = k + 1) begin: TMAes
			TMA_circuit TMA(a[k*2 + 1:k*2],b[k*2 + 1:k*2], cies[k], s[k*2 + 1:k*2], cies[k+1]);
		end
	endgenerate


endmodule
