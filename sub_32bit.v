module sub_32bit(
    input [31:0] a,
    input [31:0] b,
    output [31:0] diff,
    output ZeroFlag,
    output NegativeFlag,
    output OverflowFlag,
    output BorrowFlag
);
    wire [31:0] negated_b;
    wire cout; // Utilizado para la bandera de acarreo (borrow)

    // Complemento a dos de B para usarlo en la suma
    complement_to_two neg_b(.in(b), .out(negated_b));

    // Suma A con el complemento a dos de B
    add_32bit subtractor(
        .a(a),
        .b(negated_b),
        .cin(1'b1),  // El bit de acarreo inicial se setea en 1 para el complemento a dos
        .sum(diff),
        .cout(cout),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

    // La bandera de acarreo (borrow) es el inverso del carry out de la suma
    assign BorrowFlag = ~cout;

    // La bandera de overflow se calcula con la fórmula típica para la resta
    assign OverflowFlag = (a[31] & ~b[31] & ~diff[31]) | (~a[31] & b[31] & diff[31]);

endmodule
