module ProgramCounter(
    input clk,            
    input reset,          
    input [31:0] nextPC,  
    input enable,         
    input jump,           // Señal para realizar un salto
    input [31:0] jumpAddr, // Dirección de salto
    output reg [31:0] pc  
);

    // Inicialización y actualización del PC
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 32'b0; // Valor inicial del PC tras reset
        end else if (enable) begin
            if (jump) begin
                pc <= jumpAddr;  // Si hay salto, PC toma la dirección de salto
            end else begin
                pc <= nextPC;    // Actualiza el PC normalmente si no hay salto
            end
        end
    end

endmodule