#!/bin/bash
#SBATCH --partition=bigmem
#SBATCH --job-name=step4_xcms2
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=klongnecker@whoi.edu
#SBATCH --ntasks-per-node=36
#SBATCH --mem=2000gb
#SBATCH --time=6:00:00
#SBATCH --output=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step4.out
#SBATCH --error=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step4.error

dir="$HOME/NEplants"
cd "$dir"

in_dir="$dir/output_dir/xcms1"
out_dir="$dir/output_dir/$SLURM_JOB_NAME"

if [ ! -d "$out_dir" ]; then
    mkdir -p "$out_dir"
fi

log_dir="$dir/logfiles_dir" 

echo `date`
echo This is job $SLURM_JOB_ID

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate untargKL4

Rscript --no-save --no-restore --verbose $dir/scripts_dir/xcms2.R "$in_dir" "$out_dir" "$ionMode" > "$log_dir/${SLURM_JOB_NAME}_$ionMode.Rout" 2>&1 > "$log_dir/${SLURM_JOB_NAME}_$ionMode.log"
