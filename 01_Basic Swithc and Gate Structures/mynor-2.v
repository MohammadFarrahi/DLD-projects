` timescale 1ns/1ns
module mynor_2(input a,b, output w);
    supply1 vdd;
    supply0 gnd;
    wire s;

    nmos #(3, 4, 5) T1(w, gnd, a);
    nmos #(3, 4, 5) T2(w, gnd, b);
    pmos #(5, 6, 7) T3(s, vdd, b);
    pmos #(5, 6, 7) T4(w, s, a);
endmodule
