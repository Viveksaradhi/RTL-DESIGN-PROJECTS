# RTL Design Projects – Verilog HDL

This repository contains my RTL design projects implemented using **Verilog HDL** as part of my learning in **Digital Design, Computer Architecture, and VLSI systems**.

## Projects

### 1. 5-Stage Pipelined MIPS Processor
A 32-bit MIPS processor implemented with 5 pipeline stages (IF, ID, EX, MEM, WB).

Features:
- Pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
- Forwarding Unit for data hazard resolution
- Hazard Detection Unit for load-use hazards
- Control hazard handling using pipeline flush
- Verilog testbench for verification

Project Link: 
https://github.com/Viveksaradhi/RTL-DESIGN-PROJECTS/tree/main/mips-5stage-pipeline-processor



### 2. MIPS Single Cycle Processor
Implementation of a 32-bit single cycle MIPS processor in Verilog.

Modules:
- ALU
- Register File
- Control Unit
- Instruction Memory
- Data Memory

Project Link: 
https://github.com/Viveksaradhi/RTL-DESIGN-PROJECTS/tree/main/mips-single-cycle-processor



### 3. Synchronous FIFO
Parameterizable synchronous FIFO design with full/empty flag logic.

Project Link: 
https://github.com/Viveksaradhi/RTL-DESIGN-PROJECTS/tree/main/synchronous-fifo


### 4. UART Transmitter
UART transmitter implemented using FSM-based control logic.

Features:
- Start bit
- 8-bit data transmission
- Stop bit
- Baud rate generator

Project Link: 
https://github.com/Viveksaradhi/RTL-DESIGN-PROJECTS/tree/main/uart-transmitter



## Tools Used
- Verilog HDL
- ModelSim
- Xilinx Vivado
- Xilinx ISE

## Author
**Vivek Saradhi** 
B.Tech ECE – RGUKT Basar
