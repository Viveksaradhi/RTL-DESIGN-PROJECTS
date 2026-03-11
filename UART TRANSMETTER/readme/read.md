# UART Transmitter (Verilog)

## Overview
This project implements a UART (Universal Asynchronous Receiver Transmitter) transmitter using Verilog HDL. 
The design sends 8-bit parallel data serially using a finite state machine (FSM), shift register, and baud rate generator.

The transmitter supports a standard UART frame format consisting of:
- 1 Start Bit
- 8 Data Bits
- 1 Stop Bit

## Features
- FSM-based UART control
- Parameterized shift register
- Baud rate generator
- Modular RTL design
- Verilog testbench for verification

## Architecture

Main modules used in the design:

- **uart.v** – Top module integrating all blocks
- **fsm_controller.v** – Controls UART transmission states
- **shift_register.v** – Parallel-to-serial data conversion
- **baudrate.v** – Generates baud tick for timing control



