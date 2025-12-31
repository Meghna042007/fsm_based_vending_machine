# Vending Machine Controller – Verilog HDL
## Overview

This project implements a finite state machine (FSM)–based vending machine controller in Verilog HDL.
The vending machine accepts coins of ₹5 and ₹10, allows the user to select a product priced at ₹10, ₹15, or ₹20, and either dispenses the product or returns ₹5 change when applicable.

The design focuses on FSM sequencing, synchronous control logic, and testbench-based verification, making it suitable as a beginner-to-intermediate RTL design project.

## Features

Accepts ₹5 and ₹10 coin inputs.

Supports three selectable product prices:

sel = 000 → ₹10

sel = 001 → ₹15

sel = 010 → ₹20

FSM tracks accumulated credit through explicit states.

Dispenses product when sufficient credit is reached.

Returns ₹5 change when overpayment occurs.

Fully verified using a self-written Verilog testbench.

## Design Approach
FSM-Based Credit Tracking.

The vending machine is modeled as a credit-based FSM, where each state represents the current accumulated amount:

State	Credit
s0	₹0
s5	₹5
s10	₹10
s15	₹15
s20	₹20
s25	₹25

Coin inputs cause transitions between these states.

## Price Selection

The selected product price is derived from the sel[2:0] input and internally mapped to:

₹10

₹15

₹20

The FSM compares the current credit state against the selected price to decide whether to:

Dispense directly

Dispense and return ₹5 change

## Outputs

dispense → asserted when the product is delivered

change_5 → asserted when ₹5 change is returned

Both outputs are synchronously generated to avoid glitches.

## Module Interface
## Inputs

clk – System clock

rst – Asynchronous reset (active high)

coin_5 – ₹5 coin input

coin_10 – ₹10 coin input

sel[2:0] – Product selection

## Outputs

dispense – Product dispense signal

change_5 – ₹5 change return signal

## Testbench

A dedicated testbench verifies multiple scenarios, including:

Exact payment (₹10 → ₹10)

Accumulated payment (₹10 + ₹5 → ₹15)

Overpayment with change (₹15 → ₹10 + change)

Higher-value selections (₹20 and ₹25 credit paths)

The testbench uses clock-aligned coin pulses and monitors output behavior using $monitor.

## Simulation

Simulated using Vivado Simulator

Verified state transitions, dispense timing, and change behavior

Timing-sensitive cases validated through proper testbench sequencing

## Key Learning Outcomes

FSM design using credit-based states

Handling synchronous outputs in RTL

Avoiding race conditions via clocked logic

Writing meaningful testbenches for verification

Understanding real-world FSM edge cases

## Future Improvements

Parameterize coin values and product prices

Extend change logic beyond ₹5

Separate controller and datapath for scalability

Add timeout handling for incomplete transactions
