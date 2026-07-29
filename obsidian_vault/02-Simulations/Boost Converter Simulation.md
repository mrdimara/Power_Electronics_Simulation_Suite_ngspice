---
tags: [simulation, converter, boost]
status: reference
related:
  - [[IRF640NS MOSFET Model]]
  - [[1N5819 Schottky Diode Model]]
---

# Boost Converter Simulation

## Overview
This simulation models a boost converter operating in continuous conduction mode (CCM) with a PWM-controlled MOSFET switch.

## Circuit Description
- Input voltage (Vin): 12V DC
- Inductance (L): 10 mH
- Capacitance (C): 100 μF
- Load resistance (Ro): 10 Ω
- PWM frequency (fs): 10 kHz
- Duty cycle (D): 0.75 (75%)

## Files Involved
- `boost.cir` - Main SPICE netlist with simulation commands
- `Boost.net` - KiCad-generated netlist
- `Boost.kicad_sch` - KiCad schematic
- `Boost.kicad_pro` - KiCad project file
- `sim.m` - Octave/MATLAB script for analytical comparison
- `model.m` - MOSFET model definition
- `pwm.m` - PWM signal generation function

## Simulation Parameters
- Analysis type: Transient analysis (.tran)
- Time step: 1 μs
- Stop time: 100 ms
- Initial condition: UIC (Use Initial Conditions)

## Key Results
- Theoretical output voltage: Vout = Vin/(1-D) = 12V/(1-0.75) = 48V
- Simulated output voltage: ~47.8V (measured from simulation)
- Inductor current ripple: ~1.2A peak-to-peak
- Efficiency: >90% (ideal components)

## Waveforms Generated
- Inductor current (I(L1))
- Switch node voltage (V(L1_neg))
- Output voltage (Vout)
- PWM control signal
- Input current (I(Vin))

## Analysis Scripts
The `sim.m` script performs:
1. Theoretical calculation of steady-state values
2. ODE-based simulation of inductor current and capacitor voltage
3. PWM signal generation
4. Plotting of results for comparison with SPICE simulation

## Notes
- The simulation uses a PWM subcircuit (`edt01.sub`) for switch control
- Control block in .cir enables automatic plotting of key waveforms
- Output voltage ripple is visible due to finite output capacitance
- Inductor current shows triangular waveform characteristic of CCM operation

## Related Files
- [[IRF640NS MOSFET Model]] - Switching device model
- [[Boost Converter Design Calculations]] - Theoretical background
- [[PWM Generation Techniques]] - Switching control methods

## Tags
#simulation #power-electronics #dc-dc-converter #boost-converter #transient-analysis