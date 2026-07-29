---
tags: [simulation, rectifier, three-phase]
status: reference
related:
  - [[1N5408 Diode Model]]
---

# Three-Phase Rectifier Simulation

## Overview
This note documents the three-phase rectifier simulation included in the repository, which models a six-pulse diode rectifier with capacitive filtering.

## Files Involved
- Netlist: `simulations/rectifiers/3Phase/rectifier_3P.cir`
- Models: Various diode models from the model library
- Analysis: MATLAB scripts in `analysis/matlab/` for waveform processing

## Topology
- Three-phase AC input
- Six-diode bridge rectifier (Graetz bridge)
- Capacitive filter on DC output
- Resistive load to simulate typical DC-DC converter input

## Simulation Parameters
- Input Voltage: 3-phase 120V RMS (170V peak)
- Frequency: 60 Hz
- Diodes: 1N5408 models (standard recovery)
- Filter Capacitor: 470µF electrolytic
- Load Resistance: 100Ω

## Key Analysis Points
- Input current waveform and total harmonic distortion (THD)
- Output voltage ripple
- Diode reverse recovery losses
- Conduction losses in diodes
- Power factor calculation

## Results
[Note: Actual results would be populated from simulation runs]

## Validation
Comparison with theoretical calculations for:
- Average output voltage: Vdc ≈ (3√3/π) × Vrms_line-line ≈ 1.17 × Vrms_line-neutral
- Ripple frequency: 6× input frequency for three-phase full-wave rectifier
- Conduction angle: 120° per diode

## See Also
- [[SIMULATION_GUIDE.md]]
- [[MODEL_LIBRARY.md#Diodes]]
- [[TECHNICAL_REPORT.md#Rectifiers]]