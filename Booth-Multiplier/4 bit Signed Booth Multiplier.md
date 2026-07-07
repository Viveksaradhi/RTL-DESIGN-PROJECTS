# 4-bit Signed Booth Multiplier using Verilog HDL

## Overview

This project implements a **4-bit signed Booth Multiplier** using **Verilog HDL**. Booth's multiplication algorithm is an efficient technique for signed binary multiplication that reduces the number of addition and subtraction operations required.

The design uses a **Finite State Machine (FSM)** to control the multiplication process, performing conditional addition/subtraction followed by arithmetic right shifts until the multiplication is complete.

---

## Features

- 4-bit Signed Multiplication
- Booth's Multiplication Algorithm
- FSM-Based Control Unit
- Signed Addition and Subtraction
- Arithmetic Right Shift
- Verilog HDL Implementation
- Simulation using Testbench

---

## Project Structure

```
Booth-Multiplier-Verilog
│
├── RTL
│   └── booth_multiplier.v
│
├── Testbench
│   └── booth_multiplier_tb.v
│
├── Simulation
│   └── waveform.png
│
├── Image
│   ├── datapath.png
│   └── fsm.png
│
└── README.md
```

---

## Algorithm

The controller examines the least significant bit of the multiplier (`Q0`) and the previous bit (`Q-1`) to determine the required arithmetic operation.

| Q0 | Q-1 | Operation |
|:--:|:---:|-----------|
| 0 | 0 | No Operation |
| 1 | 1 | No Operation |
| 0 | 1 | Add Multiplicand |
| 1 | 0 | Subtract Multiplicand |

After the selected operation, the combined register is arithmetic right shifted. This process repeats for four iterations to generate the final product.

---

## Functional Description

### Inputs

- `clk` : System Clock
- `reset` : Asynchronous Reset
- `M` : 4-bit Signed Multiplicand
- `Q` : 4-bit Signed Multiplier

### Output

- `y` : 8-bit Signed Product

---

## FSM Operation

The controller consists of the following states:

- **S0** : Initialize Registers
- **S1** : Check Booth Condition
- **S2** : Arithmetic Right Shift
- **S3** : Add Multiplicand
- **S4** : Subtract Multiplicand
- **S5** : Decrement Counter
- **S6** : Output Final Product

---

## Verification

The design was verified using a Verilog testbench.

Simulation verifies:

- Positive × Positive Multiplication
- Positive × Negative Multiplication
- Negative × Positive Multiplication
- Negative × Negative Multiplication
- Correct FSM Operation

---

## Simulation Result

(Add waveform screenshot here.)

Example:

```
M = 0001 (+1)
Q = 1001 (-7)

Product = 11111001 (-7)
```

---

## Applications

- Digital Signal Processing (DSP)
- Arithmetic Logic Units (ALUs)
- Embedded Processors
- Computer Architecture
- ASIC Design
- FPGA-Based Arithmetic Units

---

## Tools Used

- Verilog HDL
- ModelSim
- Xilinx Vivado

---

## Future Improvements

- Parameterizable Data Width
- Signed/Unsigned Mode Selection
- Pipelined Booth Multiplier
- Radix-4 Booth Multiplier
- Self-Checking Testbench

---

## Author

**Vivek Saradhi Vidiyala**

B.Tech – Electronics and Communication Engineering

Rajiv Gandhi University of Knowledge Technologies (RGUKT), Basar

GitHub: https://github.com/Viveksaradhi
