---
title: 1N4007 General-Purpose Rectifier Diode
tags: [model]
device: [diode, rectifier]
part_number: [1N4007]
manufacturer: [Multiple]
source: [datasheet]
status: [validated]
---

# 1N4007 General-Purpose Rectifier Diode

## Overview

The 1N4007 is a popular general-purpose silicon rectifier diode rated for 1A continuous forward current and 1000V peak reverse voltage. It is commonly used in low-frequency rectification applications (50/60 Hz) due to its high reverse voltage rating and low cost.

## Key Specifications

| Parameter | Symbol | Value | Conditions |
|-----------|--------|-------|------------|
| Maximum Repetitive Peak Reverse Voltage | $V_{RRM}$ | 1000 V | |
| Maximum RMS Voltage | $V_{RMS}$ | 700 V | |
| Maximum DC Blocking Voltage | $V_{DC}$ | 1000 V | |
| Maximum Average Forward Rectified Current | $I_{F(AV)}$ | 1.0 A | @ $T_A = 75°C$ with lead length 0.375" |
| Peak Forward Surge Current | $I_{FSM}$ | 30 A | 8.3 ms single half sine-wave |
| Maximum Instantaneous Forward Voltage | $V_F$ | 1.1 V | @ $I_F = 1.0A$, $T_A = 25°C$ |
| Maximum Reverse Current | $I_R$ | 5.0 µA | @ $V_R = 1000V$, $T_A = 25°C$ |
| Typical Junction Capacitance | $C_J$ | 15 pF | @ $V_R = 0V$, $f = 1 MHz$ |
| Typical Reverse Recovery Time | $t_{rr}$ | 2.0 µs | @ $I_F = 0.5A$, $i_r = 1.0A$, $I_{rr} = 0.25A$ |
| Operating Junction Temperature | $T_J$ | -55 to +150 °C | |
| Storage Temperature Range | $T_{stg}$ | -55 to +150 °C | |

## Model Assumptions

*   The diode is modeled as a perfect switch when forward-biased (no voltage drop) for ideal simulations.
*   For more accurate simulations, a constant voltage drop (0.7V) or exponential model is used.
*   Reverse recovery is neglected in steady-state RMS/Average calculations but included in transient switching simulations.
*   Temperature effects are often ignored in first-order analysis.
*   Parasitic inductance and capacitance are neglected unless modeling high-frequency behavior.

## SPICE Model (Level 1)

The following is a typical SPICE .model statement for the 1N4007:

```
.model D1N4007 D(
    IS=1.02e-09   % Saturation current
    N=1.78        % Emission coefficient
    BV=1200       % Reverse breakdown voltage
    IBV=1.00e-05  % Current at breakdown
    TT=0          % Transit time (zero for standard recovery)
    CJO=1.5e-11   % Zero-bias junction capacitance
    VJ=0.75       % Junction potential
    M=0.5         % Grading coefficient
    EG=1.11       % Activation energy
    XTI=3         % Saturation current temperature exponent
    KF=0          % Flicker noise coefficient
    AF=1          % Flicker noise exponent
    FC=0.5        % Forward-bias depletion capacitance coefficient
)
```

*   Note: Parameters vary by manufacturer and source. This is a representative model.

## Temperature Effects

The saturation current $IS$ doubles approximately every 10°C rise in temperature. The forward voltage decreases by about 2 mV/°C.

## Power Dissipation

Maximum power dissipation is limited by junction temperature:

$$
P_{max} = \frac{T_{j,max} - T_A}{R_{\theta JA}}
$$

where:
*   $T_{j,max} = 150°C$ (maximum junction temperature)
*   $T_A$ = ambient temperature
*   $R_{\theta JA}$ = junction-to-ambient thermal resistance (≈ 50°C/W for leaded devices)

## Usage in Simulations

In this repository, the 1N4007 model is typically found in:
- `models/diodes/rectifiers.lib` (or similar)
- Referenced in netlists as `.model D1N4007 D (...)` or via `.include`

## Validation

Forward voltage at 1A: ≈ 1.1V (measured)
Reverse leakage at 25°C, 800V: < 5µA (typical)

## References

- [ON Semiconductor 1N400x Datasheet](https://www.onsemi.com/pdf/datasheet/1n4001-d.pdf)
- [Vishay 1N4007 Datasheet](https://www.vishay.com/docs/88503/1n4007.pdf)

## See Also

- [['Schottky Diode']]
- [['Zener Diode']]
- [['Diode Forward Characteristic']]
- [['Diode Reverse Recovery']]
- [['Diode Model']]

## Tags

#model #diode #rectifier #1n4007
