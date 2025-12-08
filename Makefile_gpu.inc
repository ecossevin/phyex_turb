FCFLAGS=-mp -fPIC -Minfo -gopt -Mlarge_arrays -Mlist -traceback -Mnofma -Mbyteswapio -Mbackslash -Mstack_arrays -cuda -acc=gpu -O1 -r8 -gopt -gpu=cc70,cc80 -Minfo=accel,all,ccff -DARCH="'$(ARCH)'"              

ARCH=cpu_intel_d
LIBS=-lnvhpcwrapnvtx -lnvToolsExt

FC=fxtran-f90 \
  --prefix fxtran-acdc \
  --user-directory-in user-in \
  --user-directory-out user-out \
  --config $(SRC)/fxtran.conf -- \
  "$(PWD)/../wrap/NVHPC2405ECTRANSGPU/mpif90" \
  $(FCFLAGS) -DARCH="'$(ARCH)'"


CXX=nvc++

boot: fxtran-acdc

fxtran-acdc:
	fxtran-boot --prefix fxtran-acdc --F90 "$(PWD)/../wrap/NVHPC2405ECTRANSGPU/mpif90 $(FCFLAGS)" --CXX $(CXX)

CC=gcc
