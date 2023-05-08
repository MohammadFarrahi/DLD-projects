` timescale 1ns/1ns
module BCS_circuit_ver1(
	input
	a1,b1,e0,g0,
	output
	e1,g1
	);
	wire j1, k1, k1_bar, a1_bar;
	wire e1_bar, g1_bar;

	mynot NOT1(a1, a1_bar);
	//structure_1
	mymux MUX(a1_bar,a1,b1, j1);
	//structure_2
	mynand_2 NAND_2IN(e0,j1, e1_bar);
	mynot NOT2(e1_bar, e1);
	//structure_3
	mynand_3 NAND_3IN(e0,b1,a1_bar, k1_bar);
	mynot NOT3(k1_bar, k1);
	//structure_4
	mynor_2 NOR_2IN(g0,k1, g1_bar);
	mynot NOT4(g1_bar, g1);
endmodule
