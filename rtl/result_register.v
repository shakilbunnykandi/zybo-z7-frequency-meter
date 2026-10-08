module result_register (
    input wire clk, input wire reset, input wire measurement_done,
    input wire [31:0] measured_count, output reg [3:0] frequency_khz
);
    reg measurement_done_d;
    always @(posedge clk) begin
        if (reset) begin measurement_done_d <= 1'b0; frequency_khz <= 4'd0; end
        else begin
            measurement_done_d <= measurement_done;
            if (measurement_done_d) begin
                if (measured_count < 32'd50) frequency_khz <= 4'd0;
                else if (measured_count < 32'd150) frequency_khz <= 4'd1;
                else if (measured_count < 32'd250) frequency_khz <= 4'd2;
                else if (measured_count < 32'd350) frequency_khz <= 4'd3;
                else if (measured_count < 32'd450) frequency_khz <= 4'd4;
                else if (measured_count < 32'd550) frequency_khz <= 4'd5;
                else if (measured_count < 32'd650) frequency_khz <= 4'd6;
                else if (measured_count < 32'd750) frequency_khz <= 4'd7;
                else if (measured_count < 32'd850) frequency_khz <= 4'd8;
                else frequency_khz <= 4'd0;
            end
        end
    end
endmodule
