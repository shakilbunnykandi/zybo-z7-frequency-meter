# FPGA-Based Frequency Meter with On-Board Test Signal Generator

A self-contained FPGA frequency meter implemented in Verilog RTL on the Digilent Zybo Z7-10 using AMD/Xilinx Vivado 2024.2.

The FPGA generates selectable test frequencies internally, measures the signal by counting rising edges during a fixed 100 ms measurement window, and displays the detected frequency on the onboard LEDs.

## Features
- Pure Verilog RTL implementation
- Digilent Zybo Z7-10
- 125 MHz system clock
- Internal test signal generation
- Rising-edge frequency measurement
- 100 ms measurement window
- LED-based frequency display
- Vivado XSim simulation
- FPGA synthesis and implementation
- Timing closure
- JTAG programming and physical hardware verification
- No Vitis or embedded C required
- No external signal generator required

## Frequency Selection
| SW1 | SW0 | Test Frequency | LED Output |
|---:|---:|---:|:---:|
| 0 | 0 | ~1 kHz | `0001` |
| 0 | 1 | ~2 kHz | `0010` |
| 1 | 0 | ~4 kHz | `0100` |
| 1 | 1 | ~8 kHz | `1000` |

## Architecture
```text
125 MHz Clock
      |
      v
+--------------------------+
| Test Signal Generator    |
| ~1 / 2 / 4 / 8 kHz       |
+------------+-------------+
             |
             v
+--------------------------+
| Frequency Counter         |
| Rising-edge detection    |
+------------+-------------+
             |
             v
+--------------------------+
| Measurement Controller   |
| 100 ms measurement gate  |
+------------+-------------+
             |
             v
+--------------------------+
| Result Register          |
| Frequency classification |
+------------+-------------+
             |
             v
+--------------------------+
| LED Display              |
+--------------------------+
```

## How It Works

The Zybo Z7-10 provides a 125 MHz clock. The `test_signal_generator` divides this clock to create selectable test signals.

During a 100 ms measurement window, `frequency_counter` detects rising edges and counts them. Approximately 100, 200, 400, and 800 rising edges correspond to 1, 2, 4, and 8 kHz respectively.

The `result_register` maps the measured count to the corresponding frequency and `led_display` presents the result on the four onboard LEDs.

## RTL Modules
- `top.v` — top-level integration
- `test_signal_generator.v` — selectable internal test-frequency generator
- `measurement_controller.v` — 100 ms measurement timing
- `frequency_counter.v` — rising-edge counter
- `result_register.v` — count-to-frequency classification
- `led_display.v` — LED output mapping

## Simulation

The project includes a Vivado XSim testbench in `simulation/tb_frequency_meter.v` and verifies all four frequency selections.

## Timing Results

An initial implementation showed a timing violation caused by hardware division in the frequency conversion logic. The division was replaced with comparison-based classification logic.

Final implementation results:
- **WNS:** +2.478 ns
- **TNS:** 0 ns
- **WHS:** +0.162 ns
- **Failed Routes:** 0

The design achieved timing closure for the 125 MHz system clock.

## Hardware Verification

The final bitstream was programmed onto a physical Zybo Z7-10 through Vivado Hardware Manager and verified using the onboard switches and LEDs.

```text
SW1 SW0    LEDs
 0   0     0001  -> ~1 kHz
 0   1     0010  -> ~2 kHz
 1   0     0100  -> ~4 kHz
 1   1     1000  -> ~8 kHz
```

## Hardware and Tools
- Digilent Zybo Z7-10
- USB programming cable
- AMD/Xilinx Vivado 2024.2
- Verilog HDL
- Vivado XSim
- JTAG Hardware Manager

## Learning Outcomes
- RTL design
- Sequential logic and counters
- Clock division
- Rising-edge detection
- Frequency measurement
- FPGA constraints
- Synthesis and implementation
- Timing analysis and timing closure
- Bitstream generation
- JTAG programming
- Physical hardware verification

## Future Improvements
- External frequency input through PMOD
- Seven-segment display output
- UART frequency reporting
- Wider measurement range
- Averaging/filtering
- Synchronization for asynchronous external signals
