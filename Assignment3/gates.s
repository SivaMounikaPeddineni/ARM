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
	  IMPORT printMsg2p
      EXPORT __main
      ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 

;store X values (x1,x2,x3 )
      VLDR.F32 s12, =1
	  VLDR.F32 s13, =1
	  VLDR.F32 s14, =1

;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =0.5
	  VLDR.F32 s10, =-0.7
	  VLDR.F32 s11, =-0.7
;bias	  
	  VLDR.F32 s16, =0.1
	  
      VLDR.F32 s15, =0	  

;calculate w1*x1_w2*x2+w3*x3 is stored in s15

	  VMLA.F32 s15,s12,s9
	  VMLA.F32 s15,s13,s10
	  VMLA.F32 s15,s14,s11
	  VADD.F32 s15,s15,s16;  z = bias + w1*x1_w2*x2+w3*x3
	  
	  BL epwrx	  
	  VADD.F32 s7,s2,s5; (1+epwrx)
      VDIV.F32 s8,s5,s7; (1/(1+epwrx))
	  
	  VMOV.F32 R0,S8	  	  
	 	  
;if s8 >0.5 make it as 1 else 0
;add 0.5 to s8 and store in s18
;result of digital gate is stored in s19
	  VLDR.F32 s17, =0.5
	  VADD.F32 s18,s8,s17;

	   VCVT.U32.F32 s18,s18
	   VMOV.F32 R1,S18
	  BL printMsg2p
	  
	  B stop

epwrx

      VNEG.F32 s0,S15     
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