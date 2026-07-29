---
tags: [troubleshooting, capacitor-unit, convergence-error]
status: open
related:
  - [[Power Supply Board Simulation]]
  - [[Known Issues]]
---

# Capacitor Unit Error at Fast-Switching Node

## Problem
The KiCad-exported netlist for the power supply board exhibits convergence failure during NGspice simulation. The issue is suspected to be caused by incorrect capacitor units (confusion between Farads, microfarads, and picofarads) at high-frequency switching nodes, resulting in unrealistically large or small capacitance values that prevent the simulator from finding a stable operating point.

## Symptoms
- Simulation fails to converge in DC operating point analysis (.op)
- Transient analysis (.tran) shows extreme voltage spikes or latch-up conditions
- Time step becomes excessively small ("time step too small" errors)
- Solution fails to converge even with increased iteration limits and relaxed tolerances
- Voltages at certain nodes reach unrealistic values (kV or TV range) or nanovolt levels

## Root Cause
In PCB design tools like KiCad:
1. **Default Units**: Component values may be entered in one unit but exported in another
2. **Scale Confusion**: Engineers might enter "100" intending 100pF but the system interprets it as 100F or 100µF
3. **Auto-scaling Issues**: Some schematic tools automatically apply prefixes based on entered values
4. **Netlist Generation Bugs**: Potential issues in the KiCad-to-netlist export process
5. **High-Frequency Nodes**: Switching nodes (drain/source of MOSFETs, transformer terminals) are particularly sensitive to incorrect capacitance values

## Impact on Simulation
- **Excessively Large Capacitance** (e.g., 1F instead of 1µF):
  - Slows down circuit dynamics dramatically
  - Causes excessively long time constants
  - May prevent reaching steady-state in reasonable simulation time
  - Can cause numerical integration issues

- **Excessively Small Capacitance** (e.g., 1pF instead of 1µF):
  - Creates unintended high-frequency resonant circuits
  - Leads to numerical instability and oscillation
  - Causes extremely small time steps required for accuracy
  - May produce unrealistic voltage spikes due to LC resonance with parasitic inductance

## Diagnostic Approach
1. **Netlist Inspection**: Examine the generated .net file for suspicious capacitor values
2. **Node-by-Node Check**: Focus on high dv/dt nodes (MOSFET drains, switch nodes)
3. **Comparison with Schematic**: Verify values match intended design
4. **Isolation Testing**: Simulate subsets of the circuit to isolate problematic sections
5. **Frequency Analysis**: Perform AC sweeps to identify unexpected resonant frequencies

## Resolution Strategy
1. **Unit Standardization**: Ensure all capacitor values are explicitly entered with correct units (pF, nF, µF) in KiCad
2. **Manual Netlist Verification**: Check critical capacitors in the generated .net file
3. **Scaling Corrections**: Apply appropriate scaling factors if systematic errors are found
4. **Component Replacement**: Replace suspect components with known-good values for testing
5. **Exact Unit Specification**: Use explicit unit notation in SPICE (e.g., 100PF, 10NF, 1UF) rather than relying on multipliers

## Preventive Measures
1. **Consistent Unit Entry**: Always specify units explicitly in schematic capture (100PF not 100)
2. **Design Rule Checks**: Implement custom checks for unreasonable component values
3. **Netlist Review**: Always inspect critical netlist sections before simulation
4. **Component Libraries**: Use verified, consistently formatted component libraries
5. **Version Control**: Track changes to netlists to identify when issues were introduced

## Current Status
- **Location**: `simulations/power_supplies/power_supply_board/` (or similar path)
- **Evidence**: Netlist shows capacitor values that are orders of magnitude different from expected
- **Impact**: Prevents meaningful simulation of power supply performance
- **Workaround**: Manual correction of netlist values allows simulation to proceed
- **Root Cause Confirmation**: Requires side-by-side comparison of schematic entries vs. netlist output

## Related Files
- **Problematic Netlist**: `simulations/power_supplies/power_supply_board/power_supply.net` (example path)
- **KiCad Schematic**: `simulations/power_supplies/power_supply_board/power_supply.kicad_sch`
- **Expected Values**: Refer to original design schematics and BOM
- **Validation Comparison**: `simulations/power_supplies/power_supply_board/corrected_netlist.net`
- **Documentation**: `docs/REPOSITORY_AUDIT.md` - Notes on this issue
- **Planned Fix Location**: Will be resolved in power supply board redesign

## Dependencies
Resolution of this issue is required before:
- Accurate power efficiency measurements
- Thermal analysis of power supply components
- Startup transient characterization
- EMI/EMC prediction from switching behavior
- Closed-loop regulation performance verification

## Testing Procedure After Fix
1. Verify DC operating point converges (.op)
2. Check bias voltages are within expected ranges
3. Run startup transient to verify soft-start behavior
4. Perform AC analysis on control loop to check stability
5. Simulate load transient response
6. Compare results with hardware measurements when available

## Estimated Effort
- **Diagnosis**: 2-4 hours (netlist inspection, comparison with schematic)
- **Correction**: 1-2 hours (fixing systematic unit errors)
- **Verification**: 2-4 hours (simulation testing across operating conditions)
- **Documentation**: 1 hour (updating relevant files)

## References
- KiCad Documentation: Unit handling in schematic capture
- Ngspice Manual: Convergence techniques and troubleshooting
- PCB Design Guidelines: Proper decoupling and capacitor selection
- Application Notes: Common simulation pitfalls in power electronics

## Tags
#troubleshooting #power-supply #convergence-issue #capacitor-units #pcb-parasitics #xima #debugging