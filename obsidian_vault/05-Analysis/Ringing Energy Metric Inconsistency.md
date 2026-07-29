---
tags: [analysis, ringing-energy, methodology]
status: open
related:
  - [[Log-Decrement Method]]
  - [[Hilbert Transform Method]]
  - [[Known Limitations]]
---

# Ringing Energy Metric Inconsistency

## Overview
This document describes the known inconsistency in ringing energy calculation between the simulated and practical MATLAB scripts in the repository. This is explicitly acknowledged as an open issue that has not been resolved.

## The Issue
There is a methodological discrepancy between how ringing energy is calculated in:
1. **Simulation MATLAB scripts** (analyzing NGspice .raw files)
2. **Practical MATLAB scripts** (analyzing oscilloscope measurements)

This inconsistency prevents direct comparison of ringing energy losses between simulation and measurement results.

## Nature of the Discrepancy
The inconsistency manifests in three key areas:

### 1. Ringing Window Definition
- **Simulation Approach**: Uses predefined time windows based on switching events identified in the simulation
- **Practical Approach**: Often uses adaptive windowing based on signal characteristics (e.g., threshold crossing, derivative-based detection)

### 2. Baseline Subtraction Method
- **Simulation Approach**: May subtract a Pre-defined baseline or assume zero baseline
- **Practical Approach**: Typically subtracts a moving average or linear fit to account for drift and noise

### 3. Integration Limits and Method
- **Simulation Approach**: Integrates squared voltage or current over the defined window
- **Practical Approach**: May use different formulas (e.g., V²/R, I²R, or instantaneous power integration)

## Mathematical Formulations
Different approaches to calculating ringing energy:

### Approach 1: Voltage Squared Over Resistance
E = (1/R) ∫[t₁ to t₂] v²(t) dt
Assumes known dissipation resistance R

### Approach 2: Capacitive Energy Loss
E = ½C [V₀² - V_f²] 
Where V₀ and V_f are initial and final voltages on capacitor

### Approach 3: Inductive Energy Loss
E = ½L [I₀² - I_f²]
Where I₀ and I_f are initial and final currents through inductor

### Approach 4: Direct Power Integration
E = ∫[t₁ to t₂] v(t)⋅i(t) dt
Requires simultaneous voltage and current measurements

### Approach 5: Damping-Based Calculation
E = E₀(1 - e^(-2ζωnt))
Where E₀ is initial energy, ζ is damping ratio, ωn is natural frequency

## Impact on Analysis
This inconsistency leads to:
1. **Non-comparable Results**: Simulation and measurement values cannot be directly compared
2. **Uncertainty in Loss Estimation**: Unable to accurately quantify switching losses due to ringing
3. **Validation Challenges**: Difficulty in validating simulation models against hardware measurements
4. **Design Optimization Issues**: Inability to use measurements to improve simulation accuracy

## Current Status in Repository
Both approaches are implemented and documented, but no consensus exists on which method is "correct":
- Simulation scripts use Method A (typically voltage-squared-over-resistance with fixed window)
- Practical scripts use Method B (typically adaptive window with baseline subtraction)

## Recommended Resolution Path
To resolve this inconsistency, the following steps are suggested:

### 1. Physical Justification
Determine which method better corresponds to actual energy dissipation in parasitic resistances by:
- Comparing with thermal measurements (IR camera, thermocouples)
- Measuring actual power dissipation in suspected resistive elements
- Validating with known calibrated resistors in test circuits

### 2. Conservation of Energy Check
Verify that the accounted energy matches input/output energy differences in isolated systems:
- Measure input energy during switching period
- Measure output energy delivered to load
- Account for all known losses (conduction, switching, etc.)
- The remainder should equal ringing losses if properly calculated

### 3. Frequency Domain Validation
Compare with energy calculated from frequency-domain representations:
- Parseval's theorem: Energy in time domain = Energy in frequency domain
- Integrate power spectral density over relevant frequency band
- Compare with time-domain integration results

### 4. Uncertainty Quantification
Evaluate sensitivity of results to:
- Window definition variations (±10-20% window size)
- Baseline subtraction methods (different polynomial orders)
- Integration techniques (trapezoidal, Simpson's, etc.)
- Sampling rate and bit resolution effects

### 5. Standardization Effort
Work with measurement experts to establish agreed-upon methodology:
- Consult IEEE standards for power measurement
- Refer to application notes from oscilloscope manufacturers
- Consider published methodologies in power electronics literature

## Files Affected
- `analysis/matlab/*_simulated_*_analysis*.m` - Simulation scripts
- `analysis/matlab/*_practical_*_analysis*.m` - Practical measurement scripts
- `analysis/octave/*_*_analysis*.m` - Octave equivalents
- Documentation in `docs/TECHNICAL_REPORT.md` Section 7 and Limitations
- This document and related Obsidian notes

## Related Documentation
- [[TECHNICAL_REPORT.md#Limitations]] - Formal acknowledgment of the issue
- [[ANALYSIS_GUIDE.md#Ranging-Energy-Calculation]] - Recommended practices
- [[Known Issues]] - Tracking of open problems in the repository
- [[REPOSITORY_AUDIT.md]] - Original identification of the inconsistency

## Tags
#analysis #ringing-energy #methodology #inconsistency #open-issue #validation #measurement