# Claude Code Handoff — NGSpice Power Electronics Simulation Suite
## Full Repository Audit, Reorganization, README, Technical Report, and Obsidian Notes Generation

---

## 0. Read This First — Operating Rules

- **You have terminal/file access to the actual repo. I do not.** Everything below is context and instructions, not ground truth about what files currently exist. Your first job is to verify what's real by inspecting and running things.
- **Never fabricate.** No invented simulation results, no invented waveform numbers, no invented figures, no invented file names. If something described below isn't actually present in the repo, write `Data unavailable in current repository` in the relevant doc section and move on. This applies especially to the "Known Project Context" section below — treat it as *leads to check*, not *facts to write down*.
- **Do not ask clarifying questions mid-task.** Make the most reasonable engineering decision, note the decision and rationale in `docs/REPOSITORY_AUDIT.md`, and continue.
- **Preserve everything.** Move/reorganize, never delete original engineering files. If reorganizing would overwrite something, rename with a suffix and log it.
- **Actually run things.** Don't just read `.cir`/`.sp`/`.net` files and describe them — execute them in ngspice where possible, capture real output (`.raw`, console logs, plots), and use that real output in the docs. Same for MATLAB/Octave scripts — run them (or note exactly why a given script couldn't run, e.g. missing toolbox, missing input `.raw` file).
- **Work in small logged steps.** Commit-sized units of work, each reflected in `docs/REPOSITORY_AUDIT.md` and eventually `FINAL_REVIEW.md`.
- **Everything must be properly cross-linked.** README, docs, and Obsidian notes are not three separate silos — they should reference each other with working relative links (standard `[text](path)` markdown links in `README.md`/`docs/`, `[[wikilinks]]` inside the Obsidian vault). No dead-end documents.

---

## 1. Known Project Context (from prior work — verify against actual repo, don't assume)

This repo is expected to center on the **NOVA Gate Driver project** (EMPES Lab, IIT Bombay, under an internship), plus a broader set of NGSpice power-electronics coursework/self-study simulations. Known/likely components, to search for and verify:

### 1.1 NOVA Gate Driver project
- Power stage built around an **IRF640NS power MOSFET**, driven by an **NE555-based gate driver circuit**.
- Simulation stack: **NGSpice** for circuit simulation, **Ansys Q3D Extractor** for PCB parasitic extraction (from a KiCad-designed board), **MATLAB** for comparative/statistical analysis against real oscilloscope measurements.
- A **KiCad-exported netlist for the gate driver *power supply* board** is currently mid-debug — suspected convergence failure caused by **capacitor unit errors at a fast-switching node** (e.g. a value exported in the wrong unit scale, F vs µF vs pF, causing an unrealistically large or small capacitance and blowing up the timestep/convergence). **This work is NOT finished — do not present it as a working/validated simulation in any doc. Mark clearly as "in progress / known issue" if included at all.**
- A **custom-wound toroid transformer model** (TDK/EPCOS N30 core, size R12.5×7.5×5, winding ratio 12:9:5 turns, AL = 2200 nH/N²) was built as an NGSpice subcircuit — check for this as a reusable magnetics model under `models/custom_subcircuits/` after reorg.
- PSpice-to-ngspice model porting work was done for the gate driver power supply: BSIM3 `LEVEL=7` → `LEVEL=8` migration, VT/VH switch syntax corrections, continuation-line formatting fixes. This got the simulation running — treat as a **solved, documented issue**, good candidate for `docs/THEORY_NOTES.md` or a troubleshooting note under `learning/troubleshooting/`.

### 1.2 Comparative Analysis Report (already produced — likely exists as LaTeX)
A full LaTeX comparative-analysis report was already completed comparing NGSpice simulation (with Q3D-extracted parasitics) against oscilloscope measurements (post-processed in MATLAB). If found in the repo:
- It's modular (separate section `.tex` files), has **27 figures embedded**, **5 comparison tables**, and compiles with **zero undefined references**.
- Treat this as authoritative source content for `docs/TECHNICAL_REPORT.md` Chapters 5–7 (parasitic extraction, results, waveform processing) — pull real figures and real captions from it rather than re-deriving numbers.
- If this `.tex` source exists, also try to locate/compile the actual PDF, and pull its figures into `assets/report_figures/` with correct captions preserved.

