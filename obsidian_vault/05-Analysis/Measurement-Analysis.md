---
title: Oscilloscope Measurement Analysis
tags: [analysis]
tools:
  - PyVISA-py
  - NumPy
  - SciPy
  - Matplotlib
process: [data-acquisition, post-processing]
status: [documented]
---

# Oscilloscope Measurement Analysis

## Overview

This note documents the process for acquiring, processing, and analyzing oscilloscope measurements using Python and PyVISA-py. The workflow is used to validate simulations against hardware measurements for power electronics circuits.

## Workflow Steps

### 1. Instrument Setup
- Connect the oscilloscope (Keysight DSOX1204 or similar) to the computer via USB/LAN
- Ensure the VISA library is installed and the instrument is visible
- Configure the probe attenuation (typically 10x)
- Set up channels: 
  - Channel 1: Input voltage
  - Channel 2: Output voltage
  - Channel 3: Inductor current (via shunt or current probe)
  - Channel 4: Gate drive signal

### 2. Data Acquisition via Python
Using PyVISA-py to communicate with the instrument:

```python
import pyvisa
import numpy as np
import matplotlib.pyplot as plt

rm = pyvisa.ResourceManager()
scope = rm.open_resource('USB0::0x2A8D::0x0101::MY60000123::INSTR')

# Configure for waveform acquisition
scope.write(':WAV:SOURCE CHAN1')
scope.write(':WAV:MODE RAW')
scope.write(':WAV:FORM BYTE')
scope.write(':WAV:POIN:MODE RAW')

# Get preamble
preamble = scope.query_ascii_values(':WAV:PRE?')
x_increment = preamble[4]  # time between points
x_origin = preamble[5]     # first time point
y_increment = preamble[7]  # voltage per bit
y_origin = preamble[8]     # voltage offset
y_reference = preamble[9]  # reference point

# Acquire data
raw_data = scope.query_binary_values(':WAV:DATA?', datatype='B', is_big_endian=False)
voltages = (np.array(raw_data) - y_reference) * y_increment + y_origin
times = np.arange(len(voltages)) * x_increment + x_origin

scope.close()
```

### 3. Data Processing
- **Baseline Removal**: Subtract DC offset
- **Filtering**: Apply low-pass filter to remove noise (if needed)
- **Interpolation**: Resample to uniform time base for multiple channels
- **Alignment**: Ensure time waveforms are synchronized (trigger alignment)

### 4. Parameter Extraction
Common measurements extracted from waveforms:

#### Time-Domain Parameters
- **Rise/Fall Time**: 10% to 90% transition duration
- **Pulse Width**: Duration at 50% amplitude
- **Duty Cycle**: Pulse width / period
- **Overshoot/Peak**: Maximum voltage relative to baseline
- **Ringing Frequency**: Frequency of post-transition oscillation

#### Frequency-Domain Parameters
- **Harmonic Content**: FFT to compute THD (Total Harmonic Distortion)
- **Spectral Power**: Power spectral density via Welch's method

#### Power Electronics Specific
- **Converter Efficiency**: 
  ```
  η = (V_out × I_out) / (V_in × I_in)
  ```
- **Ripple Factor**: 
  ```
  RF = V_rms_ac / V_dc
  ```
- **Form Factor**: 
  ```
  FF = V_rms / V_dc
  ```
- **Crest Factor**: 
  ```
  CF = V_peak / V_rms
  ```

### 5. Comparison with Simulation
- Export simulation data from NGSpice (via `.plot` or `wrdata` command)
- Align time bases (adjust for delay)
- Overlay waveforms visually
- Compute error metrics:
  - Mean Absolute Error (MAE)
  - Root Mean Square Error (RMSE)
  - Correlation coefficient

## Scripts and Tools

The following scripts are available in `analysis/python/`:
- `acquire_scope_data.py`: Generic data acquisition wrapper
- `analyze_swr.py`: Square wave response analysis (rise/fall time, overshoot)
- `analyze_ripple.py`: Ripple and DC extraction from rectifier/filter output
- `compute_efficiency.py`: Power loss and efficiency calculation
- `fft_analysis.py`: Harmonic distortion and spectral analysis
- `compare_simulation.py`: Side-by-side comparison of simulation and measurement

## Required Libraries

Install via `pip`:
```bash
pip install pyvisa numpy scipy matplotlib pandas
```

## Units and Conventions

- All voltages in volts (V)
- All currents in amperes (A)
- All times in seconds (s)
- All frequencies in hertz (Hz)
- Angles in degrees (°) or radians (rad) as specified
- Power in watts (W)
- Energy in joules (J)

## Data Storage

- Raw binary data: Stored as `.bin` files (optional)
- Processed data: Saved as `.csv` with columns: `time`, `ch1`, `ch2`, `ch3`, `ch4`
- Results: Saved as `.json` with metadata and extracted parameters
- Plots: Generated as `.png` (raster) and `.svg` (vector) for reports

## Example Application

This workflow was used to:
- Measure switching loss in a buck converter
- Validate output ripple against simulation
- Extract parasitic inductance from gate drive loop
- Confirm MPPT tracking efficiency under varying irradiance

## Limitations

- **Bandwidth**: Oscilloscope bandwidth limits measurable rise/fall times (typically < 20% of scope rise time)
- **Sampling Rate**: Minimum 2x the highest frequency of interest (Nyquist)
- **Quantization Error**: 8-bit ADC limits resolution (~0.4% of full scale)
- **Probe Loading**: 10MΩ // 15pF probe can affect high-frequency circuits
- **Ground Loops**: Differential measurements recommended for floating nodes

## See Also

- [['Oscilloscope Probe Selection']]
- [['Current Probe Types']]
- [['Grounding and Signal Integrity']]
- [['Automated Test Scripts']]
- [['Data Fusion: Simulation and Measurement']]

## Tags

#analysis #measurement #oscilloscope #pyvisa #data-acquisition
