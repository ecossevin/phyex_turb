
MODULE MODE_EMOIST_MANYBLOCKS


IMPLICIT NONE



CONTAINS
SUBROUTINE EMOIST_MANYBLOCKS (D, CST, KRR, KRRI, PTHLM, PRM, PLOCPEXNM&
&, PAMOIST, PSRCM, OOCEAN, PEMOIST, LDACC, KGPBLKS)
USE YOMHOOK,ONLY:LHOOK, DR_HOOK, JPHOOK
USE MODD_CST,ONLY:CST_T
USE MODD_DIMPHYEX,ONLY:DIMPHYEX_T
USE FXTRAN_ACDC_STACK_MOD
USE FXTRAN_ACDC_ABORT_MOD
#include "fxtran_acdc_stack.h"

IMPLICIT NONE

TYPE (DIMPHYEX_T), INTENT (IN)::D
TYPE (CST_T), INTENT (IN)::CST
INTEGER, INTENT (IN)::KRR
INTEGER, INTENT (IN)::KRRI
LOGICAL, INTENT (IN)::OOCEAN
REAL, INTENT (IN)::PTHLM(:, :, :) ! (D%NIJT, D%NKT)
REAL, INTENT (IN)::PRM(:, :, :, :) ! (D%NIJT, D%NKT, KRR)
REAL, INTENT (IN)::PLOCPEXNM(:, :, :) ! (D%NIJT, D%NKT)
REAL, INTENT (IN)::PAMOIST(:, :, :) ! (D%NIJT, D%NKT)
REAL, INTENT (IN)::PSRCM(D%NIJT, D%NKT,KGPBLKS)
REAL, INTENT (OUT)::PEMOIST(:, :, :) ! (D%NIJT, D%NKT)
INTEGER, INTENT (IN) :: KGPBLKS
LOGICAL, INTENT (IN) :: LDACC
REAL::ZRW(D%NIJT, D%NKT,KGPBLKS)
REAL::ZA(D%NIJT, D%NKT,KGPBLKS)
REAL::ZDELTA
INTEGER::JRR
INTEGER::JK
INTEGER::JI
INTEGER::IKT
INTEGER::IIJE
INTEGER::IIJB
REAL (KIND=JPHOOK)::ZHOOK_HANDLE
TYPE (FXTRAN_ACDC_STACK) :: YLSTACK
INTEGER :: JBLK

!$ACC DATA &
!$ACC&CREATE (ZA, ZRW) &
!$ACC&IF (LDACC) &
!$ACC&PRESENT (CST, D, PAMOIST, PEMOIST, PLOCPEXNM, PRM, PSRCM, PTHLM) 

IF (LHOOK) CALL DR_HOOK ('EMOIST_MANYBLOCKS', 0, ZHOOK_HANDLE)
IIJB=D%NIJB
IIJE=D%NIJE
IKT=D%NKT

IF (OOCEAN) THEN

  IF (KRR==0) THEN
    
    !$ACC PARALLEL LOOP GANG &
    !$ACC&IF (LDACC) &
    !$ACC&PRIVATE (JBLK) &
    !$ACC&VECTOR_LENGTH (D%NIT) 

    

    DO JBLK = 1, KGPBLKS
      
      !$ACC LOOP VECTOR &
      !$ACC&PRIVATE (JI, JK) 

      

      DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

        DO JK=1, IKT
          
          PEMOIST (JI, JK, JBLK)=0.
        
        ENDDO

      ENDDO

    ENDDO

  ELSE
    
    !$ACC PARALLEL LOOP GANG &
    !$ACC&IF (LDACC) &
    !$ACC&PRIVATE (JBLK) &
    !$ACC&VECTOR_LENGTH (D%NIT) 

    

    DO JBLK = 1, KGPBLKS
      
      !$ACC LOOP VECTOR &
      !$ACC&PRIVATE (JI, JK) 

      

      DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

        DO JK=1, IKT
          
          PEMOIST (JI, JK, JBLK)=1.
        
        ENDDO

      ENDDO

    ENDDO

  ENDIF

