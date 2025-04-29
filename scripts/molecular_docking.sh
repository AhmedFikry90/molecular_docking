#!/bin/bash

# molecular_docking.sh - A script for molecular docking using AutoDock Vina
# author ====== Ahmed Fikry El-Sayed =======

# Check if AutoDock Vina is installed
if ! command -v vina &> /dev/null; then
    echo "Error: AutoDock Vina is not installed. Please install it first."
    exit 1
fi

# Default parameters
CONFIG_FILE=""
LIGAND=""
RECEPTOR=""
OUT_DIR="docking_results"
NUM_MODES=9
EXHAUSTIVENESS=8
ENERGY_RANGE=3

# Function to display usage
usage() {
    echo "Usage: $0 -c config_file -l ligand_file -r receptor_file [-o output_dir] [-n num_modes] [-e exhaustiveness] [-g energy_range]"
    echo "  -c  Configuration file for docking"
    echo "  -l  Ligand file (PDBQT format)"
    echo "  -r  Receptor file (PDBQT format)"
    echo "  -o  Output directory (default: docking_results)"
    echo "  -n  Number of binding modes (default: 9)"
    echo "  -e  Exhaustiveness of search (default: 8)"
    echo "  -g  Energy range (default: 3)"
    exit 1
}

# Parse command-line arguments
while getopts "c:l:r:o:n:e:g:h" opt; do
    case $opt in
        c) CONFIG_FILE="$OPTARG";;
        l) LIGAND="$OPTARG";;
        r) RECEPTOR="$OPTARG";;
        o) OUT_DIR="$OPTARG";;
        n) NUM_MODES="$OPTARG";;
        e) EXHAUSTIVENESS="$OPTARG";;
        g) ENERGY_RANGE="$OPTARG";;
        h) usage;;
        *) usage;;
    esac
done

# Validate required inputs
if [ -z "$CONFIG_FILE" ] || [ -z "$LIGAND" ] || [ -z "$RECEPTOR" ]; then
    echo "Error: Configuration file, ligand file, and receptor file are required."
    usage
fi

# Check if input files exist
for file in "$CONFIG_FILE" "$LIGAND" "$RECEPTOR"; do
    if [ ! -f "$file" ]; then
        echo "Error: File $file does not exist."
        exit 1
    fi
done

# Create output directory
mkdir -p "$OUT_DIR"

# Generate output filenames
BASENAME=$(basename "$LIGAND" .pdbqt)
OUT_PDBQT="$OUT_DIR/${BASENAME}_docked.pdbqt"
LOG_FILE="$OUT_DIR/${BASENAME}_docking.log"

# Run AutoDock Vina
echo "Starting molecular docking..."
vina \
    --config "$CONFIG_FILE" \
    --ligand "$LIGAND" \
    --receptor "$RECEPTOR" \
    --out "$OUT_PDBQT" \
    --log "$LOG_FILE" \
    --num_modes "$NUM_MODES" \
    --exhaustiveness "$EXHAUSTIVENESS" \
    --energy_range "$ENERGY_RANGE"

# Check if docking was successful
if [ $? -eq 0 ]; then
    echo "Docking completed successfully!"
    echo "Results saved in: $OUT_PDBQT"
    echo "Log file: $LOG_FILE"
else
    echo "Error: Docking failed. Check $LOG_FILE for details."
    exit 1
fi

# Optional: Basic result summary
if [ -f "$LOG_FILE" ]; then
    echo -e "\nDocking Summary:"
    grep "Affinity" "$LOG_FILE" | head -n 5
fi