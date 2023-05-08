` timescale 1ns/1ns
module AbsDiff8_circuit(input [7:0] reff,data, output [7:0] diff);
	wire [7:0] reff_bar, result_2com, subtract_result, res_bar;
	supply1 Vdd;
	wire carr_out, co;

	Nbit_Inverter #8 inv1(reff, reff_bar);
	NMA_circuit #8 adder_8bit(data,reff_bar, Vdd, subtract_result, carr_out);
	Nbit_Inverter #8 inv2(subtract_result, res_bar);
	NMI_circuit #8 incrmt_8bit(res_bar, Vdd, result_2com, co);

	Nbit_CMOS_2to1_MUX #8 mux_8bit_2to1({subtract_result, result_2com}, carr_out, diff);
endmodule
