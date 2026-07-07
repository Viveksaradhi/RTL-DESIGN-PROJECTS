# Ping-Pong Buffer Controller using Verilog HDL

## Overview

This project implements a **Ping-Pong (Dual Buffer) Controller** using **Verilog HDL**. The controller enables continuous data transfer between a producer and a consumer by utilizing two independent memory buffers (Ping and Pong).

While one buffer is being written by the producer, the other can be simultaneously read by the consumer. The controller automatically switches between the buffers and detects error conditions such as **overrun** and **underrun**.

---

## Features

- Dual Buffer (Ping-Pong) Architecture
- Producer-Consumer Interface
- Automatic Buffer Switching
- Independent Read and Write Pointers
- Full and Empty Flag Generation
- Overrun Detection
- Underrun Detection
- Continuous Data Transfer
- Verilog HDL Implementation

---

## Project Structure

```
Ping-Pong-Buffer-Controller
│
├── RTL
│   └── ping_pong_controller.v
│
├── Testbench
│   └── ping_pong_controller_tb.v
│
├── Simulation
│   ├── normal_operation.png
│   ├── buffer_switching.png
│   ├── overrun.png
│   ├── underrun.png
│   └── simultaneous_read_write.png
│
├── Images
│   └── block_diagram.png
│
└── README.md
```

---

## Block Diagram

```
                 Producer
                    │
          prod_valid, prod_data
                    │
                    ▼
        +-------------------------+
        | Ping-Pong Controller    |
        |                         |
        |  Ping Buffer (4 x 8)    |
        |  Pong Buffer (4 x 8)    |
        |                         |
        | Buffer Switch Logic     |
        | Status Flag Generator   |
        | Overrun Detection       |
        | Underrun Detection      |
        +-------------------------+
                    │
         cons_valid, cons_data
                    ▼
                 Consumer
```

---

## Module Description

### Producer Interface

- Accepts 8-bit input data from the producer.
- Writes incoming data into the active buffer.
- Generates `prod_ready` to indicate write availability.

### Consumer Interface

- Reads data from the completed buffer.
- Generates `cons_valid` when valid data is available.
- Outputs data through `cons_data`.

### Buffer Management

- Two independent 4-byte buffers.
- Automatic switching between Ping and Pong buffers.
- Independent read and write pointers.
- Full and Empty status tracking.

### Error Detection

**Overrun**

Occurs when the producer attempts to write while both buffers are occupied.

**Underrun**

Occurs when the consumer attempts to read while no completed buffer is available.

---

## Testbench

The testbench verifies the following scenarios:

- Normal Producer-Consumer Operation
- Buffer Switching
- Continuous Read Operation
- Overrun Condition
- Underrun Condition
- Simultaneous Read and Write Operation

---

## Simulation Results

(Add waveform screenshots here.)

Example waveforms:

- Normal Operation
- Buffer Switching
- Overrun Detection
- Underrun Detection
- Simultaneous Read and Write

---

## Applications

- DMA Controllers
- Streaming Data Systems
- FPGA Data Acquisition
- Video Processing
- Audio Streaming
- Producer-Consumer Systems
- Embedded Systems

---

## Tools Used

- Verilog HDL
- ModelSim
- Xilinx Vivado

---

## Future Improvements

- Parameterizable Buffer Depth
- Configurable Data Width
- FIFO-Based Ping-Pong Buffers
- AXI-Stream Interface
- APB Configuration Interface
- Interrupt Generation
- Performance Counters

---

## Author

**Vivek Saradhi Vidiyala**

B.Tech – Electronics and Communication Engineering

Rajiv Gandhi University of Knowledge Technologies (RGUKT), Basar

GitHub: https://github.com/Viveksaradhi
