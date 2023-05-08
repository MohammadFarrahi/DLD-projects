` timescale 1ns/1ns
module BCS_circuit_ver3(input a1,b1,e0,g0, output e1,g1);
    wire j1, k1, a1_bar;

    assign #12 j1 = a1 ~^ b1;
    
    assign #17 e1 = j1 & e0;
    
    assign #7 a1_bar = ~a1;
    assign #22 k1 = a1_bar & b1 & e0;

    assign #17 g1 = g0 | k1;
endmodule
