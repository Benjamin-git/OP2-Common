#!/bin/bash
#set -e

#
#Set up directory vars and Build with cmake
#
. ./source_intel
export CURRENT_DIR=$PWD
cd ../op2
export OP2_INSTALL_PATH=$PWD
cd $OP2_INSTALL_PATH/c
rm -rf ruby.sh
ln -s $CURRENT_DIR/ruby.sh ruby.sh
./ruby.sh
cd $OP2_INSTALL_PATH
cd ../apps/c
rm -rf ruby-apps.sh
ln -s $CURRENT_DIR/ruby-apps.sh ruby-apps.sh
./ruby-apps.sh
export OP2_APPS_DIR=$PWD
export OP2_C_APPS_BIN_DIR=$OP2_APPS_DIR/bin
cd $OP2_C_APPS_BIN_DIR
echo "In directory $PWD"


#-------------------------------------------------------------------------------
# test Arifoil DP- with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "----------------Testing airfoil_dp_seq ----------------------------------"
echo " "
#./airfoil_dp_seq > perf_out
#grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_cuda ---------------------------------"
echo " "
./airfoil_dp_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_openmp--------------------------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_dp_openmp OP_PART_SIZE=256  > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_mpi ----------------------------------"
echo " "
export OMP_NUM_THREADS=1
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./airfoil_dp_mpi > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_mpi_cuda 1 mpi proc ------------------"
echo " "
./airfoil_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_mpi_cuda 2 mpi procs------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./airfoil_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_mpi_openmp 1 mpi proc ----------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "----------------Testing airfoil_dp_mpi_openmp 11 mpi procs---------------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./airfoil_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 



#-------------------------------------------------------------------------------
# test Arifoil SP- with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "-----------------Testing airfoil_sp_seq----------------------------------"
echo " "
#./airfoil_sp_seq > perf_out;
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-----------------Testing airfoil_sp_cuda---------------------------------"
echo " "
./airfoil_sp_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_openmp-------------------------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_sp_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_mpi----------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./airfoil_sp_mpi > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_mpi_cuda 1 mpi proc -----------------"
echo " "
./airfoil_sp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_mpi_cuda 2 mpi procs-----------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./airfoil_sp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_mpi_openmp 1 mpi proc ---------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_sp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_sp_mpi_openmp 11 mpi procs--------------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./airfoil_sp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 


#-------------------------------------------------------------------------------
# test Arifoil DP- with hdf5 file I/O
#-------------------------------------------------------------------------------

echo " "
echo "-----------------Testing airfoil_hdf5_dp_seq-----------------------------"
echo " "
./airfoil_hdf5_dp_seq > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-----------------Testing airfoil_hdf5_dp_cuda ---------------------------"
echo " "
./airfoil_hdf5_dp_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_openmp -------------------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_hdf5_dp_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_mpi-----------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./airfoil_hdf5_dp_mpi > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_mpi_cuda 1 mpi proc ------------"
echo " "
./airfoil_hdf5_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_mpi_cuda 2 mpi procs------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./airfoil_hdf5_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_mpi_openmp 1 mpi proc ----------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_hdf5_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_hdf5_dp_mpi_openmp 11 mpi procs---------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./airfoil_hdf5_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 


#-------------------------------------------------------------------------------
# test Arifoil_tempdats DP 
#-------------------------------------------------------------------------------

echo " "
echo "-----------------Testing Sairfoil_tempdats_seq---------------------------"
echo " "
./airfoil_tempdats_seq > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-----------------Testing airfoil_tempdats_cuda---------------------------"
echo " "
./airfoil_tempdats_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_openmp-------------------------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_tempdats_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_mpi ---------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./airfoil_tempdats_mpi > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_mpi_cuda 1 mpi proc -----------"
echo " "
./airfoil_tempdats_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_mpi_cuda 2 mpi procs-----------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./airfoil_tempdats_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_mpi_openmp 1 mpi proc----------"
echo " "
export OMP_NUM_THREADS=24
./airfoil_tempdats_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 

