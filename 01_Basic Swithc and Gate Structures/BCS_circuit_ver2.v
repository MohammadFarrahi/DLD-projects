` timescale 1ns/1ns
module BCS_circuit_ver2(input a1,b1,e0,g0, output e1,g1);
    wire a1_bar, k1_bar, e1_bar, g1_bar;
    wire k1, j1;

    //structure_1
    assign #12 j1 = a1 ~^ b1;
    //structure_2
    and #(13, 17) AND_2IN(e1, e0,j1);
    //structure_3
    not #(5, 7) NOT(a1_bar, a1);
    and #(17, 22) AND_3IN(k1, e0, b1, a1_bar);
    //structure_4
    or #(19, 17) OR_2IN(g1, g0, k1);
endmodule
