# ngspice — Power Electronics Simulation and Modeling Repository

A collection of **ngspice simulations, KiCad projects, reusable SPICE subcircuits, and Octave/MATLAB post-processing scripts** for studying and developing power electronics systems using fully open-source tools.

The repository contains learning exercises, reusable models, converter implementations, motor-drive simulations, photovoltaic systems, battery charging circuits, and control techniques with increasing levels of realism through non-ideal component modeling.

---

# Repository Structure

```text
ngspice/

├── learnings/
│   ├── Converters/
│   │   ├── Buck Converter
│   │   ├── Boost Converter
│   │   ├── Buck-Boost Converter
│   │   ├── Flyback Converter
│   │   ├── Forward Converter
│   │   ├── Push-Pull Converter
│   │   ├── Half Bridge
│   │   └── Full Bridge
│   │
│   ├── MPPT/
│   │   ├── PV modeling
│   │   └── Maximum Power Point Tracking
│   │
│   ├── Charging/
│   │   ├── Battery charging circuits
│   │   └── PV charging systems
│   │
│   ├── PWM/
│   │   ├── SPWM
│   │   └── SVPWM
│   │
│   ├── rectifier/
│   │   ├── Single phase
│   │   ├── Three phase
│   │   └── Non-ideal analysis
│   │
│   ├── FeedForward_Control/
│   │
│   ├── Passive_Power_Factor_improvement/
│   │
│   └── v_by_f_im/
│       └── Induction motor V/F control
│
├── symbols_subckt/
│   ├── Custom symbols
│   └── Subcircuit models
│
├── basic_models/
│   ├── Diodes
│   ├── BJTs
│   ├── MOSFETs
│   ├── Op-Amps
│   └── Regulators
│
├── special_models/
│
├── MicroCap-LIBRARY-for-ngspice/
│
└── README.md
```

---

# Major Topics Covered

## Power Converter Topologies

- Buck converter
- Boost converter
- Buck-Boost converter
- Flyback converter
- Forward converter
- Push-Pull converter
- Half-Bridge converter
- Full-Bridge converter

Topics explored:

- Switching behavior
- CCM/DCM operation
- Non-ideal components
- Voltage/current stress
- Efficiency analysis
- Dynamic response

---

## Motor Drive Simulations

Includes:

- V/F induction motor control
- PWM generation
- SVPWM implementation
- Motor mathematical modeling
- Octave-based analysis

Future work:

- Field Oriented Control (FOC)
- Six-phase induction motor drive
- FPGA implementation
- Advanced control methods

---

## Photovoltaic Systems

Includes:

- PV cell models
- PV source subcircuits
- MPPT simulations
- Battery charging systems

Topics:

- I-V characteristics
- P-V characteristics
- MPPT behavior
- Converter interaction with PV sources

---

## Rectifiers and Power Quality

Includes:

- Single-phase rectifiers
- Three-phase rectifiers
- Passive power factor improvement

Topics:

- Harmonics
- Ripple analysis
- Current waveforms
- Non-ideal effects

---

## Reusable Component Models

Includes reusable SPICE models for:

- Diodes
- BJTs
- MOSFETs
- Op-Amps
- Voltage regulators
- Logic ICs
- Custom subcircuits

---

# Tools Used

| Tool | Purpose |
|-------|----------|
| ngspice | Circuit simulation |
| KiCad | Schematic capture |
| GNU Octave | Mathematical modeling |
| MATLAB | Post-processing |
| Gnuplot | Visualization |
| Git | Version control |

---

# Getting Started

Clone repository:

```bash
git clone <repository-url>
cd ngspice
```

Run simulation:

```bash
ngspice example.cir
```

Run Octave scripts:

```bash
octave sim.m
```

Open KiCad project:

```bash
Open *.kicad_pro
```

---

# Typical Workflow

```text
Circuit Design
        ↓
KiCad Schematic
        ↓
Generate Netlist
        ↓
ngspice Simulation
        ↓
Export Data
        ↓
Octave/MATLAB Processing
        ↓
Plot Results
```

---

# Current Focus Areas

Current work includes:

- MPPT system development
- Battery charging systems
- Six-phase induction motor control
- ROS2 learning for autonomous systems
- FPGA implementation of motor control algorithms
- Power electronics modeling

---

# Future Goals

- Six-phase FOC implementation
- FPGA-based control architecture
- High-accuracy converter models
- Hardware validation
- EV drive simulations
- Integrated motor-drive systems

---

# Author

Maninder Singh

Electrical Engineering  
IIT (ISM) Dhanbad

GitHub:
https://github.com/<your-github>

---

# License

Open-source repository for learning, experimentation, and research.
Feel free to use and modify for educational or research purposes.
