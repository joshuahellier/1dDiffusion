      program ising
! Monte Carlo simulation of the Sticky Particle model.  Notes at end
      integer,   parameter :: double = 8
      real (kind = double) :: E,M,lambda,unstick,freemove
! n-site array.  Sites 1 and N+2 are boundary sites
!  spin(:) ture = particle,  false = vacancy
      logical, ALLOCATABLE :: spin(:)
      logical :: lrnd, rrnd
      integer,  dimension(2) :: seed
! System running time variables
      integer :: mcs,nequil,pass
!  "Chemical potential" which is actually setting the density at the boundary sites 1 and N+2 and implicit sites 0 and N+3 
      real :: chemleft,chemright
! Variables for the data collection and averaging
      integer, ALLOCATABLE :: block(:),vlock(:)
      integer :: accept,lin,rin
      real :: acceptance_prob,time
      real (kind = double),  ALLOCATABLE :: rho_x(:)
      real (kind = double), dimension(5) :: cum
!   read in system size, equilibration time and data collection time
!   boundary densities and range of stickinesses
      open(22,file='input.dat')
      read(22,*)N
      read(22,*)nequil
      read(22,*)mcs
      read(22,*)chemleft,chemright
      read(22,*)nlow,nhigh 
      ALLOCATE( spin(N+2) )
      ALLOCATE( rho_x(N+2) )
      ALLOCATE( block(N+2) )
      ALLOCATE( vlock(N+2) )

      lambda=1.0
! main outer loop over values of stickiness 
      do istick=1,nlow+nhigh
       rho_x=0.d0
       block=0
       vlock=0
! two regimes for lambda, the stickiness parameter (high lambda = low stickiness)
       if(istick.le.nlow) then 
         lambda=float(istick)/float(nlow)
       else
         lambda= lambda*1.4 
       endif
       unstick = lambda/(lambda+1.0)
       freemove = 1.0/(lambda+1.0)

! initialise and equilibrate system

       call initial()
       do pass = 1,nequil
         call sticky()
       end do
       rin=0
       lin=0

!  imtime loop accumulate data while updating spins
       do pass = 1,mcs
         lrnd=rand().lt.chemleft 
         rrnd=rand().lt.chemright
         if(lrnd)lin=lin+1
         if(spin(1))lin=lin-1
         if(rrnd) rin=rin+1
         if(spin(N+2))rin=rin-1
         spin(1)=lrnd
         spin(N+2)=rrnd
!  update the system with N attempted moves
         call sticky()
!  update the cumulatives to analyse the data
         call data(cum)
       end do

! write out data for this stickiness 
! 1) lambda, 
! 2) stickiness, 
! 3) E, number of bonds 
! 4) dE, fluctuations
! 5) density of particles 
! 6) dN, fluctuations
! 7) energy/atom
!       call output(cum)
! "Freemove" should happen at rate 1, so need to rescale time real(accept)/N/mcs,
         time=mcs*freemove
         write(10,"(d12.5,7f12.5)")lambda,1d0/lambda, cum(1)/mcs,
     & (cum(2)/mcs-(cum(1)/mcs)**2),
     &  cum(3)/mcs, (cum(4)/mcs-(cum(3)/mcs)**2),cum(1)/cum(3)
         write(11,*)lambda,
     &     (lin-rin)/time/(chemleft-chemright),lin,rin
          write(12,*)"1 ",chemleft,lambda,1d0/lambda 
         do i=2,N+1
          write(12,*)i,rho_x(i)/mcs,lambda,rho_x(i)
          write(13,*)i-1,block(i)
          write(14,*)i-1,vlock(i)
         enddo
          write(12,*)N+2,chemright,lambda,1d0/lambda 
          write(12,*)" "
          write(13,*)" "
          write(14,*)" "
!  End of main loop 
      end do

      stop

      contains

      subroutine initial()
      integer :: i,M
!     random initial configuration
         M=0
         do i = 1,N+2
            if (2*rand() < chemleft+chemright) then
               spin(i) = .true.
               M = M + 1 
            else
               spin(i) = .false.
            end if
         end do
         cum=0.0
         accept = 0
!         write(*,*)"Initialized with ", M, " of ", N+2, " sites" 
      end subroutine initial
      

      subroutine sticky()
!     one attempted Monte Carlo step per site
      integer :: nflip,i,dE
      real :: rnd
      logical :: spinback,spadd
      do  nflip = 1,N
!  Choose site as random number between 1 and N+2 
        rnd = rand()*(N+2)
         i = int(rnd+1)
!  refresh boundary site whenever anything tries to happen there to eliminate correlations.  Also, this monitors the particles entering and leaving the system and left (lin, site 1) and right (rin, site N+2) boundaries
        if(i.le.2)then
          spadd=rand().lt.chemleft
          if(spadd)lin=lin+1
          if(spin(1))lin=lin-1 
          spin(1)=spadd
        endif
        if(i.ge.N+1)then
          spadd=rand().lt.chemright
          if(spin(N+2))rin=rin-1 
          if(spadd)rin=rin+1 
          spin(N+2)=spadd
        endif

! only try to move if there is a particle
        if(spin(i)) then
          rnd=rand()
