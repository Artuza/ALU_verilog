`timescale 1ns / 1ps

module testbench_multiplier_32bit;
    reg [31:0] a, b;
    wire [63:0] product;

    // Instancia del módulo multiplier_32bit
    multiplier_32bit uut(
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        a = 32'h00000001;  // Caso mínimo
        b = 32'h00000001;
        #10;

        a = 32'hFFFFFFFF;  // Caso de prueba con el máximo valor
        b = 32'h00000001;
        #10;

        a = 32'h00000002;  // Prueba de desplazamiento
        b = 32'h00000003;
        #10;

        a = 32'h10000000;  // Prueba de números grandes
        b = 32'h10000000;
        #10;

        a = 32'hFFFFFFFF;  // Multiplicación que requiere todo el ancho de la salida
        b = 32'hFFFFFFFF;
        #10;

        // Prueba con a es 0
        a = 32'h00000000;
        b = 32'h12345678;
        #10;

        // Prueba con b es 0
        a = 32'h12345678;
        b = 32'h00000000;
        #10;

        // Finaliza la simulación
        $finish;
    end
endmodule
