# Molecular Docking with AutoDock Vina

This repository contains a bash script for performing molecular docking using AutoDock Vina. The script automates the docking process and includes input validation and result summarization.

## Prerequisites

- AutoDock Vina installed (http://vina.scripps.edu/)
- Input files in PDBQT format
- Configuration file specifying the docking parameters

## Repository Structure

```
molecular_docking/
├── scripts/
│   └── molecular_docking.sh
├── examples/
│   ├── example_config.txt
│   ├── example_ligand.pdbqt
│   └── example_receptor.pdbqt
├── results/
└── README.md
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/molecular_docking.git
cd molecular_docking
```

2. Ensure AutoDock Vina is installed:
```bash
vina --help
```

3. Make the script executable:
```bash
chmod +x scripts/molecular_docking.sh
```

## Usage

Run the docking script with required parameters:

```bash
./scripts/molecular_docking.sh -c config.txt -l ligand.pdbqt -r receptor.pdbqt
```

Optional parameters:
- `-o`: Output directory (default: docking_results)
- `-n`: Number of binding modes (default: 9)
- `-e`: Exhaustiveness (default: 8)
- `-g`: Energy range (default: 3)

Example:
```bash
./scripts/molecular_docking.sh -c examples/example_config.txt -l examples/example_ligand.pdbqt -r examples/example_receptor.pdbqt -o results -n 10 -e 16
```

## Output

- Docked poses: `docking_results/ligand_docked.pdbqt`
- Log file: `docking_results/ligand_docking.log`
- Basic summary of binding affinities printed to console

## Example Configuration File

Create a `config.txt` with docking parameters:

```
center_x = 10.0
center_y = 20.0
center_z = 30.0
size_x = 20
size_y = 20
size_z = 20
```

## Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a Pull Request

## License

MIT License

## Contact

For issues or questions, please open an issue on GitHub.