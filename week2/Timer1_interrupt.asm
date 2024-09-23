 		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_13

;======================================================================		 
;							Timer1_interrupt
;======================================================================
		
PVECTORS_13:
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;�M��Timer1���_�X��

;=======================================================================
		MOVW	DP,#GPIODatapage
		TSET	@GPASET,#3
		RPT		#1000				;Delay 200 cycle(10us)
		||		NOP

		TSET	@GPACLEAR,#3
		IRET

