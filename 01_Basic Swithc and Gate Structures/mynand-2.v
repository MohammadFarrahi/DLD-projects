` timescale 1ns/1ns
module mynand_2(input a,b, output w);
    supply1 vdd;
    supply0 gnd;
    wire s;

    nmos #(3, 4, 5) T1(s, gnd, b);
    nmos #(3, 4, 5) T2(w, s, a);
    pmos #(5, 6, 7) T3(w, vdd, a);
    pmos #(5, 6, 7) T4(w, vdd, b);
endmodule
