# FPGA-Based Frequency Meter with On-Board Test Signal Generator

![Zybo Z7-10](https://img.shields.io/badge/FPGA-Zybo%20Z7--10-blue)
![Vivado](https://img.shields.io/badge/Vivado-2024.2-orange)
![Verilog](https://img.shields.io/badge/HDL-Verilog-green)

A self-contained FPGA-based frequency meter implemented in Verilog RTL on the Digilent Zybo Z7-10 using AMD/Xilinx Vivado 2024.2.

The FPGA internally generates selectable test frequencies, measures the signal during a fixed measurement window, and displays the measured frequency on the onboard LEDs.

---

## Project Demo

### Hardware Demonstration

▶️ **[Watch the FPGA Hardware Demo](demo/frequency_meter_demo_no_audio.mp4)**

The demonstration shows the frequency meter running on the Zybo Z7-10 board.

### Simulation Results

The design was simulated before programming the FPGA.

![Frequency Meter Simulation Results](docs/simulation_results.png)

The simulation verifies the four selectable frequencies:

| SW1 | SW0 | Frequency | LED Output |
|-----|-----|-----------|------------|
| 0 | 0 | 1 kHz | `0001` |
| 0 | 1 | 2 kHz | `0010` |
| 1 | 0 | 4 kHz | `0100` |
| 1 | 1 | 8 kHz | `1000` |

---

## System Architecture

```text
                 125 MHz Clock
                      |
                      v
          +-------------------------+
          | Test Signal Generator   |
          +-------------------------+
                      |
                      v
                Test Signal
                      |
                      v
          +-------------------------+
          | Frequency Counter       |
          +-------------------------+
                      |
                      v
              Measured Count
                      |
                      v
          +-------------------------+
          | Result Register         |
          +-------------------------+
                      |
                      v
          +-------------------------+
          | LED Display             |
          +-------------------------+
                      |
                      v
                 4 LEDs
