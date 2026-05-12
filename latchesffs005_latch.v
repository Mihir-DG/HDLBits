module top_module (
    input d, 
    input ena,
    output q);

    always @ (*) begin
        if (ena) q <= d;
    end
endmodule


// https://hdlbits.01xz.net/wiki/Exams/m2014_q4a
