;Logic for checksum 
;Input bytes are stored in memory
;Output is displayed in print 

     THUMB
	  AREA     factorial, CODE, READONLY
	  IMPORT printMsg
      IMPORT printMsg2p
      EXPORT __main
      ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 

        MOV  R2,  #0x00000000
;Enter no of bytes of data in R3
        MOV  R3,  #0x00000003
	    MOV  R4,  #0x20000000  ; Base Address of memory 
		
;Sum of all the bytes is stored in R6			
		MOV  R5,  #0x00000000

;Fetch each byte from memory and add them

LOOP
		LDRSB R5, [R4]
        ADD R6,R6,R5	
        ADD R4,#01
        ADD R1,#01		
        SUB R3,#01
	    CMP R3,#00				
		BGE LOOP       

;If sum is more than 8 bits then add higher order bits above 8 to lsb part

        AND R7,R6,#0xFF00
        LSR R7,R7,#0x08		 
        AND R8,R6,#0xFF
        ADD R9,R7,R8

        ORN R7,R2,R9 

;Store CRC in the next memory location
		STRB R7, [R4] 

;Receiver 

	    MOV  R4,  #0x20000000              ; Base Address
        MOV  R3,  #0x00000004
		MOV  R10,  #0x00000000
		
;Calculate checksum at receiver side

LOOP2
		LDRSB R5, [R4]
        ADD R10,R10,R5	
        ADD R4,#01
        ADD R1,#01		
        SUB R3,#01
	    CMP R3,#00				
		BGE LOOP2 

        AND R7,R10,#0xFF00
        LSR R7,R7,#0x08		 
        AND R8,R10,#0xFF
        ADD R9,R7,R8

;If R0=0 then no error else error

        ORN R0,R2,R9 
        AND R0,R0,#0x000000FF
	    BL printMsg
	   
stop  B stop ; stop program
      ENDFUNC
      END 