ELSE

  IF (KRR==0) THEN
    
    !$ACC PARALLEL LOOP GANG &
    !$ACC&IF (LDACC) &
    !$ACC&PRIVATE (JBLK) &
    !$ACC&VECTOR_LENGTH (D%NIT) 

    

    DO JBLK = 1, KGPBLKS
      
      !$ACC LOOP VECTOR &
      !$ACC&PRIVATE (JI) 

      

      DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)
        PEMOIST (JI,:, JBLK)=0.
      ENDDO

    ENDDO

  ELSEIF (KRR==1) THEN
    ZDELTA=(CST%XRV/CST%XRD)-1.
    
    !$ACC PARALLEL LOOP GANG &
    !$ACC&IF (LDACC) &
    !$ACC&PRIVATE (JBLK) &
    !$ACC&VECTOR_LENGTH (D%NIT) 

    

    DO JBLK = 1, KGPBLKS
      
      !$ACC LOOP VECTOR &
      !$ACC&PRIVATE (JI, JK) 

      

      DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

        DO JK=1, IKT
          
          PEMOIST (JI, JK, JBLK)=ZDELTA*PTHLM (JI, JK, JBLK)
        
        ENDDO

      ENDDO

    ENDDO

  ELSE
    ZDELTA=(CST%XRV/CST%XRD)-1.
    
    !$ACC PARALLEL LOOP GANG &
    !$ACC&IF (LDACC) &
    !$ACC&PRIVATE (JBLK) &
    !$ACC&VECTOR_LENGTH (D%NIT) 

    

    DO JBLK = 1, KGPBLKS
      
      !$ACC LOOP VECTOR &
      !$ACC&PRIVATE (JI) 

      

      DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)
        ZRW (JI,:, JBLK)=PRM (JI,:, 1, JBLK)
      ENDDO

    ENDDO


    IF (KRRI>0) THEN
      
      !$ACC PARALLEL LOOP GANG &
      !$ACC&IF (LDACC) &
      !$ACC&PRIVATE (JBLK) &
      !$ACC&VECTOR_LENGTH (D%NIT) 

      

      DO JBLK = 1, KGPBLKS
        
        !$ACC LOOP VECTOR &
        !$ACC&PRIVATE (JI, JK) 

        

        DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

          DO JK=1, IKT
            
            ZRW (JI, JK, JBLK)=ZRW (JI, JK, JBLK)+PRM (JI, JK, 3, JBLK)
          
          ENDDO

        ENDDO

      ENDDO


      DO JRR=5, KRR
        
        !$ACC PARALLEL LOOP GANG &
        !$ACC&IF (LDACC) &
        !$ACC&PRIVATE (JBLK) &
        !$ACC&VECTOR_LENGTH (D%NIT) 

        

        DO JBLK = 1, KGPBLKS
          
          !$ACC LOOP VECTOR &
          !$ACC&PRIVATE (JI, JK) 

          

          DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

            DO JK=1, IKT
              
              ZRW (JI, JK, JBLK)=ZRW (JI, JK, JBLK)+PRM (JI, JK, JRR, JBLK)
            
            ENDDO

          ENDDO

        ENDDO

      ENDDO

      
      !$ACC PARALLEL LOOP GANG &
      !$ACC&IF (LDACC) &
      !$ACC&PRIVATE (JBLK) &
      !$ACC&VECTOR_LENGTH (D%NIT) 

      

      DO JBLK = 1, KGPBLKS
        
        !$ACC LOOP VECTOR &
        !$ACC&PRIVATE (JI, JK) 

        

        DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

          DO JK=1, IKT
            
            ZA (JI, JK, JBLK)=1.+((1.+ZDELTA)*(PRM (JI, JK, 1, JBLK)-PRM (JI, JK, 2, JBLK&
            &)-PRM (JI, JK, 4, JBLK))-ZRW (JI, JK, JBLK))/(1.+ZRW (JI, JK, JBLK))
            PEMOIST (JI, JK, JBLK)=ZDELTA*(PTHLM (JI, JK, JBLK)+PLOCPEXNM (JI, JK, JBLK)*(PRM (JI, JK, 2, JBLK&
            &)+PRM (JI, JK, 4, JBLK)))/(1.+ZRW (JI, JK, JBLK))+(PLOCPEXNM (JI, JK, JBLK)*ZA (JI, JK, JBLK)&
            &-(1.+ZDELTA)*(PTHLM (JI, JK, JBLK)+PLOCPEXNM (JI, JK, JBLK)*(PRM (JI, JK, 2, JBLK)+PRM (JI, JK&
            &, 4, JBLK)))/(1.+ZRW (JI, JK, JBLK)))*PAMOIST (JI, JK, JBLK)*2.*PSRCM (JI, JK, JBLK)
          
          ENDDO

        ENDDO

      ENDDO

    ELSE

      DO JRR=3, KRR
        
        !$ACC PARALLEL LOOP GANG &
        !$ACC&IF (LDACC) &
        !$ACC&PRIVATE (JBLK) &
        !$ACC&VECTOR_LENGTH (D%NIT) 

        

        DO JBLK = 1, KGPBLKS
          
          !$ACC LOOP VECTOR &
          !$ACC&PRIVATE (JI, JK) 

          

          DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

            DO JK=1, IKT
              
              ZRW (JI, JK, JBLK)=ZRW (JI, JK, JBLK)+PRM (JI, JK, JRR, JBLK)
            
            ENDDO

          ENDDO

        ENDDO

      ENDDO

      
      !$ACC PARALLEL LOOP GANG &
      !$ACC&IF (LDACC) &
      !$ACC&PRIVATE (JBLK) &
      !$ACC&VECTOR_LENGTH (D%NIT) 

      

      DO JBLK = 1, KGPBLKS
        
        !$ACC LOOP VECTOR &
        !$ACC&PRIVATE (JI, JK) 

        

        DO JI = D%NIB, MERGE (D%NIT, D%NIE, JBLK < KGPBLKS)

          DO JK=1, IKT
            
            ZA (JI, JK, JBLK)=1.+((1.+ZDELTA)*(PRM (JI, JK, 1, JBLK)-PRM (JI&
            &, JK, 2, JBLK))-ZRW (JI, JK, JBLK))/(1.+ZRW (JI, JK, JBLK))
            PEMOIST (JI, JK, JBLK)=ZDELTA*(PTHLM (JI, JK, JBLK)+PLOCPEXNM (JI, JK, JBLK)*PRM (JI&
            &, JK, 2, JBLK))/(1.+ZRW (JI, JK, JBLK))+(PLOCPEXNM (JI, JK, JBLK)*ZA (JI, JK, JBLK&
            &)-(1.+ZDELTA)*(PTHLM (JI, JK, JBLK)+PLOCPEXNM (JI, JK, JBLK)*PRM (JI, JK, 2, JBLK&
            &))/(1.+ZRW (JI, JK, JBLK)))*PAMOIST (JI, JK, JBLK)*2.*PSRCM (JI, JK, JBLK)
          
          ENDDO

        ENDDO

      ENDDO

    ENDIF

  ENDIF

ENDIF

IF (LHOOK) CALL DR_HOOK ('EMOIST_MANYBLOCKS', 1, ZHOOK_HANDLE)
!$ACC END DATA

END SUBROUTINE EMOIST_MANYBLOCKS

ENDMODULE MODE_EMOIST_MANYBLOCKS
