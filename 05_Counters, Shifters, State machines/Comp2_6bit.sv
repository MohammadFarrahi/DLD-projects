module Comp2_6bit(input [5:0] IN, output [5:0] W);
    assign W = ~IN + 1'b1;
endmodule