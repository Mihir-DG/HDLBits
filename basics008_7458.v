// https://hdlbits.01xz.net/wiki/7458

module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire p1y_in1;
    wire p1y_in2;
    wire p2y_in1;
    wire p2y_in2;
    
    assign p1y = p1y_in1 | p1y_in2;
    assign p2y = p2y_in1 | p2y_in2;
    
    assign p1y_in1 = p1a & p1b & p1c;
    assign p1y_in2 = p1d & p1e & p1f;
    assign p2y_in1 = p2a & p2b;
    assign p2y_in2 = p2c & p2d;

endmodule
