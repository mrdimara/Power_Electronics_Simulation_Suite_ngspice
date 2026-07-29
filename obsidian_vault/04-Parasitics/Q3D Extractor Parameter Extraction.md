---
tags: [analysis, parasitics, extraction]
status: reference
related:
  - [[Parasitic Extraction Workflow]]
  - [[Q3D Extractor]]
  - [[RLCG Parameters]]
---

# Parameters Extraction from ANSYS Q3D Extractor

## Overview
This note documents the process and parameters extracted from ANSYS Q3D Extractor for PCB parasitic analysis in the repository, which are subsequently used in NGspice simulations.

## Q3D Extractor Capabilities
ANSYS Q3D Extractor is a 3D quasi-static electromagnetic field solver that calculates:
- Resistance (R)
- Inductance (L)
- Capacitance (C)
- Conductance (G)

For conductors in a multi-dielectric environment, suitable for high-frequency PCB and package analysis.

## Extraction Setup
### Geometry Preparation
1. **Import CAD Data**: Typically import IDF, DXF, or XML from PCB design tools (KiCad in this case)
2. **Define Conductors**: Identify traces, planes, vias, and components to be modeled
3. **Assign Materials**: 
   - Conductors: Copper (σ = 5.8×10⁷ S/m)
   - Dielectrics: FR-4 (εr ≈ 4.4, tan δ ≈ 0.02)
   - Soldermask: Typically εr ≈ 3.5-4.0
4. **Define Boundaries**: 
   - Open boundaries (radiation condition) or
   - Enclosed in air/vacuum box

### Solution Setup
1. **Frequency Sweep**: Define frequency range of interest (typically 100Hz to 10GHz)
2. **Solution Type**: 
   - DC (for resistance only)
   - AC (for R, L, C, G)
   - Thermal (if coupled thermal analysis needed)
3. **Solvers**: 
   - Direct solver for smaller problems
   - Iterative solver with domain decomposition for larger systems
4. **Convergence Criteria**: 
   - Relative error tolerance (typically 1-3%)
   - Maximum number of passes/adaptive refinements

## Extracted Parameters
### Resistance (R)
- **DC Resistance**: Based on conductor conductivity and cross-sectional area
- **AC Resistance**: Includes skin effect and proximity effect
- **Frequency Dependence**: Increases with √f due to skin effect at high frequencies

### Inductance (L)
- **Partial Inductance**: For individual conductor segments
- **Loop Inductance**: For closed current paths (more physically meaningful)
- **Components**:
  - External inductance: Magnetic field in surrounding medium
  - Internal inductance: Magnetic field within conductor (decreases with frequency due to skin effect)
- **Frequency Dependence**: Decreases with frequency due to skin effect reducing internal inductance

### Capacitance (C)
- **Maxwell Capacitance Matrix**: Cij relates charge on conductor i to voltage on conductor j
- **Grounded Capacitance**: Cii = Σj Cij (total capacitance to ground)
- **Mutual Capacitance**: Cij (i≠j) represents coupling between conductors
- **Frequency Dependence**: Generally constant until dielectric relaxation effects (~100GHz+ for FR-4)

### Conductance (G)
- **Dielectric Losses**: Due to finite conductivity of dielectric materials
- **G = ωC tan δ**: Where tan δ is loss tangent of dielectric
- **Frequency Dependence**: Increases linearly with frequency
- **Temperature Dependence**: Typically increases with temperature

## Data Exchange with NGspice
### Touchstone Format (.snp)
- Most common for multi-port networks
- Contains S-parameters (scattering parameters)
- Requires conversion to Y- or Z-parameters for nodal analysis

### RLGC Matrix Format
- Direct extraction of resistance, inductance, conductance, capacitance matrices
- More suitable for transmission line and multi-conductor systems
- Format: [R] + jω[L] + G + jω[C] 

### SPICE Subcircuits
- Custom subcircuits representing the extracted RLGC behavior
- Can include frequency-dependent behavior through:
  - LTRA (lossy transmission line) elements
  - VPWL (piecewise linear) sources for empirical models
  - Frequency-dependent resistors (using LTRA or custom implementations)
  - Rao-Pillai-Pillai (RPP) model for frequency-dependent losses

## Multi-Conductor Transmission Line Theory
For coupled conductors, the telegrapher's equations become:
[-d/dx] [V] = [R] [I] + [L] ∂[I]/∂t
[-d/dx] [I] = [G] [V] + [C] ∂[V]/∂t

In frequency domain (jω):
[-d/dx] [V] = ([R] + jω[L]) [I]
[-d/dx] [I] = ([G] + jω[C]) [V]

The characteristic impedance and propagation constant become matrices:
[Zc] = √([R] + jω[L]) ([G] + jω[C])⁻¹/²
[γ] = √([R] + jω[L]) ([G] + jω[C])

