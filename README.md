# Parameterized-Multi-Road-Traffic-Controller
Parameterized Multi-Road Traffic Controller using System Verilog FSM with Pedestrian Override, Emergency Priority Handling, Assertions, and Functional Coverage

# Parameterized Multi-Road Traffic Controller

A SystemVerilog-based traffic controller designed using a Finite State Machine (FSM) architecture. The design manages multiple traffic paths with configurable signal timings and supports advanced traffic management features such as pedestrian requests, emergency vehicle priority, and night mode operation.

### Key Features

* Parameterized green and yellow signal timings
* FSM-based traffic control logic
* Pedestrian request handling
* Emergency vehicle priority mode
* Night mode operation
* Assertion-Based Verification (SVA)
* Functional Coverage for state and feature validation

### Verification

The testbench includes:

* SystemVerilog Assertions (SVA)
* Functional Coverage
* State Coverage
* Feature Validation for Emergency, Night Mode, and Pedestrian Requests

### Tools

Compatible with:

* QuestaSim
* ModelSim
* VCS
* Xcelium
* EDA Playground

### Running the Simulation

Compile the RTL and testbench files using any SystemVerilog simulator.

Example (QuestaSim):
vlog Traffic_Controller.sv Traffic_Controller_tb.sv
vsim testbench
run -all

This project was developed as part of an RTL Design and Verification learning journey to strengthen FSM design, SystemVerilog coding, assertions, and functional coverage concepts.

Author: Rajitha, Aspiring RTL Design / Verification Engineer

