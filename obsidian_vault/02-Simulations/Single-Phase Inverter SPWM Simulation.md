---
tags: [simulation, inverter, sine-pwm]
status: reference
related:
  - [[SPWM Generation]]
  - [[IRF640NS MOSFET Model]]
  - [[Three-Phase Inverter]]
---

# Single-Phase Inverter with SPWM Simulation

## Overview
This note documents the single-phase inverter simulation using Sinusoidal Pulse Width Modulation (SPWM) to generate AC output from DC input.

## Files Involved
- Netlist: `simulations/inverters/single_phase/spwm_inverter.cir`
- Models: MOSFET/IGBT models, diode models
- Control: SPWM generator circuit
- Analysis: MATLAB scripts for harmonic analysis

## Topology
- DC voltage source (input)
- Full-bridge inverter topology (4 switches)
- LC output filter (optional)
- Load (resistive, inductive, or RLC)
- SPWM control circuit comparing sine reference with triangle carrier

## Control Method: Sinusoidal Pulse Width Modulation (SPWM)
- **Modulating Signal**: Sine wave at desired output frequency (50/60 Hz)
- **Carrier Signal**: Triangle wave at switching frequency (typically 1-20 kHz)
- **Modulation Index (ma)**: Ratio of sine amplitude to triangle amplitude (0-1)
- **Switching Frequency**: Frequency of the carrier triangle wave
- **Fundamental Frequency**: Frequency of the sine reference signal

## Simulation Parameters
- DC Input Voltage: 300V (for 230V AC output)
- Switching Frequency: 10 kHz
- Fundamental Frequency: 50 Hz
- Modulation Index: 0.8 (80%)
- Load: RL combination (100Ω + 50mH)
- Output Filter: LC filter (if used)

## Key Analysis Points
- Output voltage waveform quality (THD analysis)
- Harmonic spectrum (characteristic harmonics at sidebands around switching frequency)
- Switching losses in MOSFETs/IGBTs
- Conduction losses in semiconductor devices
- Output filter design considerations
- Dead-time effects and distortion
- Neutral point clamping (for NPC topologies)

## Results
[Note: Actual results would be populated from simulation runs]

## Validation
Comparison with theoretical SPWM analysis:
- Fundamental output voltage: Vout1 = (ma × Vdc)/2
- Harmonic amplitudes: Determined by Bessel functions of modulation index
- Switching frequency components: Appear at fc ± nfo (where fc = carrier freq, fo = fundamental freq)
- Total Harmonic Distortion (THD): Function of modulation index and modulation ratio (fc/fo)

## Switching Device Considerations
- MOSFET vs. IGBT selection based on voltage/current requirements
- Switching losses proportional to frequency and voltage/current
- Reverse recovery losses in antiparallel diodes
- Gate drive requirements and losses
- Thermal considerations and heatsinking

## Advanced Topics
- Space Vector PWM (SVPWM) for improved DC bus utilization
- Third-harmonic injection for increased fundamental output
- Discontinuous PWM modes for switching loss reduction
- Active front-end rectifier operation (bidirectional power flow)

## See Also
- [[SIMULATION_GUIDE.md]]
- [[MODEL_LIBRARY.md#MOSFETs]]
- [[MODEL_LIBRARY.md#IGBTs]]
- [[TECHNICAL_REPORT.md#Inverters]]
- [[SPWM Generation]]
- [[Three-Phase Inverter]]