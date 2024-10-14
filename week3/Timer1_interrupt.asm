		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_13

;======================================================================		 
;							Timer1_interrupt
;======================================================================
		
PVECTORS_13:
		
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;清除Timer1中斷旗標
;==========================================================================

;=======================================================================
;								ADC	module 		
;=======================================================================


		MOVW	DP,#GPIODatapage
		TSET	@GPASET,#3


	    MOVW	DP,#ADCACFGpage1
		MOV   	@ADCASOCFRC1,#0x0004		;set SOC flag for SOC1


;---------data	address


AD_Wait:

		TBIT	@ADCAINTFLG,#0		  		;判斷是否轉換完成ADCINT1
		B		AD_Wait,NTC
		MOVW	DP,#ADCACFGpage1					;if ADCINTFLG bit0 = 0 , jmp to AD_Wait
		MOV	 	@ADCAINTFLGCLR,#0x0001		;清ADCINT1中斷旗標


;---------data->mem

		MOVW 	DP,#Userdefinepage
		MOV		AL,@Count
		ADD		AL,#0x0040
		MOV		AR4,AL
		MOVW	DP,#ADCACFGpage1
		MOV		AR5,#ADCARESULT2	;		將ADCARESULT0的位址(0x0B00)載入AR5
		MOV		AL,*AR5				;		將AR5位址所存放的值載入到AL
		MOV		*AR4,AL				;		將AL存放的值載入到AR4(0x0040)要放的值
		MOVW 	DP,#Userdefinepage
		INC		@Count




		MOVW 	DP,#Userdefinepage
		CMP		@Count,#100
		B		Temp,GEQ
		B		End,LT
;======================================================================
;							End Timer1_interrupt
;======================================================================
Temp:
	MOVW 	DP,#Userdefinepage
	MOV @Count,#0
End:
	MOVW	DP,#GPIODatapage
	TSET	@GPACLEAR,#3
 	IRET                       		;跳出中斷
