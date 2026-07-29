---
tags: [simulation, converter, buck-boost]
status: reference
related:
  - [[Buck Converter Simulation]]
  - [[Boost Converter Simulation]]
  - [[Inverting Buck-Boost Converter]]
---

# Buck-Boost Converter Simulation

## Overview
This note documents the buck-boost converter simulation which can produce an output voltage that is either higher or lower than the input voltage, with opposite polarity.

## Files Involved
- Netlist: `simulations/converters/buck_boost/buck_boost.cir`
- Models: MOSFET, diode, and control circuitry
- Analysis: MATLAB scripts in `analysis/matlab/` for waveform processing

## Topology
- Input voltage source
- Power MOSFET (switch)
- Diode (rectifier)
- Inductor and output capacitor
- Load resistor
- Feedback network for voltage regulation
- PWM controller

## Operating Modes
- **Buck Mode**: Vout < Vin (D < 0.5)
- **Boost Mode**: Vout > Vin (D > 0.5)
- **Inverting**: Output voltage is negative relative to input

## Simulation Parameters
- Input Voltage (Vin): 12V
- Switching Frequency: 50 kHz
- Inductance: 100µH
- Output Capacitance: 470µF
- Load Resistance: Variable (for different power levels)
- Duty Cycle: Adjustable (0-1)

## Key Analysis Points
- Voltage conversion ratio: Vout/Vin = D/(1-D)
- Continuous vs. Discontinuous Conduction Mode (CCM/DCM) boundary
- Inductor current ripple calculation
- Output voltage ripple considerations
- Efficiency analysis including switch and diode losses
- Right-half plane zero in control-to-output transfer function (limits bandwidth)

## Results
[Note: Actual results would be populated from simulation runs]

## Validation
Comparison with theoretical buck-boost equations:
- Vout/Vin = D/(1-D) for CCM operation
- Critical inductance for CCM boundary: Lcrit = (D(1-D)²R)/(2fs)
- Output voltage ripple: ΔVout = (Io×D)/(C×fs) + ΔIL×ESR
- Efficiency considerations similar to buck and boost topologies

## Control Considerations
- Non-minimum phase behavior due to right-half-plane zero
- Requires compensation strategies for stable voltage regulation
- Peak current mode control can help but introduces subharmonic oscillation concerns at D>0.5

## See Also
- [[SIMULATION_GUIDE.md]]
- [[MODEL_LIBRARY.md#MOSFETs]]
- [[MODEL_LIBRARY.md#Diodes]]
- [[TECHNICAL_REPORT.md#Buck-Boost-Converters]]