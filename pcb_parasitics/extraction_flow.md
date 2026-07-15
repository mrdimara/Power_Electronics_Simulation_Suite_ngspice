# PCB Parasitic Extraction Workflow

This document describes the workflow for extracting PCB parasitics using KiCad and Ansys Q3D Extractor, and integrating them into NGSpice simulations.

## Overview

The parasitic extraction workflow involves several steps from PCB design to simulation integration:

1. Schematic Capture (KiCad Eeschema)
2. PCB Layout (KiCad Pcbnew)
3. 3D Model Export (Optional, for visualization)
4. Parasitic Extraction (Ansys Q3D Extractor)
5. Equivalent Circuit Generation
6. Circuit Integration (NGSpice)

## Detailed Workflow

### 1. Schematic Capture (KiCad Eeschema)

- Place components with consideration for high-frequency layout
- Separate analog/digital sections with proper partitioning
- Route differential pairs for critical signals
- Place decoupling capacitors close to IC power pins
- Assign appropriate footprints and component values

### 2. PCB Layout (KiCad Pcbnew)

- Set up design rules for high-speed design:
  - Minimum trace width: 30mil for power currents
  - Proper clearance for high voltage sections
  - Length matching for differential pairs
- Implement power plane partitioning:
  - Separate analog and digital ground planes
  - Create dedicated power planes for different voltage rails
  - Use proper stitching vias between planes
- Implement via stitching for ground plane connectivity
- Define keep-out areas for sensitive analog sections
- Place ground vias near component pins and under components

### 3. 3D Model Export (Optional)

- Export STEP files for mechanical clearance checking
- Verify component heights and clearances
- Check for mechanical interference with heatsinks, connectors, etc.

### 4. Parasitic Extraction (Ansys Q3D Extractor)

#### Input Preparation
- Export PCB design from KiCad in ODB++ or IPC-2581 format
- Define material stackup accurately:
  - Copper thickness and conductivity
  - Dielectric constant and loss tangent for each layer
  - Solder mask and silkscreen properties
- Assign properties to different objects:
  - Signal traces: Copper conductivity
  - Vias: Copper plating with appropriate aspect ratio
  - Planes: Bulk copper properties
  - Components: Actual geometry or simplified models

#### Extraction Setup
- Define frequency sweep: Typically 100kHz to 100MHz with 10-20 points per decade
- Set up boundary conditions:
  - Radiation boundaries at λ/4 distance from structure
  - Proper port definitions for S-parameter extraction
- Configure mesh settings:
  - Enable adaptive mesh refinement
  - Set convergence criteria (typically 1-2% for S-parameters)
  - Specify minimum mesh size in critical areas (vias, sharp corners)

#### Solution and Validation
- Run electromagnetic simulation
- Validate results through:
  - Comparison with analytical formulas for simple structures
  - Consistency checks (reciprocity, passivity)
  - Convergence testing with mesh refinement
  - Comparison with measurement data if available

### 5. Equivalent Circuit Generation

- Generate SPICE subcircuits from extracted R, L, G, C matrices
- Create multi-port models that preserve coupling effects
- Generate Touchstone (.snp) files for RF applications
- Create reduced-order models if necessary for simulation efficiency
- Validate extracted models against original EM solutions

### 6. Circuit Integration (NGSpice)

#### Netlist Integration
- Include extracted subcircuits using `.include` or `.lib` statements:
  ```spice
  .include "path/to/extracted_parasitics.cir"
  ```
- For Touchstone files, use LTspice-style S-parameter elements or equivalent:
  ```spice
  * Example using frequency-dependent behavioral models
  ```
- Match port definitions between extraction and simulation

#### Simulation Setup
- Assign appropriate solver options for parasitic networks:
  ```spice
  .OPTIONS ITL4=1000 GMIN=1E-12 RELTOL=0.001
  ```
- Consider using GEAR integration method for stiff systems caused by parasitics
- Set appropriate timestep for transient analysis to capture high-frequency effects

#### Post-Processing
- Extract S-parameters from time-domain simulations if needed
- Calculate impedance and admittance matrices
- Perform time-domain reflectometry (TDR) analysis
- Extract resonant frequencies and quality factors

## Best Practices

### Design for Extractability
- Use consistent trace widths and spacing where possible
- Avoid acute angles in traces (use 45° or curved traces)
- Maintain symmetry in differential pairs
- Use ground vias liberally but not excessively

### Extraction Accuracy
- Verify material properties match actual PCB fabrication
- Include solder mask and surface finish effects when significant
- Model via holes accurately (including plating thickness)
- Consider surface roughness effects at high frequencies

### Model Validation
- Compare extracted inductance of straight wire to Rosa's formula
- Validate capacitance calculations against parallel plate formula
- Check that extracted models are causal and passive
- Validate with time-domain measurements (TDR/TDT) when possible

## File Organization

In this repository, parasitic extraction files are organized as follows:

```
pcb_parasitics/
├── extraction_flow.md          # This document
├── equivalent_circuits/        # Generated SPICE subcircuits
├── examples/                   # Example extraction projects
└── q3d_models/                 # Q3D project files and setups
```

## Example Extraction

See the `examples/` directory for complete examples of:
- Power inductor parasitic extraction
- Decoupling capacitor ESL/ESR extraction
- Bus bar inductance calculation
- Shielded extraction for noisy environments

## Troubleshooting

### Common Issues
- **Non-convergence**: Increase mesh density, check for floating geometries
- **Unphysical results**: Verify boundary conditions, check for short circuits in model
- **Large file sizes**: Use mesh decimation, focus extraction on regions of interest
- **Long solve times**: Use symmetry principles, reduce frequency points, simplify geometry

### Validation Failures
- **Passivity violations**: Check for negative capacitance/inductance values
- **Reciprocity errors**: Ensure symmetrical port excitation in extraction setup
- **Frequency dependence issues**: Verify broadband modeling assumptions

## References

For more detailed information on PCB parasitic extraction:

1. **Ansys Q3D Extractor Documentation** - Official user guide and theory reference
2. **IEEE PCB Design Guides** - Standards for high-speed digital design
3. **"High Speed Digital Design" by Johnson & Graham** - Classic reference on signal integrity
4. **"EMC and the Printed Circuit Board" by Mark Montrose** - EMC-focused PCB design
5. **IPC-2221/2222 Standards** - PCB design standards

---
*Last updated: $(date +%Y-%m-%d)*
