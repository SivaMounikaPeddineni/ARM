;Logic for e power x series
;result=1  (s2)
;product =1 (s1)
;i=1  (r2)
;x (s1)
;while (i<n)
;product= product * X / i
;result= result+ product
;i++


     THUMB
	  AREA     factorial, CODE, READONLY
	  IMPORT printMsg
      EXPORT __main
      ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 

;Store X value

;store weights
;      VLDR.F32 s9, =10
;	  VLDR.F32 s10, =10
;	  VLDR.F32 s11, =10


;vary x value so from -5 to 5 in steps of 0.25
      VLDR.F32 s31, =-5
      VLDR.F32 s30, =5
      VLDR.F32 s29, =0.25

;x is stored in s0
;      VLDR.F32 s0, =10

Loop1

	  BL epwrx	  
	  VADD.F32 s7,s2,s5; (1+epwrx)
      VDIV.F32 s8,s5,s7; (1/(1+epwrx))
	  
	  VMOV.F32 R0,S8	  	  
	  BL printMsg
	  	  	  
	  VADD.F32 s31,s31,s29	
	  VCMP.F32 S31,S30
	  vmrs APSR_nzcv,FPSCR
      BLE Loop1
	  B stop

epwrx

      VNEG.F32 s0,S31     
;Store no of iterations
	  VLDR.F32 s6, =35
	 
;iterations	count i

      VLDR.F32 s4, =1
	  VLDR.F32 s5, =1

;Product s1	 
	  VLDR.F32 s1, =1

;result s2	 
	  VLDR.F32 s2, =1     

Loop  VDIV.F32 s3,s0,s4
      VMUL.F32 s1,s1,s3
	  VADD.F32 s2,s2,s1
	  VADD.F32 s4,s4,s5
	  VCMP.F32 S4,S6
	  vmrs APSR_nzcv,FPSCR	  
	  BLT Loop
	  BX lr
 	 	
stop    B stop ; stop program
      ENDFUNC
      END 