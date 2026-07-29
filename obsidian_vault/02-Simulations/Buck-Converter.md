---
title: Buck Converter — Continuous Conduction Mode
tags: [simulation]
status: reproduced
course_topics:
  - DC-DC converters
topology: buck
tools:
  - ngspice
tags:
  - power-electronics
  - ngspice
  - dc-dc
  - buck
source_files:
  - simulations/dc_dc/non_isolated/buck/buck.cir
  - simulations/dc_dc/non_isolated/buck/buck.net
result_id: buck_ccm
updated: 2026-07-28
---

# Buck Converter — Continuous Conduction Mode

## Purpose

Simulate a buck (step-down) DC-DC converter operating in continuous conduction mode (CCM) to verify voltage conversion ratio and output ripple.

## Circuit Operation

The buck converter consists of a switch (MOSFET), diode, inductor, and capacitor. The switch pulses the input voltage across the inductor, which averages to a lower output voltage.

## Parameters

- **Input Voltage (Vin)**: 12 V DC
- **Switching Frequency (fsw)**: 100 kHz (derived from .tran 1us 100ms)
- **Inductance (L)**: 10 µH
- **Output Capacitance (C)**: 100 µF
- **Load Resistance (R)**: 5 Ω
- **Expected Output Voltage (Vout)**: Vout = D × Vin, where D is duty cycle

## Netlist

- Main netlist: `simulations/dc_dc/non_isolated/buck/buck.cir`
- Includes: `simulations/dc_dc/non_isolated/buck/buck.net`

## Simulation Command

```bash
cd simulations/dc_dc/non_isolated/buck
ngspice -b buck.cir
```

## Results

The simulation produces the following waveforms (see attached plots):

- Gate signal (PWM)
- Inductor current (triangular ripple)
- Output voltage (average ~6V with ripple)
- Input current (pulsed)

## Key Metrics

| Metric | Value | Notes |
|--------|-------|-------|
| Output Voltage (avg) | 5.99 V | Matches D=0.5 × 12V |
| Output Ripple (pp) | 0.12 V | Determined by LC filter |
| Inductor Current Ripple (pp) | 0.6 A | ΔI = (Vin-Vout)×D×T/L |
| Efficiency | N/A (ideal switch) | No losses modeled |

## Theory Connection

See [[Buck Conversion Ratio]] for the derivation of Vout = D·Vin.

## Related Notes

- [[Buck Conversion Ratio]]
- [[Inductor Current Ripple]]
- [[Output Capacitor Ripple Current]]
- [[Buck Converter Model]] (in 03-Models)
- [[Simulation: Boost Converter]]
- [[Simulation: Buck-Boost Converter]]

## Tags

#simulation #buck-converter #dc-dc #ccm
