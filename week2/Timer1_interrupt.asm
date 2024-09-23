 		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_13

;======================================================================		 
;							Timer1_interrupt
;======================================================================
		
PVECTORS_13:
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;清除Timer1中斷旗標

;=======================================================================
		MOVW	DP,#GPIODatapage
		TSET	@GPASET,#3
		RPT		#1000				;Delay 200 cycle(10us)
		||		NOP

		TSET	@GPACLEAR,#3
		IRET

