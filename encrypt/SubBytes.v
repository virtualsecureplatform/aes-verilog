// https://doi.org/10.13154/tches.v2019.i4.91-125
module sbox(
	output [7:0] SubByte,
	input [7:0] num
	);
	
	wire[0:7] R, U;

	assign U = num;
	assign SubByte = R;

//ftop.d
assign Z18 = U[1]  ^ U[4];
assign L28 = Z18 ^ U[6];
assign Q0  = U[2]  ^ L28;
assign Z96 = U[5]  ^ U[6];
assign Q1  = U[0]  ^ Z96;
assign Z160= U[5]  ^ U[7];
assign Q2  = U[6]  ^ Z160;
assign Q11 = U[2]  ^ U[3];
assign L6  = U[4]  ^ Z96;
assign Q3  = Q11 ^ L6;
assign Q16 = U[0]  ^ Q11;
assign Q4  = Q16 ^ U[4];
assign Q5  = Z18 ^ Z160;
assign Z10 = U[1]  ^ U[3];
assign Q6  = Z10 ^ Q2;
assign Q7  = U[0]  ^ U[7];
assign Z36 = U[2]  ^ U[5];
assign Q8  = Z36 ^ Q5;
assign L19 = U[2]  ^ Z96;
assign Q9  = Z18 ^ L19;
assign Q10 = Z10 ^ Q1;
assign Q12 = U[3]  ^ L28;
assign Q13 = U[3]  ^ Q2;
assign L10 = Z36 ^ Q7;
assign Q14 = U[6]  ^ L10;
assign Q15 = U[0]  ^ Q5;
assign L8  = U[3]  ^ Q5;
assign L12 = Q16 ^ Q2;
assign L16 = U[2]  ^ Q4;
assign L15 = U[1]  ^ Z96;
assign L31 = Q16 ^ L15;
assign L5  = Q12 ^ L31;
assign L13 = U[3]  ^ Q8;
assign L17 = U[4]  ^ L10;
assign L29 = Z96 ^ L10;
assign L14 = Q11 ^ L10;
assign L26 = Q11 ^ Q5;
assign L30 = Q11 ^ U[6];
assign L7  = Q12 ^ Q1;
assign L11 = Q12 ^ L15;
assign L27 = L30 ^ L10;
assign Q17 = U[0];
assign L0  = Q10;
assign L4  = U[6];
assign L20 = Q0;
assign L24 = Q16;
assign L1  = Q6;
assign L9  = U[5];
assign L21 = Q11;
assign L25 = Q13;
assign L2  = Q9;
assign L18 = U[1];
assign L22 = Q15;
assign L3  = Q8;
assign L23 = U[0];

//mulx.a
assign T20 = ~(Q6 & Q12);
assign T21 = ~(Q3 & Q14);
assign T22 = ~(Q1 & Q16);
assign T10 = (~(Q3 | Q14) ^ ~(Q0 & Q7));
assign T11 = (~(Q4 | Q13) ^ ~(Q10 & Q11));
assign T12 = (~(Q2 | Q17) ^ ~(Q5 & Q9));
assign T13 = (~(Q8 | Q15) ^ ~(Q2 & Q17));
assign X0 = T10 ^ (T20 ^ T22);
assign X1 = T11 ^ (T21 ^ T20);
assign X2 = T12 ^ (T21 ^ T22);
assign X3 = T13 ^ (T21 ^ ~(Q4 & Q13));

//inv.a
assign T0 = ~(X0 & X2);
assign T1 = ~(X1 | X3);
assign T2 = ~(T0 ^ T1);
// assign Y0 = MUX(X2, T2, X3);
// assign Y2 = MUX(X0, T2, X1);
// assign T3 = MUX(X1, X2, 1);
// assign Y1 = MUX(T2, X3, T3);
// assign T4 = MUX(X3, X0, 1);
// assign Y3 = MUX(T2, X1, T4);
assign Y0 = X2?T2:X3;
assign Y2 = X0?T2:X1;
assign T3 = X1?X2:1'b1;
assign Y1 = T2?X3:T3;
assign T4 = X3?X0:1'b1;
assign Y3 = T2?X1:T4;

//mull.f
assign K4  = (Y0 & L4 );
assign K8  = (Y0 & L8 );
assign K24 = (Y0 & L24);
assign K28 = (Y0 & L28);

//mull.d
assign K0  = ~(Y0 & L0 );
assign K12 = ~(Y0 & L12);
assign K16 = ~(Y0 & L16);
assign K20 = ~(Y0 & L20);
assign K1  = ~(Y1 & L1 );
assign K5  = ~(Y1 & L5 );
assign K9  = ~(Y1 & L9 );
assign K13 = ~(Y1 & L13);
assign K17 = ~(Y1 & L17);
assign K21 = ~(Y1 & L21);
assign K25 = ~(Y1 & L25);
assign K29 = ~(Y1 & L29);
assign K2  = ~(Y2 & L2 );
assign K6  = ~(Y2 & L6 );
assign K10 = ~(Y2 & L10);
assign K14 = ~(Y2 & L14);
assign K18 = ~(Y2 & L18);
assign K22 = ~(Y2 & L22);
assign K26 = ~(Y2 & L26);
assign K30 = ~(Y2 & L30);
assign K3  = ~(Y3 & L3 );
assign K7  = ~(Y3 & L7 );
assign K11 = ~(Y3 & L11);
assign K15 = ~(Y3 & L15);
assign K19 = ~(Y3 & L19);
assign K23 = ~(Y3 & L23);
assign K27 = ~(Y3 & L27);
assign K31 = ~(Y3 & L31);

//8xor4.d
assign R[0] = (K0  ^ K1 ) ^ (K2  ^ K3 );
assign R[1] = (K4  ^ K5 ) ^ (K6  ^ K7 );
assign R[2] = (K8  ^ K9 ) ^ (K10 ^ K11);
assign R[3] = (K12 ^ K13) ^ (K14 ^ K15);
assign R[4] = (K16 ^ K17) ^ (K18 ^ K19);
assign R[5] = (K20 ^ K21) ^ (K22 ^ K23);
assign R[6] = (K24 ^ K25) ^ (K26 ^ K27);
assign R[7] = (K28 ^ K29) ^ (K30 ^ K31);
endmodule 

module SubBytes(
x,
z);

  input [127:0] x;
  output [127:0] z;

  generate
    genvar i;
    for (i = 0; i < 16; i = i + 1) begin:SBOX
	  sbox sbox(z[8*(i+1)-1:8*i], x[8*(i+1)-1:8*i]);
    end
  endgenerate


endmodule

