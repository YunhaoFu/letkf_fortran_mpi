module lmpi

  use mpi
	use precision
  implicit none
  
  private

  public  ::   letkf_mpi_init, letkf_mpi_final, lbcast

	integer, public, protected  ::  pe_size
	integer, public, protected  ::  pe_rank
	integer, public, protected  ::  letkf_mpi_comm
	integer, public, protected  ::  pe_root
	logical, public, protected	::	pe_isroot

	interface lbcast
		module procedure lbcast_integer
		module procedure lbcast_integer_1d
		module procedure lbcast_real8
		module procedure lbcast_real8_1d
	endinterface lbcast

  contains
		
		subroutine letkf_mpi_init()
			integer  ::  ierr
			call mpi_init(ierr)
			letkf_mpi_comm = mpi_comm_world
			pe_root = 0

			call mpi_comm_size(letkf_mpi_comm, pe_size, ierr)
      call mpi_comm_rank(letkf_mpi_comm, pe_rank, ierr)

			pe_isroot = pe_root == pe_rank

			if(pe_isroot) then
				print*,'total size: ', pe_size
			endif

		endsubroutine letkf_mpi_init

		subroutine letkf_mpi_final
			integer  ::  ierr

			call mpi_finalize(ierr)

		endsubroutine letkf_mpi_final

		subroutine lbcast_integer(var)
			integer, intent(inout) :: var
			integer                :: cnt
			integer  ::  ierr
			cnt = 1

			call mpi_bcast(var,cnt,mpi_integer,pe_root,letkf_mpi_comm,ierr)
			
		end subroutine lbcast_integer

		subroutine lbcast_integer_1d(var)
			integer, intent(inout) :: var(:)
			integer                :: cnt
			integer  ::  ierr
			cnt = size(var)

			call mpi_bcast(var,cnt,mpi_integer,pe_root,letkf_mpi_comm,ierr)
			
		end subroutine lbcast_integer_1d

		subroutine lbcast_real8(var)
			real(r8),intent(inout) :: var
			integer                :: cnt
			integer  ::  ierr
			cnt = 1

			call mpi_bcast(var,cnt,mpi_real8,pe_root,letkf_mpi_comm,ierr)
			
		end subroutine lbcast_real8

		subroutine lbcast_real8_1d(var)
			real(r8),intent(inout) :: var(:)
			integer                :: cnt
			integer  ::  ierr
			cnt = size(var)

			call mpi_bcast(var,cnt,mpi_real8,pe_root,letkf_mpi_comm,ierr)
			
		end subroutine lbcast_real8_1d
endmodule lmpi