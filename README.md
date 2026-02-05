# rtl-pipeline-register
Single stage pipeline register using valid-ready handshake

Description

This project implements a single-stage pipeline register in SystemVerilog using a standard valid-ready handshake protocol.

Features

Single-stage pipelining

Valid/Ready interface

Backpressure handling

No data loss or duplication

Fully synthesizable RTL

Files Included

pipeline_register.sv → RTL design

pipeline_register_tb.sv → Testbench for functional verification

Functionality

The module accepts input data when in_valid and in_ready are asserted, stores it in a pipeline register, and forwards it to the output when out_ready is high.

Author

Purnima