! Choose whether to try backwards or forwards.  inew is the site the particle tries to move to. iback is the site which determines if its stuck.
         if(rnd <=0.5) then
           inew=i-1
           iback=i+1
         else
           inew=i+1
           iback=i-1
         endif
! again, special cases apply to boundary sites
         if(inew.eq.0)goto 100
         if(inew.eq.N+3)goto 100
! only try to move to empty space
         if(.not.spin(inew)) then
! spinback is a logical which determines if we are unsticking?
         if(i.eq.1)then
           spinback=(rand().lt.chemleft)
         elseif(i.eq.(N+2))then
           spinback=(rand().lt.chemright)
          else
           spinback=spin(iback)
         endif
! Use spinback to choose rate: stuck or free?
         if(spinback) then
           if (rand() <= unstick) then
             spin(i)=.false.
             spin(inew)=.true.
! move acceptance rate monitoring             accept = accept + 1
           end if
         else
           if (rand() <= freemove) then
             spin(i)=.false.
             spin(inew)=.true.
           end if
         endif
       end if
       endif
 100  end do
      end subroutine sticky
      
      subroutine data(cum)
!     accumulate data after every Monte Carlo step per spin
      real (kind = double), dimension(:), intent (inout) :: cum
      E=0
      M=0
      Mblock=1
      Mvlock=1
      do i=2,N+1
      if(spin(i)) then
       M=M+1 
!  count the number of consecutive spaces
       vlock(Mvlock)=vlock(Mvlock)+1
       Mvlock=1
       Mblock=Mblock+1 
       rho_x(i)=rho_x(i)+1.d0
       if(spin(i+1))E=E+1
      else
!  count up the block size
       block(Mblock)=block(Mblock)+1
       Mblock=1
       Mvlock=Mvlock+1
      endif
      enddo
      cum(1) = cum(1) + E/N
      cum(2) = cum(2) + E*E/N/N
      cum(3) = cum(3) + M/N
      cum(4) = cum(4) + M*M/N/N
      cum(5) = cum(5) + abs(M)
      end subroutine data
      
      subroutine output(cum)
      real (kind = double), dimension(:), intent (inout) :: cum
      real (kind = double) :: norm,eave,e2ave,mave,m2ave,abs_mave
      acceptance_prob = real(accept)/real((N*mcs))
      eave = cum(1)/mcs
      e2ave = cum(2)/mcs
      mave = cum(3)/mcs
      m2ave = cum(4)/mcs
      print *, "Stickiness =",1.0-lambda
      print *, "Length =",N
      print *, "acceptance probability =",acceptance_prob
      print *, "mean energy =", eave
      print *, "mean squared energy =", e2ave
      print *, "mean density =", mave
      print *, "mean squared density =", m2ave
      end subroutine output
      
      subroutine save_config()
      character(len = 32) :: config
      print *, "file name of configuration?"
      read *, config
      open(unit=5,file=config,status="new",action="write")
      write(unit=5,fmt="(f13.6)") lambda
!   write(unit=5,fmt="(i4)") spin
      close(unit=5)
      end subroutine save_config

      subroutine read_config()
      integer :: x,y
      character(len = 20) :: file_name
      print *, "filename ?"
      read *, file_name
      open(unit=4,file=file_name,status="old",action="read")
      read(unit=4,fmt=*) lambda
         do x = 1,N+2
            read(unit=1,fmt=*) spin(x)
         end do
      close(unit=4)
      end subroutine read_config
      
      end program ising
      

! The code implements the Metropolis Monte Carlo algorithm on a 1D lattice for the SPM.  The system is a 1D line of length N+2. Special rules apply at boundary sites 1 and N+2.

! The algorithm works as follows:

! 1/  A site is chosen at random (i in subroutine sticky)

! 2/  If that site contains a particle, choose a neighbouring site i+1 or i-1 at random.

! 3/  If the site is empty, move it with probabillty   freemove = 1.0/(lambda+1.0)  or unstick lambda/(lambda+1.0).  Depending on whether the moving particle is stuck or not *.

! 4/  Advance number of timesteps by 1  (timestep depends on freemove)

!If a boundary site is chosen, then before doing anything the occupation of that site is updated according to the chemical potential "chemleft or chemright".  Then, choose at random which way to move: but if the move would take the particle out of the system, don't do it**.  The boundary particle is "free/stuck" with probability equal to the chemical potential.

!This is how particles are added or removed from the system.

!Each call to "sticky" makes N attempted moves.   I do "nequil" equilibration steps, then I analyse the system averages and update the cumulatives  after every call to sticky (i..e every N attempted moves).    "sticky" is called mcs times, so the statistics are averages over mcs configurations.  Averages exclude the boundary sites.

!For a given system size, the programme loops over a range of different lambdas, equilibrating each time.  Prior to equilibration, the system is initiallsed at a density (chemleft+chemright)/2 with no correlations.

!Everything outside the subroutine "sticky" is analysis or setup.

!Although I call chemleft and chemright the "chemical potential", they dont depend on the stickiness so its not quite the correct terminology.  I'm slightly worried that that a sweep across lambda with fixed chemical potential might be different to having fixed densities.


!*  slightly more efficient would be to rescale the faster move to 1

!** slightly more efficient would be to choose the boundary sites only half as ofter, then always jump into the system. 


