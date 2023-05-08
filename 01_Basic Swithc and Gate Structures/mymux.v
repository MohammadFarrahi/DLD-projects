` timescale 1ns/1ns
module mymux(input a,b,s, output w);
    wire s_bar;

    mynot NOT(s, s_bar);
    nmos #(3, 4, 5) T1(w, a, s_bar);
    nmos #(3, 4, 5) T2(w, b, s);
endmodule
