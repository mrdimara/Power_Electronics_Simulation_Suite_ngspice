---
tags: [analysis, fft, frequency-domain]
status: reference
related:
  - [[Windowing Functions]]
  - [[Spectral Leakage]]
  - [[Frequency Resolution]]
---

# Blackman-Harris Windowed FFT Analysis

## Overview
This note documents the Blackman-Harris windowed Fast Fourier Transform (FFT) analysis used in the repository for frequency domain examination of switching waveforms and ringing signals.

## Theoretical Background
The Discrete Fourier Transform (DFT) converts a finite sequence of equally spaced samples into a same-length sequence of discrete-frequency complex numbers:

X[k] = Σ[n=0 to N-1] x[n] * e^(-j2πkn/N)

The Fast Fourier Transform (FFT) is an efficient algorithm to compute the DFT with O(N log N) complexity instead of O(N²).

## Windowing and Spectral Leakage
When analyzing finite-length signals, the implicit assumption of periodicity in DFT/FFT causes spectral leakage when the signal frequency is not an integer multiple of the fundamental frequency (fs/N).

Windowing reduces spectral leakage by multiplying the signal by a window function that tapers to zero at the edges:

x_windowed[n] = x[n] * w[n] for n = 0, 1, ..., N-1

The Blackman-Harris window is a generalized cosine window with excellent sidelobe suppression:

w[n] = a₀ - a₁cos(2πn/(N-1)) + a₂cos(4πn/(N-1)) - a₃cos(6πn/(N-1))

Where the coefficients for the 4-term Blackman-Harris window are:
- a₀ = 0.35875
- a₁ = 0.48829
- a₂ = 0.14128
- a₃ = 0.01168

## Implementation in MATLAB
The `fft_analysis_bh.m` script implements Blackman-Harris windowed FFT:

```matlab
% Apply Blackman-Harris window
window = blackmanharris(N);
x_windowed = x .* window;

% Compute FFT
X = fft(x_windowed);

% Compute frequency vector
df = fs / N;  % Frequency resolution
f = (0:N-1) * df;  % Frequency vector (0 to fs-df)

% Compute magnitude spectrum (in dB)
magnitude_db = 20 * log10(abs(X) / (N/2));  % Normalized for sine wave amplitude

% For power spectral density:
psd = (abs(X).^2) / (fs * ENBW);  % ENBW = Equivalent Noise Bandwidth
```

Where ENBW (Equivalent Noise Bandwidth) for Blackman-Harris window is approximately 2.0044 * (fs/N).

## Advantages of Blackman-Harris Window
- **Excellent sidelobe suppression**: Minimum sidelobe attenuation of ~92 dB
- **Good frequency resolution**: Main lobe width of approximately 4 bins
- **Low scallop loss**: Maximum amplitude error of ~0.001 dB for sinusoids
- **Superior dynamic range**: Able to detect small signals in presence of large ones
- **Minimal leakage**: Energy strongly concentrated around true frequency

## Disadvantages
- **Wider main lobe**: Compared to rectangular window (reduced frequency resolution)
- **Increased noise bandwidth**: Higher equivalent noise bandwidth than simpler windows
- **More complex computation**: Slightly higher computational cost than basic windows

## Application to Power Electronics
In switching power supply analysis, Blackman-Harris windowed FFT is used to:
- Quantify harmonic distortion in output voltages and currents
- Analyze switch-node voltage spectrum for EMI prediction
- Characterize ringing frequency and damping from spectral width
- Measure conducted emissions (150 kHz - 30 MHz range)
- Identify subharmonics and chaotic behavior in control loops
- Evaluate effectiveness of input filters
- Analyze spectrum spread techniques for EMI reduction