## Validation Approach
1. **Known Geometries**: Compare with analytical solutions for simple structures (parallel plates, microstrip, coax)
2. **DC Limit**: Resistance should match bulk conductivity calculations
3. **Capacitance Matrix Properties**:
   - Symmetric (Cij = Cji)
   - Diagonal dominance (Cii ≥ Σj≠i |Cij|)
   - Positive definite
4. **Inductance Matrix Properties**:
   - Positive definite
   - Mutual inductance limited by self-inductances |Mij| ≤ √(Li·Lj)
5. **Reciprocity**: S-parameter matrix should be symmetric (Sij = Sji) for reciprocal networks
6. **Passivity**: No net energy generation (all eigenvalues of [Z]+[Z]† should be non-negative)

## Application in Power Electronics
### High-Frequency Switching Nodes
- Extract parasitic capacitance between switch node and ground/other planes
- Model inductor winding capacitance and core effects
- Characterize EMI coupling paths

### Power Distribution Networks (PDN)
- Target impedance analysis: Ztarget = ΔV/Iripple
- Decoupling capacitor placement optimization
- Plane resonance identification and suppression

### Gate Drive Loops
- Critical for switching performance and EMI
- Loop impedance affects turn-on/turn-off times and losses
- Mutual coupling between gate drive and power traces

### Snubber and Dampening Networks
- Characterize parasitic LC tanks to be damped
- Optimize snubber component values based on extracted parasitics
- Verify damping effectiveness across frequency range

## File Organization
Extracted data typically stored in:
- `pcb_parasitics/q3d_models/` - Raw Q3D project files and setups
- `pcb_parasitics/equivalent_circuits/` - SPICE subcircuits and models
- `pcb_parasitics/examples/` - Validation and demonstration circuits
- ` documentation in docs/MODEL_LIBRARY.md#Parasitics and docs/TECHNICAL_REPORT.md#PCB-Parasitics

## Software-Specific Notes
### Q3D Meshing
- Adaptive meshing refines based on error estimation
- Surface vs. volume meshing options
- Convergence monitoring essential for accurate results

### Solution Options
- **Direct Solver**: Accurate but memory-intensive for large problems
- **Iterative Solver (JSCC/JDG)**: Memory-efficient, preconditioning important
- **Inclusion of Displacement Current**: Essential for accuracy above ~100MHz
- **Ground Rule Definition**: Affects capacitance to infinity calculations

## Post-Processing
1. **Touchstone Conversion**: S-parameters to Y/Z matrices for SPICE compatibility
2. **Model Order Reduction**: Techniques like PRIMA or AWE for large systems
3. **Curvilinear Fitting**: Rational function approximation for broadband models
4. **Passivity Enforcement**: Ensuring extracted models don't violate energy conservation
5. **Causality Enforcement**: Ensuring impulse response is zero for t<0

## Limitations and Assumptions
1. **Quasi-Static Approximation**: Valid when dimensions << λ/10 (typically < λ/20 for good accuracy)
2. **Perfect Conductors**: Assumes infinite conductivity (skin effect modeled approximately)
3. **Linear Materials**: Does not capture magnetic saturation or dielectric nonlinearity
4. **Isotropic Materials**: Assumes uniform properties in all directions
5. **Invariant Cross-Section**: For transmission lines, assumes uniform along length
6. **Negligible Radiation**: Assumes contained fields (valid for enclosed structures or low frequencies)

## Advanced Topics
1. **Surface Roughness Models**: Hammerstad-Jensen or Huray-Snowball models for conductor losses
2. **Anisotropic Dielectrics**: For layered materials or textured surfaces
3. **Non-Uniform Grids**: For conformal modeling of complex geometries
4. **Multi-Physics Coupling**: Thermal-electromagnetic for self-heating effects
5. **Statistical Analysis**: Monte Carlo for manufacturing variation impact
6. **Optimization Loops**: Geometric parameters for target impedance achievement

## Validation Examples
1. **Parallel Plate Capacitor**: C = εA/d
2. **Coaxial Inductance**: L = (μ/2π) ln(b/a) per unit length
3. **Parallel Wire Capacitance**: C = πε/(acosh(D/2r))
4. **Microstrip Formulas**: Wheeler, Hammerstad, or Schneider equations
5. **Inductance of Rectangular Loop**: Grover's formulas
6. **Mutual Inductance**: Neumann, Rosa, or Grover methods

## Tools and Scripts
- **Automated Extraction**: Python or MATLAB scripts for batch processing
- **Parameter Interpolation**: Spline or polynomial fitting for tabular data
- **Model Generation**: Automatic SPICE subcircuit creation from matrices
- **Validation Suites**: Automated comparison against analytical or measurement data
- **Visualization Tools**: Field plots, current density, charge distribution analysis

## References
1. Ansys Q3D Extractor Help Documentation
2. "Electromagnetic Vibration Analysis of Complex Systems" - Bouwkamp
3. "Computer Techniques for Electromagnetics" - Mittra
4. "Fast Electromagnetic Modeling of Increasingly Complex Structures" - Various authors
5. IPC-2141B: Design for High Frequency