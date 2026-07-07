# Parameterized Dual-Port RAM using Verilog HDL

## Overview

This project implements a **parameterized Dual-Port RAM** using **Verilog HDL**. The memory supports two independent ports (Port A and Port B), allowing simultaneous read and write operations using separate clocks.

The design is configurable through parameters for data width, address width, and memory depth, making it reusable for different memory configurations.

---

## Features

- Parameterized Memory Design
- Independent Port A and Port B
- Dual Clock Operation
- Simultaneous Read and Write Support
- Synchronous Read
- Synchronous Write
- Verilog HDL Implementation

---

## Project Structure

```
Dual-Port-RAM
│
├── RTL
│   └── ram16_8.v
│
├── Testbench
│   └── ram16_8_tb.v
│
├── Simulation
│   ├── write_read_portA.png
│   ├── write_read_portB.png
│   ├── simultaneous_access.png
│   └── address_conflict.png
│
└── README.md
```

---

## Memory Configuration

| Parameter | Value |
|-----------|------:|
| Data Width | 8 bits |
| Address Width | 4 bits |
| Memory Depth | 16 Locations |
| Number of Ports | 2 |

---

## Architecture

```
                 +----------------------+
                 |    Dual-Port RAM     |
                 |                      |
Port A --------->|                      |
                 |      Memory Array    |
Port B --------->|                      |
                 +----------------------+
```

Each port has independent:

- Clock
- Address
- Data Input
- Data Output
- Write Enable
- Read Enable

---

## Port Description

### Port A

- Independent Clock
- Read Enable
- Write Enable
- 8-bit Data Input
- 8-bit Data Output

### Port B

- Independent Clock
- Read Enable
- Write Enable
- 8-bit Data Input
- 8-bit Data Output

---

## Testbench

The testbench verifies the following scenarios:

- Reset Operation
- Write using Port A
- Read using Port A
- Write using Port B
- Read using Port B
- Simultaneous Access
- Same Address Write Conflict

---

## Simulation Results

(Add waveform screenshots here.)

Example simulations:

- Port A Write/Read
- Port B Write/Read
- Simultaneous Access
- Address Conflict

---

## Applications

- FPGA Memory Blocks
- Register Files
- Packet Buffers
- Data Buffers
- Embedded Systems
- ASIC Memory Blocks

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- ModelSim

---

## Future Improvements

- Byte Enable Support
- Read-First / Write-First Modes
- True Dual-Port RAM
- Collision Detection Logic
- Asynchronous Read Option

---

## Author

**Vivek Saradhi Vidiyala**

B.Tech – Electronics and Communication Engineering

Rajiv Gandhi University of Knowledge Technologies (RGUKT), Basar
