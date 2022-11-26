// http://cs-www.cs.yale.edu/homes/peralta/CircuitStuff/Sinv.txt
module inverse_sbox(	
	output [7:0] SubByte,
	input [7:0] num
	);
	
	wire[0:7] S, U;

	assign U = num;
	assign SubByte = S;


assign Y0 = U[0] ^ U[3];
assign Y2 = ~U[1] ^ U[3];
assign Y4 = U[0] ^ Y2;
assign RTL0 = U[6] ^ U[7];
assign Y1 = Y2 ^ RTL0;
assign Y7 = ~U[2] ^ Y1;
assign RTL1 = U[3] ^ U[4];
assign Y6 = ~U[7] ^ RTL1;
assign Y3 = Y1 ^ RTL1;
assign RTL2 = ~U[0] ^ U[2];
assign Y5 = U[5] ^ RTL2;
assign sa1 = Y0 ^ Y2;
assign sa0 = Y1 ^ Y3;
assign sb1 = Y4 ^ Y6;
assign sb0 = Y5 ^ Y7;
assign ah = Y0 ^ Y1;
assign al = Y2 ^ Y3;
assign aa = sa0 ^ sa1;
assign bh = Y4 ^ Y5;
assign bl = Y6 ^ Y7;
assign bb = sb0 ^ sb1;
assign ab20 = sa0 ^ sb0;
assign ab22 = al ^ bl;
assign ab23 = Y3 ^ Y7;
assign ab21 = sa1 ^ sb1;
assign abcd1 = ah & bh;
assign rr1 = Y0 & Y4;
assign ph11 = ab20 ^ abcd1;
assign t01 = Y1 & Y5;
assign ph01 = t01 ^ abcd1;
assign abcd2 = al & bl;
assign r1 = Y2 & Y6;
assign pl11 = ab22 ^ abcd2;
assign r2 = Y3 & Y7;
assign pl01 = r2 ^ abcd2;
assign r3 = sa0 & sb0;
assign vr1 = aa & bb;
assign pr1 = vr1 ^ r3;
assign wr1 = sa1 & sb1;
assign qr1 = wr1 ^ r3;
assign ab0 = ph11 ^ rr1;
assign ab1 = ph01 ^ ab21;
assign ab2 = pl11 ^ r1;
assign ab3 = pl01 ^ qr1;
assign cp1 = ab0 ^ pr1;
assign cp2 = ab1 ^ qr1;
assign cp3 = ab2 ^ pr1;
assign cp4 = ab3 ^ ab23;
assign tinv1 = cp3 ^ cp4;
assign tinv2 = cp3 & cp1;
assign tinv3 = cp2 ^ tinv2;
assign tinv4 = cp1 ^ cp2;
assign tinv5 = cp4 ^ tinv2;
assign tinv6 = tinv5 & tinv4;
assign tinv7 = tinv3 & tinv1;
assign d2 = cp4 ^ tinv7;
assign d0 = cp2 ^ tinv6;
assign tinv8 = cp1 & cp4;
assign tinv9 = tinv4 & tinv8;
assign tinv10 = tinv4 ^ tinv2;
assign d1 = tinv9 ^ tinv10;
assign tinv11 = cp2 & cp3;
assign tinv12 = tinv1 & tinv11;
assign tinv13 = tinv1 ^ tinv2;
assign d3 = tinv12 ^ tinv13;
assign sd1 = d1 ^ d3;
assign sd0 = d0 ^ d2;
assign dl = d0 ^ d1;
assign dh = d2 ^ d3;
assign dd = sd0 ^ sd1;
assign abcd3 = dh & bh;
assign rr2 = d3 & Y4;
assign t02 = d2 & Y5;
assign abcd4 = dl & bl;
assign r4 = d1 & Y6;
assign r5 = d0 & Y7;
assign r6 = sd0 & sb0;
assign vr2 = dd & bb;
assign wr2 = sd1 & sb1;
assign abcd5 = dh & ah;
assign r7 = d3 & Y0;
assign r8 = d2 & Y1;
assign abcd6 = dl & al;
assign r9 = d1 & Y2;
assign r10 = d0 & Y3;
assign r11 = sd0 & sa0;
assign vr3 = dd & aa;
assign wr3 = sd1 & sa1;
assign ph12 = rr2 ^ abcd3;
assign ph02 = t02 ^ abcd3;
assign pl12 = r4 ^ abcd4;
assign pl02 = r5 ^ abcd4;
assign pr2 = vr2 ^ r6;
assign qr2 = wr2 ^ r6;
assign p0 = ph12 ^ pr2;
assign p1 = ph02 ^ qr2;
assign p2 = pl12 ^ pr2;
assign p3 = pl02 ^ qr2;
assign ph13 = r7 ^ abcd5;
assign ph03 = r8 ^ abcd5;
assign pl13 = r9 ^ abcd6;
assign pl03 = r10 ^ abcd6;
assign pr3 = vr3 ^ r11;
assign qr3 = wr3 ^ r11;
assign p4 = ph13 ^ pr3;
assign S[7] = ph03 ^ qr3;
assign p6 = pl13 ^ pr3;
assign p7 = pl03 ^ qr3;
assign S[3] = p1 ^ p6;
assign S[6] = p2 ^ p6;
assign S[0] = p3 ^ p6;
assign X11 = p0 ^ p2;
assign S[5] = S[0] ^ X11;
assign X13 = p4 ^ p7;
assign X14 = X11 ^ X13;
assign S[1] = S[3] ^ X14;
assign X16 = p1 ^ S[7];
assign S[2] = X14 ^ X16;
assign X18 = p0 ^ p4;
assign X19 = S[5] ^ X16;
assign S[4] = X18 ^ X19;

endmodule

module inverseSubBytes(x,z);
input [127:0] x;
output [127:0] z;

generate
genvar i;
for (i = 0; i < 16; i = i + 1) begin:INVERSESBOX
	inverse_sbox inverse_sbox(z[8*(i+1)-1:8*i], x[8*(i+1)-1:8*i]);
end
endgenerate


endmodule