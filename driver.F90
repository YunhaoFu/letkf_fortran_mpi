program driver

  use precision
  use lmpi
  use ini_fnl

  implicit none

  character(len=256)     ::    cmd
  character(len=1024)    ::    bkg_dir    ! bkg directory
  character(len=1024)    ::    ana_dir    ! ana directory
  character(len=1024)    ::    obs_dir    ! obs directory
  integer                ::    ens_size   ! ensemble size
  real(r8)               ::    omb_max    ! maximum of abs(omb) 
  real(r8)               ::    infl       ! inflation rate for LETKF
  real(r8)               ::    radius(2)  ! localization radius for LETKF
  character(len=1024)    ::    nmlfile    ! absolute dir+name for nml file which contains the info above
  integer, parameter     ::    argv_cnt  = 1
  integer, parameter     ::    fu = 101

  namelist /letkf/ bkg_dir , &
                   ana_dir , &
                   obs_dir , &
                   ens_size, &
                   omb_max , &
                   infl    , &
                   radius


  ! write(*, "('============================== ** Initialize ** =================================')")
  ! print *
	call letkf_mpi_init()

  if(pe_isroot) then
    if (command_argument_count() < argv_cnt) then
      call get_command_argument(0, cmd)
      write(*, "('Usage: ', A, 'dir+name for nml')") trim(cmd)
      stop 18
    else
      call get_command_argument(1, nmlfile)
    endif

    open(unit=fu,file=trim(nmlfile))
    read(unit=fu,nml=letkf)
    close(unit=fu)
  endif

  call letkf_parameter_init(ens_size,omb_max,infl,radius)

  if(pe_isroot) call letkf_xens_init(ens_size,bkg_dir)

  if(pe_isroot) call letkf_y_init(obs_dir)

	call letkf_mpi_final()

endprogram driver