### 1.3 MATLAB analysis scripts
Two production MATLAB scripts are expected — one for **simulated** (NGSpice `.raw`) data, one for **practical** (oscilloscope) data. Each likely covers:
- Rise time / fall time extraction
- Ringing analysis via **log-decrement method** and **Hilbert envelope fitting**
- **Blackman-Harris windowed FFT**
- Parasitic loop inductance extraction

**Known open issue:** there is a flagged inconsistency between the two scripts in how the *ringing energy metric* is computed (methodology mismatch between simulated vs practical). If you find this, **do not silently reconcile it** — document it explicitly in `docs/REPOSITORY_AUDIT.md` and `TECHNICAL_REPORT.md` Chapter 8 (Limitations) as a known, unresolved methodology gap. Do not guess which one is "correct."

### 1.4 Instrumentation / data acquisition
- Oscilloscope: **Keysight DSOX1204**, acquired via **PyVISA-py** on macOS M2.
- Look for a Python acquisition script under a `python/` or similar folder — this belongs under `analysis/python/` post-reorg.

### 1.5 Broader NGSpice coursework/self-study simulations
From an NPTEL course ("Design and Simulation of Power Conversion Using Open Source Tools", Prof. L. Umanand, IISc), expect NGSpice simulations for:
- Rectifiers
- Buck/boost converters
- Inverters (possibly SVPWM)
- MPPT (possibly an RCC-based MPPT circuit)
- PV battery charging
- V/f control

These are good fill-in content for `simulations/rectifiers/`, `simulations/converters/`, and possibly a new `simulations/renewable_mppt/` subfolder if there's enough material — use judgment, note the decision.

### 1.6 Environment / toolchain actually in use
- **NGSpice v46**, built from source with **XSPICE** support enabled.
- GNU Octave and MATLAB/Simulink both used (some scripts may be Octave-compatible variants).
- KiCad for PCB design.
- macOS M2 dev environment.
- Git repo already exists at `github.com/mrdimara` namespace — check remotes before assuming a repo name; don't rename the repo itself, only reorganize its internal structure.

### 1.7 Reference materials for the PCB parasitic extraction workflow (for grounding `pcb_parasitics/extraction_flow.md` and `docs/THEORY_NOTES.md`)
An 8-day Ansys Q3D Extractor self-study plan was completed, covering dielectric modeling, frequency sweeps, common-source inductance, and the Gerber-to-Q3D workflow, mapped against these references:
- Bogatin, *Signal and Power Integrity — Simplified*, 3rd Ed., Ch. 4–7, 10–12
- Hayt & Buck, *Engineering Electromagnetics*, 8th Ed., Ch. 7–9, 12
- Johnson & Graham, *High-Speed Digital Design*, Ch. 1–4, 7
- Mohan, *Power Electronics*, 3rd Ed., Ch. 20

