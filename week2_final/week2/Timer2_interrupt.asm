 		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_14

;======================================================================		 
;							Timer2_interrupt
;======================================================================
		
PVECTORS_14:
		EINT
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;�M��Timer2���_�X��

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

