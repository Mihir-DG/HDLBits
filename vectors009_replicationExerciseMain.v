// https://hdlbits.01xz.net/wiki/Vector5

module top_module (
    input a, b, c, d, e,
    output [24:0] out );//

    wire[24:0] comp_a;
    wire[24:0] comp_b;
    
    assign comp_a = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
    assign comp_b = {5{a, b, c, d, e}};
    assign out = (comp_a & comp_b) | (~(comp_a) & ~(comp_b));
    
    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };

endmodule
