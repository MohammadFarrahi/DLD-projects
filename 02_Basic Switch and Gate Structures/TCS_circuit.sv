` timescale 1ns/1ns
module TCS_circuit(
        input [1:0] a,
        input [1:0] b,
        input eq,gt,
        output EQ,GT);
    wire eq_bar, a0_bar, a1_bar, j1_bar, gt_bar;
    wire j0, j1, k0, k1, ok0, ok1;

    assign #19 j0 = a[0] ^ b[0];
    assign #19 j1 = a[1] ^ b[1];
    
    assign #7 eq_bar = ~eq;
    assign #21 EQ = ~(j0 | j1 | eq_bar);
    
    assign #7 a0_bar = ~a[0];
    assign #7 a1_bar = ~a[1];
    assign #7 j1_bar = ~j1;
    
    assign #12 k0 = ~(j1_bar & b[0] & a0_bar);
    assign #8 k1 = ~(a1_bar & b[1]);
    assign #8 ok0 = ~(k1 & k0);

    assign #7 gt_bar = ~gt;
    assign #8 ok1 = ~(ok0 & eq);
    assign #8 GT = ~(ok1 & gt_bar);
endmodule
