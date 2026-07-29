---
tags: [analysis, hilbert-transform, ringing]
status: reference
related:
  - [[Log-Decrement Method]]
  - [[Analytic Signal]]
  - [[Instantaneous Frequency]]
---

# Hilbert Transform Method for Ringing Analysis

## Overview
This note documents the Hilbert transform method used in the repository for analyzing ringing in switching waveforms, which provides instantaneous frequency and amplitude information for non-stationary signals.

## Mathematical Foundation
The Hilbert transform creates an analytic signal from a real-valued signal:

For a real signal x(t), the analytic signal z(t) is defined as:
z(t) = x(t) + jy(t)

Where y(t) is the Hilbert transform of x(t):
y(t) = H{x(t)} = (1/π) * ∫[-∞ to ∞] x(τ)/(t-τ) dτ

The analytic signal can be expressed in polar form:
z(t) = a(t) * e^(jφ(t))

Where:
- a(t) = |z(t)| = √[x²(t) + y²(t)] is the instantaneous amplitude (envelope)
- φ(t) = arg{z(t)} = arctan[y(t)/x(t)] is the instantaneous phase
- ω(t) = dφ(t)/dt is the instantaneous frequency

## Implementation in MATLAB
The `hilbert_transform_ringing.m` script uses MATLAB's `hilbert` function:

```matlab
% Compute analytic signal
z = hilbert(x);
% Extract envelope and normalize
envelope = abs(z) / max(abs(z));
% Instantaneous phase
phase = angle(z);
% Unwrap phase to avoid jumps
phase_unwrapped = unwrap(phase);
% Instantaneous frequency (in Hz)
fs = sampling_frequency;
inst_freq = diff(unwrap(angle(z))) * fs / (2*pi);
```

## Advantages
- Provides time-frequency representation (unlike FFT which gives only frequency distribution)
- Tracks instantaneous amplitude and frequency evolution
- Works well for non-stationary signals (changing frequency over time)
- No need to select specific cycles for analysis (unlike log-decrement)
- Can handle multiple overlapping oscillatory modes
- Provides direct visualization of envelope and instantaneous frequency

## Limitations
- Edge effects at signal boundaries (mitigated by zero-padding or filtering)
- Sensitivity to noise (requiring preprocessing filtering)
- Computational cost for very long signals (O(N log N) with FFT implementation)
- Interpretation can be complex for multi-component signals
- Requires adequate sampling rate (Nyquist criterion for highest frequency component)

## Application to Power Electronics
In switching power supplies, the Hilbert transform method is used to:
- Extract instantaneous frequency of ringing oscillations
- Track amplitude decay (envelope) for damping calculation
- Identify frequency shifts during the ringing event
- Separate multiple ringing modes (if present)
- Analyze non-exponential decay behaviors
- Characterize voltage-dependent capacitance effects (frequency shifts with amplitude)

## Procedure
1. Preprocess signal (remove DC offset, apply anti-aliasing filter if needed)
2. Compute analytic signal using Hilbert transform
3. Extract instantaneous amplitude (envelope) and phase
4. Unwrap phase to compute instantaneous frequency
5. Analyze envelope decay to determine damping characteristics
6. Examine instantaneous frequency variation for nonlinearity detection
7. Compare with expected resonant frequency: fr = 1/(2π√(LC))

## Interpretation
- **Constant instantaneous frequency**: Indicates linear time-invariant system
- **Frequency decreasing with amplitude**: Suggests voltage-dependent capacitance (common in varactor diodes or ceramic capacitors)
- **Frequency increasing with amplitude**: May indicate magnetic saturation effects
- **Exponential envelope decay**: Consistent with linear damping (constant Q factor)
- **Non-exponential decay**: Suggests nonlinear damping mechanisms
- **Abrupt frequency changes**: May indicate mode switching or circuit topology changes

## Comparison with Log-Decrement Method
| Aspect | Log-Decrement | Hilbert Transform |
|--------|---------------|-------------------|
| **Assumptions** | Single frequency, exponential decay | None (more general) |
| **Output** | Average damping ratio, frequency | Time-varying amplitude, frequency |
| **Noise Sensitivity** | Moderate (peak detection) | High (requires filtering) |
| **Computational Load** | Low | Moderate (FFT-based) |
| **Applicability** | Simple ringing | Complex, non-stationary signals |
| **Frequency Resolution** | Single value | Continuous spectrum |
| **Amplitude Tracking** | Peak-to-peak only | Continuous envelope |

## Practical Recommendations
1. Use bandpass filtering to isolate frequency band of interest before analysis
2. Apply windowing to reduce edge effects
3. Verify sampling rate is at least 5-10x expected maximum frequency
4. Consider using the analytic signal magnitude for envelope detection rather than peak detection
5. Cross-validate with frequency domain methods for confidence
6. For power electronics, focus on both amplitude decay (losses) and frequency shift (nonlinearities)

## Validation
The Hilbert transform approach is validated by:
- Comparing with known sinusoidal signals with exponential decay
- Cross-referencing with sweep frequency measurements
- Comparing results with ring-down simulations in SPICE
- Verifying with known RLC values using impedance bridge measurements
- Consistency check: Area under instantaneous frequency curve should relate to total phase change

## See Also
- [[Log-Decrement Method]] - Complementary time-domain technique
- [[FFT Analysis]] - Frequency domain approach
- [[Analytic Signal Theory]] - Mathematical foundation
- [[Instantaneous Frequency Measurement]] - Related concepts
- [[TECHNICAL_REPORT.md#Ringing-Analysis]]
- [[ANALYSIS_GUIDE.md#Hilbert-Transform-Method]]