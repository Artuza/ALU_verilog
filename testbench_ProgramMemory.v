`timescale 1ns / 1ps

module testbench_ProgramMemory;

    // Inputs
    reg clk;
    reg [31:0] address;
    reg [31:0] write_data;
    reg mem_write;
    reg mem_read;

    // Output
    wire [31:0] read_data;

    // Instantiate the Unit Under Test (UUT)
    ProgramMemory uut (
        .clk(clk),
        .address(address),
        .write_data(write_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .read_data(read_data)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize Inputs
        address = 0;
        write_data = 0;
        mem_write = 0;
        mem_read = 0;

        // Wait for global reset to finish
        #100;

        // Add stimulus here
        // Test case 1: Write and then read from address 0
        address = 32'h4;       // Address aligned to word boundary
        write_data = 32'h12345678;
        mem_write = 1;         // Enable write
        #10;
        mem_write = 0;         // Disable write
        #10;
        mem_read = 1;          // Enable read
        #10;
        mem_read = 0;          // Disable read
        #10;

        // Test case 2: Write and read from another address
        address = 32'h8;       // Next word boundary
        write_data = 32'h87654321;
        mem_write = 1;
        #10;
        mem_write = 0;
        #10;
        mem_read = 1;
        #10;
        mem_read = 0;
        #10;

        // Test case 3: Check if memory holds the value without read or write
        #50;
        address = 32'h4;       // Re-read from first address
        mem_read = 1;
        #10;
        mem_read = 0;
        #10;

        // End simulation
        $finish;
    end

    initial begin
        $monitor("At time %t, address = %h, write_data = %h, read_data = %h, mem_write = %b, mem_read = %b",
                 $time, address, write_data, read_data, mem_write, mem_read);
    end
endmodule
