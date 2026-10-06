# VHDL Project

This repository contains a VHDL implementation of a hardware processing unit designed for a digital logic/embedded systems project. The main design is implemented in `10851917_10839448.vhd` and is named `project_reti_logiche`.

The project is a memory-driven signal-processing block that reads data from external memory, processes it using a set of coefficients and sliding windows, and writes the result back to memory.

## Project overview

The design exposes a synchronous interface with:

- `i_clk` clock input
- `i_rst` reset input
- `i_start` start signal
- `i_add` memory address input
- `i_mem_data` input data from memory
- `o_mem_addr` memory address output
- `o_mem_data` output data
- `o_mem_we` write enable
- `o_mem_en` memory enable
- `o_done` completion flag

The module performs a sequence of memory reads, coefficient and window handling, and arithmetic computation. It supports signed arithmetic and writes processed results back to memory after completing a computation step.

## Main files

- `10851917_10839448.vhd` — main VHDL top-level module
- `Testbenches/` — testbench files used to validate the design
- `PFRL_Regole_24_25_V1.pdf` — project rules / specification PDF
- `PFRL_Specifica_24_25 20250212 v3.5.pdf` — detailed project specification
- `timing_summary_report.txt` — Vivado timing analysis report

## Design intent

The code implements a state machine that:

- reads configuration values from memory
- loads coefficients and data windows
- evaluates arithmetic conditions based on a control signal `s(0)`
- performs signed multiply-accumulate style processing
- clamps final values to valid 8-bit ranges
- writes back the processed output
- signals completion through `o_done`

This is consistent with a hardware digital signal processing or filtering application, likely implementing a convolution-like function or an optimized fixed-point arithmetic pipeline.

## Tests and validation

The repository includes several testbench files in the `Testbenches` folder, such as:

- `TB_Intermedi_Negativi.vhdl`
- `TB_Intermedi_Positivi.vhdl`
- `TestBench_mark2.vhd`
- `tb2425.vhd`
- `tb_new.vhd`
- `testbench_202533172420.vhd`

The design was validated through positive and negative intermediate cases, as well as general functional simulation.

## Hardware tool context

This project was developed and validated in the Xilinx Vivado environment.

## Typical workflow

To use the project in Vivado or another VHDL simulator:

1. Open the project in Vivado.
2. Add `10851917_10839448.vhd` to the design.
3. Compile the design.
4. Add a relevant testbench from `Testbenches/`.
5. Run behavioral simulation.
6. Check the timing summary and memory interface behavior.

## Example simulation command (generic)

```bash
ghdl -a 10851917_10839448.vhd
ghdl -a Testbenches/tb_new.vhd
ghdl -e tb_new
ghdl -r tb_new --wave=tb_new.ghw
```

This is a generic example; exact commands may vary depending on the simulator used.

## Notes

- The project is written entirely in VHDL.
- The code contains explicit state-machine logic and memory interfacing.
- The repository includes both documentation and hardware validation artifacts, suggesting an academic or coursework-oriented digital design project.
