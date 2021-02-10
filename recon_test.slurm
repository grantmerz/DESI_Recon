#!/bin/bash
#SBATCH -p regular
#SBATCH -o propagator_job_mesh
#SBATCH -N 1
#SBATCH -t 00:15:00
#SBATCH -C haswell

#data and randoms examples
data=/global/project/projectdirs/desi/users/UNIT-BAO-RSD-challenge/Reconstruction/Results_stage2/ELG/den2/Javier/ELG-wpmax-v3-snap97-redshift0.99_dens2-20xpad0_red_smoo5.0.datDan.recon

randoms=/global/project/projectdirs/desi/users/UNIT-BAO-RSD-challenge/Reconstruction/Results_stage2/ELG/den2/Javier/ELG-wpmax-v3-snap97-redshift0.99_dens2-20xpad0.red_smoo5.0.ranDan.recon

#intial density field (binary file with (x,y,z) indices, x varying the fastest
init=/global/project/projectdirs/desi/users/UNIT-BAO-RSD-challenge/Reconstruction/Stage2/IC/UNIT/minusden0512.bin
#init=/global/cscratch1/sd/yuyu22/unitic/den0512.bin 

out=test_mesh

#example for inputting the reconstructed mesh
mesh=/global/project/projectdirs/desi/users/UNIT-BAO-RSD-challenge/Reconstruction/Stage1/ReconstructedCatalogs/Xinyi/delta_r_iter_run1001_z0_sm5_desi_mock.dat.npy


# load nbodykit
source /global/common/software/m3035/conda-activate.sh 3.7


#other arguments (all defaulted)
# --b 1.4 bias
# --Gf 0.61207 growth factor (D(z)/D(0))
# --Nmesh 512
# --Nmu 10 number of mu bins for 2D propagator

# run with data and randoms catalogs
srun -n 1 -c 64 python propagator_catalog_calc.py --data ${data} --ran ${randoms} --init ${init} --out ${out}

#to run with a mesh, use
#srun -n 1 -c 64 python propagator_catalog_calc.py --from_mesh --mesh ${mesh} --init ${init} --out ${out}
