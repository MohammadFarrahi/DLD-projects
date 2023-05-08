` timescale 1ns/1ns
module mynand_3(input a,b,c, output w);
    supply1 vdd;
    supply0 gnd;
    wire s1, s2;

    nmos #(3, 4, 5) T1(s1, gnd, c);
    nmos #(3, 4, 5) T2(s2, s1, b);
    nmos #(3, 4, 5) T3(w, s2, a);
    pmos #(5, 6, 7) T4(w, vdd, a);
    pmos #(5, 6, 7) T5(w, vdd, b);
    pmos #(5, 6, 7) T6(w, vdd, c);
endmodule
