## 🏗️ System Architecture

The FPGA-based frequency meter follows a modular RTL architecture consisting of five major blocks:

- **Test Signal Generator** – Generates selectable test frequencies of 1 kHz, 2 kHz, 4 kHz, and approximately 8 kHz.
- **Measurement Controller** – Creates a fixed 100 ms measurement window.
- **Frequency Counter** – Detects rising edges of the test signal and counts them during the measurement window.
- **Result Register** – Converts the measured edge count into frequency in kHz.
- **LED Display** – Displays the measured frequency using the four onboard LEDs.

### Architecture Diagram

```text
                    ┌─────────────────────┐
                    │     Zybo Z7-10      │
                    │   125 MHz Clock     │
                    └──────────┬──────────┘
                               │
              ┌────────────────┴────────────────┐
              │                                 │
              ▼                                 ▼
    ┌────────────────────┐           ┌────────────────────┐
    │ Test Signal        │           │ Measurement        │
    │ Generator          │           │ Controller         │
    │                    │           │                    │
    │ SW1/SW0            │           │ 100 ms Gate        │
    │                    │           │                    │
    │ 1 kHz               │           │ gate_active        │
    │ 2 kHz               │           │ measurement_done   │
    │ 4 kHz               │           └─────────┬──────────┘
    │ ~8 kHz              │                     │
    └─────────┬──────────┘                     │
              │                                │
              │ test_signal                    │
              └──────────────┬─────────────────┘
                             ▼
                  ┌─────────────────────┐
                  │  Frequency Counter  │
                  │                     │
                  │ Rising Edge         │
                  │ Detection & Count   │
                  └──────────┬──────────┘
                             │
                             │ measured_count
                             ▼
                  ┌─────────────────────┐
                  │   Result Register   │
                  │                     │
                  │ Count → Frequency   │
                  │      → kHz          │
                  └──────────┬──────────┘
                             │
                             │ frequency_khz
                             ▼
                  ┌─────────────────────┐
                  │     LED Display     │
                  └──────────┬──────────┘
                             │
                             ▼
                       Zybo LEDs
```

### Measurement Flow

The system operates using the following sequence:

```text
Switch Selection
       ↓
Generate Test Frequency
       ↓
Open 100 ms Measurement Window
       ↓
Detect Rising Edges
       ↓
Count Signal Cycles
       ↓
Convert Count to Frequency
       ↓
Display Result on LEDs
```

### Frequency Selection

| SW1 | SW0 | Generated Frequency | LED Output |
|:---:|:---:|:-------------------:|:----------:|
| 0 | 0 | 1 kHz | `0001` |
| 0 | 1 | 2 kHz | `0010` |
| 1 | 0 | 4 kHz | `0100` |
| 1 | 1 | ~8 kHz | `1000` |

### RTL Module Structure

| Module | Function |
|---|---|
| `top.v` | Connects all RTL modules |
| `test_signal_generator.v` | Generates selectable test frequencies |
| `measurement_controller.v` | Controls the 100 ms measurement window |
| `frequency_counter.v` | Detects rising edges and counts frequency |
| `result_register.v` | Converts the measured count into kHz |
| `led_display.v` | Drives the onboard LEDs |

### Design Principle

The complete system follows a simple:

**Generate → Measure → Process → Display**

architecture.

The test signal is generated internally, measured using a fixed time window, converted into a frequency value, and finally displayed on the Zybo Z7-10 LEDs.
