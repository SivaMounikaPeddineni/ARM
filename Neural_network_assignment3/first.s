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
	  IMPORT printMsg4p
	  IMPORT printMsg
      EXPORT __main
      ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 

	  MOV R4,#0x00000000	
	  ;MOV R0,#0x00000001	 
;Total number of gates
      MOV R5,#0x00000007
AllGates
      ADD R4,#1
      MOV R0,R4	  
      CMP R4,#0x00000001
	  BEQ Weight_and
      CMP R4,#0x00000002	 
	  BEQ Weight_or
      CMP R4,#0x00000003	 
	  BEQ Weight_not
back
      CMP R4,#0x00000004	 
	  BEQ Weight_nand
	  CMP R4,#0x00000005	 
	  BEQ Weight_nor
	  CMP R4,#0x00000006	 
	  BEQ Weight_xor
	  CMP R4,#0x00000007	 
	  BEQ Weight_xnor
      BLE AllGates
      B stop

Weight_and
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =-0.1
	  VLDR.F32 s10, =0.2
	  VLDR.F32 s11, =0.2
;bias	  
	  VLDR.F32 s16, =-0.2
      B dataset
      ;BX lr
	  
Weight_or
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =-0.1
	  VLDR.F32 s10, =0.7
	  VLDR.F32 s11, =0.7
;bias	  
	  VLDR.F32 s16, =-0.1
      BL dataset
      BX lr

Weight_not
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =0
	  VLDR.F32 s10, =0.5
	  VLDR.F32 s11, =-0.7
	  
;bias	  
	  VLDR.F32 s16, =0.1	  
      BL dataset
      BX lr
	  
Weight_nand
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =0.6
	  VLDR.F32 s10, =-0.8
	  VLDR.F32 s11, =-0.8

;bias	  
	  VLDR.F32 s16, =0.3
      BL dataset
      BX lr
	  
Weight_nor
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =0.5
	  VLDR.F32 s10, =-0.7
	  VLDR.F32 s11, =-0.7

;bias	  
	  VLDR.F32 s16, =0.1
      BL dataset
      BX lr

Weight_xor
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =-5
	  VLDR.F32 s10, =20
	  VLDR.F32 s11, =10

;bias	  
	  VLDR.F32 s16, =1
      BL dataset
	  BX lr
	  
Weight_xnor
      BL printMsg
;store weights (weights w1 w2 w3 corresponding to x1, x2, x3)
      VLDR.F32 s9, =-5
	  VLDR.F32 s10, =20
	  VLDR.F32 s11, =10
;bias	  
	  VLDR.F32 s16, =1
      BL dataset
      BX lr
	  
dataset
      MOV R8,#01
	  MOV R9,#4
	  B dataset1	  
      ;BX lr
 
dataset1

      VLDR.F32 s12, =1
	  VLDR.F32 s13, =0
	  VLDR.F32 s14, =0
	  BL calculate 
dataset2
      VLDR.F32 s12, =1
	  VLDR.F32 s13, =0
	  VLDR.F32 s14, =1
      BL calculate
	 ; BX lr	

dataset3
      VLDR.F32 s12, =1
	  VLDR.F32 s13, =1
	  VLDR.F32 s14, =0	
      BL calculate
	  ;BX lr	
dataset4
      VLDR.F32 s12, =1
	  VLDR.F32 s13, =1
	  VLDR.F32 s14, =1
      BL calculate
	  ;BX lr  
	      	  

;calculate w1*x1_w2*x2+w3*x3 is stored in s15
calculate
      VCVT.U32.F32 s31,s12
      VMOV.F32 R0,S31
      VCVT.U32.F32 s30,s13
      VMOV.F32 R1,S30
      VCVT.U32.F32 s29,s14	  
      VMOV.F32 R2,S29
	  
      VLDR.F32 s15, =0
	  VMLA.F32 s15,s12,s9
	  VMLA.F32 s15,s13,s10
	  VMLA.F32 s15,s14,s11
	  VADD.F32 s15,s15,s16;  z = bias + w1*x1_w2*x2+w3*x3
	  
	  BL epwrx	  
	  VADD.F32 s7,s2,s5; (1+epwrx)
      VDIV.F32 s8,s5,s7; (1/(1+epwrx))
	  
	  ;VMOV.F32 R0,S8	  	  
	 	  
;if s8 >0.5 make it as 1 else 0
;add 0.5 to s8 and store in s18
;result of digital gate is stored in s19
	  VLDR.F32 s17, =0.5
	  VADD.F32 s18,s8,s17;

	  VCVT.U32.F32 s18,s18
	  VMOV.F32 R3,S18	  	  
	  BL printMsg4p
	  ADD R8,#1
      CMP R8,#2
	  BEQ dataset2 
      CMP R4,#0x00000003
	  BEQ AllGates	  
      CMP R8,#3
	  BEQ dataset3
      CMP R8,#4
	  BEQ dataset4	  	  	  
	  B AllGates 
	  
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
