module mycomparator(input [9:0] dataa, datab, output LT);
    assign LT = (dataa < datab) ? 1 : 0;
endmodule
