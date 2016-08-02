subroutine ini_coupler(istart)
    !
    !   subroutine ini_coupler (istart)
    !

    implicit none

    integer, intent(in) :: istart

    include "atparam.h"
    include "atparam1.h"

    include "com_cli_land.h"
    include "com_cli_sea.h"

    include "com_surfcon.h"

    ! 1.1 initialize land model constants
    call land_model_init(fmask_l,alb0)

    ! 1.2 initialize land model variables
    call ini_land(istart)

    ! 2.1 initialize sea and ice model constants
    call sea_model_init(fmask_s,deglat_s)

    ! 2.2 initialize sea and ice model variables
    call ini_sea(istart)
end

subroutine agcm_to_coupler(jday)
    !
    !   subroutine agcm_to_coupler (jday)
    !

    implicit none

    integer, intent(in) :: jday

    ! 1. send fields to land model
    call atm2land(jday)

    ! 2. send fields to sea and ice model
    call atm2sea(jday)
end

subroutine coupler_to_agcm(jday)
    !
    !   subroutine coupler_to_agcm (jday)
    !

    implicit none

    integer, intent(in) :: jday

    ! 1. get updated fields from land model
    call land2atm(jday)

    ! 2. get updated fields from sea and ice model
    call sea2atm(jday)
end