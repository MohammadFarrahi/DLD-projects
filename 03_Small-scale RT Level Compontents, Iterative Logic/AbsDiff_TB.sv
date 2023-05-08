` timescale 1ns/1ns
module AbsDiff8_circuit_TB();
	localparam NUM_OF_CASES = 65536;

	logic [7:0] reff;
	logic [7:0] data;
	logic [7:0] expected;

	logic [15:0] test_vectors [0:NUM_OF_CASES];
	logic [7:0] prev_output;
	wire [7:0] diff;

	shortreal start_point_delay, end_point_delay;
	shortreal worst_case_delay;

	integer i, worst_case_num;

	AbsDiff8_circuit CUT(reff,data, diff);

initial begin
	$readmemb("AbsDiff_test_vectors.txt", test_vectors);
	i = 0;
	worst_case_num = 0;
	worst_case_delay = 0;
	start_point_delay = 0;
	end_point_delay = 0;
end
always @(diff) begin
	if(prev_output !== 8'bx) begin
		end_point_delay = $realtime;
	end
end
initial begin
	for(i = 0; i < NUM_OF_CASES; i = i + 1) begin
		prev_output = diff;
		{reff,data} = test_vectors[i];
		start_point_delay = $realtime;
		expected = (data > reff) ? data - reff : reff - data;
		#610;
		if(diff !== expected) begin
			$display("**Error** case i = %0d | reff : %b | data : %b | diff : %b ( |%d - %d| != %d )(exp : %b)", i, reff, data, diff, reff, data, diff, expected);
		end
		if(end_point_delay - start_point_delay > worst_case_delay) begin
			worst_case_delay = end_point_delay - start_point_delay;
			worst_case_num = i;
		end
	end
	repeat(100) begin
		prev_output = diff;
		{reff,data} = $random;
		start_point_delay = $realtime;
		expected = (data > reff) ? data - reff : reff - data;
		#610;
		if(diff !== expected) begin
			$display("**Error** case i = %0d | reff : %b | data : %b | diff : %b ( |%d - %d| != %d )(exp : %b)", i, reff, data, diff, reff, data, diff, expected);
		end
		if(end_point_delay - start_point_delay > worst_case_delay) begin
			worst_case_delay = end_point_delay - start_point_delay;
			worst_case_num = i;
		end
		i = i + 1;
	end
	$display("\n\nworst case delay: %0t ns in case: %0d", worst_case_delay, worst_case_num);
	#20 $stop;
end
endmodule
