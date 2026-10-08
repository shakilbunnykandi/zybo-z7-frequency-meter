# FPGA-Based Frequency Meter with On-Board Test Signal Generator

![Zybo Z7-10](https://img.shields.io/badge/FPGA-Zybo%20Z7--10-blue)
![Vivado](https://img.shields.io/badge/Vivado-2024.2-orange)
![Verilog](https://img.shields.io/badge/HDL-Verilog-green)
![Status](https://img.shields.io/badge/Status-Hardware%20Verified-success)

A self-contained **FPGA-based frequency meter** implemented using **Verilog RTL** on the **Digilent Zybo Z7-10** and developed using **AMD/Xilinx Vivado 2024.2**.

The FPGA internally generates selectable test signals, measures their frequency over a fixed measurement window, and displays the measured frequency using the onboard LEDs.

No external signal generator is required.

---

## 🚀 Project Demo

### 🎥 Hardware Demonstration

▶️ **[Watch the FPGA Hardware Demo](demo/frequency_meter_demo_no_audio.mp4)**

The demonstration shows the frequency meter running directly on the **Zybo Z7-10 FPGA board**.

### 📊 Simulation Results

The design was simulated before programming the FPGA.

![Frequency Meter Simulation Results](docs/simulation_results.png)

The simulation verifies the four selectable test frequencies:

| SW1 | SW0 | Selected Frequency | LED Output |
|:---:|:---:|:------------------:|:----------:|
| 0 | 0 | 1 kHz | `0001` |
| 0 | 1 | 2 kHz | `0010` |
| 1 | 0 | 4 kHz | `0100` |
| 1 | 1 | 8 kHz | `1000` |

---

# 📌 Project Overview

The objective of this project is to design a digital frequency measurement system completely inside an FPGA.

The system consists of:

1. An internal test signal generator
2. A measurement controller
3. A frequency counter
4. A result register
5. An LED display interface

The internally generated signal is measured during a fixed time interval. The number of detected rising edges is used to determine the frequency.

### Basic concept

```text
             125 MHz FPGA Clock
                     |
                     v
        +-------------------------+
        | Test Signal Generator   |
        |                         |
        | 1 kHz / 2 kHz / 4 kHz   |
        | / 8 kHz                 |
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
             Rising Edge Count
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
              Zybo Z7-10 LEDs
