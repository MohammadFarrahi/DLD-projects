` timescale 1ns/1ns
module LessDistanceB_circuit(input [7:0] dataA,dataB,reff, output [7:0] w);
    wire [7:0] distA, distB;
    
    assign distA = (dataA > reff) ? dataA - reff : reff - dataA;
    assign distB = (dataB > reff) ? dataB - reff : reff - dataB;
    assign #520 w = (distB > distA) ? dataA : dataB;

endmodule
