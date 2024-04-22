`timescale 1ns / 1ps
module tb_add_with_carry_32bit();

    // Parámetros
    parameter CLK_PERIOD = 10; // Periodo de reloj en unidades de tiempo

    // Señales de entrada
    reg [31:0] a;
    reg [31:0] b;
    reg cin;

    // Señales de salida
    wire [31:0] sum;
    wire cout;

    // Instancia del módulo bajo prueba
    add_with_carry_32bit DUT (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Generar reloj
    reg clk = 0;
    always #((CLK_PERIOD/2)) clk = ~clk;

    // Estímulos
    initial begin
        $monitor("Time=%0t a=%h b=%h cin=%b sum=%h cout=%b", $time, a, b, cin, sum, cout);
        
        // initial
        a = 32'h00000000;
        b = 32'h00000000;
        cin = 1;
        #20; // Esperar 100 unidades de tiempo
		  
		  
		  // Test Case 1
        a = 32'h12345678;
        b = 32'h87654321;
        cin = 0;
        #40; // Esperar 100 unidades de tiempo

        // Test Case 2
        a = 32'hFFFFFFFF;
        b = 32'h00000001;
        cin = 1;
        #40; // Esperar 100 unidades de tiempo

        // Puedes agregar más casos de prueba aquí

        // Finalizar la simulación
        $finish;
    end

    // Conducir entradas con un reloj
    always @(posedge clk) begin
        // Aquí puedes generar los estímulos si prefieres controlar las entradas con un reloj
    end

endmodule
