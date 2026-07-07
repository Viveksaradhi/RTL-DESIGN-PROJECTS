# UART Transmitter & Receiver (Echo System) on FPGA

## Overview

This project implements a complete UART communication system using **Verilog HDL**. The design includes a UART Transmitter, UART Receiver, and an Echo Controller integrated on an FPGA.

The FPGA receives serial data from a PC through UART, processes the received byte, and transmits the same byte back to the PC. The functionality was verified through simulation and validated on FPGA hardware using a serial terminal.

---

## Features

- UART Transmitter
- UART Receiver
- Echo Controller
- Baud Rate Generator
- 8-bit UART Communication
- Start and Stop Bit Detection
- FPGA Implementation using Xilinx Vivado
- Verilog HDL Design

---

## Project Structure

```
UART-Transmitter-Receiver-Echo-System-FPGA
│
├── UART_Transmitter
│   ├── uart_tx.v
│   ├── baudrate_tx.v
│   └── uart_tx_tb.v
│
├── UART_Receiver
│   ├── uart_receiver.v
│   ├── baudrate_rx.v
│   └── uart_receiver_tb.v
│
├── Echo_System
│   └── echo_controller.v
│
├── Images
│   ├── tx_waveform.png
│   ├── rx_waveform.png
│   ├── echo_waveform.png
│   └── fpga_demo.jpg
│
└── README.md
```

---

## Block Diagram

```
           PC (Serial Terminal)
                   │
                   │ UART RX
                   ▼
          +------------------+
          |  UART Receiver   |
          +------------------+
                   │
              Received Byte
                   │
                   ▼
          +------------------+
          | Echo Controller  |
          +------------------+
                   │
             Transmit Byte
                   ▼
          +------------------+
          | UART Transmitter |
          +------------------+
                   │
                   │ UART TX
                   ▼
           PC (Serial Terminal)
```

---

## Module Description

### UART Transmitter

- FSM-based UART transmitter
- Supports 8-bit data transmission
- Generates Start Bit and Stop Bit
- Uses baud rate generator for timing

### UART Receiver

- FSM-based UART receiver
- Detects Start Bit
- Samples incoming serial data
- Reconstructs 8-bit received data
- Generates Ready signal after successful reception

### Echo Controller

- Interfaces UART Receiver and UART Transmitter
- Waits for received data
- Sends the received byte back through the transmitter
- Demonstrates UART loopback (echo) functionality

---

## Verification

The design was verified using Verilog testbenches.

Simulation verified:

- UART transmission
- UART reception
- Echo functionality
- Correct baud timing

---

## FPGA Hardware Validation

The design was implemented on an FPGA using **Xilinx Vivado**.

Hardware testing was performed using a serial terminal.

Example:

```
PC Terminal

Input :
Hello FPGA

Output :
Hello FPGA
```

The FPGA successfully echoed every received character back to the PC.

---

## Tools Used

- Verilog HDL
- Xilinx Vivado
- ModelSim
- FPGA Development Board

---

## Future Improvements

- Configurable Baud Rate
- Even/Odd Parity Support
- Multiple Stop Bits
- FIFO-based UART
- Interrupt Support
- APB/AXI UART Peripheral

---

## Author

**Vivek Saradhi Vidiyala**

B.Tech – Electronics and Communication Engineering

Rajiv Gandhi University of Knowledge Technologies (RGUKT), Basar

    
