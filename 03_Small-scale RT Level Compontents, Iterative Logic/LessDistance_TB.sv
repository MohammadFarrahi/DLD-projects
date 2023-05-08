` timescale 1ns/1ns
module LessDistance_circuit_TB();
	localparam NUM_OF_CASES = 65536;

	logic [7:0] reff, dataA, dataB;
	logic [7:0] distA, distB, expected;

	logic [15:0] test_vectors [0:NUM_OF_CASES];
	logic [7:0] prev_output;
	wire [7:0] answer;

	shortreal start_point_delay, end_point_delay;
	shortreal worst_case_delay;

	integer i, worst_case_num;

	LessDistance_circuit CUT(dataA,dataB,reff, answer);

	initial begin
	$readmemb("AbsDiff_test_vectors.txt", test_vectors);
		i = 0;
		worst_case_num = 0;
		worst_case_delay = 0;
		start_point_delay = 0;
		end_point_delay = 0;
	end
	always @(answer) begin
		if(prev_output !== 8'bx) begin
		end_point_delay = $realtime;
		end
	end
	initial begin
	repeat(NUM_OF_CASES) begin
		prev_output = answer;
		{dataA,dataB} = test_vectors[i];
		reff = $random;
		start_point_delay = $realtime;
		distA = (dataA > reff) ? dataA - reff : reff - dataA;
		distB = (dataB > reff) ? dataB - reff : reff - dataB;
		expected = (distB > distA) ? dataA : dataB;
		#800;
		if(answer !== expected) begin
			$display("**Error** case i = %0d | reff : %b(%d) | dataA : %b(%d) | dataB : %b(%d) | answer : %b(%d) (exp : %b(%d))",
			i, reff, reff, dataA, dataA, dataB, dataB, answer, answer, expected, expected);
		end
		if(end_point_delay - start_point_delay > worst_case_delay) begin
			worst_case_delay = end_point_delay - start_point_delay;
			worst_case_num = i;
		end
		i = i + 1;
		end
		$display("\n\nworst case delay: %0t ns in case: i = %0d", worst_case_delay, worst_case_num);
		#20 $stop;
	end
endmodule
