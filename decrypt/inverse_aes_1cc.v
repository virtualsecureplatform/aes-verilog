// `timescale 1ns / 1ps
// synopsys template


module inverse_aes_1cc
(
  clock,
  reset,
  g_input,
  e_input,
  o
);
  localparam    NR = 10;
  input                 clock;
  input                 reset;
  input   [127:0]       g_input; // key
  input   [127:0]       e_input; // ciphertext
  output  [127:0]       o;

  wire    [127:0]          key;
  wire    [127:0]          msg;
  wire    [127:0]          out;
  wire    [128*(NR+1)-1:0] expandedKey;
  wire    [127:0]          expandedKeyi[NR:0];
  wire    [127:0]          x1[NR-1:0];
  wire    [127:0]          x2[NR-1:0];
  wire    [127:0]          x3[NR-1:0];
  wire    [127:0]          x4[NR-2:0];


  assign  key = g_input;   
  assign  msg = e_input;
  assign  o = out;

  genvar i;

  KeyExpansion e (.key(key), .expandedKey(expandedKey));


  generate 
  for(i=0;i<(NR+1);i=i+1)
  begin:EXPANDKEY
    assign expandedKeyi[i] = expandedKey[128*(i+1)-1:128*i];
  end
  endgenerate

  AddRoundKey a(.x(msg), .y(expandedKeyi[NR]), .z(x1[0]));

  generate 
  for(i=0;i<NR;i=i+1)
  begin:INVSHIFTROWS
    inverseShiftRows c(.in(x1[i]), .shifted(x2[i]));
  end
  endgenerate

  generate 
  for(i=0;i<NR;i=i+1)
  begin:INVSUBBYTES
    inverseSubBytes a(.x(x2[i]), .z(x3[i]));
  end
  endgenerate

  generate 
  for(i=0;i<NR;i=i+1)
  begin:INVADDROUNDKEY
    if(i==NR-1) begin:LAST
      AddRoundKey a(.x(x3[i]), .y(expandedKeyi[NR - 1 - i]), .z(out));
    end else begin:ELSE
      AddRoundKey a(.x(x3[i]), .y(expandedKeyi[NR - 1 - i]), .z(x4[i]));
    end
  end
  endgenerate

  generate 
  for(i=0;i<NR-1;i=i+1)
  begin:INVMIXCOLUMNS
    inverseMixColumns d(.state_in(x4[i]), .state_out(x1[i+1]));
  end
  endgenerate


endmodule
