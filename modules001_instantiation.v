module top_module ( input a, input b, output out );

    //mod_a instance1 (a,b,out);
    mod_a instance2 (.in1(a), .in2(b), .out(out));
    
endmodule

// https://hdlbits.01xz.net/wiki/Module
