---
title: Buck Conversion Ratio
tags: [theory]
related:
  - Buck Converter — Continuous Conduction Mode
  - Inductor Current Ripple
  - Output Capacitor Ripple Current
---

# Buck Conversion Ratio

## Derivation

For an ideal buck converter in continuous conduction mode (CCM), the inductor voltage-second balance over one switching period gives:

$$
(V_{in} - V_{out}) \cdot D \cdot T + (-V_{out}) \cdot (1-D) \cdot T = 0
$$

Solving for $V_{out}$:

$$
V_{out} = D \cdot V_{in}
$$

where:
- $D$ = duty cycle ($t_{on}/T$)
- $T$ = switching period
- $V_{in}$ = input voltage
- $V_{out}$ = output voltage

## Assumptions

1. Ideal switch (zero on-resistance, infinite off-resistance)
2. Ideal diode (zero forward voltage, zero reverse recovery)
3. Inductor current never falls to zero (CCM)
4. Steady-state operation
5. Output ripple voltage small compared to $V_{out}$

## Applications

This relation is used to:
- Set the duty cycle for a desired output voltage
- Design the control loop for voltage regulation
- Calculate the maximum duty cycle for given input/output ratios

## Limitations

- Ignores voltage drops across switch and diode
- Does not account for inductor resistance (DCR)
- Assumes perfect switching instant (no dead time effects)
- In discontinuous conduction mode (DCM), the ratio becomes load-dependent

## See Also

- [[Buck Converter — Continuous Conduction Mode]]
- [[Buck Converter — Discontinuous Conduction Mode]]
- [[Inductor Voltage-Second Balance]]

## Tags

#theory #buck-converter #conversion-ratio #ccm
