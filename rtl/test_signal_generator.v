module test_signal_generator (
    input wire clk, input wire reset, input wire [1:0] select, output reg test_signal
);
    reg [31:0] counter;
    reg [31:0] half_period;
    always @(*) begin
        case (select)
            2'b00: half_period = 62500;
            2'b01: half_period = 31250;
            2'b10: half_period = 15625;
            2'b11: half_period = 7812;
            default: half_period = 62500;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin counter <= 0; test_signal <= 1'b0; end
        else if (counter >= half_period - 1) begin
            counter <= 0; test_signal <= ~test_signal;
        end else counter <= counter + 1;
    end
endmodule
