---
title: Single-Phase Half-Wave Rectifier
tags: [simulation]
status: reproduced
course_topics:
  - Rectifiers
topology: single_phase_half_wave
tools:
  - ngspice
tags:
  - power-electronics
  - ngspice
  - rectifier
  - half-wave
source_files:
  - simulations/rectifiers/single_phase_half_wave/ex02.cir
  - simulations/rectifiers/single_phase_half_wave/ex02.net
result_id: hw_rectifier
updated: 2026-07-28
---

# Single-Phase Half-Wave Rectifier

## Purpose

Simulate a single-phase half-wave rectifier with resistive load to characterize output voltage and current waveforms.

## Circuit Operation

A single diode conducts during the positive half-cycle of the AC input, producing a pulsating DC output.

## Parameters

- **Input Voltage (Vin)**: 120 V RMS, 60 Hz sine wave
- **Load Resistance (R)**: 100 Ω
- **Diode Model**: Ideal switch (for simplicity) or [1N4007] if modeled

## Netlist

- Main netlist: `simulations/rectifiers/single_phase_half_wave/ex02.cir`
- Includes: (none - self-contained)

## Simulation Command

```bash
cd simulations/rectifiers/single_phase_half_wave
ngspice -b ex02.cir
```

## Results

The simulation produces:

- Input voltage: sinusoidal
- Output voltage: half-sine waveform (zero during negative half-cycle)
- Output current: same shape as voltage (resistive load)

## Key Metrics

| Metric | Formula | Value (Ideal) |
|--------|---------|---------------|
| Average Output Voltage | Vavg = Vpeak / π | 54.0 V |
| RMS Output Voltage | Vrms = Vpeak / 2 | 84.85 V |
| Form Factor | Vrms / Vavg | 1.57 |
| Ripple Factor | √(Form² - 1) | 1.21 |

## Theory Connection

See [[Half-Wave Rectifier Equations]] for derivations.

## Related Notes

- [[Half-Wave Rectifier Equations]]
- [[Diode Model]]
- [[Simulation: Full-Wave Rectifier]]
- [[Simulation: Bridge Rectifier]]
- [[Rectifier Comparison]]

## Tags

#simulation #rectifier #half-wave #single-phase