## Procedure
1. Acquire time-domain signal with adequate sampling rate (fs ≥ 2×fmax)
2. Remove DC offset: x_ac = x - mean(x)
3. Apply anti-aliasing filter if necessary (for sampled data)
4. Select appropriate number of points (N, preferably power of 2 for FFT efficiency)
5. Apply Blackman-Harris window: x_windowed = x_ac .* blackmanharris(N)
6. Compute FFT: X = fft(x_windowed)
7. Calculate frequency axis: f = (0:N-1) * fs/N
8. Compute magnitude spectrum: |X| or 20*log10(|X|) for dB
9. Apply appropriate scaling based on measurement goal (amplitude, PSD, etc.)
10. Interpret results considering window effects

## Key Parameters
- **Frequency Resolution (df)**: fs/N Hz/bin
- **Nyquist Frequency**: fs/2 Hz (maximum observable frequency)
- **Main Lobe Width**: Approximately 4 × df for Blackman-Harris
- **Stopband Attenuation**: > 90 dB for Blackman-Harris
- **Dynamic Range**: Limited by floating-point precision and window characteristics
- **Number of Points (N)**: Affects resolution vs. statistical variance trade-off

## Interpretation Guidelines
- **Peak Identification**: Local maxima in magnitude spectrum represent frequency components
- **Harmonic Content**: Integer multiples of fundamental frequency
- **Sidebands**: Frequencies offset from carrier by modulation frequencies (fm ± nfc)
- **Noise Floor**: Broadband distribution indicating random processes
- **Discrete Tones**: Narrow peaks indicating periodic components
- **Skirt Width**: Related to damping in resonant peaks (wider = more damping)

## Special Considerations for Power Electronics
1. **Wide Dynamic Range**: Switching signals often have strong fundamentals with weak harmonics
2. **Non-Stationary Behavior**: Load transients cause spectral changes over time
3. **Modulation Effects**: PWM creates sidebands around switching frequency
4. **Quantization Effects**: Limited ADC resolution affects noise floor
5. **Aliasing**: Undersampling folds high-frequency components into baseband
6. **Leakage**: Strong components can mask nearby weaker signals

## Comparison with Other Windows
| Window | Main Lobe Width | Peak Sidelobe | Max Scallop Loss | 3 dB Bandwidth |
|--------|----------------|---------------|------------------|----------------|
| Rectangular | 2 bins | -13 dB | 3.92 dB | 0.89 bins |
| Hann | 4 bins | -32 dB | 1.42 dB | 1.44 bins |
| Hamming | 4 bins | -43 dB | 1.78 dB | 1.30 bins |
| Blackman | 6 bins | -58 dB | 1.13 dB | 1.68 bins |
| Blackman-Harris | 4 bins | -92 dB | 0.001 dB | 1.81 bins |

## Validation
Blackman-Harris windowed FFT accuracy is verified by:
- Testing with known single-frequency signals
- Verifying amplitude accuracy for sinusoids
- Checking Parseval's theorem (energy conservation)
- Comparing with windowed analytical solutions
- Validating against swept frequency measurements
- Checking symmetry for real-valued inputs
- Confirming DC gain preservation

## Practical Recommendations
1. Choose N based on desired frequency resolution: N = fs / df_desired
2. Ensure adequate sampling rate to avoid aliasing
3. Remove known deterministic components before analysis if desired
4. Consider overlapping segments for stationary signal averaging (Welch's method)
5. Zero-pad for better interpolated frequency resolution (doesn't add information)
6. Use appropriate scaling for power spectral density estimates
7. Verify frequency axis correctness with known calibration signals
8. Consider using complex FFT for phase information when needed

## See Also
- [[Windowing Functions]] - Comparison of different window types
- [[Spectral Leakage]] - Detailed explanation of leakage phenomenon
- [[Frequency Resolution]] - Factors affecting ability to distinguish frequencies
- [[ Welch's Method ]] - Modified periodogram for spectral estimation
- [[EMI Prediction from Switching Waveforms]] - Application-specific methodology
- [[TECHNICAL_REPORT.md#FFT-Analysis]]
- [[ANALYSIS_GUIDE.md#Blackman-Harris-FFT]]