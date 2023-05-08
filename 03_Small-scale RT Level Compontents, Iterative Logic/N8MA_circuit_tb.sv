` timescale 1ns/1ns
module N8MA_circuit_tb();
	localparam NUM_OF_CASES = 131073;

	logic [7:0] aa;
	logic [7:0] bb;
	logic [7:0] worst_case_aa [0:1];
	logic [7:0] worst_case_bb [0:1];

	logic [15:0] test_vectors [0:NUM_OF_CASES];
    logic [8:0] prev_output;
	wire [7:0] sum;
    wire co;
    
	shortreal start_point_delay, end_point_delay;
	shortreal worst_case_delay;
	
	supply0 Gnd;
	integer i;
	
    NMA_circuit CUT(aa,bb, Gnd, sum, co);

	initial begin
		$readmemb("NMI_NMA_NCS_testvectors.txt", test_vectors);
		i = 0;
		worst_case_delay = 0;
        start_point_delay = 0;
        end_point_delay = 0;
	end
	always @(sum, co) begin
		if(prev_output !== 9'bx) begin
            end_point_delay = $realtime;
		end
	end
	initial begin
		for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
			prev_output = {co, sum};
			{aa,bb} = test_vectors[i];
			start_point_delay = $realtime;
			#420;
            if({co, sum} !== (aa + bb)) begin
                $diplay("**Error** aa : %b | bb : %b | s : %b | co : %b (%d + %d != %d)", aa, bb, sum, co, aa, bb, {co, sum});
            end
            if(end_point_delay - start_point_delay > worst_case_delay) begin
                worst_case_delay = end_point_delay - start_point_delay;
                {worst_case_aa[0], worst_case_bb[0]} = test_vectors[i - 1];
                {worst_case_aa[1], worst_case_bb[1]} = {aa, bb};
            end
		end
		$display("worst case delay:");
		$display("aa : %b --> %b , bb : %b --> %b  delay: %0t ns",
		worst_case_aa[0], worst_case_aa[1], worst_case_bb[0], worst_case_bb[1], worst_case_delay);
		#20 $stop;
	end


endmodule