module ini_fnl

  use precision
  use lmpi
  use io_control

  implicit none
  
  private

  public :: letkf_parameter_init, letkf_xens_init, letkf_y_init

  contains
    subroutine letkf_parameter_init(ens_size,omb_max,infl,radius)
      integer , intent(inout) :: ens_size
      real(r8), intent(inout) :: omb_max
      real(r8), intent(inout) :: infl
      real(r8), intent(inout) :: radius(2)

      call lbcast(ens_size)
      call lbcast(omb_max)
      call lbcast(infl)
      call lbcast(radius)

    endsubroutine letkf_parameter_init

    subroutine letkf_xens_init(ens_size,bkg_dir)
      integer , intent(in)       :: ens_size
      character(len=*),intent(in):: bkg_dir
      integer :: num, ens

      num = int(log10(real(ens_size)))+1

      do ens=1,ens_size
        call xens_readin(ens,bkg_dir,num)
      enddo

    endsubroutine letkf_xens_init

    subroutine letkf_y_init(obs_dir)
      character(len=*),intent(in):: obs_dir

      call y_readin(obs_dir)
      
    end subroutine letkf_y_init

end module ini_fnl
