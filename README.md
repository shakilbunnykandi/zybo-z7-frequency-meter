# FPGA-Based Frequency Meter with On-Board Test Signal Generator

![Zybo Z7-10](https://img.shields.io/badge/FPGA-Zybo%20Z7--10-blue)
![Vivado](https://img.shields.io/badge/Vivado-2024.2-orange)
![Verilog](https://img.shields.io/badge/HDL-Verilog-green)
![Simulation](https://img.shields.io/badge/Simulation-Verified-success)
![Hardware](https://img.shields.io/badge/Hardware-Tested-success)

A self-contained **FPGA-based digital frequency meter** implemented using **Verilog RTL** on the **Digilent Zybo Z7-10** and developed using **AMD/Xilinx Vivado 2024.2**.

The system internally generates selectable test signals, measures their frequency using rising-edge counting over a fixed measurement window, and displays the measured frequency using the onboard LEDs.

The complete project was simulated, synthesized, implemented, converted into a bitstream, programmed onto the Zybo Z7-10, and verified on physical hardware.

---

# 📌 Project Overview

The objective of this project is to design and implement a digital frequency measurement system completely inside an FPGA.

The FPGA performs the complete measurement process:

```text
125 MHz Clock
      |
      v
Test Signal Generation
      |
      v
Rising Edge Detection
      |
      v
Frequency Counting
      |
      v
Fixed Measurement Window
      |
      v
Frequency Calculation
      |
      v
LED Display
