` timescale 1ns/1ns
module DlatchS(input D,clk, output Q,Q_bar);
	wire s,r;

	nand #(8,8) N1(s, D,clk), N2(r, s,clk), N3(Q, s,Q_bar), N4(Q_bar, r,Q);
endmodule

module DlatchS_TB();
	logic clk = 1;
	logic D = 0;
	wire Q, Q_bar;

	DlatchS CUT(D,clk, Q,Q_bar);

	always #79 clk = ~clk;

	initial begin
		#83;
		//clk low, output must not change
		D = ~D;
		#38
		D = ~D;
		#43;
		//transparecy
		D = ~D;
		#36;
		D = ~D;
		#40;
		//may occur glitgh
		#115;
		D = ~D;
		#158;
		//verification
		repeat(10) begin
			D = ~D;
			#79;
			if(Q !== D) $display("data didn't latch at time = %0t ns", $realtime);
			#79;
		end
	end
	initial begin
		#2049;
		repeat(100) begin
			D = ~D;
			#159;
		end
		$stop;
	end
endmodule

module DlatchS_LR(input D,clk,rst, output Q,Q_bar);
	wire s,r;
	//rst is low active
	nand #(12,12) N1(s, D,clk,rst), N4(Q_bar, r,Q,rst);
	nand #(8,8) N2(r, s,clk), N3(Q, s,Q_bar);
endmodule
