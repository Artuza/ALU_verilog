module subtractor_32bit(
    input [31:0] a,
    input [31:0] b,
    input bin,  // Borrow in inicial
    output [31:0] diff,
    output bout  // Borrow out final
);
    wire [31:0] borrow;
    full_subtractor fs0(a[0], b[0], bin, diff[0], borrow[0]);

    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : subtractor_loop
            full_subtractor fs(a[i], b[i], borrow[i-1], diff[i], borrow[i]);
        end
    endgenerate

    assign bout = borrow[31];  // El borrow out final es el último generado
endmodule
