# Synchronous FIFO (Verilog)

## Overview
This project implements a synchronous FIFO (First-In First-Out) buffer using Verilog HDL. 
The FIFO uses a single clock for both read and write operations and supports controlled data flow between producer and consumer modules.

## Features
- Parameterized FIFO depth and width
- Separate read and write pointers
- Full and empty status flags
- Synchronous read and write operations
- Verilog testbench for verification

## FIFO Operation

The FIFO stores data sequentially and outputs data in the same order it was written.

Write operation:
