FC=mpif90
FCFLAGS=-I$(NETCDF)/include
LDFLAGS=-L$(NETCDF)/lib -lnetcdff -lnetcdf -L$(NETCDF)/lib -lhdf5_hl -lhdf5 -lz -L -lblas -lmkl_rt #-lpthread -ldl # module load mkl/v4.5

objs = precision.o lmpi.o io_control.o ini_fnl.o driver.o

run.exe : $(objs)
	$(FC) $^ -o $@ $(LDFLAGS)
%.o : %.F90
	$(FC) $(FCFLAGS) -c $^
clean:
	rm -f *.o *.mod run.exe
