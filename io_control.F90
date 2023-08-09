module io_control

  use precision

  implicit none
  
  private

  public :: xens_readin, y_readin

  interface xens_readin
    module procedure ncfile_read_x
  endinterface xens_readin

  interface y_readin
    module procedure ncfile_read_y
  endinterface y_readin

  contains
    subroutine ncfile_read_x(ens,bkg_dir,num)
      integer , intent(in)       :: ens
      character(len=*),intent(in):: bkg_dir
      integer , intent(in)       :: num

      character(len=1024)         :: fn
      character(len=256)          :: fmt
      character(len=20), parameter:: fi = 'xb'

      write(fmt, '(A,I0,A)') '(A,A,I0.',num,',A,A)' 
      write(fn,fmt) trim(bkg_dir),'/', ens,'/', fi
      print*, 'read in '//trim(fn)

    endsubroutine ncfile_read_x

    subroutine ncfile_read_y(obs_dir)
      character(len=*),intent(in):: obs_dir

      character(len=1024)         :: fn
      character(len=256)          :: fmt
      character(len=20), parameter:: fi = 'obs'

      write(fn,'(A,"/",A)') trim(obs_dir),trim(fi)
      print*, 'read in '//trim(fn)
    endsubroutine ncfile_read_y

end module io_control
