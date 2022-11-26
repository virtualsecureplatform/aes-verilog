// https://github.com/The-OpenROAD-Project/OpenLane/blob/7f0486c949c21042e0a670dd77d2d654ad189483/designs/aes/src/aes.v#L778-L800
module inverseShiftRows (
x,
z);

	input [127:0] x;
	output [127:0] z;
	
	wire [31 : 0] w0, w1, w2, w3;
   wire [31 : 0] ws0, ws1, ws2, ws3;
   assign w0 = x[127 : 096];
   assign w1 = x[095 : 064];
   assign w2 = x[063 : 032];
   assign w3 = x[031 : 000];

   assign ws0 = {w0[31 : 24], w3[23 : 16], w2[15 : 08], w1[07 : 00]};
   assign ws1 = {w1[31 : 24], w0[23 : 16], w3[15 : 08], w2[07 : 00]};
   assign ws2 = {w2[31 : 24], w1[23 : 16], w0[15 : 08], w3[07 : 00]};
   assign ws3 = {w3[31 : 24], w2[23 : 16], w1[15 : 08], w0[07 : 00]};

   assign z = {ws0, ws1, ws2, ws3};

endmodule
