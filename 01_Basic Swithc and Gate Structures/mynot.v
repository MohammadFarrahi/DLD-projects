` timescale 1ns/1ns
module mynot(input a, output w);
    supply1 vdd;
    supply0 gnd;
    
    nmos #(3, 4, 5) T1(w, gnd, a);
    pmos #(5, 6, 7) T2(w, vdd, a);
endmodule
