#!/bin/bash
#SBATCH --partition=compute
#SBATCH --job-name=step3_xcms_combine
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=klongnecker@whoi.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=175gb
#SBATCH --time=01:00:00
#SBATCH --output=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step3.out
#SBATCH --error=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step3.error

dir="$HOME/NEplants"

in_dir="$HOME/NEplants/output_dir/xcms1"
cd $in_dir

log_dir="$dir/logfiles_dir"  

echo `date`
echo This is job $SLURM_JOB_ID

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate untargKL4

Rscript --no-save --no-restore --verbose $dir/scripts_dir/xcms_combine.R "$in_dir" "$ionMode" > "$log_dir/${SLURM_JOB_NAME}_$ionMode.Rout" 2>&1 > "$log_dir/${SLURM_JOB_NAME}_$ionMode.log"
