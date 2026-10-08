module frequency_counter (
    input wire clk, input wire reset, input wire gate_active, input wire measurement_done,
    input wire test_signal, output reg [31:0] measured_count
);
    reg [31:0] count;
    reg test_signal_d;
    always @(posedge clk) begin
        if (reset) begin
            count <= 32'd0; measured_count <= 32'd0; test_signal_d <= 1'b0;
        end else begin
            test_signal_d <= test_signal;
            if (gate_active && test_signal && !test_signal_d) count <= count + 1;
            if (measurement_done) begin measured_count <= count; count <= 32'd0; end
        end
    end
endmodule
