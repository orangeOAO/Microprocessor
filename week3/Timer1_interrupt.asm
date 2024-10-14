		  .include		"register_377.inc"
		  .include		"PetchVect_377.inc"
		  .global       PVECTORS_13

;======================================================================		 
;							Timer1_interrupt
;======================================================================
		
PVECTORS_13:
		
		MOVW  	DP,#Timerpage
		OR   	@TIMER1TCR,#0x8000  			;�M��Timer1���_�X��
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

		TBIT	@ADCAINTFLG,#0		  		;�P�_�O�_�ഫ����ADCINT1
		B		AD_Wait,NTC
		MOVW	DP,#ADCACFGpage1					;if ADCINTFLG bit0 = 0 , jmp to AD_Wait
		MOV	 	@ADCAINTFLGCLR,#0x0001		;�MADCINT1���_�X��


;---------data->mem

		MOVW 	DP,#Userdefinepage
		MOV		AL,@Count
		ADD		AL,#0x0040
		MOV		AR4,AL
		MOVW	DP,#ADCACFGpage1
		MOV		AR5,#ADCARESULT2	;		�NADCARESULT0����}(0x0B00)���JAR5
		MOV		AL,*AR5				;		�NAR5��}�Ҧs�񪺭ȸ��J��AL
		MOV		*AR4,AL				;		�NAL�s�񪺭ȸ��J��AR4(0x0040)�n�񪺭�
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
 	IRET                       		;���X���_
