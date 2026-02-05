// -------------------------------------------
// Single Stage Pipeline Register
// Valid/Ready Handshake
// Fully Synthesizable Design
// Handles Backpressure without Data Loss or Duplication
// -------------------------------------------

module pipeline_register #(
parameter DATA_WIDTH = 32
)(
input  logic                     clk,
input  logic                     rst_n,


// Input Interface
input  logic [DATA_WIDTH-1:0]   in_data,
input  logic                    in_valid,
output logic                    in_ready,

// Output Interface
output logic [DATA_WIDTH-1:0]   out_data,
output logic                    out_valid,
input  logic                    out_ready

);


// Internal pipeline storage
logic [DATA_WIDTH-1:0] data_reg;
logic                  valid_reg;

// -------------------------------------------
// Handshake Logic
// -------------------------------------------

// Ready when stage empty OR output consumed
assign in_ready  = ~valid_reg || out_ready;

// Output signals
assign out_valid = valid_reg;
assign out_data  = data_reg;

// -------------------------------------------
// Sequential Logic
// -------------------------------------------

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_reg  <= '0;
        valid_reg <= 1'b0;
    end
    else begin
        // Load new data into pipeline stage
        if (in_valid && in_ready) begin
            data_reg  <= in_data;
            valid_reg <= 1'b1;
        end
        // Clear stage when output accepts data
        else if (out_ready && valid_reg) begin
            valid_reg <= 1'b0;
        end
    end
end


endmodule
