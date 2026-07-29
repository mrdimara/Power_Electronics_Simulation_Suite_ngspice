---
title: Perturb and Observe (P&O) MPPT Controller
tags: [simulation]
status: reproduced
course_topics:
  - MPPT
  - Renewable energy
topology: buck_converter_with_mppt
tools:
  - ngspice
tags:
  - power-electronics
  - ngspice
  - mppt
  - boost-converter
  - perturb-and-observe
source_files:
  - simulations/renewable/mppt/MPPT/mppt_v2.cir
result_id: mppt_pob
updated: 2026-07-28
---

# Perturb and Observe (P&O) MPPT Controller

## Purpose

Simulate a boost converter with a perturb and observe (P&O) maximum power point tracking (MPPT) algorithm for a photovoltaic panel.

## Circuit Operation

The P&O algorithm periodically perturbs the operating point (voltage) and observes the change in power. If power increases, the perturbation continues in the same direction; if power decreases, the direction is reversed.

## Parameters

- **PV Panel**: 12 V nominal, 50 W (simplified model)
- **Boost Converter**:
  - Inductance: 5 mH
  - Output Capacitance: 100 µF
  - Switching Frequency: 10 kHz
- **Load**: 10 Ω resistive
- **P&O Perturbation**: 0.1 V step every 100 ms

## Netlist

- Main netlist: `simulations/renewable/mppt/MPPT/mppt_v2.cir`
- Includes: `./edt01.sub` (contains PWM, PID, etc. subcircuits)

## Simulation Command

```bash
cd simulations/renewable/mppt/MPPT
ngspice -b mppt_v2.cir
```

## Results

The simulation shows:

- PV voltage and current converging to the maximum power point
- Duty cycle adjusting to maintain optimal operation
- Output voltage higher than input (boost action)

## Key Metrics

| Metric | Value |
|--------|-------|
| MPP Voltage | ~17 V (for simulated panel) |
| MPP Current | ~2.9 A |
| Converter Efficiency | ~85% (simulated, includes switch/conduction losses) |
| Tracking Efficiency | >95% (under steady irradiance) |

## Theory Connection

See [[Perturb and Observe Algorithm]] for a description of the MPPT technique.

## Related Notes

- [[Perturb and Observe Algorithm]]
- [[PV Array Model]]
- [[Boost Converter]]
- [[MPPT: Incremental Conductance]]
- [[Simulation: Boost Converter]]

## Tags

#simulation #mppt #pob #boost-converter #renewable-energy
