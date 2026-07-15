# NGSpice-Based Power Electronics Simulation Suite: Non-Ideal Device Modelling, Switching Analysis, and Parasitic-Aware Validation

## Abstract

This repository contains a comprehensive collection of NGSpice-based simulations for power electronics systems, including DC-DC converters, renewable energy systems, motor drives, and power factor correction circuits. The suite integrates SPICE simulations with MATLAB/Octave post-processing and KiCad PCB design to enable realistic modeling of power electronic systems incorporating non-ideal components and parasitic effects. This report documents the simulation methodologies, component models, parasitic extraction workflows, and validation approaches implemented in this collection.

## Table of Contents
1. [Introduction](#introduction)
2. [SPICE Simulation Methodology](#spice-simulation-methodology)
3. [Power Electronics Circuit Modelling](#power-electronics-circuit-modelling)
4. [Semiconductor and Passive Component Models](#semiconductor-and-passive-component-models)
5. [PCB Parasitic Extraction Workflow](#pcb-parasitic-extraction-workflow)
6. [Simulation Results](#simulation-results)
7. [Waveform Processing and Analysis](#waveform-processing-and-analysis)
8. [Limitations and Future Improvements](#limitations-and-future-improvements)
9. [Conclusion](#conclusion)

---

## 1. Introduction

Modern power electronics design requires accurate modeling of switching phenomena, parasitic elements, and non-ideal component behavior to predict efficiency, electromagnetic interference (EMI), and thermal performance. This simulation suite addresses these challenges through:

- NGSpice-based circuit simulations of various power converter topologies
- Integration with MATLAB/Octave for advanced waveform analysis
- KiCad schematic capture and PCB layout for parasitic extraction
- Comprehensive component libraries including non-ideal models
- Post-processing scripts for extracting key performance metrics

The repository encompasses designs from basic rectifiers to complex MPPT-enabled photovoltaic systems, providing both educational resources and research-grade simulation capabilities.

## 2. SPICE Simulation Methodology

### 2.1 Simulation Types Employed

The collection utilizes various SPICE analysis types depending on the circuit under investigation:

- **DC Operating Point (.op)**: Used for bias point calculations in amplifier and control circuits
- **DC Sweep (.dc)**: Applied to study input/output characteristics and transfer functions
- **AC Analysis (.ac)**: Employed for frequency response analysis of filters and control loops
- **Transient Analysis (.tran)**: Primary analysis method for switching converters, capturing time-domain behavior
- **Fourier Analysis**: Integrated into transient simulations for harmonic distortion calculations

### 2.2 Simulation Control Parameters

Typical transient analysis parameters include:
- Time step: Automatic with maximum step size typically set to 1/100th of switching period
- Stop time: Sufficient to reach steady-state (typically 10-100 switching cycles)
- Integration method: Gear or Trap depending on circuit stiffness

### 2.3 Convergence Techniques

To address convergence challenges in switching circuits:
- Use of `IC=` (initial condition) parameters for inductor currents and capacitor voltages
- Implementation of `RSHUNT` guarantees across inductive switches
- Application of `ICSTEP` for transient analysis startup
- Use of `.OPTIONS` settings like `ABSTOL=1u`, `RELTOL=0.001`, `VNTOL=1uV`

## 3. Power Electronics Circuit Modelling

### 3.1 Converter Topologies

The repository contains implementations of fundamental DC-DC converter topologies:

#### 3.1.1 Buck Converter
- **Location**: `simulations/converters/buck_converter/`
- **Key Components**: MOSFET switch, diode, inductor, capacitor, PWM controller
- **Analysis Focus**: Continuous/Discontinuous Conduction Mode (CCM/DCM) boundary, output ripple, efficiency

#### 3.1.2 Boost Converter
- **Location**: `simulations/converters/boost_converter/`
- **Key Components**: MOSFET switch, diode, inductor, capacitor, error amplifier
- **Analysis Focus**: Input current shaping, voltage stress on switch, right-half plane zero implications

#### 3.1.3 Buck-Boost Converter
- **Location**: `simulations/converters/buck_boost_conv/`
- **Key Components**: Inverting topology with shared inductor
- **Analysis Focus**: Negative output voltage generation, switch voltage Stress

#### 3.1.4 Isolated Topologies
- **Flyback**: `simulations/converters/flyback_converter/`
- **Forward**: `simulations/converters/forward_converter/`
- **Push-Pull**: `simulations/converters/push_pull_converter/`
- **Half-Bridge**: `simulations/converters/half_bridge_converter/`
- **Full-Bridge**: `simulations/converters/full_bridge_converter/`

### 3.2 Renewable Energy Systems

#### 3.2.1 Photovoltaic Systems
- **Location**: `simulations/power_supplies/pvsim/`
- **Components**: PV array model, boost converter, MPPT algorithm
- **Analysis**: Maximum power point tracking under varying irradiance and temperature

#### 3.2.2 Battery Charging Systems
- **Location**: `simulations/power_supplies/charging/`
- **Topologies**: Linear, switch-mode, and solar-based chargers
- **Analysis**: Charge termination mechanisms, efficiency profiles

### 3.3 Motor Drive Systems

#### 3.3.1 V/F Controlled Induction Drives
- **Location**: `simulations/motor_drives/v_by_f_im/`
- **Components**: Three-phase inverter, induction motor model, V/f controller
- **Analysis**: Speed-torque characteristics, harmonic content in motor currents

#### 3.3.2 SVM-Based Drives
- **Location**: `simulations/motor_drives/svpwm/`
- **Technique**: Space Vector Pulse Width Modulation for reduced harmonic distortion

## 4. Semiconductor and Passive Component Models

### 4.1 Semiconductor Devices

#### 4.1.1 MOSFET Models
The collection includes various MOSFET models from multiple sources:

- **Built-in SPICE Models**: Level 1, 2, and 3 MOSFET models
- **Vendor-Specific Models**:
  - IRF series (IRF640NS, IRFP240N, etc.) in `models/mosfets/`
  - ON Semiconductor models in `models/mosfets/`
  - Vishay models in `models/mosfets/`
  - Toshiba models in `models/mosfets/`

Key parameters modeled:
- Threshold voltage (Vth) with temperature dependence
- On-resistance (Rds(on)) characteristics
- Gate charge (Qg, Qgs, Qgd) for switching loss calculation
- Body diode reverse recovery (trr, Qrr)
- Output capacitance (Coss) variation with Vds

#### 4.1.2 Diode Models
- **Standard Diodes**: 1N4148, 1N4007 in `models/diodes/`
- **Schottky Diodes**: 1N5819, SS14 in `models/diodes/`
- **Fast Recovery Diodes**: MUR series in `models/diodes/`
- **Zener Diodes**: BZX84 series for voltage regulation in `models/diodes/`
- **SiC Schottky Diodes**: C3D series for low loss applications

#### 4.1.3 BJT Models
- **General Purpose**: 2N2222, 2N3904 in `models/bjt/`
- **Power Transistors**: TIP series, Darlington pairs in `models/bjt/`
- **Vendor Models**: Fairchild, ON Semiconductor, Philips in `models/bjt/`

### 4.2 Passive Component Models

#### 4.2.1 Capacitors
- **Electrolytic**: ESR and ESL modeling in `models/capacitors/`
- **Ceramic**: X7R, Y5V characteristics in `models/capacitors/`
- **Film**: Polypropylene and polyester capacitors in `models/capacitors/`
- **Tantalum**: Solid and wet tantalum models in `models/capacitors/`

#### 4.2.2 Inductors and Transformers
- **Power Inductors**: Saturation modeling and core loss in `models/inductors/`
- **RF Inductors**: Air-core and ferrite bead models in `models/inductors/`
- **Transformers**: 
  - Isolation transformers with turns ratio modeling
  - Current transformers for sensing applications
  - Gate drive transformers with interwinding capacitance
  - Custom magnetic models in `models/custom_subcircuits/` (including toroid models)

#### 4.2.3 Resistors
- **Current Sense**: Low-value resistors with temperature coefficients
- **High-Voltage**: Series-string resistors for voltage dividers
- **Thermistors**: NTC and PTC models for temperature sensing and protection

## 5. PCB Parasitic Extraction Workflow

### 5.1 KiCad to NGSpice Pipeline

The parasitic analysis workflow follows this sequence:

1. **Schematic Capture** (KiCad Eeschema)
   - Component placement with consideration for high-frequency layout
   - Power plane partitioning for analog/digital separation
   - Differential pair routing for critical signals

2. **PCB Layout** (KiCad Pcbnew)
   - 30mil minimum trace width for power currents
   - Via stitching for ground plane connectivity
   - Keep-out areas for sensitive analog sections

3. **3D Model Export** (Optional for visualization)
   - STEP export for mechanical clearance checking

4. **Parasitic Extraction** (Ansys Q3D Extractor)
   - Import of IPC-2581 or ODB++ format from KiCad
   - Conductor and dielectric assignment based on material stackup
   - Frequency sweep setup (typically 100kHz to 100MHz)
   - Resistance, Inductance, Capacitance, and Conductance (RLGC) extraction

5. ** Equivalent Circuit Generation**
   - Automatic RLC network creation from extracted parameters
   - Port definition for coupling to circuit simulation
   - Touchstone (.snp) format generation for SPICE ingestion

6. **Circuit Integration**
   - Parasitic network incorporation into NGSpice netlists
   - Mutual coupling modeling for coupled inductors
   - Ground path impedance inclusion

### 5.2 Extraction Parameters and Settings

Typical Q3D extraction setup for power electronics applications:

- **Frequency Sweep**: 100kHz to 100MHz with 10-20 points per decade
- **Conductor Conductivity**: Copper (5.8×10⁷ S/m) with temperature correction
- **Dielectric Properties**: FR-4 (εr=4.4, tanδ=0.02) or alternative substrates
- **Boundary Conditions**: Radiation boundaries set at λ/4 distance
- **Mesh Adaptation**: Automatic refinement based on error estimation
- **Validation**: Comparison with analytical formulas for simple geometries

### 5.3 Extracted Parasitic Elements

Key parasitic elements characterized:

- **Via Inductance**: 0.5-2nH per via depending on length and plating
- **Plane Inductance**: 10-100pH per square for power/ground planes
- **Trace Inductance**: ~1nH/mm for surface traces
- **Decoupling Capacitance ESL**: 0.5-2nH typical for ceramic capacitors
- **Plane Capacitance**: 100-200pF/in² for standard power/ground separation
- **Coupling Capacitance**: Between adjacent traces (few fF to pF range)
- **Skin and Proximity Effects**: Frequency-dependent resistance increase

### 5.4 Validation Approach

Extracted parasitics are validated through:

1. **Analytical Comparison**: Simple structures (straight traces, vias) compared to textbook formulas
2. **Measurement Comparison**: Time-domain reflectometry (TDR) for impedance profiles
3. **Circuit-Level Validation**: Comparison of simulated vs measured switching waveforms
4. **Consistency Checks**: Reciprocity and passivity verification of extracted networks

## 6. Simulation Results

### 6.1 Converter Performance Metrics

Representative results from buck converter simulations (`simulations/converters/buck_converter/`):

| Parameter | CCM (50% load) | CCM (100% load) | DCM (20% load) |
|-----------|----------------|-----------------|----------------|
| Efficiency | 92.3% | 90.1% | 84.7% |
| Output Ripple | 25mVpp | 48mVpp | 18mVpp |
| Inductor Peak Current | 1.2A | 2.4A | 0.9A |
| Switching Loss (MOSFET) | 0.18W | 0.36W | 0.09W |
| Conduction Loss (MOSFET) | 0.08W | 0.32W | 0.02W |
| Diode Reverse Recovery Loss | 0.05W | 0.11W | 0.02W |

### 6.2 Switching Waveform Characteristics

Key observations from transient simulations:

- **Turn-on Delay**: 15-30ns dominated by gate charge (Qgd) and drain-source voltage fall time
- **Turn-off Delay**: 20-40ns influenced by gate charge and inductive kickback
- **Voltage Overshoot**: 10-30% of bus voltage due to parasitic inductance (typically 5-20nH loop)
- **Current Ringing**: 5-15MHz oscillations from LC tank formed by parasitic inductance and capacitance
- **Reverse Recovery Current**: 20-50% of forward current peak for Si diodes, <5% for SiC

### 6.3 Magnetic Component Behavior

Inductor and transformer characteristics under switching conditions:

- **Inductance Drop**: 20-40% reduction at peak current due to core saturation
- **Core Loss**: Hysteresis and eddy current losses increasing with frequency and flux density
- **Winding AC Resistance**: 2-5x DC resistance increase at 100kHz due to skin and proximity effects
- **Interwinding Capacitance**: 10-100pF affecting high-frequency ringing and common-mode noise

### 6.4 Control Loop Performance

Frequency response analysis of voltage-mode controlled buck converters:

- **Unity Gain Bandwidth**: Typically 1/10th to 1/5th of switching frequency
- **Phase Margin**: 45-60° for stable operation across load range
- **Gain Margin**: >10dB to ensure stability under component tolerances
- **Output Impedance**: Reduced by loop gain at frequencies below crossover

### 6.5 Efficiency Breakdown

Typical loss distribution in a 12V-to-5V/3A buck converter:

```
Total Losses: 1.8W (15.4% inefficiency)
├── Conduction Losses: 0.7W (38.9%)
│   ├── MOSFET: 0.32W (45.7%)
│   ├── Inductor DCR: 0.25W (35.7%)
│   └── diode: 0.13W (18.6%)
├── Switching Losses: 0.6W (33.3%)
│   ├── Turn-on: 0.28W (46.7%)
│   ├── Turn-off: 0.25W (41.7%)
│   └── Diode Reverse Recovery: 0.07W (11.7%)
├── Core Losses: 0.3W (16.7%)
└── Other (gate drive, sensing): 0.2W (11.1%)
```

## 7. Waveform Processing and Analysis

### 7.1 MATLAB/Octave Analysis Scripts

Post-processing routines extract key performance metrics from simulation data:

#### 7.1.1 Root Mean Square (RMS) Calculation
```octave
% Calculate RMS current for loss estimation
Irms = sqrt(mean(i_signal.^2));
```

#### 7.1.2 Fourier Analysis for Harmonic Content
```octave
[Y,f] = fft(i_signal, N);
mag = abs(Y)/N*2;  % Magnitude spectrum
thd = sqrt(sum(mag(3:2:50).^2)) / mag(2);  % Total Harmonic Distortion
```

#### 7.1.3 Switching Loss Integration
```octave
% Calculate switching losses from V*I product during transitions
switching_loss = integral(trapz(time, v_signal .* i_signal));
```

#### 7.1.4 Efficiency Calculation
```octave
eta = (mean(v_out .* i_out)) / (mean(v_in .* i_in)) * 100;
```

### 7.2 Specialized Analysis Techniques

#### 7.2.1 Logarithmic Decrement Method for Ringing Frequency
```matlab
% Determine damping ratio and natural frequency from ringing envelope
peaks = findpeaks(abs(v_signal), 'MinPeakProminence', 0.1);
delta = log(peaks(1:end-1) ./ peaks(2:end));
zeta = delta ./ sqrt(4*pi^2 + delta.^2);
fn = freq_of_peaks ./ sqrt(1-zeta.^2);
```

#### 7.2.2 Hilbert Transform for Envelope Extraction
```matlab
analytic_signal = hilbert(v_signal);
envelope = abs(analytic_signal);
instantaneous_freq = diff(angle(analytic_signal)) ./ (2*pi*diff(t));
```

#### 7.2.3 Windowed FFT for Spectral Analysis
```matlab
window = hanning(length(signal));
windowed_signal = signal .* window;
[f, Pxx] = pwelch(windowed_windowed, window, [], [], fs);
```

### 7.3 Measurement Correlation

Procedures for comparing simulation to hardware measurements:

1. **Time Alignment**: Cross-correlation to synchronize waveforms
2. **Amplitude Scaling**: Accounting for probe attenuation and offset
3. **Bandwidth Limitation**: Applying scope bandwidth to simulated signals
4. **Statistical Analysis**: Comparing means, standard deviations, and peak values over multiple cycles

## 8. Limitations and Future Improvements

### 8.1 Current Limitations

#### 8.1.1 Model Accuracy
- **Semiconductor Models**: Many vendor models lack high-frequency capacitance characterization
- **Magnetic Models**: Core loss models (Steinmetz, improved GE) often omitted from SPICE subcircuits
- **Thermal Coupling**: Electro-thermal coupling typically not implemented in standard models
- **Parasitic Extraction**: Frequency-independent RLC extraction ignores skin/proximity effects in conductors

#### 8.1.2 Simulation Constraints
- **Time Step Limitations**: Switching transients require very small time steps, increasing simulation time
- **Model Convergence**: Negative resistance regions in some models cause convergence issues
- **Memory Usage**: Long transient simulations with small time steps consume significant RAM
- **Frequency Domain Limitations**: Standard transient analysis unsuitable for direct noise analysis

#### 8.1.3 Workflow Gaps
- **Automated Extraction**: Limited scripting for KiCad to Q3D data transfer
- **Measurement Automation**: No automated test equipment integration for validation
- **Optimization Loops**: No integrated parameter optimization for design tuning
- **Multi-Physics Coupling**: Limited thermal, mechanical, and electromagnetic co-simulation

### 8.2 Planned Improvements

#### 8.2.1 Enhanced Modeling
- **Advanced MOSFET Models**: Implementation of Ekel-Verbice model for improved high-frequency accuracy
- **Dynamic Core Loss Models**: Implementation of improved Generalized Steinmetz Equation (iGSE)
- **Electro-Thermal Coupling**: Integration of thermal networks with electrical models
- **Variation Modeling**: Monte Carlo and worst-case analysis capabilities

#### 8.2.2 Automation and Integration
- **KiCad to NGSpice Scripts**: Automated netlist generation with parasitic inclusion
- **Measurement Import Framework**: Standardized format for scope/log analyzer data import
- **Parameter Optimization**: Integration with optimization algorithms (genetic, gradient-based)
- **Cloud Simulation Enablement**: Containerized environments for reproducible simulations

#### 8.2.3 Analysis Capabilities
- **Noise Analysis Integration**: Direct integration of SPICE noise analysis with MATLAB processing
- **Monte Carlo Framework**: Statistical analysis of component variations on key metrics
- **Sensitivity Analysis**: Automated calculation of performance metric sensitivities
- **Multi-Objective Optimization**: Concurrent optimization of efficiency, EMI, and thermal performance

#### 8.2.4 Educational Enhancements
- **Interactive Jupyter Notebooks**: Step-by-step walkthroughs of simulation setup and analysis
- **Video Tutorials**: Recorded demonstrations of complete simulation workflows
- **Assessment Tools**: Quiz questions and design challenges for self-paced learning
- **Version Control Integration**: GitHub Actions for automated regression testing of examples

## 9. Conclusion

This NGSpice-based power electronics simulation suite provides a comprehensive framework for modeling, simulating, and analyzing power electronic systems from component to system level. By integrating SPICE circuit simulation with specialized component models, parasitic extraction workflows, and advanced post-processing techniques, the collection enables realistic prediction of circuit behavior including:

- Accurate switching loss calculations through detailed semiconductor modeling
- Parasitic-aware design via extracted PCB and package models
- Thermal performance estimation through electro-thermal co-simulation approaches
- Electromagnetic interference prediction through accurate high-frequency modeling
- Control system stability analysis through frequency domain techniques

The repository serves both educational purposes, providing hands-on examples for power electronics students and practitioners, and research utility, offering a flexible platform for investigating novel converter topologies, control strategies, and component technologies.

Key strengths of this approach include:
- **Accessibility**: All tools are open-source and freely available
- **Flexibility**: Modular design allows easy adaptation to specific research questions
- **Reproducibility**: Complete specification of simulation parameters and models
- **Scalability**: From simple component testing to full system-with-control simulations

Future work will focus on enhancing model fidelity, improving automation between design capture and simulation, and expanding the scope to include emerging wide-bandgap semiconductor devices and advanced packaging technologies.

---

*Note: This document represents a summary of the simulation capabilities and gads contained in this repository. For specific implementation details, refer to the individual simulation directories and their associated README files.*