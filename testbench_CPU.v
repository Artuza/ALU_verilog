`timescale 1ns / 1ps

module testbench_CPU;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [31:0] alu_result;
    wire NegativeFlag;
    wire ZeroFlag;

    // Instantiate the CPU
    CPU uut (
        .clk(clk),
        .reset(reset),
        .alu_result(alu_result),
        .NegativeFlag(NegativeFlag),
        .ZeroFlag(ZeroFlag)
    );

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk; // Clock period of 20ns

    initial begin
        // Initialize Inputs
        reset = 1;
        #40;
        reset = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add additional time for observations
        #500;

        // Finish simulation
        $finish;
    end

    initial begin
        // Monitor output signals to observe changes
        $monitor("Time=%t, ALU Result=%h, NegativeFlag=%b, ZeroFlag=%b",
                 $time, alu_result, NegativeFlag, ZeroFlag);
    end

endmodule
