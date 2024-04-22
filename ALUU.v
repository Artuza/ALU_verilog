//PRUEBA DE FUNCIONAMIENTO (NO CUENTA ESTE)
module ALUU(
    input [31:0] a, b,  // Operandos de 32 bits
    input [3:0] opcode, // Código de operación para determinar la función de la ALU
    input cin,          // Carry in para operaciones con acarreo
    output reg [31:0] result, // Resultado de la operación
    output reg cout,          // Carry out
    output reg NegativeFlag,  // Bandera de negativo
    output reg ZeroFlag       // Bandera de cero
);

always @(a, b, opcode, cin) begin
    case (opcode)
        4'b0000: {cout, result} = a + b + cin; // ADD con acarreo
        4'b0001: result = a + b; // ADD sin acarreo
        4'b0010: result = a & b; // ANDS
        4'b0011: result = a - b; // CMP, sólo interesados en flags, resultado no utilizado
        4'b0100: result = a * b; // MULS
        4'b0101: result = a | b; // ORRS
        4'b0110: result = b - a; // RSBS, reverse subtract
        4'b0111: {cout, result} = b - a - ~cin; // SBCS
        4'b1000: result = a - b; // SUBS sin acarreo
        default: result = 32'hxxxx; // Código no definido
    endcase
    
    // Actualización de flags
    NegativeFlag = result[31]; // Considera el bit más significativo como el signo
    ZeroFlag = (result == 32'b0);
end

endmodule
