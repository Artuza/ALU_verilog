`timescale 1ns / 1ps

module testbench_subtractor_32bit;
    reg [31:0] a, b;
    reg bin;
    wire [31:0] diff;
    wire bout;

    // Instancia del módulo subtractor_32bit
    subtractor_32bit uut(
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    initial begin
        // Initialize Inputs
        a = 0;
        b = 0;
        bin = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        // Add stimulus here
        a = 32'h55555555;
        b = 32'h12345678;
        bin = 0;
        #20;  // Espera 20ns para observar la salida

        a = 32'hFFFFFFFF;
        b = 32'h00000001;
        bin = 0;
        #20;  // Espera 20ns para observar la salida

        a = 32'h80000000;
        b = 32'h1;
        bin = 0;
        #20;  // Espera 20ns para observar la salida

        a = 32'h0;
        b = 32'h0;
        bin = 1;
        #20;  // Espera 20ns para observar la salida

        // Observar el comportamiento cuando b > a
        a = 32'h12345678;
        b = 32'h87654321;
        bin = 0;
        #20;  // Espera 20ns para observar la salida

        $finish;
    end
endmodule