echo " "
echo "-----------------Testing airfoil_tempdats_mpi_openmp 1 mpi procs---------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./airfoil_tempdats_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "1.060" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 



#-------------------------------------------------------------------------------
# test Jac DP - with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "------------------Testing jac1_dp_seq------------------------------------"
echo " "
./jac1_dp_seq > perf_out
grep "Results check" perf_out 

echo " "
echo "------------------Testing jac1_dp_cuda ----------------------------------"
echo " "
./jac1_dp_cuda > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac1_dp_openmp --------------------------------"
echo " "
export OMP_NUM_THREADS=24
./jac1_dp_openmp > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac1_dp_mpi------------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./jac1_dp_mpi > perf_out
grep "Results check" perf_out

#-------------------------------------------------------------------------------
# test Jac SP - with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "------------------Testing jac1_sp_seq------------------------------------"
echo " "
./jac1_sp_seq > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac1_sp_cuda-----------------------------------"
echo " "
./jac1_sp_cuda  > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac1_sp_openmp---------------------------------"
echo " "
export OMP_NUM_THREADS=24
./jac1_sp_openmp  > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac1_sp_mpi------------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./jac1_sp_mpi > perf_out
grep "Results check" perf_out


#-------------------------------------------------------------------------------
# test Jac2 DP - with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "------------------Testing jac2_seq --------------------------------------"
echo " "
./jac2_seq > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac2_cuda--------------------------------------"
echo " "
./jac2_cuda  > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac2_openmp------------------------------------"
echo " "
export OMP_NUM_THREADS=24
./jac2_openmp  > perf_out
grep "Results check" perf_out

echo " "
echo "------------------Testing jac2_mpi---------------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./jac2_mpi > perf_out
grep "Results check" perf_out



#-------------------------------------------------------------------------------
# test Aero DP- with plain text file I/O
#-------------------------------------------------------------------------------

echo " "
echo "-------------------Testing aero_dp_seq-----------------------------------"
echo " "
./aero_dp_seq > perf_out
grep "rms = 5.6" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out 


echo " "
echo "-------------------Testing aero_dp_cuda----------------------------------"
echo " "
./aero_dp_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_openmp--------------------------------"
echo " "
export OMP_NUM_THREADS=24
./aero_dp_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_mpi-----------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./aero_dp_mpi > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_mpi_cuda 1 mpi proc ------------------"
echo " "
./aero_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_mpi_cuda 2 mpi procs------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./aero_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_mpi_openmp 1 mpi proc ----------------"
echo " "
./aero_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_dp_mpi_openmp 11 mpi procs---------------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./aero_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out




#-------------------------------------------------------------------------------
# test Aero DP- with hdf5 file I/O
#-------------------------------------------------------------------------------

echo " "
echo "-------------------Testing Saero_hdf5_dp_seq-----------------------------"
echo " "
./aero_hdf5_dp_seq > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out


echo " "
echo "-------------------Testing aero_hdf5_dp_cuda ----------------------------"
echo " "
./aero_hdf5_dp_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_openmp --------------------------"
echo " "
export OMP_NUM_THREADS=24
./aero_hdf5_dp_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_mpi------------------------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 22 ./aero_hdf5_dp_mpi > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_mpi_cuda 1 mpi proc -------------"
echo " "
./aero_hdf5_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_mpi_cuda 2 mpi procs-------------"
echo " "
$MPI_INSTALL_PATH/bin/mpirun -np 2 ./aero_hdf5_dp_mpi_cuda OP_PART_SIZE=128 OP_BLOCK_SIZE=192 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_mpi_openmp 1 mpi proc -----------"
echo " "
./aero_hdf5_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

echo " "
echo "-------------------Testing aero_hdf5_dp_mpi_openmp 11 mpi procs----------"
echo " "
export OMP_NUM_THREADS=2
$MPI_INSTALL_PATH/bin/mpirun -np 11 ./aero_hdf5_dp_mpi_openmp OP_PART_SIZE=256 > perf_out
grep "iter: 200" perf_out;grep "Max total runtime" perf_out;tail -n 1  perf_out

