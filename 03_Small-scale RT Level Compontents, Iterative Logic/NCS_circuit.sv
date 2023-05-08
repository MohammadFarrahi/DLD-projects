` timescale 1ns/1ns
module TCS_circuit(
		input [1:0] a,
		input [1:0] b,
		input eq,gt,
		output logic EQ,GT);
	logic [1:0] j;
	logic k, ok;
	
	always @(a, b) begin
		#19;
		j = {a[1] ^ b[1], a[0] ^ b[0]};
	end
	always @(j, eq) begin
		#25;
		EQ = ~(j[0] | j[1] | ~eq);
	end

	always @(a, b) begin
		#35;
		k = ~(~(~(a[1] ^ b[1]) & ~a[0] & b[0]) & ~(~a[1] & b[1]));
	end
	always @(k, eq) begin
		#8;
		ok = ~(eq & k);
	end
	always @(ok, gt) begin
		#12;
		GT = ~(~gt & ok);
	end
endmodule

module NCS_circuit #(parameter N = 8) (input [N-1:0] a,b, input eq,gt, output EQ,GT);
	localparam NUM_OF_TCSes = (N + 1) / 2;
	wire gt_eq [NUM_OF_TCSes:0][1:0];
	genvar k;

	assign gt_eq[NUM_OF_TCSes][1] = gt;
	assign gt_eq[NUM_OF_TCSes][0] = eq;
	assign EQ = gt_eq[0][0];
	assign GT = gt_eq[0][1];

	generate
		for(k = NUM_OF_TCSes - 1; k >= 0; k = k - 1) begin: TCSes
			TCS_circuit TCS(a[k*2 + 1:k*2],b[k*2 + 1:k*2], gt_eq[k + 1][0],gt_eq[k + 1][1], gt_eq[k][0],gt_eq[k][1]);
		end
	endgenerate
endmodule