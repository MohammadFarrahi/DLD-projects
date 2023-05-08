` timescale 1ns/1ns
module N8CS_circuit_tb();
	localparam NUM_OF_CASES = 131073;

	logic [7:0] aa;
	logic [7:0] bb;
	logic [7:0] EE_worst_case_aa [0:1][0:1];
	logic [7:0] EE_worst_case_bb [0:1][0:1];
	logic [7:0] GG_worst_case_aa [0:1][0:1];
	logic [7:0] GG_worst_case_bb [0:1][0:1];

	logic [15:0] test_vectors [0:NUM_OF_CASES];
	wire EE, GG;
	logic prev_EE, prev_GG;
	
	shortreal delay_EE, delay_GG;
	shortreal worst_delay_EE_to0, worst_delay_EE_to1;
	shortreal worst_delay_GG_to1, worst_delay_GG_to0;
	
	supply1 Vdd;
	supply0 Gnd;
	integer i;

	NCS_circuit CUT(aa,bb, Vdd,Gnd, EE,GG);
	
	initial begin
		$readmemb("NMI_NMA_NCS_testvectors.txt", test_vectors);
		i = 0;
		worst_delay_EE_to1 = 0;
		worst_delay_EE_to0 = 0;
		worst_delay_GG_to1 = 0;
		worst_delay_GG_to0 = 0;
	end
	always @(EE) begin
		delay_EE = $realtime - delay_EE;
		#1;
		if(EE === 1'b0 && prev_EE !== 1'bx) begin
			if(delay_EE > worst_delay_EE_to0) begin
				{EE_worst_case_aa[0][0], EE_worst_case_bb[0][0]} = test_vectors[i - 1];
				{EE_worst_case_aa[0][1], EE_worst_case_bb[0][1]} = {aa, bb};
				worst_delay_EE_to0 = delay_EE;
			end
		end
		if(EE === 1'b1 && prev_EE !== 1'bx) begin
			if(delay_EE > worst_delay_EE_to1) begin
				{EE_worst_case_aa[1][0], EE_worst_case_bb[1][0]} = test_vectors[i - 1];
				{EE_worst_case_aa[1][1], EE_worst_case_bb[1][1]} = {aa, bb};
				worst_delay_EE_to1 = delay_EE;
			end
		end
	end
	always @(GG) begin
		delay_GG = $realtime - delay_GG;
		#1;
		if(GG === 1'b0 && prev_GG !== 1'bx) begin
			if(delay_GG > worst_delay_GG_to0) begin
				{GG_worst_case_aa[0][0], GG_worst_case_bb[0][0]} = test_vectors[i - 1];
				{GG_worst_case_aa[0][1], GG_worst_case_bb[0][1]} = {aa, bb};
				worst_delay_GG_to0 = delay_GG;
			end
		end
		if(GG === 1'b1 && prev_GG !== 1'bx) begin
			if(delay_GG > worst_delay_GG_to1) begin
				{GG_worst_case_aa[1][0], GG_worst_case_bb[1][0]} = test_vectors[i - 1];
				{GG_worst_case_aa[1][1], GG_worst_case_bb[1][1]} = {aa, bb};
				worst_delay_GG_to1 = delay_GG;
			end
		end
	end
	initial begin
		for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
			prev_EE = EE; prev_GG = GG;
			{aa,bb} = test_vectors[i];
			delay_EE = $realtime;
			delay_GG = $realtime;
			#180;
		end
		$display("EE to0 worst case delay:");
		$display("aa : %b --> %b , bb : %b --> %b  delay: %0t ns",
		EE_worst_case_aa[0][0], EE_worst_case_aa[0][1], EE_worst_case_bb[0][0], EE_worst_case_bb[0][1], worst_delay_EE_to0);
		$display("EE to1 worst case delay:");
		$display("aa : %b --> %b , bb : %b --> %b  delay: %0t ns",
		EE_worst_case_aa[1][0], EE_worst_case_aa[1][1], EE_worst_case_bb[1][0], EE_worst_case_bb[1][1], worst_delay_EE_to1);
		$display("GG to0 worst case delay:");
		$display("aa : %b --> %b , bb : %b --> %b  delay: %0t ns",
		GG_worst_case_aa[0][0], GG_worst_case_aa[0][1], GG_worst_case_bb[0][0], GG_worst_case_bb[0][1], worst_delay_GG_to0);
		$display("GG to1 worst case delay:");
		$display("aa : %b --> %b , bb : %b --> %b  delay: %0t ns",
		GG_worst_case_aa[1][0], GG_worst_case_aa[1][1], GG_worst_case_bb[1][0], GG_worst_case_bb[1][1], worst_delay_GG_to1);
		#20 $stop;
	end
endmodule
