# Component Model Library Reference

## Overview

This document provides a comprehensive reference to the component models available in the NGSpice power electronics simulation suite. It includes information on semiconductor devices, passive components, and specialized models, along with their locations, key parameters, and usage guidelines.

## Table of Contents
1. [Library Structure](#library-structure)
2. [Semiconductor Models](#semiconductor-models)
3. [Passive Component Models](#passive-component-models)
4. [Specialized Models](#specialized-models)
5. [Model Usage Guidelines](#model-usage-guidelines)
6. [Parameter Extraction](#parameter-extraction)
7. [Temperature Modeling](#temperature-modeling)
8. [Validation and References](#validation-and-references)

---

## Library Structure

The model library is organized by component type in the `models/` directory:

```
models/
├── analog_ic/          # Operational amplifiers, voltage references, etc.
├── bjt/                # Bipolar junction transistors
├── capacitors/         # Capacitors with ESR/ESL modeling
├── diodes/             # Diodes (standard, Schottky, Zener, etc.)
├── drivers/            # Gate driver ICs and transistors
├── igbt/               # Insulated gate bipolar transistors
├── inductors/          # Inductors and transformers
├── jfet/               # Junction field-effect transistors
├── logic_ic/           # Logic gates and digital ICs
├── mosfets/            # Metal-oxide-semiconductor field-effect transistors
├── passive/            # Resistors, potentiometers, and passive networks
└── custom_subcircuits/ # User-defined and specialized subcircuits
```

Each subdirectory contains:
- `.lib` files: SPICE model libraries
- `.sub` files: Subcircuit definitions
- README files: Documentation specific to the component type
- Datasheets: Manufacturer documentation (where available)

## Semiconductor Models

### MOSFET Models (`models/mosfets/`)

#### Built-in SPICE Models
- **Level 1**: Basic Shichman-Hodges model
- **Level 2**: Improved MOS model with bulk charge effects
- **Level 3**: Semi-empirical model (most commonly used for power MOSFETs)

#### Vendor-Specific Models

**IRF Series**:
- IRF640N: 200V, 18A, N-channel MOSFET
- IRF640NS: 200V, 18A, N-channel MOSFET (low gate charge)
- IRFP240N: 200V, 20A, N-channel MOSFET
- IRFP260N: 200V, 25A, N-channel MOSFET
- IRFZ44N: 55V, 49A, N-channel MOSFET
- IRF9540: -200V, -13A, P-channel MOSFET
- IRF9640: -200V, -12A, P-channel MOSFET

**ON Semiconductor Models**:
- NTD5867NL: 60V, 58A, N-channel MOSFET (low Qg)
- NTD5869NL: 60V, 65A, N-channel MOSFET (ultra-low Qg)
- NTD5410NL: 40V, 100A, N-channel MOSFET

**Vishay Models**:
- SiHF8600: 30V, 120A, N-channel MOSFET (low Rds(on))
- SiH420: 200V, 9A, N-channel MOSFET
- SiH440: 200V, 18A, N-channel MOSFET

**Toshiba Models**:
- TK6A60D: 600V, 6A, N-channel MOSFET
- TK35E20N1: 200V, 35A, N-channel MOSFET

#### Key MOSFET Parameters
| Parameter | Description | Typical Units | Importance |
|-----------|-------------|---------------|------------|
| VTO | Zero-bias threshold voltage | V | Determines turn-on voltage |
| B | Doping gradient | 1/V | Affects Vth temperature dependence |
| TOX | Oxide thickness | m | Influences gate capacitance |
| KP | Transconductance parameter | A/V² | Related to Rds(on) |
| GAMMA | Body effect threshold | V^1/2 | Affects Vth with Vbs |
| PHI | Surface potential | V | Affects weak inversion |
| L | Channel length | m | Affects short-channel effects |
| WD | Channel width diffusion | m | Affects effective width |
| NSUB | Substrate doping | 1/cm³ | Affects body effect |
| NSS | Surface state density | 1/cm² | Affects threshold voltage |
| NFSS | Fast surface state density | 1/cm² | Affects high-frequency behavior |
| TGATE | Gate oxide thickness | m | Influences Cgs/Cgd |
| LD | Lateral diffusion | m | Affects short-channel effects |
| UO | Surface mobility | cm²/Vs | Affects transconductance |
| UCRIT | Critical field for mobility degradation | V/cm | Affects high-field behavior |
| UEXP | Critical field exponent | - | Affects mobility modeling |
| UTRA | Transverse field coefficient | m/V | Affects mobility with Vgs |
| VMAX | Maximum drift velocity of carriers | m/s | Affects high-frequency behavior |
| XJ | Junction depth | m | Affects capacitance |
| LD | Lateral diffusion | m | Affects capacitance |
| NSUB | Substrate doping | 1/cm³ | Affects capacitance |
| NSS | Surface state density | 1/cm² | Affects capacitance |
| NFS | Fast surface state density | 1/cm² | Affects capacitance |
| TPG | Type of gate material | - | Affects work function difference |
| XQC | Charge due to monolayer | - | Affects threshold voltage |
| CGSO | Gate-source overlap capacitance per meter | F/m | Affects Cgs |
| CGDO | Gate-drain overlap capacitance per meter | F/m | Affects Cgd |
| CGBO | Gate-bulk overlap capacitance per meter | F/m | Affects Cgb |
| RDSO | Drain-source shunt resistance | Ω | Affects output resistance |
| CSB | Zero-bias bulk junction capacitance | F | Affects Cbd |
| CBD | Zero-bias bulk junction capacitance | F | Affects Cbs |
| PBS | Bulk junction potential | V | Affects capacitance with Vbs |
| PBD | Bulk junction potential | V | Affects capacitance with Vbd |
| CJ | Zero-bias junction capacitance | F | Affects Cbd/Cbs |
| MJ | Junction grading coefficient | - | Affects capacitance with Vds/Vbs |
| CJSW | Zero-bias sidewall junction capacitance | F/m | Affects capacitance |
| MJSW | Sidewall junction grading coefficient | - | Affects capacitance with Vds/Vbs |
| PB | Bulk junction potential | V | Affects capacitance |
| FC | Forward bias switch coefficient | - | Affects capacitance modeling |
| TT | Transit time | s | Affects charge storage |
| RD | Resistance per square | Ω/□ | Affects series resistance |
| RS | Source resistance | Ω | Affects input resistance |
| RD | Drain resistance | Ω | Affects output resistance |
| RSH | Drain and source diffusion sheet resistance | Ω/□ | Affects parasitic resistance |

#### MOSFET Modeling Notes
- **Temperature Dependence**: Most models include VTO(T), BETA(T), and UO(T) parameters
- **Parasitics**: RGATE, RS, RD, RDSO, CBD, CBS, CGSO, CGDO, CGBO model parasitics
- **Capacitance Modeling**: CGS, CGD, CGB modeled as nonlinear functions of voltages
- **Breakdown Modeling**: BVdss models drain-source breakdown voltage

### Diode Models (`models/diodes/`)

#### Standard Diodes
- **1N4148**: 100V, 300mA, Fast switching diode
- **1N4001-1N4007**: 50V-1000V, 1A, General purpose rectifier
- **1N5400-1N5408**: 50V-1000V, 3A, General purpose rectifier

#### Schottky Diodes
- **1N5817-1N5819**: 20V-40V, 1A, Low Vf Schottky
- **SS12-SS15**: 20V-40V, 1A, Surface mount Schottky
- **SB320-SB360**: 20V-60V, 3A, Schottky rectifier
- **C3D Series**: SiC Schottky diodes (C3D06060A, C3D10060A, etc.)

#### Fast Recovery Diodes
- **MUR105-MUR1620C**: 50V-200V, 1A, Ultrafast recovery
- **MUR410-MUR4200EG**: 100V-200V, 4A, Ultrafast recovery
- **UF4001-UF4007**: 50V-1000V, 1A, Ultrafast recovery

#### Zener Diodes
- **BZX84 Series**: 2.4V-75V, 200mA, Voltage regulators
- **1N4728A-1N4764A**: 1.8V-100V, 1W, Voltage regulators
- **1N5908B-1N5956B**: 2.4V-39V, 3W, Voltage regulators

#### Key Diode Parameters
| Parameter | Description | Typical Units | Importance |
|-----------|-------------|---------------|------------|
| IS | Saturation current | A | Determines leakage current |
| N | Emission coefficient | - | Ideality factor |
| BV | Reverse breakdown voltage | V | Zener or avalanche voltage |
| IBV | Current at breakdown voltage | A | Tests sharpness of breakdown |
| VJ | Junction potential | V | Affects capacitance |
| M | Grading coefficient | - | Affects capacitance with voltage |
| CJO | Zero-bias junction capacitance | F | Affects switching speed |
| VJ | Junction potential | V | Affects capacitance |
| M | Grading coefficient | - | Affects capacitance with voltage |
| FC | Forward bias switch coefficient | - | Affects capacitance modeling |
| TT | Transit time | s | Affects reverse recovery |
| XTI | Saturation current temperature exponent | - | Affects IS with temperature |
| EG | Energy gap | eV | Affects IS with temperature |
| XTB | Forward bias temperature exponent | - | Affects PTAT with temperature |

#### Diode Modeling Notes
- **Reverse Recovery**: Modeled using TT (transit time) and charge storage parameters
- **Capacitance**: CJO, VJ, M model nonlinear junction capacitance
- **Temperature Effects**: IS, EG, XTI, XTB model temperature dependence
- **Series Resistance**: RS models parasitic resistance
- **Breakdown**: BV, IBV model avalanche or Zener breakdown

### BJT Models (`models/bjt/`)

#### General Purpose Transistors
- **2N2222**: 40V, 0.6A, NPN switch/amplifier
- **2N3904**: 40V, 0.2A, NPN switch/amplifier
- **2N3906**: -40V, -0.2A, PNP switch/amplifier
- **2N2907**: -60V, -0.6A, PNP switch/amplifier

#### Power Transistors
- **TIP29-TIP32**: 40V-100V, 1A-3A, NPN/PNP power
- **TIP41-TIP42**: 40V-100V, 6A, NPN/PNP power
- **TIP120-TIP122**: 60V-100V, 2A-5A, Darlington pairs
- **TIP31-TIP34**: 40V-100V, 3A, NPN/PNP power
- **TIP48-TIP50**: 80V-150V, 3A, NPN/PNP power

#### Key BJT Parameters
| Parameter | Description | Typical Units | Importance |
|-----------|-------------|---------------|------------|
| IS | Saturation current | A | Determines forward characteristics |
| BF | Ideal maximum forward beta | - | Affects DC gain |
| NF | Forward emission coefficient | - | Affects forward characteristics |
| VAF | Early voltage | V | Affects output characteristics |
| IKF | Corner for forward beta high current roll-off | A | Affects gain at high current |
| ISE | B-E leakage saturation current | A | Affects leakage |
| NE | B-E leakage emission coefficient | - | Affects leakage characteristics |
| BR | Ideal maximum reverse beta | - | Affects reverse characteristics |
| NR | Reverse emission coefficient | - | Affects reverse characteristics |
| VAR | Early voltage | V | Affects reverse output characteristics |
| IKR | Corner for reverse beta high current roll-off | A | Affects reverse gain at high current |
| ISC | B-C leakage saturation current | A | Affects leakage |
| NC | B-C leakage emission coefficient | - | Affects reverse leakage characteristics |
| RB | Base zero bias resistance | Ω | Affects input characteristics |
| IRB | Current for base resistance halfway roll-off | A | Affects resistance modulation |
| RBM | Minimum base resistance | Ω | Affects input resistance at high current |
| RE | Emitter resistance | Ω | Affects emitter characteristics |
| RC | Collector resistance | Ω | Affects collector characteristics |
| CJE | B-E zero-bias capacitance | F | Affects input capacitance |
| VJE | B-E built-in potential | V | Affects capacitance |
| MJE | B-E junction exponential | - | Affects capacitance with voltage |
| CJC | B-C zero-bias capacitance | F | Affects feedback capacitance |
| VJC | B-C built-in potential | V | Affects capacitance |
| MJC | B-C junction exponential | - | Affects capacitance with voltage |
| XCJB | Fraction of B-C capacitance connected to internal base node | - | Affects capacitance partitioning |
| TF | Ideal forward transit time | s | Affects switching speed |
| XTF | Coefficient for bias dependence of TF | - | Affects TF with Vbc |
| VTF | Voltage describing Vbc dependence of TF | V | Affects TF with Vbc |
| ITF | High current parameter for TF | A | Affects TF at high current |
| PTF | Excess phase at frequency 1/(TF*2π) Hz | deg | Affects high-frequency response |
| TR | Ideal reverse transit time | s | Affects reverse switching speed |

#### BJT Modeling Notes
- **DC Characteristics**: Modeled using Gummel-Poon equations
- **AC Characteristics**: CJC, CJE, VJE, VJC, MJC, MJE model capacitances
- **Temperature Effects**: IS, EG, XTI model temperature dependence
- **Breakdown**: BVCEO, BVCES, BVEBO model breakdown voltages
- **Saturation**: VBE(sat), VCE(sat) model saturation characteristics

### IGBT Models (`models/igbt/`)

#### Available Models
- **MG50Q2YS20**: 600V, 50A, IGBT with soft recovery antiparallel diode
- **MG75Q2YS20**: 600V, 75A, IGBT with soft recovery antiparallel diode
- **MG100Q2YS20**: 600V, 100A, IGBT with soft recovery antiparallel diode
- **GF20T65AD**: 650V, 20A, IGBT with fast recovery antiparallel diode
- **GF30T65AD**: 650V, 30A, IGBT with fast recovery antiparallel diode

#### Key IGBT Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| VGE(th) | Gate-emitter threshold voltage | V |
| VCE(sat) | Collector-emitter saturation voltage | V |
| IC | Continuous collector current | A |
| ICM | Pulsed collector current | A |
| VCES | Collector-emitter voltage | V |
| VGES | Gate-emitter voltage | V |
| tON | Turn-on time | s |
| tOFF | Turn-off time | s |
| tRISE | Rise time | s |
| tFALL | Fall time | s |
| tD(ON) | Turn-on delay time | s |
| tD(OFF) | Turn-off delay time | s |
| EON | Turn-on switching energy | J |
- EOFF | Turn-off switching energy | J |
- ERR | Reverse recovery energy | J |
- QG | Total gate charge | C |
- QGE | Gate-emitter charge | C |
- QGC | Gate-collector charge | C |

#### IGBT Modeling Notes
- **Static Characteristics**: Modeled using modified SPICE Level 3 MOSFET equations
- **Dynamic Characteristics**: Include switching losses and recovery behavior
- **Temperature Dependence**: VGE(th), VCE(sat) modeled with temperature coefficients
- **Short Circuit Robustness**: Included in advanced models

## Passive Component Models

### Capacitor Models (`models/capacitors/`)

#### Electrolytic Capacitors
- **Standard Aluminum Electrolytic**: High capacitance, high ESR
- **Low-ESR Aluminum Electrolytic**: Reduced ESR for switching applications
- **Solid Tantalum**: Stable capacitance, lower ESR than wet tantalum
- **Wet Tantalum**: High capacitance, stable over temperature

#### Ceramic Capacitors
- **C0G/NP0**: Stable, low loss, temperature compensating
- **X7R**: Stable capacitance over temperature range
- **Y5V**: High volumetric efficiency, poorer stability
- **Z5U**: Very high volumetric efficiency, poor temperature stability

#### Film Capacitors
- **Polypropylene (PP)**: Low loss, high insulation resistance
- **Polyester (PET)**: Good balance of properties
- **Polyphenylene Sulfide (PPS)**: High temperature capability
- **Polycarbonate (PC)**: Stable properties, moderate cost

#### Key Capacitor Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| CAP | Nominal capacitance | F |
| ESR | Equivalent series resistance | Ω |
| ESL | Equivalent series inductance | H |
| VMAX | Maximum working voltage | V |
| TOL | Tolerance | % |
| TC | Temperature coefficient | ppm/°C |
| DF | Dissipation factor at 1kHz | - |
| IR | Insulation resistance | Ω |
| LC | Leakage current | A |

#### Capacitor Modeling Notes
- **Frequency Dependence**: ESR and ESL modeled as frequency-dependent
- **Voltage Coefficient**: Capacitance changes with applied voltage (especially ceramics)
- **Temperature Effects**: Capacitance and ESR vary with temperature
- **Aging**: Particularly relevant for electrolytic capacitors
- **Ripple Current Rating**: Important for power applications

### Inductor and Transformer Models (`models/inductors/`)

#### Power Inductors
- **Ferrite Core**: High permeability, suitable for <1MHz
- **Powdered Iron Core**: Soft saturation, good for DC bias
- **Laminated Steel Core**: Used in line-frequency applications
- **Air Core**: Low inductance, no saturation

#### Transformers
- **Isolation Transformers**: Provide galvanic isolation
- **Current Transformers**: For sensing applications
- **Gate Drive Transformers**: Include interwinding capacitance modeling
- **Toroidal Transformers**: Low leakage, high efficiency

#### Key Inductor Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| INDUCTANCE | Nominal inductance | H |
| TURNS | Number of turns (for coupled inductors) | - |
| RDC | DC resistance | Ω |
| FREQ | Frequency for inductance measurement | Hz |
| IDC | DC current rating | A |
| IRMS | RMS current rating | A |
| ISAT | Saturation current | A |
| SRF | Self-resonant frequency | Hz |
| Q | Quality factor | - |
| CORE_LOSS | Core loss at specified frequency and flux density | W/cm³ |

#### Key Transformer Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| L1, L2 | Primary and secondary inductance | H |
| MUTUAL | Mutual inductance | H |
| K | Coupling coefficient (0-1) | - |
| R1, R2 | Primary and secondary resistance | Ω |
| C1, C2 | Primary and secondary capacitance | F |
| C12 | Interwinding capacitance | F |
| TURNS_RATIO | N2/N1 | - |
| VOLTAGE_RATIO | V2/V1 | V/V |
| CURRENT_RATIO | I2/I1 | A/A |
| POWER_RATING | Maximum power handling | VA |

#### Inductor Modeling Notes
- **Saturation Modeling**: Inductance decreases with current
- **Core Loss**: Hysteresis and eddy current losses modeled
- **AC Resistance**: Skin and proximity effects increase resistance with frequency
- **Parasitic Capacitance**: Between turns and layers affects SRF
- **Leakage Inductance**: Important for switching applications

### Resistor Models (`models/passive/`)

#### Standard Resistors
- **Carbon Film**: General purpose, moderate stability
- **Metal Film**: High stability, low noise
- **Metal Oxide**: High surge capability
- **Wirewound**: High power handling, inductive at high frequency

#### Specialty Resistors
- **Current Sense**: Low value, high precision, low TCR
- **High Voltage**: Series string construction for high voltage
- **Thermistors**: NTC and PTC for temperature sensing
- **Varistors**: Voltage-dependent resistance for surge protection

#### Key Resistor Parameters
| Parameter | Description | Typical Units |
|-----------|-------------|---------------|
| RESISTANCE | Nominal resistance | Ω |
| POWER | Power rating | W |
| TOLERANCE | Resistance tolerance | % |
| TCR | Temperature coefficient of resistance | ppm/°C |
| VMAX | Maximum working voltage | V |
| IMAX | Maximum continuous current | A |
| L | Inductance (parasitic) | H |
| C | Capacitance (parasitic) | F |

#### Resistor Modeling Notes
- **Temperature Dependence**: R(T) = R0[1 + TCR(T-T0)]
- **Voltage Coefficient**: Some resistors change resistance with applied voltage
- **Frequency Dependence**: Skin and proximity effects increase effective resistance
- **Excess Noise**: Particularly relevant for carbon composition resistors
- **Surge Capability**: Important for protection applications

## Specialized Models

### Operational Amplifiers (`models/analog_ic/`)
- **LM741**: General purpose op-amp
- **LM358**: Dual low-power op-amp
- **LM324**: Quad low-power op-amp
- **TL082**: Dual JFET-input op-amp
- **OPA2134**: Dual precision op-amp
- **LT1012**: Precision low-offset op-amp
- **AD822**: Dual instrumentation op-amp

### Logic ICs (`models/logic_ic/`)
- **74HC00**: Quad 2-input NAND gate
- **74HC02**: Quad 2-input NOR gate
- **74HC04**: Hex inverter
- **74HC08**: Quad 2-input AND gate
- **74HC14**: Hex Schmitt-trigger inverter
- **74HC86**: Quad 2-input XOR gate
- **74HC132**: Quad 2-input Schmitt-trigger NAND gate
- **74HC138**: 3-to-8 line decoder/demultiplexer
- **74HC164**: 8-bit serial-in/parallel-out shift register
- **74HC165**: 8-bit parallel-in/serial-out shift register
- **74HC193**: 4-bit synchronous up/down counter
- **74HC240**: Octal bus buffer (inverting)
- **74HC244**: Octal bus buffer (non-inverting)
- **74HC245**: Octal bus transceiver
- **74HC373**: Octal D-type latch
- **74HC374**: Octal D-type flip-flop
- **74HC541**: Octal bus buffer (non-inverting)
- **74HC573**: Octal D-type latch
- **74HC574**: Octal D-type flip-flop
- **74HC595**: 8-bit serial-in/parallel-out shift register
- **74HC596**: 8-bit serial-in/parallel-out shift register
- **74HC640**: Octal bus transceiver (inverting)
- **74HC645**: Octal bus transceiver (non-inverting)
- **74HC688**: 8-bit equality comparator

### Gate Drivers (`models/drivers/`)
- **TC4420/TC4421/TC4422**: Dual MOSFET drivers
- **TC4424/TC4425/TC4426**: Dual MOSFET drivers
- **IR2110/IR2111**: High and low side drivers
- **IR2113**: High speed high and low side driver
- **IR2184**: Half-bridge driver with shutdown
- **IR2184S**: Half-bridge driver with shutdown and fault reporting
- **UCC27211**: Dual high-speed MOSFET driver
- **UCC27321**: Dual high-speed MOSFET driver
- **UCC27323**: Dual high-speed MOSFET driver
- **UCC27324**: Dual high-speed MOSFET driver
- **UCC27325**: Dual high-speed MOSFET driver
- **UCC27326**: Dual high-speed MOSFET driver
- **UCC27327**: Dual high-speed MOSFET driver
- **UCC27328**: Dual high-speed MOSFET driver
- **UCC27329**: Dual high-speed MOSFET driver
- **UCC27330**: Dual high-speed MOSFET driver
- **UCC27331**: Dual high-speed MOSFET driver
- **UCC27332**: Dual high-speed MOSFET driver

### Voltage References (`models/analog_ic/`)
- **LM336**: 2.5V voltage reference
- **LM385**: 1.2V-2.5V voltage reference
- **LM4040**: Precision shunt voltage reference
- **REF191**: Low-noise voltage reference
- **REF192**: Low-noise voltage reference
- **REF193**: Low-noise voltage reference
- **REF194**: Low-noise voltage reference
- **REF195**: Low-noise voltage reference
- **REF196**: Low-noise voltage reference
- **REF197**: Low-noise voltage reference
- **REF198**: Low-noise voltage reference
- **REF199**: Low-noise voltage reference
- **REF200**: Dual current source
- **REF201**: Dual current source
- **REF202**: Dual current source
- **REF203**: Dual current source
- **REF300**: Precision low-noise voltage reference
- **REF301**: Precision low-noise voltage reference
- **REF302**: Precision low-noise voltage reference
- **REF303**: Precision low-noise voltage reference
- **REF304**: Precision low-noise voltage reference
- **REF305**: Precision low-noise voltage reference
- **REF306**: Precision low-noise voltage reference
- **REF307**: Precision low-noise voltage reference
- **REF308**: Precision low-noise voltage reference
- **REF309**: Precision low-noise voltage reference
- **REF310**: Precision low-noise voltage reference
- **REF311**: Precision low-noise voltage reference
- **REF312**: Precision low-noise voltage reference
- **REF313**: Precision low-noise voltage reference
- **REF314**: Precision low-noise voltage reference
- **REF315**: Precision low-noise voltage reference
- **REF316**: Precision low-noise voltage reference
- **REF317**: Precision low-noise voltage reference
- **REF318**: Precision low-noise voltage reference
- **REF319**: Precision low-noise voltage reference
- **REF320**: Precision low-noise voltage reference

## Model Usage Guidelines

### Selecting the Appropriate Model
1. **Application Requirements**: Consider voltage, current, frequency, and switching speed
2. **Accuracy Needs**: Determine if datasheet-level accuracy is required or if generic models suffice
3. **Simulation Time**: More detailed models increase simulation time
4. **Convergence**: Simpler models often converge more easily
5. **Availability**: Use models that are actually present in the library

### Model Instantiation
```spice
* MOSFET Example
M1  drain gate source body IRF640N L=100n W=10u

* Diode Example
D1  anode cathode 1N4148

* BJT Example
Q1  collector base emitter 2N2222

* Capacitor Example
C1  node1 node2 10uF

* Inductor Example
L1  node1 node2 100uH

* Resistor Example
R1  node1 node2 100
```

### Including Model Libraries
```spice
* Correct way to include libraries (relative paths)
.lib "./models/mosfets/irf.lib"
.lib "./models/diodes/standard.lib"
.lib "./models/bjt/bjt.lib"
.lib "./models/capacitors/capacitors.lib"
.lib "./models/inductors/inductors.lib"
.lib "./models/passive/resistors.lib"
.lib "./models/analog_ic/opamps.lib"
.lib "./models/logic_ic/74hc.lib"
.lib "./models/drivers/tc4420.lib"
```

### Common Mistakes to Avoid
1. **Incorrect Paths**: Using absolute paths or wrong relative paths
2. **Case Sensitivity**: Linux filesystems are case-sensitive
3. **Missing Models**: Referencing models that don't exist in the included libraries
4. **Parameter Conflicts**: Specifying parameters that conflict with model parameters
5. **Outdated Models**: Using models that don't reflect current technology

### Parameter Verification
1. **Check Datasheets**: Verify key parameters against manufacturer datasheets
2. **Units Consistency**: Ensure all parameters use consistent units
3. **Reasonable Values**: Values should be within expected ranges for the component type
4. **Temperature Coefficients**: Verify that temperature modeling is appropriate for your application
5. **Parasitics**: Ensure parasitic elements (ESR, ESL, etc.) are included where significant

## Parameter Extraction

### From Datasheets
Key parameters to extract for accurate modeling:

#### For MOSFETs:
- VGS(th) at specified ID
- RDS(on) at specified VGS and ID
- Gate charge (Qg, Qgs, Qgd) at specified VGS
- Body diode forward voltage (VF) and reverse recovery (trr, Qrr)
- Output capacitance (Coss) vs VDS
- Input capacitance (Ciss) and reverse transfer capacitance (Crss)
- Maximum drain current (ID) and pulsed current (IDM)
- Maximum power dissipation (PD) and thermal resistance (RθJC)

#### For Diodes:
- Forward voltage (VF) at specified IF
- Reverse leakage current (IR) at specified VR
- Reverse recovery time (trr) and charge (Qrr)
- Junction capacitance (CJ) at specified VR
- Maximum repetitive reverse voltage (VRRM)
- Maximum average forward current (IF(AV))
- Maximum surge current (IFSM)
- Thermal resistance (RθJC)

#### For Capacitors:
- Capacitance value and tolerance
- ESR at specified frequency
- ESL (usually Given as inductance)
- Maximum working voltage
- Temperature coefficient
- Dissipation factor (DF) or quality factor (Q)
- Insulation resistance
- Leakage current

#### For Inductors:
- Inductance value and tolerance
- DC resistance (RDC)
- Saturation current (ISAT)
- RMS current rating (IRMS)
- Self-resonant frequency (SRF)
- Quality factor (Q) at specified frequency
- Temperature coefficient of inductance
- Shielding effectiveness (for shielded inductors)

### Measurement-Based Extraction
For critical applications, consider extracting parameters from measurements:

#### MOSFET Parameter Extraction:
1. **VGS(th)**: Measure VGS at ID = 250μA (typical)
2. **RDS(on)**: Measure VDS at ID = specified value, VGS = overdrive
3. **Gate Charge**: Use gate charge measurement setup or derive from switching waveforms
4. **Capacitances**: Measure using impedance analyzer or derive from switching behavior
5. **Body Diode**: Measure forward voltage and recovery characteristics

#### Capacitor Parameter Extraction:
1. **Capacitance**: Measure with LCR meter at specified frequency
2. **ESR**: Measure with LCR meter or impedance analyzer
3. **ESL**: Measure resonant frequency with known capacitance
4. **Leakage**: Measure leakage current at rated voltage

#### Inductor Parameter Extraction:
1. **Inductance**: Measure with LCR meter at specified frequency
2. **RDC**: Measure with DC ohmmeter or calculate from dimensions and resistivity
3. **Saturation**: Measure inductance vs DC current
4. **Losses**: Measure Q factor or power loss at specified frequency and current

## Temperature Modeling

### Semiconductor Temperature Dependence
Most semiconductor models include built-in temperature modeling:

#### MOSFETs:
```spice
.MODEL MODNAME NMOS (VTO=-2.0 + 0.001*(TEMP-27)  ...)
```
- VTO typically changes by -2mV/°C to -5mV/°C
- BETA (KP*UO) decreases with temperature (~0.5%/°C)
- UO (mobility) decreases with temperature (~1.5%/°C)

#### BJTs:
```spice
.MODEL MODNAME NPN (IS=1E-14 * EXP(-EG*(1/T-1/300)/K) ...)
```
- IS doubles approximately every 10°C (EK/T modeling)
- VF decreases by ~2mV/°C
- BETA peaks around room temperature

#### Diodes:
```spice
.MODEL MODNAME D (IS=1E-14 * EXP(-EG*(1/T-1/300)/K) ...)
```
- IS follows similar exponential relationship as BJTs
- VF temperature coefficient typically -2mV/°C
- Breakdown voltage may have positive or negative TC depending on mechanism

### Passive Component Temperature Dependence

#### Resistors:
```spice
RESISTANCE = R0 * (1 + TCR * (TEMP - T0))
```
- Metal film: TCR typically ±25ppm/°C to ±100ppm/°C
- Carbon film: TCR typically ±250ppm/°C to ±500ppm/°C
- Wirewound: TCR typically ±10ppm/°C to ±50ppm/°C (depending on alloy)

#### Capacitors:
- **Ceramic (Class I, C0G/NP0)**: TC typically 0±30ppm/°C
- **Ceramic (Class II, X7R)**: TC typically ±15% over -55°C to +125°C
- **Ceramic (Class III, Y5V)**: TC typically +22%/-82% over -30°C to +85°C
- **Film (Polypropylene)**: TC typically ±30ppm/°C to ±120ppm/°C
- **Electrolytic**: Capacitance may decrease with temperature, ESR changes significantly

#### Inductors:
- **Ferrite Core**: Inductance may change ±10% over -40°C to +125°C
- **Powdered Iron**: Inductance relatively stable with temperature
- **DC Resistance**: Increases with temperature (copper ~0.393%/°C)

### Using Temperature in Simulations
```spice
* Set simulation temperature
.OPTIONS TEMP=125

* Sweep temperature
.STEP PARAM TEMP LIST -55 25 85 125

* Use .IC for initial conditions at different temperatures
.IC V(C1)=0 I(L1)=0

* Monitor temperature-sensitive parameters
.MEAS TRAN VTH MAX V(GS) WHERE V(DS)=0.1V
.MEAS TRAN RDSON MIN V(DS)/I(D) WHERE V(GS)=5V
```

## Validation and References

### Validation Methods
1. **DC Characteristics**: Verify IDS-VGS, IDS-VDS curves
2. **AC Characteristics**: Verify CGS, CGD, CDS vs voltages
3. **Transient Characteristics**: Verify switching times, recovery behavior
4. **Temperature Characteristics**: Verify parameter variation with temperature
5. **Noise Characteristics**: Verify thermal and flicker noise (if modeled)

### Reference Datasheets
Key datasheets referenced in this library:
- MOSFETs: IRF640N, IRFP240N, IRFZ44N datasheets (Infineon/International Rectifier)
- Diodes: 1N4148, 1N5819, MUR1560 datasheets (Various manufacturers)
- BJTs: 2N2222, 2N3904, TIP31C datasheets (Various manufacturers)
- Capacitors: Various manufacturer series (Murata, TDK, Vishay, etc.)
- Inductors: Various manufacturer series (TDK, Vishay, Coilcraft, etc.)
- ICs: Manufacturer datasheets (TI, Analog Devices, ON Semiconductor, etc.)

### Model Sources
Models in this library come from:
- **Manufacturer SPICE Models**: Direct from semiconductor vendors
- **Standard SPICE Models**: Built-in NGSpice models (Level 1, 2, 3)
- **Shared Libraries**: Communities like SPICEModels.com, ModelMaker
- **Converted Models**: From other SPICE simulators (PSpice, HSpice, etc.)
- **Custom Developments**: Created specifically for this suite
- **Approved Substitutes**: Where exact models unavailable, closest equivalent used

### Reporting Issues
If you find inaccuracies in the models:
1. Check the specific `.lib` file for the component
2. Verify against the latest manufacturer datasheet
3. Test with simple verification circuits
4. Document discrepancies and submit through GitHub Issues
5. Include test circuits and expected vs actual behavior

## Appendix: Common Model Files

### MOSFET Libraries
- `models/mosfets/irf.lib`: IRF series MOSFETs
- `models/mosfets/onsemi.lib`: ON Semiconductor MOSFETs
- `models/mosfets/vishay.lib`: Vishay MOSFETs
- `models/mosfets/toshiba.lib`: Toshiba MOSFETs
- `models/mosfets/generic.lib`: Generic MOSFET models

### Diode Libraries
- `models/diodes/standard.lib`: 1N4xxx, 1N5xxx series
- `models/diodes/schottky.lib`: Schottky diodes
- `models/diodes/fastrec.lib`: Fast recovery diodes
- `models/diodes/zener.lib`: Zener diodes
- `models/diodes/sic.lib`: SiC Schottky diodes

### BJT Libraries
- `models/bjt/general.lib`: General purpose BJTs
- `models/bjt/power.lib`: Power transistors
- `models/bjt/darlington.lib`: Darlington pairs
- `models/bjt/rf.lib": RF transistors

### Capacitor Libraries
- `models/capacitors/ceramic.lib`: Ceramic capacitors
- `models/capacitors/electrolytic.lib`: Electrolytic capacitors
- `models/capacitors/film.lib`: Film capacitors
- `models/capacitors/tantalum.lib`: Tantalum capacitors

### Inductor Libraries
- `models/inductors/power.lib`: Power inductors
- `models/inductors/rf.lib": RF inductors
- `models/inductors/transformer.lib": Transformers
- `models/inductors/toroid.lib": Toroidal inductors

### Resistor Libraries
- `models/passive/resistors.lib": Standard resistors
- `models/passive/currentsense.lib": Current sense resistors
- `models/passive/highvoltage.lib": High voltage resistors
- `models/passive/thermistors.lib": NTC and PTC thermistors

### Specialized Libraries
- `models/analog_ic/opamps.lib": Operational amplifiers
- `models/analog_ic/references.lib": Voltage references
- `models/analog_ic/comparators.lib": Comparators
- `models/drivers/tc4420.lib": TC4420 series drivers
- `models/drivers/ir2110.lib": IR2110 series drivers
- `models/logic_ic/74hc.lib": 74HC series logic
- `models/custom_subcircuits/PV_symbol.sub": PV array model
- `models/custom_subircuits/transformer_with_parasitics.sub": Transformer model with parasitics