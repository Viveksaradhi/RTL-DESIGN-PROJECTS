# 5-Stage Pipelined MIPS Processor (Verilog)

## Overview

This project implements a **32-bit 5-stage pipelined MIPS processor** in Verilog.
The design extends a previously implemented **single-cycle MIPS processor** by introducing pipeline stages and hazard handling mechanisms.

The processor follows the classical MIPS pipeline:

* **IF** – Instruction Fetch
* **ID** – Instruction Decode / Register Read
* **EX** – Execute / ALU
* **MEM** – Data Memory Access
* **WB** – Write Back

The design also includes **data forwarding, hazard detection, and pipeline flushing** to correctly handle pipeline hazards.

---

## Pipeline Architecture

The processor is divided into the following pipeline stages:

| Stage | Description                                        |
| ----- | -------------------------------------------------- |
| IF    | Fetch instruction from instruction memory          |
| ID    | Decode instruction and read register operands      |
| EX    | Perform ALU operations and calculate branch target |
| MEM   | Access data memory for load/store instructions     |
| WB    | Write result back to the register file             |

Pipeline registers are used between stages to hold intermediate values.

---

## Pipeline Registers

The following pipeline registers are implemented:

* **IF/ID** – Holds fetched instruction and PC+4
* **ID/EX** – Holds decoded control signals and operands
* **EX/MEM** – Holds ALU result and memory control signals
* **MEM/WB** – Holds memory data or ALU result for write back

---

## Hazard Handling

### 1. Data Hazards

Handled using a **Forwarding Unit**.

Forwarding paths:

* EX/MEM → EX
* MEM/WB → EX

This allows dependent instructions to use results without stalling.

---

### 2. Load-Use Hazard

Handled using a **Hazard Detection Unit**.

If a load instruction is followed by an instruction that uses the loaded register:

* PC write is disabled
* IF/ID register write is disabled
* ID/EX pipeline register is flushed (bubble inserted)

---

### 3. Control Hazards

Branch instructions are handled using **pipeline flushing**.

When a branch is taken:

* IF/ID register is flushed
* ID/EX register is flushed

This prevents incorrect instructions from executing.

---

## Modules Implemented

Main modules in this project:

```
pipeline_processor.v
if_id.v
id_ex.v
ex_mem.v
mem_wb.v
forwarding_unit.v
hazard_detection.v
pipeline_processor_tb.v
```

Reusable modules from the single-cycle design:

```
pc.v
ALU_32bits.v
register_file.v
control_unit.v
sign_extend.v
instruction_memory.v
data_memory.v
alu_controller.v
```

---

## Testbench

The processor is verified using **pipeline_processor_tb.v**.

The testbench prints pipeline stage instructions and debug signals for every clock cycle:

* PC value
* Instruction in each pipeline stage
* ALU result
* Memory data
* Forwarding signals
* Hazard detection signals

Example debug output:

```
Cycle=6 PC=00000018
IF=02538820 ID=11090002 EX=01ea8020 MEM=8d2f0000 WB=8d2f0000
frwA=01 frwB=00 pcwrite=1 flush=0
```

---

## Instruction Memory Example

Example program used for testing:

```
012A4020
010C5822
010E6824
8D2F0000
01EA8020
11090002
02538820
02B6A020
00000000
```

---

## Features

✔ 32-bit MIPS architecture
✔ 5-stage pipeline implementation
✔ Forwarding unit for data hazard resolution
✔ Hazard detection unit for load-use hazards
✔ Control hazard handling using pipeline flush
✔ Verilog testbench with cycle-by-cycle debug output

---

## Author

**Vivek Saradhi**

B.Tech Electronics and Communication Engineering
Focus: **Digital Design / RTL Design / VLSI**

