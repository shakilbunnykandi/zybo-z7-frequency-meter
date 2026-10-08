`timescale 1ns / 1ps
module tb_frequency_meter;
    reg clk; reg reset; reg [1:0] sw; wire [3:0] led;
    top uut (.clk(clk), .reset(reset), .sw(sw), .led(led));
    initial begin clk = 1'b0; forever #4 clk = ~clk; end
    initial begin
        sw=2'b00; reset=1'b1; #100; reset=1'b0; #10_000_000;
        sw=2'b01; reset=1'b1; #100; reset=1'b0; #10_000_000;
        sw=2'b10; reset=1'b1; #100; reset=1'b0; #10_000_000;
        sw=2'b11; reset=1'b1; #100; reset=1'b0; #10_000_000;
        $finish;
    end
endmodule
