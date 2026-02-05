`timescale 1ns/1ps

module pipeline_register_tb;

parameter DATA_WIDTH = 32;

logic clk;
logic rst_n;

logic [DATA_WIDTH-1:0] in_data;
logic in_valid;
logic in_ready;

logic [DATA_WIDTH-1:0] out_data;
logic out_valid;
logic out_ready;

// DUT Instance
pipeline_register #(
    .DATA_WIDTH(DATA_WIDTH)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .in_data(in_data),
    .in_valid(in_valid),
    .in_ready(in_ready),
    .out_data(out_data),
    .out_valid(out_valid),
    .out_ready(out_ready)
);

// Clock generation
always #5 clk = ~clk;

// Test sequence
initial begin
    clk = 0;
    rst_n = 0;
    in_data = 0;
    in_valid = 0;
    out_ready = 0;

    // Reset
    #20;
    rst_n = 1;

    // Send first data
    #10;
    in_data = 32'hA5A5A5A5;
    in_valid = 1;
    out_ready = 1;

    #10;
    in_valid = 0;

    // Backpressure case
    #20;
    in_data = 32'h12345678;
    in_valid = 1;
    out_ready = 0;   // Stall output

    #30;
    out_ready = 1;   // Release stall
    in_valid = 0;

    #50;
    $finish;
end

endmodule
