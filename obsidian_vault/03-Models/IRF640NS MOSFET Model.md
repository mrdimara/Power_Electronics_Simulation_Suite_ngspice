---
tags: [model, mosfet, power-device]
status: reference
related:
  - [[BSIM3 LEVEL7 to LEVEL8 Porting Fix]]
  - [[Buck Converter Simulation]]
  - [[Boost Converter Simulation]]
---

# IRF640NS MOSFET Model

## Overview
Model documentation for the IRF640NS N-channel power MOSFET used in various power converter simulations

## Device Specifications
- **Type**: N-channel Power MOSFET
- **Package**: TO-220AB
- **Manufacturer**: Originally International Rectifier (now Infineon)
- **Technology**: HEXFET® Power MOSFET

## Key Parameters (Typical @ 25°C unless noted)
| Parameter | Symbol | Value | Units | Conditions |
|-----------|--------|-------|-------|------------|
| Drain-Source Voltage | VDSS | 60 | V |  |
| Gate-Source Voltage | VGS | ±20 | V |  |
| Continuous Drain Current | ID | 18 | A | TC = 25°C |
| Pulsed Drain Current | IDM | 72 | A |  |
| Single Pulse Avalanche Energy | EAS | 150 | mJ |  |
| Avalanche Current | IAR | 18 | A |  |
| Repetitive Avalanche Energy | EAR | 6.0 | mJ |  |
| MOSFET Power Dissipation | PD | 65 | W | TC = 25°C |
| Derating Factor |  | 0.52 | W/°C | TC > 25°C |
| Gate Threshold Voltage | VGS(th) | 2.0-4.0 | V | VDS = VGS, ID = 250μA |
| Drain-Source On-Resistance | RDS(on) | 0.027 | Ω | VGS = 10V, ID = 9A |
| Forward Transconductance | gfs | 15 | S | VDS = 15V, ID = 9A |
| Input Capacitance | Ciss | 770 | pF | VDS = 25V, VGS = 0V, f = 1MHz |
| Output Capacitance | Coss | 220 | pF | VDS = 25V, VGS = 0V, f = 1MHz |
| Reverse Transfer Capacitance | Crss | 55 | pF | VDS = 25V, VGS = 0V, f = 1MHz |
| Turn-On Delay Time | td(on) | 12 | ns | VDD = 30V, ID = 15A, RG = 25Ω |
| Rise Time | tr | 22 | ns | VDD = 30V, ID = 15A, RG = 25Ω |
| Turn-Off Delay Time | td(off) | 38 | ns | VDD = 30V, ID = 15A, RG = 25Ω |
| Fall Time | tf | 22 | ns | VDD = 30V, ID = 15A, RG = 25Ω |
| Total Gate Charge | Qg | 46 | nC | VDS = 48V, ID = 18A, VGS = 10V |
| Gate-Source Charge | Qgs | 10 | nC | VDS = 48V, ID = 18A, VGS = 10V |
| Gate-Drain Charge | Qgd | 24 | nC | VDS = 48V, ID = 18A, VGS = 10V |
| Internal Diode Forward Voltage | VSD | 0.9-1.2 | V | VGS = 0V, IS = 18A |
| Reverse Recovery Time | trr | 85 | ns | IF = 18A, dIF/dt = 100A/μs |
| Reverse Recovery Charge | Qrr | 450 | nC | IF = 18A, dIF/dt = 100A/μs |

## SPICE Model Information
- **Model Type**: Level 3 or Level 8 MOS model (BSIM3)
- **Model File**: `models/mosfets/irf640ns.lib`
- **Inclusion**: `.lib "./models/mosfets/irf640ns.lib"`
- **Instance**: `M1 drain gate source source IRF640NS L=1U W=1U` (or similar)

## Temperature Dependencies
The model includes temperature coefficients for:
- Threshold voltage (VGS(th)): ~ -4mV/°C
- On-resistance (RDS(on)): ~ 0.5%/°C
- Zero-bias threshold voltage
- Mobility
- Saturation velocity
- Subthreshold slope

## Usage Guidelines
1. **Appropriate for**: Switching applications up to 100kHz
2. **Gate Drive Requirements**: 
   - Voltage: 10V-15V recommended for full enhancement
   - Current: Sufficient to charge/discharge gate capacitance quickly
   - Ringing: Minimize gate loop inductance to prevent oscillations
3. **Thermal Considerations**:
   - Use adequate heatsinking for continuous current applications
   - Consider junction-to-case thermal resistance (RθJC)
   - Maximum junction temperature: 175°C
4. **Parasitic Awareness**:
   - Package inductance affects switching performance
   - Consider source inductance for accurate switching loss calculation
   - Gate resistance affects turn-on/turn-off times

## Validation
- **DC Characteristics**: Verified against datasheet ID-VGS and VDS-ID curves
- **AC Characteristics**: Ciss, Coss, Crss validated against specified values
- **Switching Characteristics**: Rise/fall times compared to datasheet values
- **Thermal Characteristics**: Power dissipation validated at various temperatures

## Related Files
- [[BSIM3 LEVEL7 to LEVEL8 Porting Fix]] - Documentation of model porting work
- [[MOSFET Switching Characteristics]] - General MOSFET switching analysis
- [[Gate Drive Circuit Design]] - Gate driver design considerations
- [[Thermal Modeling of Power Devices]] - Thermal analysis approaches

## Tags
#model #mosfet #irf640ns #power-mosfet #switching-device #semiconductor