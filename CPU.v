module CPU(
    input clk,            // Reloj del sistema
    input reset,          // Señal de reinicio
    output [31:0] alu_result, // Para observar el resultado de la ALU
    output wire NegativeFlag,  // Bandera negativa de la ALU (cambiado a wire)
    output wire ZeroFlag       // Bandera de cero de la ALU (cambiado a wire)
);

    wire [31:0] pc_out;
    wire [31:0] instruction;
    wire [31:0] nextPC;
    wire [31:0] alu_operand_a;
    wire [31:0] alu_operand_b;
    wire [3:0] alu_op;
    wire enable_pc = 1;        // Habilitación siempre activa para simplificar
    wire alu_cout;
    wire mem_write = 0;        // No escribimos en memoria en este ejemplo
    wire mem_read = 1;         // Siempre leemos de memoria
    wire cin = 0;              // Carry in no utilizado en este ejemplo

    // Instancia del Program Counter
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .nextPC(nextPC),
        .enable(enable_pc),
        .pc(pc_out)
    );

    // Instancia de la Memoria de Programa
    ProgramMemory program_memory(
        .clk(clk),
        .address(pc_out),
        .write_data(32'b0), // Sin datos de escritura, sólo lectura
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(instruction)
    );

    // Decodificación de la instrucción y configuración de la ALU
    assign nextPC = pc_out + 4;  // Incremento simple de PC
    assign alu_operand_a = pc_out;              // Ejemplo: usar PC como operando
    assign alu_operand_b = instruction[15:0];   // Parte de la instrucción como operando
    assign alu_op = instruction[31:28];         // Código de operación desde instrucción

    // Instancia de la ALU
    alu alu_unit(
        .a(alu_operand_a),
        .b(alu_operand_b),
        .cin(cin),
        .opcode(alu_op),
        .result(alu_result),
        .cout(alu_cout),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

endmodule
