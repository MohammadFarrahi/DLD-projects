` timescale 1ns/1ns
module comparator_8bit_ver2(
        input [7:0] in1,
        input [7:0] in2,
        output EQ,GT);
    wire [4:0] eq;
    wire [4:0] gt;
    supply1 Vdd;
    supply0 Gnd;

    assign eq[4] = Vdd;
    assign gt[4] = Gnd;
    assign EQ = eq[0];
    assign GT = gt[0];
    genvar k;

    generate
        for(k = 3; k >= 0; k = k - 1) begin: TCSgates
        TCS_circuit TCS(in1[(2*k) + 1:(2*k)],in2[(2*k) + 1:(2*k)], eq[k + 1],gt[k + 1], eq[k],gt[k]);
        end
    endgenerate
endmodule
