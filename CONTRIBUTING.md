# Contributing to NGSpice Power Electronics Simulation Suite

Thank you for considering contributing to this project! We welcome contributions from the community.

## How to Contribute

There are many ways to contribute to this project:

1. **Report bugs** - Open an issue describing the problem
2. **Suggest features** - Open an issue describing the feature you'd like to see
3. **Improve documentation** - Help improve or write documentation
4. **Fix bugs** - Submit pull requests with fixes
5. **Add new features** - Submit pull requests with new functionality
6. **Add examples** - Contribute new simulation examples
7. **Improve models** - Contribute improved device models

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/ngspice.git
   ```
3. Create a branch for your changes:
   ```bash
   git checkout -b feature-or-fix-name
   ```
4. Make your changes
5. Test your changes thoroughly
6. Commit your changes:
   ```bash
   git commit -am "Description of changes"
   ```
7. Push to your fork:
   ```bash
   git push origin feature-or-fix-name
   ```
8. Submit a pull request

## Reporting Issues

When reporting issues, please include:
- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior vs. actual behavior
- Screenshots or error messages if applicable
- Version information (NGSpice version, OS, etc.)
- Any relevant simulation files

## Pull Request Guidelines

Before submitting a pull request, please ensure:

1. Your code follows the existing style in the project
2. You have tested your changes thoroughly
3. You have updated any relevant documentation
4. Your commit messages are clear and descriptive
5. You have referenced any related issues in your pull request description

### Simulation Contributions
When contributing new simulations or models:

1. **Organization**: Place new simulations in the appropriate directory under `simulations/`
2. **Documentation**: Include a README.md in the simulation directory explaining:
   - What the simulation demonstrates
   - How to run it
   - What parameters to adjust
   - What results to expect
3. **Models**: Place new device models in the appropriate subdirectory under `models/`
4. **Verification**: Include verification that the simulation produces reasonable results
5. **Clean up**: Remove any temporary or unnecessary files

### Documentation Contributions
When contributing documentation:

1. Use clear, concise language
2. Include examples where helpful
3. Follow the existing documentation style
4. For technical documentation, include relevant equations and references
5. Update diagrams or schematics if applicable

## Code Style

While this project contains various file types (SPICE netlists, MATLAB scripts, documentation), please follow these general principles:

- Use consistent naming conventions
- Comment your code/documents clearly
- For code: follow the style already present in the file you're modifying
- For SPICE: use clear node names and include comments explaining circuit function
- For documentation: use markdown formatting consistently

## Licensing

By contributing to this project, you agree that your contributions will be licensed under the MIT License (see LICENSE file).

## Getting Help

If you need help with your contribution:
- Check existing issues and pull requests
- Look at the documentation in the `docs/` directory
- Ask questions in the Issues section

Thank you again for contributing to this project!
