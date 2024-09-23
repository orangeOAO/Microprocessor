 		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_14

;======================================================================		 
;							Timer1_interrupt
;======================================================================
		
PVECTORS_13:
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;清除Timer1中斷旗標

;=======================================================================
 		EINT
		MOVW	DP,#GPIODatapage
		TSET	@GPASET,#4
		RPT		#1200				;Delay 200 cycle(1us)
		||		NOP

		TSET	@GPACLEAR,#4
		IRET

