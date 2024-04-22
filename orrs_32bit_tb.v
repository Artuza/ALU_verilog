`timescale 1ns / 1ps

module orrs_32bit_tb;

    // Entradas
    reg [31:0] a;
    reg [31:0] b;

    // Salidas
    wire [31:0] y;

    // Instancia del módulo orrs_32bit a probar
    orrs_32bit uut (
        .a(a), 
        .b(b), 
        .y(y)
    );

    // Proceso para aplicar estímulos
    initial begin
        // Inicializar entradas
        a = 32'h00000000;
        b = 32'h00000000;

        // Mostrar valores de las entradas y salidas en la consola
        $monitor("Time=%t | a=%h, b=%h -> y=%h", $time, a, b, y);

        // Probar diferentes combinaciones de entradas
        #10 a = 32'h00000000; b = 32'hFFFFFFFF;  // Expect y=FFFFFFFF
        #10 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;  // Expect y=FFFFFFFF
        #10 a = 32'hA5A5A5A5; b = 32'h5A5A5A5A;  // Expect y=FFFFFFFF
        #10 a = 32'hFF00FF00; b = 32'h00FF00FF;  // Expect y=FFFFFFFF

        // Esperar un poco antes de finalizar la simulación
        #10;
        $finish;
    end

endmodule
