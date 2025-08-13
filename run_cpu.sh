#!/bin/bash
#SBATCH -N1
#SBATCH -p normal256
#SBATCH --nodes=1
#SBATCH --time 00:10:00
#SBATCH --exclusive
#SBATCH -p normal256,huge512,debug256,debug512

set -x

ulimit -s unlimited
export OMP_STACKSIZE=4G
export OMP_NUM_THREADS=8

SUBMIT_DIR=./turb.$$
mkdir $SUBMIT_DIR
cd $SUBMIT_DIR

#arch=gpu_nvhpc_d
arch=cpu_intel_d

######test bon fonctionnement - petit
#for method in openmp openmp_bitrepro openmpsinglecolumn openaccsinglecolumn
for method in openmp 
do
../compile.${arch}/main_turb.x \
  --case-in /home/gmap/mrpm/cossevine/phyex_turb/data_small/ \
  --verbose  --diff  \
  --nproma 32        \
  --method $method > $method.txt 2>&1
done

#####création de fichier - petit
##for method in openaccsinglecolumn
##do
##../compile.${arch}/main_shallow_mf.x  \
##  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_small_gpu/ \
##  --case-out /home/gmap/mrpm/penigaudn/shallow_mf/data_small_gpu_repro/ \
##  --verbose  --diff  \
##  --method $method > $method.txt 2>&1
##done

######gros 
###for method in openaccsinglecolumn
###do
###../compile.${arch}/main_shallow_mf.x  \
###  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_gpu/ \
###  --case-out /home/gmap/mrpm/penigaudn/shallow_mf/data_gpu_repro/ \
###  --verbose  --diff  \
###  --method $method > $method.txt 2>&1
###done

######test reproductibilité exacte - petit
##for method in openmp openmp_bitrepro openmpsinglecolumn openaccsinglecolumn
##do
##../compile.${arch}/main_shallow_mf.x  \
##  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_small_gpu_repro/ \
##  --verbose  --diff  \
##  --nproma 32        \
##  --method $method > $method.txt 2>&1
##done

######gros
##for method in openmp openmp_bitrepro openmpsinglecolumn openaccsinglecolumn
##do
##../compile.${arch}/main_shallow_mf.x  \
##  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_gpu_repro/ \
##  --verbose  --diff  \
##  --nproma 32        \
##  --method $method > $method.txt 2>&1
##done



####test effet précision des fonctions de br_transcendentals.cc
###for method in openmp openmp_bitrepro openmpsinglecolumn openaccsinglecolumn
###do
###../compile.${arch}/main_shallow_mf.x  \
###  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_small_gpu/ \
###  --verbose  --diff  \
###  --nproma 32        \
###  --method $method > $method.txt 2>&1
###done

####vérifie que le cas openacc tourne bien sur GPU
###for method in openaccsinglecolumn
###do
###srun /opt/softs/nvidia/hpc_sdk/Linux_x86_64/23.3/compilers/bin/nsys profile ../compile.${arch}/main_shallow_mf.x  \
###  --case-in /home/gmap/mrpm/penigaudn/shallow_mf/data_gpu_repro/ \
###  --verbose  --diff  \
###  --nproma 32        \
###  --method $method > $method.txt 2>&1
###done
