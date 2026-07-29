---
tags: [analysis, ringing, log-decrement]
status: reference
related:
  - [[Hilbert Transform Method]]
  - [[FFT Analysis]]
  - [[Switching Waveform Analysis]]
---

# Log-Decrement Method for Ringing Analysis

## Overview
This note documents the log-decrement method used in the repository for analyzing ringing in switching waveforms, which is implemented in the MATLAB analysis scripts.

## Principle
The logarithmic decrement (δ) is a measure of the rate of decay of oscillations in a damped system. For a signal exhibiting exponential decay superimposed on a sinusoidal oscillation:

x(t) = Xe^(-ζωnt) * cos(ωdt + φ)

Where:
- X = initial amplitude
- ζ = damping ratio
- ωn = natural frequency
- ωd = damped frequency = ωn√(1-ζ²)
- t = time
- φ = phase angle

The logarithmic decrement is defined as the natural logarithm of the ratio of any two successive amplitudes:

δ = (1/n) * ln(x₀/xₙ)

Where:
- x₀ = initial peak amplitude
- xₙ = peak amplitude after n cycles
- n = number of cycles between measurements

## Relationship to Damping Ratio and Frequency
The damping ratio (ζ) can be calculated from the logarithmic decrement:

ζ = δ / √(4π² + δ²)

The damped frequency (ωd) and natural frequency (ωn) are related to the decay envelope and oscillation frequency:

ωd = 2π / Td  (where Td is the period of damped oscillation)
ωn = ωd / √(1-ζ²)

## Implementation in MATLAB
The `ringing_analysis_log_decrement.m` script implements this method:

1. **Peak Detection**: Identify positive and negative peaks in the ringing waveform
2. **Amplitude Extraction**: Extract peak amplitudes for envelope calculation
3. **Log-Decrement Calculation**: Compute δ using peak amplitudes
4. **Parameter Extraction**: Calculate damping ratio and frequencies
5. **Quality Factor**: Compute Q-factor = 1/(2ζ)

## Advantages
- Simple to implement and understand
- Provides direct physical interpretation (damping ratio)
- Works well for lightly damped systems (ζ < 0.3)
- Computationally efficient
- Good for single-burst ringing events

## Limitations
- Requires clear, identifiable peaks in the signal
- Accuracy decreases with heavy damping (ζ > 0.3)
- Sensitive to noise in peak detection
- Assumes constant damping ratio (may not hold for nonlinear systems)
- Difficult to apply to continuous ringing (multiple excitation events)

## Application to Power Electronics
In switching power supplies, the log-decrement method is used to:
- Characterize parasitic LC tank circuits (inductor capacitance, capacitor ESR/ESL)
- Quantify damping in snubber circuits
- Analyze switch-node ringing due to parasitic inductance and capacitance
- Evaluate effectiveness of damping resistors
- Extract equivalent series resistance (ESR) from decay rate

## Procedure
1. Isolate the ringing segment of interest (post-switching transition)
2. Subtract any DC offset or baseline
3. Identify peaks using zero-crossings or peak detection algorithms
4. Calculate logarithmic decrement from peak amplitudes
5. Derive damping ratio, natural frequency, and damped frequency
6. Calculate equivalent parallel resistance: Rp = 2Lωn/Q or Rp = ωnL/(2ζ)
7. Validate by comparing extracted RLC values with known parasitics

## Validation
The method is validated by:
- Comparing results with known RLC values in test circuits
- Cross-checking with frequency domain analysis (FFT)
- Verifying energy conservation principles
- Comparing with alternative methods (HFSS simulation, impedance measurement)

## See Also
- [[Hilbert Transform Method]] - Alternative approach for instantaneous frequency extraction
- [[FFT Analysis]] - Frequency domain complementary technique
- [[Switching Waveform Analysis]] - Comprehensive analysis framework
- [[Parasitic Extraction from Ringing]] - Application-specific methodology
- [[TECHNICAL_REPORT.md#Ringing-Analysis]]
- [[ANALYSIS_GUIDE.md#Log-Decrement-Method]]