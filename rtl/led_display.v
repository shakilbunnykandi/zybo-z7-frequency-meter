module led_display (
    input wire [3:0] frequency_khz, output wire [3:0] led
);
    assign led = frequency_khz;
endmodule
