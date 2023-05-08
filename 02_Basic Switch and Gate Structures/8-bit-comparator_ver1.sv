` timescale 1ns/1ns
module comparator_8bit_ver1(
        input [7:0] in1,
        input [7:0] in2,
        output EQ,GT);
    wire [8:0] eq;
    wire [8:0] gt;
    supply1 Vdd;
    supply0 Gnd;

    assign eq[8] = Vdd;
    assign gt[8] = Gnd;
    assign EQ = eq[0];
    assign GT = gt[0];
    genvar k;

    generate
        for(k = 7; k >= 0; k = k - 1) begin: BCSgates
            BCS_circuit_ver3 BCS(in1[k],in2[k],eq[k + 1],gt[k + 1], eq[k],gt[k]);
        end
    endgenerate
endmodule
