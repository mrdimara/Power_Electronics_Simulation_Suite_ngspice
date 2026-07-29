---
tags: [simulation, converter, buck]
status: reference
related:
  - [[IRF640NS MOSFET Model]]
  - [[1N5819 Schottky Diode Model]]
---

# Buck Converter Simulation

## Overview
Simulation of a buck (step-down) converter operating in continuous conduction mode (CCM) with PWM-controlled MOSFET switch.

## Circuit Parameters
- Input Voltage (Vin): Various test values (typically 12V, 24V, or 48V)
- Inductance (L): Selected based on ripple current requirements (e.g., 10μH-100μH)
- Output Capacitance (C): Selected based on output voltage ripple requirements (e.g., 10μF-100μF)
- Load Resistance (R): Variable to test different load conditions
- PWM Frequency (fs): Typically 25kHz-200kHz for power applications
- Duty Cycle (D): Vout/Vin ratio (0 < D < 1)

## Files Involved
- `simulations/converters/buck_converter/buck.cir` - Main SPICE netlist
- `simulations/converters/buck_converter/buck.net` - KiCad-generated netlist
- `simulations/converters/buck_converter/buck.kicad_sch` - KiCad schematic
- `simulations/converters/buck_converter/buck.kicad_pro` - KiCad project

## Simulation Setup
- Analysis Type: Transient analysis (.tran)
- Typical Time Step: 1/100th of switching period
- Stop Time: 20-100 switching cycles to reach steady-state
- Analysis Includes: .control block for automatic waveform plotting and measurements

## Expected Results
- Output Voltage: Vout = Vin × D (ideal case)
- Inductor Current: Triangular waveform with peak-to-peak ripple ΔIL = (Vin-Vout)×L/(Vin×fs)
- Output Voltage Ripple: ΔVout = ΔIL/(8×C×fs) (for CCM operation)
- Efficiency: Typically 85-95% depending on component parasitics

## Measurement Capabilities
The simulation includes .measure statements for:
- Output voltage average and ripple
- Inductor current peak, average, and RMS
- Efficiency calculation (Pout/Pin)
- Power losses in switch and diode
- Input and output power

## Related Files
- [[Boost Converter Simulation]] - Similar step-up topology
- [[Buck-Boost Converter]] - Inverting/non-inverting buck-boost
- [[IRF640NS MOSFET Model]] - Switching device model
- [[Schottky Diode Model]] - Free-wheeling diode model
- [[LC Filter Design]] - Output filter design guidelines

## Tags
#simulation #power-electronics #dc-dc-converter #buck-converter #pwm #step-down