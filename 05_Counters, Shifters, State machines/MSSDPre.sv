module MSSDPre(input serIn,clk,rst, output [3:0] P, output [1:0] pn, output outValid, output error);
    logic [1:0] ns, ps;
    logic C3en, Cinit, C9en, Shen, DMen;
    localparam [1:0] Idls = 2'b00, GetInfo = 2'b01, GetData = 2'b10, Check = 2'b11;
    wire [2:0] C3Q;
    wire [8:0] C9Q;
    wire [7:0] Sh_parout;
    wire [8:0] C9PL;
    wire C9co, C3co, C9ld, Sh_serOut;

    always @(ps, serIn, C3co, C9co) begin
        ns = Idls; Cinit = 0; Shen = 0;
        C3en = 0; C9en = 0; DMen = 0;
        case(ps)
            Idls: begin ns = serIn ? Idls : GetInfo; Cinit = 1; end
            GetInfo: begin ns = C3co ? GetData : GetInfo; C3en = 1; Shen = 1; end
            GetData: begin
                ns = (~C9co) ? GetData :
                     (serIn) ? Idls : Check;
                DMen = (C9co) ? 0 : 1;
                C9en = 1;
            end
            Check: ns = serIn ? Idls : Check;
            default: ns = Idls;
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if(rst) ps <= Idls;
        else ps <= ns;
    end
    
    Counter_3bit cnt_3bit(Cinit, C3en, clk, rst, C3Q, C3co);
    ShiftRegister_8bit ShR_8bit(serIn, Shen, clk, rst, Sh_parout, Sh_serOut);
    
    Comp2_6bit comp2_6bit(Sh_parout[7:2], C9PL[8:3]);
    MyDFF mydff(C3co, clk, rst, C9ld);
    assign C9PL[2:0] = 3'd0;
    Counter_9bit cnt_9bit(C9PL, C9ld, Cinit, C9en, clk, rst, C9Q, C9co);

    DMUX_1to4 dmux_1to4(serIn, DMen, Sh_parout[1:0], P, outValid);
    assign pn = Sh_parout[1:0];
    
    assign error = (ps == Check) ? 1 : 0;
endmodule