// https://hdlbits.01xz.net/wiki/Wire_decl

module top_module(input a, b, c, d
                  output out, out_n)

  // note the order of assignments here; assigning outputs is only enabled by having the declarations in place earlier.
  
  wire AND1out;
  wire AND2out;
  wire ORout;

  assign out = ORout;
  assign out_n = !ORout;
  
  assign AND1out = a & b;
  assign AND2out = c & d;
  assign ORout = AND1out | AND2out;
endmodule
