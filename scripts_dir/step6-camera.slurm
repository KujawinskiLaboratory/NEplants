#!/bin/bash
#SBATCH --partition=compute
#SBATCH --job-name=step6_camera
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=klongnecker@whoi.edu
#SBATCH --ntasks-per-node=12
#SBATCH --mem=20gb
#SBATCH --time=6:00:00
#SBATCH --output=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step6.out
#SBATCH --error=/vortexfs1/home/klongnecker/NEplants/logfiles_dir/step6.error

dir="$HOME/NEplants"
cd "$dir"

work_dir="$dir/output_dir/xcms2"

log_dir="$dir/logfiles_dir" 

echo `date`
echo This is job $SLURM_JOB_ID

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate untargKL4

Rscript --no-save --no-restore --verbose $dir/scripts_dir/CAMERA_KL.R "$work_dir" > "$log_dir/${SLURM_JOB_NAME}.Rout" 2>&1 > $log_dir/${SLURM_JOB_NAME}.log
 
echo `date`
