---
title: Half-Wave Rectifier Equations
tags: [theory]
related:
  - Half-Wave Rectifier — Unfiltered
  - Half-Wave Rectifier — Filtered
  - Peak Inverse Voltage
  - Ripple Factor
---

# Half-Wave Rectifier Equations

## Assumptions

*   Sinusoidal input voltage: $v_s(t) = V_m \sin(\omega t)$
*   Ideal diode: forward voltage drop $V_D = 0V$ (or 0.7V for silicon, noted separately)
*   The transformer is ideal (no losses, perfect coupling)
*   The load is purely resistive ($R_L$)
*   The diode switches instantaneously
*   The filter capacitor is large enough to maintain nearly constant voltage (for filtered case) or absent (for unfiltered case)

## Equations

### 1. Output Voltage (Average, Unfiltered)

For a half-wave rectified sine wave with peak voltage $V_m$:

$$
V_{dc} = \frac{V_m}{\pi}
$$

where $V_m = \sqrt{2} \cdot V_{rms}$ is the peak secondary voltage.

### 2. Output Voltage (RMS, Unfiltered)

$$
V_{rms} = \frac{V_m}{2}
$$

### 3. Form Factor and Ripple Factor

*   Form Factor: $\frac{V_{rms}}{V_{dc}} = \frac{\pi}{2} \approx 1.57$
*   Ripple Factor: $\sqrt{\left(\frac{\pi}{2}\right)^2 - 1} \approx 1.21$

### 4. Peak Inverse Voltage (PIV)

The diode must withstand the peak secondary voltage when reverse-biased:

$$
PIV = V_m = \sqrt{2} \cdot V_{rms}
$$

### 5. Diode Current

*   Average diode current: $I_{d,avg} = I_{dc} = \frac{V_{dc}}{R_L}$
*   RMS diode current: $I_{d,rms} = \frac{I_m}{2}$ where $I_m = \frac{V_m}{R_L}$

### 6. Transformer Secondary Current (RMS)

$$
I_{s,rms} = \frac{I_m}{2}
$$

## With Filter Capacitor (C-Load)

When a capacitor $C$ is placed in parallel with the load $R_L$:

### Output Voltage (Approximate)

$$
V_{out} \approx V_{peak} - I_{load} \cdot \frac{\Delta t}{C}
$$

where $\Delta t$ is the discharge interval (approximately the period minus conduction time).

### Ripple Voltage (Peak-to-Peak)

$$
V_{ripple} \approx \frac{I_{load}}{f \cdot C}
$$

where $f$ is the line frequency (50/60 Hz).

### Conduction Angle

The diode conducts only when the input voltage exceeds the capacitor voltage. The conduction angle $\theta$ can be found from:

$$
\cos\theta = 1 - \frac{V_{ripple}}{V_{peak}}
$$

## Design Example

Given: $V_{in,rms} = 120V$, $f = 60Hz$, $V_{out,desired} = 12V$, $I_{load} = 1A$, ripple < 10%

1.  Transformer turns ratio: $n = \frac{V_{secondary}}{V_{primary}} \approx \frac{12V \cdot \pi}{120V \cdot \sqrt{2}} \approx 0.177$ (for average ~12V)
2.  Peak secondary voltage: $V_{m} = 120 \cdot \sqrt{2} \cdot 0.177 \approx 30V$
3.  PIV requirement: $> 30V$ → Use 1N4001 (50V) or better
4.  For $V_{ripple} < 1.2V$ (10% of 12V): $C > \frac{I_{load}}{f \cdot V_{ripple}} = \frac{1}{60 \cdot 1.2} \approx 13,889 \mu F$ → Use 22,000 µF electrolytic
5.  Diode average current: $I_{d,avg} \approx I_{load} = 1A$
6.  Diode RMS current: $I_{d,rms} \approx \frac{I_m}{2} = \frac{V_m/(2R_L)}{2}$ (needs calculation based on conduction angle)

## Limitations

*   **Low utilization**: Only half of the input waveform is used.
*   **High ripple**: Requires large filtering for smooth DC.
*   **Low transformer utilization factor (TUF)**: Approximately 0.287 for resistive load.
*   **DC saturation risk**: Transformer core may saturate due to asymmetric flux excitation if not properly designed.

## See Also

- [['Full-Wave Rectifier']]
- [['Bridge Rectifier']]
- [['Peak Inverse Voltage']]
- [['Ripple Factor']]
- [['Transformer Utilization Factor']]

## Tags

#theory #rectifier #half-wave #ac-dc-conversion
