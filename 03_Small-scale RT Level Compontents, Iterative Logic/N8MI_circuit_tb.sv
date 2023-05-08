` timescale 1ns/1ns
module N8MI_circuit_tb();
	localparam NUM_OF_CASES = 131073;

	logic [7:0] aa;
	logic [7:0] worst_case_aa[1:0];

	logic [15:0] test_vectors [0:131073];
    logic [8:0] prev_output;
	wire [7:0] result;
    wire co;
    
	shortreal start_point_delay, end_point_delay;
	shortreal worst_case_delay;
	
	supply1 Vdd;
	integer i;

	NMI_circuit CUT(aa, Vdd, result, co);
	
	initial begin
		$readmemb("NMI_NMA_NCS_testvectors.txt", test_vectors);
		i = 0;
		worst_case_delay = 0;
        start_point_delay = 0;
        end_point_delay = 0;
	end
	always @(result, co) begin
		if(prev_output !== 9'bx) begin
            end_point_delay = $realtime;
		end
	end
	initial begin
		for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
			prev_output = {co, result};
			aa = test_vectors[i][7:0];
			start_point_delay = $realtime;
			#200;
            if({co, result} !== (aa + 1'b1)) begin
                $diplay("**Error** aa : %b | result : %b | co : %b (%d + 1 != %d)", aa, result, co, aa, {co, result});
            end
            if(end_point_delay - start_point_delay > worst_case_delay) begin
                worst_case_delay = end_point_delay - start_point_delay;
                worst_case_aa[0] = test_vectors[i - 1][7:0];
                worst_case_aa[1] = aa;
            end
		end
		$display("worst case delay:");
		$display("aa : %b --> %b  delay: %0t ns",
		worst_case_aa[0], worst_case_aa[1], worst_case_delay);
		#20 $stop;
	end


endmodule