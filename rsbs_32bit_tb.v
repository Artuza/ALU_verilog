`timescale 1ns / 1ps

module rsbs_32bit_tb;

    // Entradas
    reg [31:0] a;
    reg [31:0] b;

    // Salidas
    wire [31:0] result;

    // Instancia del módulo a probar
    rsbs_32bit uut (
        .a(a), 
        .b(b), 
        .result(result)
    );

    // Proceso para aplicar estímulos
    initial begin
        // Inicializar entradas
        a = 0;
        b = 0;

        // Mostrar valores de las entradas y salidas en la consola
        $monitor("Time=%t | a=%h, b=%h -> result=%h", $time, a, b, result);

        // Probar diferentes combinaciones de entradas
        #10 a = 32'h00000005; b = 32'h00000003;  // 3 - 5 = -2
        #10 a = 32'h00000001; b = 32'h00000001;  // 1 - 1 = 0
        #10 a = 32'hFFFFFFFF; b = 32'h00000001;  // 1 - (-1) = 2
        #10 a = 32'h7FFFFFFF; b = 32'h80000001;  // -2147483647 - 2147483647 = 2

        // Esperar un poco antes de finalizar la simulación
        #10;
        $finish;
    end

endmodule
