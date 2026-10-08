module top (
    input wire clk, input wire reset, input wire [1:0] sw, output wire [3:0] led
);
    wire test_signal, gate_active, measurement_done;
    wire [31:0] measured_count;
    wire [3:0] frequency_khz;

    test_signal_generator u_test_signal (.clk(clk), .reset(reset), .select(sw), .test_signal(test_signal));
    measurement_controller #(.GATE_COUNT(12_500_000)) u_controller (
        .clk(clk), .reset(reset), .gate_active(gate_active), .measurement_done(measurement_done));
    frequency_counter u_counter (
        .clk(clk), .reset(reset), .gate_active(gate_active), .measurement_done(measurement_done),
        .test_signal(test_signal), .measured_count(measured_count));
    result_register u_result (
        .clk(clk), .reset(reset), .measurement_done(measurement_done),
        .measured_count(measured_count), .frequency_khz(frequency_khz));
    led_display u_led (.frequency_khz(frequency_khz), .led(led));
endmodule
