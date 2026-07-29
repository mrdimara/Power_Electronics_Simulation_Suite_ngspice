---
title: Perturb and Observe (P&O) Algorithm
tags: [theory]
related:
  - Perturb and Observe (P&O) MPPT Controller
  - PV Array Model
  - Incremental Conductance MPPT
---

# Perturb and Observe (P&O) Algorithm

## Overview

The Perturb and Observe (P&O) algorithm is a hill-climbing technique used for maximum power point tracking (MPPT) in photovoltaic systems. It periodically perturbs the operating voltage of the PV array and observes the change in power to determine the direction of the next perturbation.

## Algorithm Steps

1. Measure PV voltage ($V_{pv}$) and current ($I_{pv}$)
2. Calculate power: $P_{pv} = V_{pv} \times I_{pv}$
3. Store previous voltage and power: $V_{prev}$, $P_{prev}$
4. Perturb voltage by a small step $\Delta V$ (typically 0.1-0.5 V)
5. Wait for stabilization (sampling period)
6. Measure new voltage and power
7. If $P_{new} > P_{prev}$:
   - Continue perturbing in the same direction
   - Else:
   - Reverse the direction of perturbation
8. Update $V_{prev} = V_{new}$, $P_{prev} = P_{new}$
9. Repeat from step 4

## Mathematical Formulation

The decision rule is based on the derivative of power with respect to voltage:

$$
\frac{dP}{V} = \frac{\Delta P}{\Delta V}
$$

- If $\frac{dP}{V} > 0$: we are on the left of the MPP (increasing voltage increases power)
- If $\frac{dP}{V} < 0$: we are on the right of the MPP (increasing voltage decreases power)
- If $\frac{dP}{V} = 0$: we are at the MPP

## Parameters

- **Perturbation Step ($\Delta V$)**: Smaller steps give higher accuracy but slower tracking; larger steps cause oscillations around MPP.
- **Sampling Period ($T_s$)**: Must be longer than the system's settling time to avoid measuring transient behavior.

## Advantages

- Simple to implement
- Requires only voltage and current measurements
- No need for prior knowledge of PV characteristics

## Disadvantages

- Can oscillate around the MPP under steady-state conditions
- May track incorrectly under rapidly changing irradiance (can follow local maxima)
- Does not distinguish between local and global maximum in partially shaded conditions

## Mitigation Techniques

- Variable step size (smaller near MPP)
- Delayed perturbation after transient detection
- Hybrid algorithms (e.g., combine with incremental conductance)

## See Also

- [[Perturb and Observe (P&O) MPPT Controller]]
- [[Incremental Conductance MPPT]]
- [[MPPT Efficiency]]
- [[PV Array Model]]

## Tags

#theory #mppt #perturb-and-observe #pv
