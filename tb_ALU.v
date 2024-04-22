`timescale 1ns / 1ps

module tb_ALU;

    // Entradas
    reg [31:0] a;
    reg [31:0] b;
    reg cin;
    reg [3:0] opcode;

    // Salidas
    wire [31:0] result;
    wire cout;
    wire NegativeFlag;
    wire ZeroFlag;

    // Instancia del módulo ALU
    alu uut (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .opcode(opcode), 
        .result(result), 
        .cout(cout),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

    // Proceso de inicialización y pruebas
    initial begin
        // Inicializar las entradas
        a = 0;
        b = 0;
        cin = 0;
        opcode = 0;

        // Monitor para observar cambios en las señales
        $monitor("Time = %t | Opcode = %b | A = %d | B = %d | Result = %d | Cout = %b | NF = %b | ZF = %b", 
                 $time, opcode, a, b, result, cout, NegativeFlag, ZeroFlag);

        // Probar ADD
        a = 15; b = 10; cin = 0; opcode = 4'b0000; #10;
        // Probar ADCS
        a = 15; b = 10; cin = 1; opcode = 4'b0001; #10;
        // Probar ANDS
        a = 12; b = 5; cin = 0; opcode = 4'b0010; #10;
        // Probar ORRS
        a = 12; b = 5; cin = 0; opcode = 4'b0011; #10;
        // Probar RSBS
        a = 10; b = 15; cin = 0; opcode = 4'b0100; #10;
        // Probar SBCS
        a = 20; b = 5; cin = 1; opcode = 4'b0101; #10;
        // Probar SUBS
        a = 20; b = 5; cin = 0; opcode = 4'b0110; #10;
        // Probar CMP
        a = 10; b = 10; cin = 0; opcode = 4'b0111; #10;
        // Probar MULS
        a = 3; b = 3; cin = 0; opcode = 4'b1000; #10;

        // Terminar la simulación
        #10 $finish;
    end

endmodule
