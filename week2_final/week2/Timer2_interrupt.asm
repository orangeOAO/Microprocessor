 		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_14

;======================================================================		 
;							Timer2_interrupt
;======================================================================
		
PVECTORS_14:
		EINT
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;清除Timer2中斷旗標

;=======================================================================

		MOVW	DP,#GPIODatapage
		TSET	@GPASET,#4

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP
		RPT		#120				;Delay 120 cycle(1.2us)
		||		NOP

		TSET	@GPACLEAR,#4
		IRET

