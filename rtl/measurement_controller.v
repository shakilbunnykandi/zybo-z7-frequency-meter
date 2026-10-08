module measurement_controller #(
    parameter integer GATE_COUNT = 12_500_000
)(
    input wire clk, input wire reset, output reg gate_active, output reg measurement_done
);
    reg [31:0] counter;
    always @(posedge clk) begin
        if (reset) begin
            counter <= 32'd0; gate_active <= 1'b1; measurement_done <= 1'b0;
        end else begin
            measurement_done <= 1'b0;
            if (counter == GATE_COUNT - 1) begin
                counter <= 32'd0; gate_active <= 1'b0; measurement_done <= 1'b1;
            end else begin
                counter <= counter + 1; gate_active <= 1'b1;
            end
        end
    end
endmodule
