module top_module(inputs a, b output out)
  assign c = a | b;
  assign out = !(c);

  // alternatively, assign out = !(a | b);
endmodule

// https://hdlbits.01xz.net/wiki/Norgate
