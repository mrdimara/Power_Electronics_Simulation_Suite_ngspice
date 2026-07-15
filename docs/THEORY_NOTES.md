# Theoretical Foundations of Power Electronics Simulation

## Overview

This document covers the theoretical foundations underlying the simulation models and techniques used in this power electronics simulation suite. It provides the theoretical background necessary to understand the models, interpret results, and make informed decisions about simulation setup and interpretation.

## Table of Contents
1. [Semiconductor Device Physics](#semiconductor-device-physics)
2. [MOSFET Theory](#mosfet-theory)
3. [Diode Theory](#diode-theory)
4. [BJT Theory](#bjts-bipolar-junction-transistors)
5. [Magnetic Components Theory](#magnetic-components-theory)
6. [Capacitor Theory](#capacitor-theory)
7. [Thermal Modeling](#thermal-modeling)
8. [Switching Losses](#switching-losses)
9. [Parasitic Effects](#parasitic-effects)
10. [Control Theory Basics](#control-theory-basics)
11. [Numerical Methods in SPICE](#numerical-methods-in-spice)
12. [Validation Techniques](#validation-techniques)

---

## Semiconductor Device Physics

### Energy Band Theory
In crystalline solids, electron energy levels form bands:
- **Valence Band**: Highest energy band containing electrons at 0K
- **Conduction Band**: Lowest energy band that is empty at 0K
- **Band Gap (Eg)**: Energy difference between conduction and valence bands
  - Si: 1.12 eV at 300K
  - Ge: 0.66 eV at 300K
  - GaAs: 1.42 eV at 300K
  - SiC: 3.2-3.3 eV (4H-SiC) at 300K
  - GaN: 3.4 eV at 300K

### Carrier Concentration
In intrinsic semiconductor at temperature T:
```
ni = √(Nc*Nv) * exp(-Eg/(2kT))
```
Where:
- ni: intrinsic carrier concentration (cm⁻³)
- Nc, Nv: effective density of states in conduction and valence bands
- k: Boltzmann constant (8.617×10⁻⁵ eV/K)
- T: absolute temperature (K)

In doped semiconductors:
- n-type: n ≈ ND (donor concentration)
- p-type: p ≈ NA (acceptor concentration)
- np = ni² (mass action law)

### Drift and Diffusion Currents
**Drift Current** (due to electric field):
```
Jn = q·μn·n·E    (electrons)
Jp = q·μp·p·E    (holes)
```
Where:
- q: electron charge (1.602×10⁻¹⁹ C)
- μn, μp: electron and hole mobilities
- n, p: electron and hole concentrations
- E: electric field

**Diffusion Current** (due to concentration gradient):
```
Jn = q·Dn·dn/dx    (electrons)
Jp = -q·Dp·dp/dx   (holes)
```
Where:
- Dn, Dp: diffusion coefficients
- Related to mobility by Einstein relation: D = μ·kT/q

### Continuity Equations
For electrons:
```
∂n/∂t = (1/q)·∇·Jn + Gn - Rn
```
For holes:
```
∂p/∂t = (-1/q)·∇·Jp + Gp - Rp
```
Where:
- G, R: generation and recombination rates
- t: time

## MOSFET Theory

### Structure and Operation
The MOSFET (Metal-Oxide-Semiconductor Field-Effect Transistor) consists of:
- Source and drain heavily doped regions of same type (n or p)
- Channel region between source and drain
- Gate electrode separated from channel by oxide insulator
- Body (substrate) contact

### Threshold Voltage
The gate-to-source voltage at which the channel begins to form:
```
VTH = VFB + 2|φF| + (√(2qεsiNA|2φF|))/Cox
```
Where:
- VFB: Flat-band voltage
- φF: Fermi potential
- q: Electron charge
- εsi: Silicon permittivity
- NA: Substrate acceptor concentration
- Cox: Oxide capacitance per unit area

### Drain Current Equations

**Linear (Triode) Region (VDS < VGS - VTH):**
```
IDS = μn·Cox·(W/L)·[(VGS-VTH)·VDS - ½·VDS²]·(1+λ·VDS)
```

**Saturation Region (VDS ≥ VGS - VTH):**
```
IDS = ½·μn·Cox·(W/L)·(VGS-VTH)²·(1+λ·VDS)
```
Where:
- μn: Electron mobility
- Cox: Oxide capacitance per unit area (εox/tox)
- W/L: Width-to-length ratio
- λ: Channel-length modulation parameter

### Body Effect
Threshold voltage modification due to source-to-body voltage:
```
VTH = VTH0 + γ·(√(|2φF|+VSB) - √(|2φF|))
```
Where:
- VTH0: Threshold voltage at VSB=0
- γ: Body effect parameter (√(2qεsiNA)/Cox)
- VSB: Source-to-body voltage
- φF: Fermi potential

### Subthreshold Conduction
For VGS < VTH:
```
IDS = I0·exp[(VGS-VTH)/(n·VT)]·(1-exp(-VDS/VT))
```
Where:
- I0: Pre-exponential factor
- n: Subthreshold slope factor (n ≥ 1)
- VT: Thermal voltage (kT/q)

### Capacitance Modeling
**Gate-to-Channel Capacitance:**
```
GCG = W·LCox  (in accumulation)
GCG = (2/3)·W·LCox  (in saturation)
GCG = 0  (in depletion)
```

**Overlap Capacitances:**
```
CGSO = W·Cox·LD  (gate-source overlap)
CGDO = W·Cox·LD  (gate-drain overlap)
```

**Junction Capacitances:**
```
CJ = CJ0 / (1+VDS/φJ)^M  (zero-bias junction capacitance)
```

### Temperature Dependence
- **Threshold Voltage**: VTH(T) = VTH(T0) + TCV·(T-T0)
  - TCV typically -2 to -5 mV/°C for NMOS
- **Mobility**: μ(T) = μ(T0)·(T/T0)^(-α)
  - α typically 1.5 for lattice scattering
- **Threshold Voltage Temperature Coefficient**: 
  - TCV ≈ -2mV/°C (dominated by φF temperature dependence)

## Diode Theory

### PN Junction Fundamentals
When p-type and n-type semiconductors are joined:
- Electrons diffuse from n to p region
- Holes diffuse from p to n region
- Leaves behind ionized donors (+) and acceptors (-)
- Creates depletion region and built-in potential

### Built-in Potential
```
φBi = VT·ln(NA·ND/ni²)
```
Where:
- VT: Thermal voltage (kT/q)
- NA, ND: Acceptor and donor concentrations
- ni: Intrinsic carrier concentration

### Depletion Region Width
```
W = √[(2·εsi/q)·(NA+ND)/(NA·ND)·(φBi-VR)]
```
Where:
- εsi: Silicon permittivity
- VR: Reverse bias voltage (positive for reverse bias)

### Junction Capacitance
```
CJ = εsi·A/W = CJ0 / (1+VR/φBi)^M
```
Where:
- A: Junction area
- CJ0: Zero-bias junction capacitance
- M: Grading coefficient (0.5 for abrupt junction, 0.33 for linear)

### Current-Voltage Relationship
**Shockley Diode Equation:**
```
I = IS·[exp(V/(n·VT)) - 1]
```
Where:
- IS: Saturation current
- n: Ideality factor (1 ≤ n ≤ 2)
- VT: Thermal voltage (kT/q)

### Reverse Recovery
When switching from forward to reverse bias:
1. Forward current IF flows
2. Voltage reverses to -VR
3. Current continues forward briefly due to stored charge
4. Current reverses to peak reverse current IRRM
5. Current recovers to steady-state reverse leakage

**Key Parameters:**
- **Storage Time (ts)**: Time from zero-crossing to 10% of IRRM
- **Fall Time (tf)**: Time from 10% to 90% of IRRM
- **Reverse Recovery Charge (Qrr)**: Area under current curve during trr
- **Softness Factor**: Ratio of tb to ta (segments of reverse recovery)

### Temperature Effects
- **Saturation Current**: IS(T) = IS(T0)·exp[(qEg/k)·(1/T0 - 1/T)]
  - Approximately doubles every 10°C for Si
- **Forward Voltage**: VF(T) = VF(T0) + TCVF·(T-T0)
  - TCVF typically -2 mV/°C
- **Reverse Breakdown**: VBR(T) = VBR(T0) + TCVBR·(T-T0)
  - TCVBR depends on breakdown mechanism

## BJT Theory (Bipolar Junction Transistors)

### Transistor Action
BJTs control collector current via base-emitter voltage:
- **NPN**: VBE > 0.7V allows electrons to flow from emitter to collector
- **PNP**: VEB > -0.7V allows holes to flow from emitter to collector

### Transport Model (Ebers-Moll)
**Forward Active Mode:**
```
IE = -IEO·[exp(VBE/VT) - 1] + αR·ICO·[exp(VBC/VT) - 1]
IC = αF·IEO·[exp(VBE/VT) - 1] - ICO·[exp(VBC/VT) - 1]
```
Where:
- IEO, ICO: Saturation currents
- αF, αR: Forward and reverse common-base current gains
- VBE, VBC: Base-emitter and base-collector voltages

**Common-Emitter Form:**
```
IC = βF·IB + (βF+1)·ICEO·[exp(VBE/VT) - 1]
ICEO = (1-αFαR)·ICO
βF = αF/(1-αF)
```

### Gummel-Poon Model (Improved Ebers-Moll)
Accounts for high-level effects:
```
IB = (IE/βF)·[1+(VBE/VAF)] + (IC/βR)·[1+(VBC/VAR)] + ISE·[exp(VBE/nE·VT)-1] + ISC·[exp(VBC/nC·VT)-1]
IC = IE·[αF/(1+VBC/VAR)] - ICO·[exp(VBC/VT)-1]
```
Where:
- VAF, VAR: Forward and reverse Early voltages
- ISE, ISC: Base-emitter and base-collector leakage currents
- nE, nC: Emission coefficients

### Output Characteristics
**Early Effect:**
```
IC = IS·exp(VBE/VT)·(1+VCE/VA)
```
Where VA: Early voltage

**Output Resistance:**
```
ro = VA/IC
```

### Charge Control Model
Relates terminal currents to stored charge:
```
IE = QF/τF + IEO·[exp(VBE/VT)-1]
IC = QF/τB - ICO·[exp(VBC/VT)-1]
IQ = -QF/τF - QC/τR
```
Where:
- QF: Forward transit charge
- QC: Reverse transit charge
- τF, τB, τR: Forward, base storage, and reverse transit times

### Switching Characteristics
**Turn-on Delay (td):**
```
td = τB·ln[1+IB1/(IB1+IB2)]
```

**Rise Time (tr):**
```
tr = τF·ln[(IB1+IB2)/IB2]
```

**Storage Time (ts):**
```
ts = τB·ln[1+IB2·(βF-1)/(IB1+IB2)]
```

**Fall Time (tf):**
```
tf = τF·ln[(IB1+IB2)/IB2]
```

### Temperature Effects
- **VBE**: Decreases ~2 mV/°C
- **IC**: Increases with temperature for fixed VBE
- **β**: Peaks around room temperature, decreases at extremes
- **ICBO**: Increases exponentially with temperature (doubles every 10°C)

## Magnetic Components Theory

### Inductance Fundamentals
**Self-Inductance:**
```
L = N·Φ/I
```
Where:
- N: Number of turns
- Φ: Magnetic flux through coil
- I: Current through coil

**For a solenoid:**
```
L = μ0·μr·N²·A/l
```
Where:
- μ0: Permeability of free space (4π×10⁻⁷ H/m)
- μr: Relative permeability of core
- A: Cross-sectional area
- l: Magnetic path length

### Magnetomotive Force (MMF) and Magnetic Field
**MMF:**
```
F = N·I
```
Where:
- N: Number of turns
- I: Current

**Magnetic Field Strength (H):**
```
H = F/l = N·I/l
```
Where l: Magnetic path length

### Magnetic Flux and Flux Density
**Magnetic Flux (Φ):**
```
Φ = B·A
```
Where:
- B: Magnetic flux density
- A: Cross-sectional area

**Flux Density (B):**
```
B = μ0·μr·H
```

### Magnetic Circuit Analysis
Analogous to electrical circuits:
- **MMF** ↔ Voltage (V)
- **Flux (Φ)** ↔ Current (I)
- **Reluctance (R)** ↔ Resistance (R)

**Reluctance:**
```
R = l/(μ0·μr·A)
```

**Flux:**
```
Φ = MMF/R = N·I·μ0·μr·A/l
```

### Inductor with Air Gap
**Effective Permeability:**
```
μe = μr / [1 + (μr·lg/lc)]
```
Where:
- lg: Gap length
- lc: Core path length

**Inductance with Gap:**
```
L = μ0·μe·N²·A/lc
```

### Saturation
When magnetic domains are fully aligned:
- Bs: Saturation flux density
  - Si steel: ~1.6-2.0 T
  - Ferrite: ~0.3-0.5 T
  - Powdered iron: ~1.0-1.2 T
- Beyond Bs, μr approaches 1 (air-like)

### Core Losses
**Hysteresis Loss:**
```
Ph = η·Bm^α·f
```
Where:
- η: Steinmetz coefficient
- Bm: Maximum flux density
- α: Steinmetz exponent (typically 1.6-2.5)
- f: Frequency

**Eddy Current Loss:**
```
Pe = ke·d²·Bm²·f²
```
Where:
- ke: Eddy current coefficient
- d: Lamination thickness
- Bm: Maximum flux density
- f: Frequency

**Total Core Loss:**
```
Pc = Ph + Pe = k·fm·Bn
```
Where k, m, n are empirical constants

### Winding Losses
**DC Resistance:**
```
RDC = ρ·lwire/Awire
```
Where:
- ρ: Resistivity of conductor
- lwire: Wire length
- Awire: Wire cross-sectional area

**AC Resistance (Skin Effect):**
```
Rac = RDC · Fs(x)
```
Where:
- Fs(x): Skin effect factor
- x = wire radius / skin depth
- Skin depth: δ = √(ρ/(π·f·μ))

**Proximity Effect:**
Additional increase in AC resistance due to magnetic fields from nearby conductors

### Transformer Fundamentals
**Ideal Transformer:**
```
V1/N1 = V2/N2
I1/N1 = I2/N2
```
Where:
- V1, V2: Primary and secondary voltages
- I1, I2: Primary and secondary currents
- N1, N2: Primary and secondary turns

**Real Transformer Equivalent Circuit:**
- **R1, R2**: Winding resistances
- **X1, X2**: Leakage reactances
- **Rc**: Core loss resistance
- **Xm**: Magnetizing reactance
- **Ideal transformer**: Turns ratio N1:N2

**Voltage Regulation:**
```
VR = [(VNL - VFL)/VFL] × 100%
```
Where:
- VNL: No-load secondary voltage
- VFL: Full-load secondary voltage

### Coupled Inductors
**Coupling Coefficient:**
```
k = M/√(L1·L2)
```
Where:
- M: Mutual inductance
- L1, L2: Self-inductances
- Range: 0 ≤ k ≤ 1

**Voltage Equations:**
```
V1 = L1·dI1/dt + M·dI2/dt
V2 = M·dI1/dt + L2·dI2/dt
```

**Dot Convention:**
- Current entering dotted end of one coil produces positive voltage at dotted end of coupled coil
- Follows right-hand rule for flux direction

## Capacitor Theory

### Capacitance Fundamentals
**Basic Definition:**
```
C = Q/V
```
Where:
- Q: Charge stored
- V: Voltage across capacitor

**Parallel Plate Capacitor:**
```
C = ε·A/d
```
Where:
- ε: Permittivity of dielectric (ε0·εr)
- A: Plate area
- d: Plate separation

### Dielectric Properties
**Permittivity:**
```
ε = ε0·εr
```
Where:
- ε0: Vacuum permittivity (8.854×10⁻¹² F/m)
- εr: Relative permittivity (dielectric constant)

**Dielectric Strength:**
Maximum electric field before breakdown:
```
Emax = Vbreakdown/d
```

**Loss Tangent (tan δ):**
```
tan δ = ε''/ε'
```
Where:
- ε': Real part of permittivity (energy storage)
- ε'': Imaginary part of permittivity (energy loss)

### Frequency Dependence
**Permittivity as Complex Quantity:**
```
ε*(ω) = ε'(ω) - j·ε''(ω)
```

**Capacitance vs Frequency:**
- At low frequencies: εr ≈ static value
- At high frequencies: εr decreases due to inability of dipoles to follow field
- Resonances occur at molecular relaxation frequencies

### Equivalent Series Resistance (ESR)
Sources of ESR:
1. **Lead resistance**
2. **Plate resistance**
3. **Dielectric losses**
4. **Electrolyte resistance** (in electrolytics)

**ESR vs Frequency:**
- Increases with frequency due to skin effect
- Peaks at certain frequencies due to dielectric relaxation
- Decreases at very high frequencies as current bypasses lossy paths

### Equivalent Series Inductance (ESL)
Sources of ESL:
1. **Lead inductance**
2. **Loop area of plates/foils**
3. **Internal connection inductance**

**Resonant Frequency:**
```
fres = 1/(2π·√(L·C))
```
Where L = ESL, C = capacitance

### Dielectric Absorption
Also called "soakage":
- After discharge, voltage reappears over time
- Modeled as parallel RC networks
- Important in sample-and-hold circuits

### Temperature Dependence
**Capacitance vs Temperature:**
```
C(T) = C(T0)·[1 + αc·(T-T0) + βc·(T-T0)²]
```
Where αc, βc: Temperature coefficients

**ESR vs Temperature:**
- Electrolytics: ESR decreases with temperature (ionic conductivity increases)
- Ceramics: ESR relatively stable
- Film: ESR slightly increases with temperature

### Voltage Coefficient
Especially in ceramic capacitors:
```
C(V) = C0 / [1 + β·(V/V0)²]
```
Where:
- C0: Zero-bias capacitance
- β: Voltage coefficient
- V0: Reference voltage

## Thermal Modeling

### Heat Transfer Mechanisms
**Conduction:**
Fourier's Law:
```
q = -k·∇T
```
Where:
- q: Heat flux (W/m²)
- k: Thermal conductivity (W/m·K)
- ∇T: Temperature gradient

**Convection:**
Newton's Law of Cooling:
```
q = h·(Ts - Tf)
```
Where:
- h: Convective heat transfer coefficient (W/m²·K)
- Ts: Surface temperature
- Tf: Fluid temperature

**Radiation:**
Stefan-Boltzmann Law:
```
q = ε·σ·(Ts⁴ - Tsurr⁴)
```
Where:
- ε: Emissivity (0-1)
- σ: Stefan-Boltzmann constant (5.67×10⁻⁸ W/m²·K⁴)
- Ts: Surface temperature
- Tsurr: Surroundings temperature

### Thermal Resistance
**Junction-to-Case (RθJC):**
```
RθJC = (TJ - TC)/PD
```
Where:
- TJ: Junction temperature
- TC: Case temperature
- PD: Power dissipation

**Case-to-Sink (RθCS):**
```
RθCS = (TC - TS)/PD
```
Where TS: Heat sink temperature

**Sink-to-Ambient (RθSA):**
```
RθSA = (TS - TA)/PD
```
Where TA: Ambient temperature

**Total Thermal Resistance:**
```
RθJA = RθJC + RθCS + RθSA
TJ = TA + PD·RθJA
```

### Transient Thermal Response
**Thermal Impedance:**
```
Zθ(t) = ΔT(t)/P
```
For pulse power:
```
ΔT(t) = P·[R1·(1-e^(-t/τ1)) + R2·(1-e^(-t/τ2)) + ...]
```
Where:
- Ri: Thermal resistance of ith layer
- τi: Thermal time constant of ith layer (Ri·Ci)

### Thermal Modeling in SPICE
Using thermal-electrical analogy:
- **Temperature** ↔ Voltage
- **Power** ↔ Current
- **Thermal Resistance** ↔ Electrical Resistance
- **Thermal Capacitance** ↔ Electrical Capacitance

**Example RC Network:**
```
* Power dissipation
IPWR 0 POWER DC 1.0

* Thermal resistance to case
RJC  POWER CASE  2.0

* Thermal capacitance of junction
CJ   CASE   0    1.0E-3

* Thermal resistance to heatsink
RCS  CASE   HEATSINK  1.0

* Thermal capacitance of case
CC   HEATSINK 0     2.0E-3

* Thermal resistance to ambient
RSA  HEATSINK 0     5.0

* Ambient temperature
VA   0   AMB   DC  25.0

* Measure junction temperature
.MEAS TRAN TJ MAX V(CASE)
```

## Switching Losses

### Turn-On Losses
**Ideal Switching:**
- Voltage falls to zero before current rises
- Current rises to full value after voltage is zero
- Ideal loss = 0

**Realistic Switching (Inductive Load):**
1. **Delay Period**: VGS rises to VTH, ID begins to rise
2. **Current Rise Period**: ID rises from 0 to IL while VDS ≈ VDD
3. **Voltage Fall Period**: VDS falls from VDD to near 0 while ID ≈ IL
4. **Overlap Period**: Both ID and VDS significant simultaneously

**Turn-On Energy Loss:**
```
EON = ∫ VDS(t)·ID(t) dt  (during switching interval)
```

**Approximation for Linear Waveforms:**
```
EON ≈ ½·VDD·IL·(td + tr)
```
Where:
- td: Delay time
- tr: Rise time

### Turn-Off Losses
Similar to turn-on but with current falling and voltage rising:

**Four Intervals:**
1. **Delay Period**: VGS falls below VTH, ID begins to fall
2. **Current Fall Period**: ID falls from IL to 0 while VDS ≈ 0
3. **Voltage Rise Period**: VDS rises from 0 to VDD while ID ≈ 0
4. **Overlap Period**: Both ID and VSD significant simultaneously

**Turn-Off Energy Loss:**
```
EOFF = ∫ VDS(t)·ID(t) dt  (during switching interval)
```

**Approximation for Linear Waveforms:**
```
EOFF ≈ ½·VDD·IL·(td + tf)
```
Where:
- td: Delay time
- tf: Fall time

### Total Switching Loss
```
PSW = fsw·(EON + EOFF)
```
Where fsw: Switching frequency

### Conduction Losses
**Resistive Loss:**
```
PCOND = ID(rms)²·RDS(on)
```
Where:
- ID(rms): RMS drain current
- RDS(on): On-resistance at operating junction temperature

**Diode Conduction Loss:**
```
PCOND = VF·IF(avg) + RD·IF(rms)²
```
Where:
- VF: Forward voltage
- IF(avg): Average forward current
- RD: Dynamic resistance
- IF(rms): RMS forward current

### Gate Drive Losses
**Energy to Charge/Discharge Gate:**
```
EGATE = ½·Qg·VGS²
```
Where:
- Qg: Total gate charge
- VGS: Gate-source voltage swing

**Gate Drive Power Loss:**
```
PGATE = fsw·EGATE = fsw·½·Qg·VGS²
```

### Body Diode Losses
**Forward Conduction:**
```
PBD = VF·IF(avg) + RD·IF(rms)²
```

**Reverse Recovery Loss:**
```
PRR = fsw·QRR·VDD
```
Where:
- Qrr: Reverse recovery charge
- VDD: Off-state voltage

### Temperature Effects on Losses
- **RDS(on)**: Increases with temperature (approx 0.7%/°C for Si MOSFETs)
- **VF**: Decreases with temperature (approx -2 mV/°C for diodes)
- **Switching Times**: May increase or decrease with temperature depending on mechanism
- **Qrr**: Generally increases with temperature

### Loss Reduction Techniques
1. **Soft Switching**: ZVS (Zero Voltage Switching) or ZCS (Zero Current Switching)
2. **Snubbers**: Reduce voltage/current overlap during switching
3. **Gate Resistance Optimization**: Balance switching speed and ringing
4. **Paralleling Devices**: Share current and power dissipation
5. **Material Selection**: Use SiC or GaN for lower switching losses
6. **Frequency Optimization**: Balance switching vs conduction losses

## Parasitic Effects

### Parasitic Inductance
**Sources:**
- Package inductance (bond wires, leads)
- PCB trace inductance
- Via inductance
- Component lead inductance

**Impact:**
- Voltage spikes during switching: V = L·di/dt
- Ringing with parasitic capacitance
- Increased EMI
- Reduced switching speed

**Typical Values:**
- Bond wire: 1-2 nC/mm
- Package lead: 5-10 nC/mm
- Via (through-hole): 0.5-1 nC
- Via (microvia): 0.1-0.3 nC
- PCB trace: 1-10 nH/cm (depends on width/height)

### Parasitic Capacitance
**Sources:**
- Device capacitances (Cgs, Cgd, Cds)
- PCB trace-to-plane capacitance
- Inter-winding capacitance in magnetics
- Package capacitance

**Impact:**
- Forms LC tank with parasitic inductance → ringing
- Feedback paths → instability
- Smacking effects → increased losses
- High-frequency signal attenuation

**Typical Values:**
- MOSFET Cgs: 1-10 nF (power devices)
- MOSFET Cgd: 0.1-1 nF (Miller capacitance)
- PCB trace-to-plane: 1-5 pF/cm²
- Inter-winding: 1-100 pF (depends on construction)

### Parasitic Resistance
**Sources:**
- Bond wire resistance
- Lead frame resistance
- Die attach resistance
- PCB trace resistance
- Via resistance

**Impact:**
- I²R losses
- Voltage drops
- Thermal issues
- Current sharing imbalance in parallel devices

**Typical Values:**
- Bond wire: 0.5-2 mΩ/mm
- Package lead: 1-5 mΩ/mm
- PCB trace: 0.5-5 mΩ/sq (depends on thickness/width)

### Parasitic Modeling in SPICE
**Parasitic Inductance:**
```
Lpkg  drain  drain_pkg  5nH
Lpkg  source  source_pkg  3nH
Lpkg  gate    gate_pkg    2nH
```

**Parasitic Capacitance:**
```
Cpkg  drain  gate  100pF  (drain-gate coupling)
Cpkg  source  drain  50pF  (source-drain coupling)
Cpkg  gate    source  200pF  (gate-source coupling)
```

**Parasitic Resistance:**
```
Rpkg  drain  drain_pkg  10mOhm
Rpkg  source  source_pkg  5mOhm
Rpkg  gate    gate_pkg    2mOhm
```

### Impact on Switching Waveforms
**Voltage Overshoot:**
```
Vpeak = VDD + Lpar·di/dt
```
Where Lpar: Total parasitic inductance in commutation path

**Ringing Frequency:**
```
f ringing = 1/(2π·√(Lpar·Cpar))
```
Where Cpar: Total parallel capacitance

**Damping:**
```
ζ = Rpar/(2·√(Lpar/Cpar))
```
Where Rpar: Total series resistance

### Mitigation Techniques
1. **Layout Optimization**:
   - Minimize loop areas
   - Use ground planes
   - Place decoupling capacitors close to devices
   - Minimize trace lengths and widths appropriately

2. **Component Selection**:
   - Low-inductance packages (flip-chip, DPAK, etc.)
   - Low-ESR capacitors
   - Properly rated devices

3. **Snubber Circuits**:
   - RC snubber across switch
   - Diode-RC snubber
   - RCD snubber

4. **Gate Resistance**:
   - Series gate resistance to control di/dt
   - Separate turn-on/turn-off gate resistances

5. **Snubberless Techniques**:
   - Active clamping
   - Resonant switching
   - Soft switching techniques

## Control Theory Basics

### Feedback Control Systems
**Basic Block Diagram:**
```
Reference --> [Controller] --> [Plant] --> Output
                                   ↑          ↓
                                   --------[Feedback Sensor]-------
```

**Closed-Loop Transfer Function:**
```
T(s) = Gc(s)·Gp(s) / [1 + Gc(s)·Gp(s)·H(s)]
```
Where:
- Gc(s): Controller transfer function
- Gp(s): Plant transfer function
- H(s): Feedback sensor transfer function

### PID Controller
**Transfer Function:**
```
Gc(s) = Kp + Ki/s + Kd·s
```
Where:
- Kp: Proportional gain
- Ki: Integral gain
- Kd: Derivative gain

**Time Domain:**
```
u(t) = Kp·e(t) + Ki·∫e(τ)dτ + Kd·de(t)/dt
```
Where:
- e(t): Error signal (reference - output)

### Ziegler-Nichols Tuning Methods
**Step Response Method:**
1. Apply step input to open-loop system
2. Determine lag time (L) and time constant (T)
3. Set parameters:
   - P-only: Kp = T/L
   - PI: Kp = 0.9T/L, Ki = 0.27/T
   - PID: Kp = 1.2T/L, Ki = 0.6/T, Kd = 0.3L

**Ultimate Sensitivity Method:**
1. Increase gain until sustained oscillations
2. Record ultimate gain (Ku) and period (Pu)
3. Set parameters:
   - P-only: Kp = 0.5Ku
   - PI: Kp = 0.45Ku, Ki = 1.2Kp/Pu
   - PID: Kp = 0.6Ku, Ki = 2Kp/Pu, Kd = Kp·Pd/8

### Stability Analysis
**Bode Plot Criteria:**
- **Gain Margin**: Amount gain can increase before instability (at -180° phase)
- **Phase Margin**: Amount phase can lag before instability (at 0dB gain)
- **Desired**: GM > 6dB, PM > 45°

**Nyquist Criterion:**
- Plot G(s)H(s) in complex plane
- Count encirlements of (-1,0) point
- Z = P - N (zeros = poles - encirclements)
- System stable if Z = 0

**Root Locus:**
- Plot roots of 1+KG(s)H(s)=0 as K varies
- Shows how poles move with gain
- Used to design compensators

### Compensator Types
**Lead Compensator:**
```
Gc(s) = K·(s+a)/(s+b)  where b > a
```
- Provides phase lead
- Increases bandwidth
- Improves transient response

**Lag Compensator:**
```
Gc(s) = K·(s+a)/(s+b)  where b < a
```
- Provides phase lag
- Improves steady-state accuracy
- Reduces bandwidth

**Lead-Lag Compensator:**
```
Gc(s) = K·(s+a1)(s+a2)/[(s+b1)(s+b2)]
```
- Combines benefits of lead and lag
- Can meet both transient and steady-state requirements

### Digital Control
**Z-Transform:**
```
Z{f[n]} = F(z) = Σ f[n]·z^-n
```

**Common Discretization Methods:**
- **Forward Euler**: s = (z-1)/T
- **Backward Euler**: s = (z-1)/(z·T)
- **Tustin (Bilinear)**: s = (2/T)·(z-1)/(z+1)
- **Matched Pole-Zero**: Map s-plane poles/zeros to z-plane

**PID in Digital Form:**
```
u[k] = Kp·e[k] + Ki·T·Σe[i] + Kd·(e[k]-e[k-1])/T
```
Where T: Sampling period

### Current Mode Control
**Advantages Over Voltage Mode:**
- Automatic input voltage feedforward
- Cycle-by-cycle current limiting
- Simplified compensation
- Better transient response

**Types:**
- **Peak Current Mode**: Controls peak inductor current
- **Average Current Mode**: Controls average inductor current
- **Hysteretic (Bang-Bang) Control**: Switches when current crosses boundaries

**Slope Compensation:**
Needed for duty cycles > 50% in peak current mode to prevent subharmonic oscillation:
```
mc ≥ ½·mi·(2D-1)
```
Where:
- mc: Compensation slope
- mi: Inductor current upslope
- D: Duty cycle

### Voltage Mode Control
**Simple Implementation:**
- Compares output voltage to reference
- Uses PWM generator to set duty cycle

**Disadvantages:**
- No inherent current limiting
- Requires more complex compensation
- Slower transient response
- Sensitive to input voltage variations

### Hysteretic Control
**Operation:**
- Switch ON when output < lower threshold
- Switch OFF when output > upper threshold
- Frequency varies with load and input

**Advantages:**
- Excellent transient response
- Simple implementation
- Naturally current-limited

**Disadvantages:**
- Variable switching frequency
- Can enter chaotic operation
- Difficult to synchronize

## Numerical Methods in SPICE

### Matrix Formulation
SPICE uses Modified Nodal Analysis (MNA):
```
[G]·[v] + [C]·d[v]/dt = [i]
```
Where:
- [G]: Conductance matrix
- [C]: Capacitance matrix
- [v]: Node voltage vector
- [i]: Current source vector

### Linear Multistep Methods
**Trapezoidal Rule (Trap):**
```
x[n] = x[n-1] + (h/2)·[f(x[n]) + f(x[n-1])]
```
- Second order accurate
- A-stable (good for stiff systems)
- Can cause ringing

**Gear (Backward Difference):**
```
x[n] = x[n-1] + h·f(x[n])
```
- First order accurate
- L-stable (excellent for stiff systems)
- More damping than trap

### Gear vs Trapezoidal Selection
**Use Trapezoidal When:**
- Smooth waveforms desired
- Low distortion required
- Moderate stiffness
- Energy conservation important

**Use Gear When:**
- Stiff circuits (wide time constant ratios)
- Strong nonlinearities
- Convergence problems with trap
- DC operating point accuracy paramount

### Integration Error Control
**Local Truncation Error (LTE):**
Error introduced in each integration step

**Error per Step:**
```
EPS = |x[n] - x_exact[n]|
```

**Adaptive Stepping:**
- Adjust step size to keep LTE below tolerance
- Smaller steps for rapidly changing signals
- Larger steps for slowly varying signals

**Tolerances:**
- **ABSTOL**: Absolute current error tolerance (default 1e-12 A)
- **RELTOL**: Relative error tolerance (default 0.001)
- **VNTOL**: Absolute voltage error tolerance (default 1e-6 V)

### Convergence Techniques
**Gmin (Conductance Flooring):**
- Adds small conductance (default 1e-12) from each node to ground
- Helps with convergence in cutoff regions

**Source Stepping:**
- Ramps up sources from zero to final value
- Helps with convergence of circuits with feedback

**DI (Source Diagonalization):**
- Adds diagonal terms to conductance matrix
- Improves matrix conditioning

**PIO (-Pivot Insertion Optimization):**
- Improves pivot selection in matrix solution

### Time Step Control
**Maximum Step Size:**
- Limited by .TRAN statement
- Can be overridden by .OPTIONS MAXSTEP

**Minimum Step Size:**
- Limited by numerical precision
- Can be overridden by .OPTIONS MINSTEP

**Initial Step Size:**
- Often determined by circuit time constants
- Can be set with .OPTIONS DELTA

### Accuracy vs Speed Tradeoffs
**Faster Simulation:**
- Looser tolerances (higher ABSTOL, RELTOL)
- Larger minimum step size
- Use Gear instead of Trapezoidal
- Higher integration order (if available)

**More Accurate Simulation:**
- Tighter tolerances
- Smaller minimum step size
- Use Trapezoidal instead of Gear
- Lower integration formulas
- Verify with mesh refinement (smaller tolerances)

## Validation Techniques

### Component-Level Validation
**DC Characteristics:**
- Measure ID vs VGS for MOSFETs
- Measure IC vs VBE for BJTs
- Measure IF vs VF for diodes
- Compare to simulation

**AC Characteristics:**
- Measure Cgs, Cgd, Cdss vs voltages
- Measure input/output impedance
- Compare to simulation

**Switching Characteristics:**
- Measure turn-on/off times
- Measure reverse recovery
- Compare to simulation

### Circuit-Level Validation
**Waveform Comparison:**
- Capture oscilloscope traces
- Align in time (use triggering or cross-correlation)
- Compare amplitude, shape, timing
- Calculate RMS error or correlation coefficient

**Frequency Response:**
- Measure gain/phase vs frequency
- Compare Bode plots
- Check bandwidth, gain margin, phase margin

**Efficiency Measurement:**
- Measure input and output power
- Calculate efficiency: η = Pout/Pin × 100%
- Compare to simulation
- Break down losses by component

### System-Level Validation
**Thermal Validation:**
- Measure junction temperature (IR camera, thermocouple)
- Compare to thermal simulation
- Validate thermal model and power dissipation

**EMI Validation:**
- Conducted emissions (LISN measurement)
- Radiated emissions (antenna/spectrometer)
- Compare to parasitic extraction predictions

**Reliability Validation:**
- Accelerated life testing
- Compare failure rates to physics-of-failure models
- Validate thermal cycling, humidity bias, etc.

### Validation Metrics
**Normalized Root Mean Square Error (NRMSE):**
```
NRMSE = RMSE / (ymax - ymin)
```
Where RMSE = √[Σ(ysim - ymeas)²/N]

**Coefficient of Determination (R²):**
```
R² = 1 - [Σ(ysim - ymeas)² / Σ(ymeas - ȳ)²]
```
Where ȳ: Mean of measured values

**Mean Absolute Percentage Error (MAPE):**
```
MAPE = (100%/N) · Σ|(ysim - ymeas)/ymeas|
```

**Maximum Absolute Error (MaxAE):**
```
MaxAE = max|ysim - ymeas|
```

### Validation Procedure
1. **Define Test Conditions**: Specify input, load, temperature, etc.
2. **Prepare Test Circuit**: Build physical circuit matching simulation
3. **Instrumentation**: Set up measurement equipment properly
4. **Baseline Measurement**: Measure key parameters at room temp
5. **Temperature Sweep**: Measure at multiple temperatures if relevant
6. **Operating Range**: Test across expected input/load range
7. **Transient Response**: Measure switching waveforms
8. **Steady-State**: Measure DC operating points
9. **Frequency Response**: Measure AC characteristics if applicable
10. **Compare Results**: Use validation metrics to quantify agreement
11. **Analyze Discrepancies**: Identify sources of error
12. **Improve Models**: Adjust parameters or models as needed
13. **Re-validate**: Repeat tests to confirm improvements

### Sources of Discrepancy
1. **Model Inaccuracies**: Parameters not matching actual device
2. **Parasitic Omissions**: Missing layout or package parasitics
3. **Measurement Errors**: Probe loading, bandwidth limitations, calibration
4. **Environmental Differences**: Temperature, humidity, aging
5. **Numerical Errors**: Integration errors, convergence issues
6. **Component Variations**: Tolerances, drift, lot-to-lot variations
7. **Model Limitations**: Assumptions in model that don't hold

### Continuous Improvement
1. **Benchmark Suite**: Maintain set of validation circuits
2. **Regression Testing**: Run benchmarks when models change
3. **Version Control**: Track model and parameter changes
4. **Documentation**: Record validation results and methods
5. **Community Feedback**: Share validation data with users
6. **Manufacturer Updates**: Incorporate new models from vendors
7. **State-of-the-Art**: Stay current with modeling techniques

## Conclusion

This document has provided the theoretical foundation for understanding and using the power electronics simulation suite. By understanding the underlying physics, device operation, circuit behavior, and numerical methods, users can:

1. **Select appropriate models** for their specific applications
2. **Interpret simulation results** correctly in context of theory
3. **Identify limitations** of simulations and when to supplement with measurement
4. **Improve simulation accuracy** through better model selection and parameter extraction
5. **Design more effectively** by leveraging theoretical insights
6. **Troubleshoot simulation issues** by understanding the underlying mathematics

The combination of solid theoretical understanding and practical simulation skills enables engineers to predict circuit behavior accurately, optimize designs efficiently, and reduce reliance on costly prototype iterations.

For further study, consult the references listed in the individual model documentation and the seminal texts in semiconductor device physics, power electronics, and circuit simulation.

*This document is intended to complement the practical guides and model documentation provided elsewhere in this repository.*