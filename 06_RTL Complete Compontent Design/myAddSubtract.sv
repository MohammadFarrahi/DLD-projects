module myAddSubtract(input add_sub_crl, input [9:0] dataa, datab, output logic [9:0] w);
    always @(dataa, datab, add_sub_crl) begin
        w = 10'd0;
        w = add_sub_crl ? (dataa - datab) : (dataa + datab);
    end
endmodule