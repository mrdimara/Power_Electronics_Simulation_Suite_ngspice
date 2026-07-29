---
title: Missing Include File
tags: [troubleshooting]
symptom:
  - "Error: Could not find include file"
  - "fatal error in ngspice, exit(1)"
  - "No such file or directory"
root_cause:
  - Incorrect relative path in .include or .lib statement
  - File moved or deleted
  - Case sensitivity mismatch (on some filesystems)
  - Missing file in repository
fix:
  - Verify the path in the netlist
  - Use absolute path for debugging (then convert to relative)
  - Check file existence with `ls` or `dir`
  - Ensure file is committed to Git
  - Use `scripts/validate_netlists.py` to detect broken includes
verification:
  - Run simulation again
  - Check that the include file is found and parsed
prevention:
  - Use relative paths from the netlist's directory
  - Avoid hard-coded absolute paths
  - Run validation before committing
  - Keep included files close to the netlist when possible
related:
  - [['Broken Includes']]
  - [['Include Path Best Practices']]
  - [['Validate Netlists']]
---

# Missing Include File

## Symptom

When running a simulation, ngspice exits with an error like:

```
Error: Could not find include file "filename.sub"
While reading netlist.cir
ERROR: fatal error in ngspice, exit(1)
```

or

```
Error: Could not find include file "/path/to/file.lib"
While reading netlist.net
ERROR: fatal error in ngspice, exit(1)
```

## Root Cause

This error occurs when ngspice cannot locate a file specified in an `.include` or `.lib` statement. Common causes include:

- The file path is incorrect relative to the location of the netlist being simulated
- The file has been moved, renamed, or deleted
- The filesystem is case-sensitive (e.g., Linux) and the filename
- The file exists but was accidentally during a file

## Fix

### Step 1: Identify the Missing File
Note the exact filename from the error message (including extension).

### Step 2: Check the .include/.lib Statement
Open the netlist and locate the line that includes the file. It will look like:
```
.include "path/to/file.sub"
.lib "path/to/file.lib"
```

### Step 3: Verify File Existence
From the directory containing the netlist, check if the file exists at the specified path:
```bash
ls -l "path/to/file.sub"
```
If the file is not there, search for it elsewhere in the repository:
```bash
find . -name "file.sub" -type f
```

### Step 4: Correct the Path
If the file exists but the path is wrong, edit the netlist to use the correct relative path. The path should be relative to the directory of the netlist file.

Example:
If the netlist is `simulations/converters/buck/buck.cir` and the file is `simulations/converters/buck/buck.net`, the correct include is:
```
.include "buck.net"
```

If the file is in a subdirectory:
```
include "subdir/file.sub"
```

### Step 5: Handle Case Sensitivity
If working on a case-sensitive filesystem (Linux, macOS default), ensure the case matches exactly. For example, `myfile.Sub` is not the same as `myfile.sub`.

### Step 6: Confirm Fix
Save the netlist and run the simulation again. The error should disappear.

## Verification

After fixing the include:
- Run the simulation: `ngspice -b netlist.cir`
- Confirm that the simulation proceeds past the netlist parsing stage
- Check for other errors (e.g., missing models, convergence issues)

## Prevention

- **Use Relative Paths**: Always use paths relative to the netlist's directory. Avoid absolute paths like `/Users/name/project/...`.
- **Validate Before Committing**: Run `python3 scripts/validate_netlists.py` to catch broken includes early.
- **Keep Related Files Together**: When possible, keep .sub and .lib files in the same directory as the netlist that uses them.
- **Use Git to Track Files**: Ensure all included files are added to the repository: `git add path/to/file.sub`.
- **Leverage Tab Completion**: When editing, use tab completion in your editor to avoid typos in filenames.

## Related Issues

- [['Broken Includes']]: General category of include/path problems
- [['Include Path Best Practices']]: Guidelines for writing robust include statements
- [['Validate Netlists']]: How to use the validation script to find issues
- [['Case Sensitivity in File Paths']]: Specific issues on case-sensitive filesystems

## Example

**Error**:
```
Error: Could not find include file "./edt01.sub"
While reading simulations/dc_dc/non_isolated/buck/buck_c_ascii.cir
ERROR: fatal error in ngspice, exit(1)
```

**Fix**:
Check that `simulations/dc_dc/non_isolated/buck/edt01.sub` exists. If it does, the error may be due to a typo or incorrect path. In this case, the file exists but the netlist incorrectly references it as `./edt01.sub` when it should be `edt01.sub` (if in same directory) or the path is wrong relative to the netlist location.

Actually, in this example, the file is in the same directory, so the correct include is:
```
.include "edt01.sub"
```

## Notes

- Some netlists may include files from a `models/` directory using relative paths like `../../models/diodes/rectifiers.lib`. Ensure the relative path count is correct.
- If using a symbolic link, ensure it resolves correctly.
- On Windows, be aware of backslashes vs. forward slashes; use forward slashes or double backslashes in SPICE.

## Tags

#troubleshooting #include-path #file-not-found #ngspice-error
