module rsbs_32bit(
    input [31:0] a,
    input [31:0] b,
    output [31:0] result
);
    wire [31:0] neg_a;  // Para almacenar el complemento a dos de A
    complement_to_two negation(.in(a), .out(neg_a));
    full_adder subtractor(.a(b), .b(neg_a), .cin(1'b0), .sum(result), .cout());
endmodule