If the repo contains study notes tied to this plan, they are good source material for `docs/THEORY_NOTES.md` — cite the reference chapters rather than restating textbook content wholesale (copyright + it's cleaner engineering practice to cite).

### 1.8 Related but separate projects (do NOT merge into this repo — cross-link only, if the other repo/site is publicly reachable)
These exist as separate bodies of work by the same author and should only appear as "Related Work" links, never pulled in as content:
- A **from-scratch SPICE simulator project** (currently at planning stage — master plan + resource list, eventually targeting LTspice/PSpice/HSPICE netlist compatibility). If a link/repo for this exists, reference it under README "Future Development" or "Related Projects" as a natural next step from this suite, since it's a spiritual successor. Do not invent implementation details for it — it's pre-implementation.
- A **personal portfolio site** (Next.js 14, deployed on Vercel) documenting this and other projects. If it has a live URL, that's a reasonable README link target (e.g. "See full writeup on my portfolio"), but do not pull its content in — that site is independently maintained and may have had its own recent factual corrections; this repo should not duplicate content that could drift out of sync with it.

Use section 1 only as a checklist of things to go verify — confirm file existence before writing anything into documentation.

---

## 2. Step 1 — Repository Audit (do this before touching anything)

1. Walk the full repo tree (`find . -type f` or equivalent, respecting `.gitignore`).
2. Categorize every file: netlists (`.cir`/`.sp`/`.net`/`.spi`), SPICE models/subcircuits (`.lib`/`.mod`/`.sub`), KiCad files (`.kicad_pcb`, `.kicad_sch`, schematic/PCB libs), Q3D/Ansys project files, MATLAB (`.m`), Octave scripts, Python scripts, `.raw`/`.csv` data, plots/images (`.png`/`.jpg`/`.svg`/`.fig`), LaTeX source, PDFs, existing README/docs, screenshots.
3. Attempt to run every netlist found:
   - `ngspice -b <file>` (batch mode) where possible.
   - Record: succeeded / failed, error message, missing `.include` or model files, missing `.lib` paths.
4. Attempt to run every MATLAB/Octave script (`octave --no-gui script.m` if MATLAB itself isn't available in this environment):
   - Record: succeeded / failed, missing input files (e.g. expects a `.raw` or `.csv` that doesn't exist yet), missing toolboxes.
5. Write findings to `docs/REPOSITORY_AUDIT.md`:
   - Current (pre-reorg) tree
   - Table of every simulation/script: status (pass/fail/blocked), reason if failed
   - List of broken paths, outdated references, missing dependencies
   - List of engineering decisions you made during reorg (e.g. "grouped MPPT netlist under simulations/converters/ rather than a new folder because only one file exists")

---

## 3. Step 2 — Reorganize into Target Structure

```
ngspice-power-electronics-suite/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CITATION.cff
├── requirements.md
│
├── docs/
│   ├── TECHNICAL_REPORT.md
│   ├── REPOSITORY_AUDIT.md
│   ├── SIMULATION_GUIDE.md
│   ├── MODEL_LIBRARY.md
│   └── THEORY_NOTES.md
│
├── simulations/
│   ├── rectifiers/
│   ├── converters/
│   ├── switching_devices/
│   ├── gate_drivers/
│   ├── power_supplies/
│   └── parasitic_analysis/
│
├── models/
│   ├── diodes/
│   ├── mosfets/
│   ├── igbt/
│   ├── drivers/
│   └── custom_subcircuits/      <- toroid transformer model goes here if found
│
├── pcb_parasitics/
│   ├── extraction_flow.md
│   ├── q3d_models/
│   ├── equivalent_circuits/
│   └── examples/
│
├── analysis/
│   ├── matlab/                  <- simulated + practical analysis scripts
│   ├── octave/
│   ├── python/                  <- PyVISA-py DSOX1204 acquisition script
│   └── plotting/
│
├── learning/
│   ├── spice_basics/
│   ├── power_electronics/       <- NPTEL-derived simulations/notes
│   ├── modelling/
│   └── troubleshooting/         <- BSIM3 LEVEL=7→8 porting notes, other solved issues
│
├── examples/
│
├── assets/
│   ├── figures/
│   ├── screenshots/
│   └── report_figures/          <- pulled from the LaTeX comparative report, if found
│
└── obsidian_vault/               <- see Section 5, standalone Obsidian vault mirroring docs/
    ├── 00-MOC/
    ├── 01-Projects/
    ├── 02-Simulations/
    ├── 03-Models/
    ├── 04-Parasitics/
    ├── 05-Analysis/
    ├── 06-Troubleshooting/
    └── attachments/
```

Rules:
- Preserve every original file (move, don't delete). If a file's role is ambiguous, put it in `examples/` rather than force-fitting it, and note the ambiguity in the audit.
- Fix relative paths broken by the move (`.include`, `.lib`, image references in `.tex`/`.md`).

---

## 4. Step 3 — Documentation Content

### 4.1 `docs/SIMULATION_GUIDE.md`
NGSpice framework basics actually demonstrated in this repo: netlist structure, models/subcircuits in use, and which of `.op` / `.dc` / `.ac` / `.tran` analyses appear in which files, with real examples pulled from the repo (not generic textbook examples) wherever real ones exist.

### 4.2 Per-simulation documentation (folded into `SIMULATION_GUIDE.md` or per-folder `README.md`, your call — note the choice)
For each real circuit found: topology/operating principle, files involved (netlist/models/scripts/plots), simulation parameters actually used (Vin, fsw, component values, load), and results — real waveform/FFT plots if they exist, or `Data unavailable in current repository` if they don't.

### 4.3 `docs/MODEL_LIBRARY.md`
Non-ideal component modeling actually present:
- **Diodes** — forward voltage, reverse recovery, switching behavior, losses (only for models actually in the repo).
- **MOSFETs** — threshold voltage, Rds(on), gate charge, switching losses, parasitic capacitances (this should cover the IRF640NS model if it's SPICE-modeled in repo, using its real model parameters, not generic datasheet-style filler).
- **Passives** — ESR, ESL, winding resistance, leakage inductance (the toroid transformer model belongs here if found).

### 4.4 `pcb_parasitics/extraction_flow.md`
Document the real KiCad → STEP export → Ansys Q3D → RLGC extraction → equivalent circuit → NGSpice validation flow **as actually executed in this project**, including real screenshots if present in the repo. Cover copper/dielectric assignment, frequency sweep, R/L/C extraction as actually configured (not generic defaults) — pull settings from whatever Q3D project files or notes exist. Cite the reference chapters from section 1.7 where the flow follows textbook methodology.

### 4.5 Gate driver / switching section
Document the ideal-vs-parasitic-simulation comparison **only using real completed results** (this is the comparative analysis report content, section 1.2 above). Ringing frequency, overshoot, switching speed, EMI implications — from the actual MATLAB output, not invented numbers.

**Explicitly separate this from the currently-broken power-supply-board Xyce netlist (section 1.1).** That debugging work is unresolved and must be flagged as in-progress, not presented as a completed result.

### 4.6 `docs/THEORY_NOTES.md` / `learning/troubleshooting/`
Capture real solved issues as documentation value-add, e.g. the BSIM3 LEVEL=7→8 PSpice-to-ngspice porting fix, VT/VH syntax corrections, continuation-line formatting — written as a short "problem → cause → fix" note, since this is genuinely reusable troubleshooting knowledge.

### 4.7 Waveform processing workflow
Document the real pipeline: NGSpice `.raw` → CSV export → MATLAB/Octave → log-decrement + Hilbert envelope ringing analysis → Blackman-Harris FFT → engineering metrics (rise/fall time, overshoot, ringing frequency, parasitic loop inductance). **Explicitly call out the known simulated-vs-practical ringing-energy-metric methodology inconsistency (section 1.3)** as an open item — do not resolve it silently, do not pick one as "correct" without justification grounded in the actual scripts.

### 4.8 Internal linking requirement (applies to everything in `docs/` and `README.md`)
Every doc must link to the docs it logically depends on or feeds into, using relative markdown links — not just be reachable from README, but cross-reference each other directly:
- `README.md` → links to every file under `docs/`, plus `requirements.md`, `pcb_parasitics/extraction_flow.md`, and the top-level Obsidian vault index (`obsidian_vault/00-MOC/Home.md`).
- `docs/SIMULATION_GUIDE.md` → links to relevant entries in `docs/MODEL_LIBRARY.md` (e.g. a converter sim links to the diode/MOSFET model it uses) and to `pcb_parasitics/extraction_flow.md` where a simulation used extracted parasitics.
- `docs/MODEL_LIBRARY.md` → links back to the simulations that use each model.
- `pcb_parasitics/extraction_flow.md` → links to `docs/TECHNICAL_REPORT.md` Chapter 5 and to the specific gate-driver simulation it feeds.
- `docs/THEORY_NOTES.md` → links to the simulation/model files each troubleshooting note applies to.
- `docs/TECHNICAL_REPORT.md` → links to all of the above per chapter, since it's the synthesis document.
- No document should be an orphan (unreached by any link) or a dead end (contains no outbound links where a logical cross-reference exists). This gets verified in Step 7 (Final Review).

---

## 5. Step 4 — Obsidian Vault / Knowledge Notes

Build `obsidian_vault/` as a genuinely usable standalone Obsidian vault, not just a copy-paste of `docs/`. This is the "second brain" layer — atomic, linkable notes, meant for browsing via Obsidian's graph view and backlinks, separate in style from the formal README/report prose.

### 5.1 Structure
- `00-MOC/` — Maps of Content. At minimum: `Home.md` (top-level index, links to every other MOC), `MOC-Simulations.md`, `MOC-Models.md`, `MOC-Parasitics.md`, `MOC-Analysis.md`, `MOC-Troubleshooting.md`.
- `01-Projects/` — one note per real project found (e.g. `NOVA Gate Driver.md`), summarizing scope and linking out to every note that belongs to it.
- `02-Simulations/` — one atomic note per real simulation/circuit (e.g. `IRF640NS Gate Driver Transient Sim.md`), with frontmatter tags and `[[wikilinks]]` to the models it uses and the project it belongs to.
- `03-Models/` — one note per real device/passive model (e.g. `IRF640NS MOSFET Model.md`, `TDK N30 Toroid Transformer.md`), linked back to every simulation that uses it.
- `04-Parasitics/` — notes on the Q3D extraction workflow, RLGC results, equivalent circuits — linked to the reference materials in section 1.7 and to the simulations that consume the extracted parasitics.
- `05-Analysis/` — notes on the MATLAB/Octave analysis methodology (ringing analysis, FFT, log-decrement vs Hilbert), explicitly including a note on the open ringing-energy-metric inconsistency (section 1.3), linked from both the simulated-side and practical-side analysis notes.
- `06-Troubleshooting/` — one note per real solved issue (e.g. `BSIM3 LEVEL7 to LEVEL8 Porting Fix.md`), plus one note for the currently-open issue (capacitor unit error at fast-switching node), clearly tagged `#status/open` vs `#status/resolved`.
- `attachments/` — real images/figures referenced by the notes (can symlink or copy from `assets/`, your call — note the choice).

### 5.2 Note conventions
- YAML frontmatter on every note: `tags`, `status` (e.g. `resolved`/`open`/`reference`), `related` (optional list).
- Use `[[Note Name]]` wikilinks for all internal cross-references — not relative markdown paths — since this vault is meant to be opened directly in Obsidian.
- Every project/simulation/model/troubleshooting note should be reachable from at least one MOC and link back to its MOC (`[[MOC-Simulations]]`), so the Obsidian graph view isn't full of disconnected islands.
- Keep individual notes atomic (one concept per note) rather than replicating the long-form prose of `docs/TECHNICAL_REPORT.md` — the vault is for fast navigation and connections, the report is for linear reading.
- Same fabrication rule applies here: if a project/simulation/model doesn't actually exist in the repo, don't create a note claiming it does.

### 5.3 `obsidian_vault/00-MOC/Home.md`
This is the vault's front door. It should briefly describe the suite, then link to every other MOC, and also link back out to `../../README.md` and `../../docs/TECHNICAL_REPORT.md` so someone browsing the vault can always get back to the formal deliverables.

---

## 6. Step 5 — README.md

Professional GitHub README with:
- Title + one-line description: *"An open-source NGSpice-based power electronics simulation framework for realistic converter modelling, switching analysis, and parasitic-aware circuit validation."*
- Sections: Overview, Features, Repository Structure, Installation, Requirements, Quick Start, Example Simulations, Modelling Approach, PCB Parasitic Workflow, Results Gallery, Documentation, Related Projects, Future Development, Contribution Guidelines.
- Real images pulled from `assets/`.
- Badges: NGSpice, KiCad, MATLAB, License, Documentation.
- A **Documentation** section that links out to every file in `docs/`, `pcb_parasitics/extraction_flow.md`, `requirements.md`, and `obsidian_vault/00-MOC/Home.md` — per the internal linking requirement in 4.8.
- A **Related Projects** section linking (only as external references, per section 1.8) to the from-scratch SPICE simulator project and/or portfolio site, if reachable URLs exist.
- "Future Development" should honestly include the in-progress items: the power-supply-board convergence debugging, and the ringing-energy-metric reconciliation — this is good-faith open-source practice, not a weakness to hide.

---

## 7. Step 6 — Technical Report

`docs/TECHNICAL_REPORT.md` (and `.pdf` if LaTeX/pandoc tooling is available in the environment):

**Title:** *NGSpice-Based Power Electronics Simulation Suite: Non-Ideal Device Modelling, Switching Analysis, and Parasitic-Aware Validation*

Structure:
- Abstract (motivation, methodology, outcomes — grounded in what's actually in the repo)
- Ch. 1 — Introduction
- Ch. 2 — SPICE Simulation Methodology
- Ch. 3 — Power Electronics Circuit Modelling
- Ch. 4 — Semiconductor and Passive Component Models
- Ch. 5 — PCB Parasitic Extraction Workflow
- Ch. 6 — Simulation Results
- Ch. 7 — Waveform Processing and Analysis
- Ch. 8 — Limitations and Future Improvements (**must include** the two known open issues from sections 1.1 and 1.3 above, stated plainly)
- Conclusion

Every figure: numbered, captioned, briefly explained. Pull real figures out of the existing LaTeX report where it exists rather than regenerating from scratch — that report was already reviewed and is the authoritative source for anything it covers. Each chapter should end with a short "See also" line linking to the relevant `docs/` file(s) and Obsidian MOC.

---

## 8. Step 7 — Repo Hygiene

- `requirements.md`: NGSpice version (v46, XSPICE-enabled), MATLAB requirements, Python requirements (PyVISA-py etc.), plotting tools, KiCad version/requirements — all pulled from what's actually configured, not assumed.
- `LICENSE`: MIT unless a different license is already present in the repo.
- `CITATION.cff`: basic citation metadata.
- `CONTRIBUTING.md`: short, standard contribution process.

---

## 9. Step 8 — Final Review

Before declaring done, run:
1. Repo structure check (matches target structure, nothing orphaned)
2. README review (all links resolve, all referenced images exist)
3. Markdown link check across `docs/` **and** `obsidian_vault/` (wikilinks resolve to real notes, no broken `[[links]]`)
4. Re-run simulation execution test (confirm nothing broke during the file moves)
5. Figure verification (every figure referenced in `TECHNICAL_REPORT.md` and in Obsidian notes actually exists in `assets/`/`attachments/`)
6. Documentation consistency check (no contradictions between README, SIMULATION_GUIDE, TECHNICAL_REPORT, and the Obsidian notes)
7. Orphan check: every note in `obsidian_vault/` is linked from at least one MOC; every doc in `docs/` is linked from README or another doc

Write `FINAL_REVIEW.md`: completed tasks, remaining limitations (explicitly list the power-supply convergence bug and the ringing-energy-metric inconsistency), recommended future work.

---

## 10. Hard Constraints (repeat, because these matter most)

- Do not remove existing engineering work.
- Do not simplify technical explanations to make them sound cleaner than the underlying work.
- Do not invent simulation results, measurements, or figures.
- Do not present the in-progress Xyce power-supply-board debugging as resolved.
- Do not silently resolve the ringing-energy-metric inconsistency between the two MATLAB scripts.
- Do not merge the separate SPICE-simulator or portfolio-site projects into this repo's content — link only.
- Where data is genuinely missing, write exactly: `Data unavailable in current repository.`

---

## 11. Deliverables Checklist

- [ ] `docs/REPOSITORY_AUDIT.md`
- [ ] Reorganized repo matching target structure, nothing deleted
- [ ] `README.md` — fully cross-linked per section 4.8/6
- [ ] `docs/SIMULATION_GUIDE.md`
- [ ] `docs/MODEL_LIBRARY.md`
- [ ] `pcb_parasitics/extraction_flow.md`
- [ ] `docs/THEORY_NOTES.md`
- [ ] `docs/TECHNICAL_REPORT.md` (+ PDF if tooling allows)
- [ ] `requirements.md`, `LICENSE`, `CITATION.cff`, `CONTRIBUTING.md`
- [ ] `assets/` populated with real figures, correctly captioned
- [ ] `obsidian_vault/` — MOCs, atomic notes, wikilinked, no orphans (Section 5)
- [ ] `FINAL_REVIEW.md`