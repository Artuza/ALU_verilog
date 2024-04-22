module CPU(
    input clk,
    input reset,
    output wire [31:0] alu_result,
    output wire NegativeFlag,
    output wire ZeroFlag
);

    // Señales de control y datos internos
    wire [31:0] pc_out, instruction, nextPC;
    wire [31:0] alu_operand_a, alu_operand_b;
    wire [3:0] alu_op;
    wire [4:0] rs, rt, rd;
    wire [15:0] immediate;
    wire [25:0] jumpAddress;
    wire regWrite;
    wire [31:0] writeData, readData1, readData2;
    wire alu_cout;
    wire enable_pc = 1;

    // Instancia del Contador de Programa (Program Counter)
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
        .address(pc_out[7:0]),  // Asegurarse que la dirección es la correcta según el diseño de memoria
        .write_data(32'b0),
        .mem_write(1'b0),  // Memoria de programa generalmente solo se lee
        .mem_read(1'b1),
        .read_data(instruction)
    );

    // Instancia del Decodificador de Instrucciones
    InstructionDecoder decoder(
        .instruction(instruction),
        .opcode(alu_op),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .immediate(immediate),
        .jumpAddress(jumpAddress)
    );

    // Instancia del Banco de Registros
    RegisterFile regFile(
        .clk(clk),
        .reset(reset),
        .regWrite(regWrite),
        .readReg1(rs),
        .readReg2(rt),
        .writeReg(rd),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2)
    );

    // Lógica para determinar la siguiente dirección del PC
    assign nextPC = pc_out + 4;  // Incremento simple del PC

    // Lógica para seleccionar operandos y configurar la ALU
    assign alu_operand_a = readData1;
    assign alu_operand_b = readData2;  // Uso de datos directamente desde el banco de registros

    // Instancia de la ALU
    alu alu_unit(
        .a(alu_operand_a),
        .b(alu_operand_b),
        .cin(1'b0),
        .opcode(alu_op),
        .result(alu_result),
        .cout(alu_cout),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

    // Lógica para la escritura en registros
    assign writeData = alu_result;  // Por ejemplo, escribir el resultado de la ALU
    assign regWrite = (alu_op != 4'b1111);  // No escribir en caso de instrucción de salto, por ejemplo

endmodule
