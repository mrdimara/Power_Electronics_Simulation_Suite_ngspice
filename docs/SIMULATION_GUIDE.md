# Simulation Guide for NGSpice Power Electronics Suite

## Overview

This guide provides instructions for running simulations in the NGSpice-based power electronics simulation suite. It covers basic usage, common parameters, troubleshooting, and best practices for getting accurate results.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Basic Simulation Commands](#basic-simulation-commands)
3. [Running Different Analysis Types](#running-different-analysis-types)
4. [Common Simulation Directories](#common-simulation-directories)
5. [Parameter Guidelines](#parameter-guidelines)
6. [Troubleshooting](#troubleshooting)
7. [Best Practices](#best-practices)
8. [Example Workflows](#example-workflows)

## Prerequisites

Before running simulations, ensure you have the following installed:

- **NGSpice**: Latest version from http://ngspice.sourceforge.net/
- **MATLAB/Octave**: For post-processing scripts (optional but recommended)
- **KiCad**: For PCB design and parasitic extraction (optional)
- **Gnuplot**: For plotting simulation results (optional)

## Basic Simulation Commands

### Running a SPICE Netlist

To run a basic simulation:
```bash
ngspice -b circuit.cir
```

Where:
- `-b`: Batch mode (no interactive prompt)
- `circuit.cir`: Your SPICE netlist file

### Interactive Mode

For interactive simulation:
```bash
ngspice circuit.cir
```

This will open the NGSpice command prompt where you can run analyses interactively.

### Running with Control Lines

Many circuits in this repository include `.control` blocks for automated execution:
```bash
ngspice circuit.cir
```
The `.control` block will execute automatically.

## Running Different Analysis Types

### DC Operating Point (.op)
For bias point calculations:
```spice
.op
```
Control via command line:
```bash
ngspice -r op.raw -b circuit.cir
```

### DC Sweep (.dc)
To sweep a parameter:
```spice
.dc VIN 0 5 0.1
```
Sweeps VIN from 0V to 5V in 0.1V steps

### AC Analysis (.ac)
For frequency response:
```spice
.ac DEC 10 10Hz 100kHz
```
Decade sweep: 10 points per decade from 10Hz to 100kHz

### Transient Analysis (.tran)
For time-domain simulation:
```spice
.tran 1us 10ms
```
Simulates from 0 to 10ms with 1μs time step

### Fourier Analysis
To calculate harmonic distortion:
```spice
.four 60Hz V(OUT)
```
Analyzes the output at 60Hz fundamental frequency

## Common Simulation Directories

### Converters
- `simulations/converters/buck_converter/` - Buck converter simulations
- `simulations/converters/boost_converter/` - Boost converter simulations
- `simulations/converters/buck_boost_conv/` - Buck-Boost converter simulations
- `simulations/converters/flyback_converter/` - Flyback converter simulations
- `simulations/converters/forward_converter/` - Forward converter simulations
- `simulations/converters/push_pull_converter/` - Push-Pull converter simulations
- `simulations/converters/half_bridge_converter/` - Half-Bridge converter simulations
- `simulations/converters/full_bridge_converter/` - Full-Bridge converter simulations

### Power Supplies
- `simulations/power_supplies/pvsim/` - Photovoltaic system with MPPT
- `simulations/power_supplies/charging/` - Battery charging systems

### Motor Drives
- `simulations/motor_drives/v_by_f_im/` - V/F controlled induction drives
- `simulations/motor_drives/svpwm/` - Space Vector PWM drives

### Examples
- `examples/basic/` - Basic tutorial circuits
- `examples/advanced/` - Advanced converter topologies
- `examples/components/` - Component testing circuits

## Parameter Guidelines

### Transient Analysis Settings
For switching converters, use these guidelines:

| Parameter | Recommendation | Reason |
|-----------|----------------|---------|
| **Time Step** | 1/100th of switching period | Captures switching transitions |
| **Stop Time** | 20-100 switching cycles | Reaches steady-state |
| **Integration Method** | Trap for most circuits, Gear for stiff systems | Balance accuracy and stability |
| **Initial Conditions** | Use `IC=` for inductors/capacitors | Improves convergence |

### Example Transient Statement
For a 100kHz converter:
```spice
.tran 0.1us 20ms 0ms 0.1us uic
```
- 0.1us time step (1/10th of 10μs period)
- 20ms stop time (200 cycles at 100kHz)
- 0ms start time
- 0.1us max print step
- `uic`: Use initial conditions

## Troubleshooting

### Common Errors and Solutions

#### "Cannot find subcircuit definition"
- **Cause**: Missing `.lib` or `.include` statement
- **Solution**: 
  1. Check the `.cir` file for missing library references
  2. Verify the library file exists in the correct `models/` subdirectory
  3. Add appropriate `.lib` statement: `.lib "./models/mosfets/irf.lib"`

#### "Convergence difficulties"
- **Cause**: Switching circuits often have convergence issues
- **Solution**:
  1. Add `RSHUNT` across inductive switches: `RSHUNT 1 0 1e12`
  2. Use `.OPTIONS` settings: `.OPTIONS ABSTOL=1u RELTOL=0.001 VNTOL=1uV`
  3. Add initial conditions: `.IC I(L1)=0 V(C1)=0`
  4. Try different integration method: `.OPTIONS METHOD=GEAR`

#### "Time step too small"
- **Cause**: Simulation getting stuck at a transient point
- **Solution**:
  1. Increase `ABSTOL` and `RELTOL` slightly
  2. Check for floating nodes (add large resistors to ground)
  3. Verify MOSFET models have proper `RDSO` parameters

#### "Missing model file"
- **Cause**: Incorrect path in `.lib` statement
- **Solution**:
  1. Use relative paths from simulation directory
  2. Example: If simulating in `simulations/converters/buck_converter/` and need model from `models/mosfets/`:
     ```spice
     .lib ../../models/mosfets/irf.lib
     ```

## Best Practices

### 1. Organization
- Keep simulation files in their respective directories
- Use relative paths for library references
- Document parameter choices in comments

### 2. Model Usage
- Always check model parameters against datasheets
- Verify temperature coefficients are properly set
- Use appropriate model levels for your analysis (Level 3 for switching)

### 3. Analysis Setup
- Start with `.op` to verify bias points
- Use `.dc` to check operating ranges before transient analysis
- Ensure sufficient simulation time for steady-state
- Plot key waveforms to verify expected behavior

### 4. Post-Processing
- Save raw data files: `ngspice -r output.raw circuit.cir`
- Use MATLAB/Octave scripts in `analysis/scripts/` for advanced processing
- Calculate efficiency, losses, and other metrics systematically

## Example Workflows

### Workflow 1: Basic Converter Simulation
1. Navigate to converter directory:
   ```bash
   cd simulations/converters/buck_converter/
   ```
2. Run simulation:
   ```bash
   ngspice -b buck_converter.cir
   ```
3. View results:
   ```bash
   ngspice buck_converter.cir
   ngspice> plot v(out)
   ngspice> four 100kHz v(out)
   ```

### Workflow 2: MPPT Simulation with Post-Processing
1. Navigate to PV system directory:
   ```bash
   cd simulations/power_supplies/pvsim/
   ```
2. Run simulation (generates .raw file):
   ```bash
   ngspice -r pv_sim.raw -b pv.cir
   ```
3. Process with MATLAB/Octave:
   ```bash
   cd ../..
   octave analysis/scripts/process_pv.m pv_sim.raw
   ```

### Workflow 3: Parasitic-Aware Simulation
1. Extract parasitics using KiCad + Q3D (see PCB Parasitic Extraction Workflow)
2. Import generated Touchstone file:
   ```spice
   .include parasitics.s3p
   ```
3. Run transient analysis with parasitics included

## Advanced Topics

### Monte Carlo Analysis
For component variation analysis:
```spice
.step param run count 1 100 1
.param tol=0.05
* Vary resistor values by ±5%
R1 1 2 {10*(1+tol*gauss(0,1))}
```

### Temperature Sweep
To analyze temperature effects:
```spice
.step param temp -55 125 25
.options temp=27
```

### Parametric Analysis
Sweeping multiple parameters:
```spice
.step param L 10uH 100uH 20uH
.step param C 1uF 10uF 2uF
```

## Validation Techniques

### Comparing to Theoretical Values
1. Calculate expected values analytically
2. Run simulation with ideal components
3. Compare results to verify models

### Comparing to Measurements
1. Capture waveforms with oscilloscope
2. Align time signals using cross-correlation
3. Compare magnitude, frequency, and harmonic content

### Conservation of Power Check
Verify: `Pin ≈ Pout + Losses`
- Input power: average(Vin × Iin)
- Output power: average(Vout × Iout)
- Losses: Pin - Pout

## Appendix: Common NGSpice Commands

### Plot Commands
```ngspice
plot v(out)                    % Plot output voltage
plot i(Rload)                  % Plot load resistor current
plot v(out) i(Rload)           % Plot multiple traces
plot v(out) vs time            % Plot vs time (default)
fft v(out)                     % Perform FFT on output voltage
```

### Measurement Commands
```ngspice
meas tran vmax find max v(out)        % Find maximum voltage
meas tran vavg avg v(out)             % Calculate average voltage
meas tran vrms rms v(out)             % Calculate RMS voltage
meas tran power avg (v(in)*i(Vin))    % Calculate input power
```

### Control Block Examples
```spice
.control
tran 0.1us 20ms
plot v(out) i(L1)
meas tran vmaxavg avg v(out) end=20ms
meas tran eff avg (v(out)*i(iload))/avg(v(in)*i(lin)) * 100
.endc
```

## Safety Notes

1. **Verify Models**: Always check that component models match your actual hardware
2. **Check Parasitics**: Ensure extracted parasitics match your PCB layout
3. **Validate Results**: Compare simulations to theoretical expectations and measurements when possible
4. **Temperature Effects**: Consider temperature dependencies in critical parameters
5. **Model Limitations**: Be aware of the frequency range and limitations of each model

## Getting Help

- NGSpice Manual: http://ngspice.sourceforge.net/docs/ngspice-manual.pdf
- Repository Issues: Check GitHub Issues for known problems
- Examples Directory: Refer to working examples in `examples/`
- Analysis Scripts: See `analysis/scripts/` for processing examples