` timescale 1ns/1ns
module LessDistance_circuit(input [7:0] dataA,dataB,reff, output [7:0] w);
    wire [7:0] diff_dataA, diff_dataB;
    wire GT,EQ;
    supply1 Vdd;
    supply0 Gnd;

    AbsDiff8_circuit abs_diff_1(dataA,reff, diff_dataA);
    AbsDiff8_circuit abs_diff_2(dataB,reff, diff_dataB);

    NCS_circuit #8 ncs_8bit(diff_dataA,diff_dataB, Vdd,Gnd, EQ,GT);
    Nbit_CMOS_2to1_MUX #8 mux_8bit_2to1({dataA, dataB}, GT, w);
endmodule
