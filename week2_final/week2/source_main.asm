					.include	"register_377.inc"
					.include	"PetchVect_377.inc"
					.global		_c_int00
				  	
					.text


_c_int00:				;entry point 程式開始的位置

;===========================================================================
	 DINT						;Disable Interrupt 初始化不能跳中斷
;===========================================================================
;initial
;===========================================================================
			EALLOW						;要寫有保護的暫存器,要先打"EALLOW"

;====================================================================================
;		     				  Clock setting(launch板)
;====================================================================================

		MOVW    DP,#CLKpage

        MOV		@CLKSRCCTL1,#0x0001      ;XTAL on CLK_source=XTAL
        MOV		@CLKSRCCTL2,#0x0001
        MOV     @CLKSRCCTL3,#0x0000     ;XCLKOUT=PLLSYS

;-------PLL setting data P.107
		MOV		@AR4,#0					;5 times counter
        TCLR	@SYSPLLCTL1,#1			;disable PLL PLLCKEN
        MOV		@SYSCLKDIVSEL,#0x0000

PLLLOCK:
        TCLR	@SYSPLLCTL1,#0
        RPT		#20
        ||	NOP
        MOV		@SYSPLLMULT,#0x0028		;fmult=0	imult=40
LK:
        TBIT	@SYSPLLSTS,#0
        B		LK,NTC

        INC		@AR4					;RPT 5	times to make sure PLL is locked
        CMP		AR4,#5
        B		PLLLOCK,LEQ

        MOV		@SYSCLKDIVSEL,#0x0002	;200M/2=100M;Set divider to produce slower output frequency to limit current increase
        TSET	@SYSPLLCTL1,#0
        TSET	@SYSPLLCTL1,#1

        MOV     @LOSPCP,#0x0000         ;Low speed clock = SYSCLKOUT/1, 給周邊的CLock



;-------------key ADC calibration here (if need)

;-------------give periperal clk
;        MOVW	DP,#CPUSYSpage1
        MOVW	DP,#0x174C
        MOV		@0x0,#0x0001


;        MOVW	DP,#CPUSYSpage2

        MOV     @PCLKCR0,#0x003D        ;CPUtimer DMA CLA on
        MOV		@PCLKCR0+1,#0x0005		;TBSYNC HRPWM on
        MOV     @PCLKCR2,#0x0FFF		;EPWM.ALL on
;       MOV     @PCLKCR3,#0x003F        ;eCAP.ALL on
;       MOV		@PCLKCR4,#0x0005			;eQEP.ALL on
        MOV		@PCLKCR8,#0x0005			;SPI.ALL on
;       MOV		@PCLKCR10,#0x0003		;CAN.ALL on
        MOV		@PCLKCR13,#0x000F			;ADC.ALL on
        MOV		@PCLKCR16+1,#0x0007			;DAC.ALL on

        MOV		@CPUSYSLOCK1,#1

        MOVW    DP,#WDpage
        MOV     @SCSR,#0x0007           ;disable Watch dog
        MOV     @WDCR,#0x0040           ;Set WDDIS bit in WDCR to disable WD

;=====================================================================================
;							End Clock setting
;=====================================================================================

;=====================================================================================
;							Interrupt setting P.84
;=====================================================================================

		MOVW	DP,#PIECTLpage
;-------PIE MAP	P.88
		MOV   	@PIECTRL,#0x0001  		;Enable PIE
;		MOV   	@PIEIFR1,#0x0001  		;設PIE interrupt ADC
;		MOV   	@PIEIER1,#0x0001  		;Enable PIE interrupt 1.1 ADC
;		MOV   	@PIEACK,#0x0001   		;ADC

		AND   	IFR,#0x0000       		;Clear interrupt flag
		 OR    	IER,#0x3000      		;Enable interrupt group 13、14 (Timer1、Timer2)


;======================================================================================
;							CPU Timer1 setting
;======================================================================================

		MOVW	DP,#Timerpage		;CPU Timer0,1,2	page

		MOV		@TIMER1TIM,#0	;先將Timer1之counts清零
		MOV		@TIMER1PRD,#9999	;設定Timer1中斷週期 20000*1/200M = 100us
		MOV		@TIMER1TCR,#0x4800  ;Enable Timer1, Free run



;======================================================================================
;							End CPU Timer setting
;======================================================================================

;======================================================================================
;							CPU Timer2 setting
;======================================================================================

		MOVW	DP,#Timerpage		;CPU Timer0,1,2	page

		MOV		@TIMER2TIM,#0	;先將Timer2之counts清零
		MOV		@TIMER2PRD,#39999   ;設定Timer2中斷週期 40000*1/100M = 400us
		MOV		@TIMER2TCR,#0x4800  ;Enable Timer2, Free run



;======================================================================================
;							End CPU Timer setting
;======================================================================================

;=======================================================================================
;								ADC setting
;=======================================================================================

;		MOVW	DP,#ADCACFGpage2

		;//Also apply the offset trim and, if needed, linearity trim correction.
;		MOV		@ADCAINLTRIM1,#0xFFFF0000



		MOVW	DP,#ADCACFGpage1

		MOV   	@ADCACTL2,#0x0006
		MOV		@ADCACTL2,#0x0006

		MOV   	@ADCACTL1,#0x0004

		OR		@ADCACTL1,#0x0080		;power up ADC
		OR		@ADCACTL1,#0x0080		;power up ADC

		MOV   	@AR0,#20000
DELAY_1ms:
		NOP

		BANZ  DELAY_1ms,AR0--		;1ms delay for power up ADC



		MOV   	@ADCASOC1CTL,#0x01FF		;SOC0  選channel A0 ACQPS 16cycle
		MOV   	@ADCASOC1CTL+1,#0x0000


		MOV		@ADCAINTSEL1N2,#0x0021
		MOV	 	@ADCAINTFLGCLR,#0x0001		     ;清出ADCINT1中斷旗標

;=========================================================================================
;							GPIO setting
;=========================================================================================

		MOVW	DP,#GPIOpageA					;GPIOpageA
;--------------------------GPIO0~GPIO44 function------------------------
		MOV		@GPAMUX1,#00000000000000b		;Fuction of GPIO0~GPIO7
                         ;\\\\\\\\\\\\\\== ---->;GPIO0
                         ;\\\\\\\\\\\\==   ---->;GPIO1
                         ;\\\\\\\\\\==     ---->;GPIO2
                         ;\\\\\\\\==       ---->;GPIO3
                         ;\\\\\\==         ---->;GPIO4
                         ;\\\\==           ---->;GPIO5
                         ;\\==             ---->;GPIO6
                         ;==               ---->;GPIO7

		MOV		@GPAMUX1+1,#0000000000000000b     ;Fuction of GPIO8~GPIO15
                           ;\\\\\\\\\\\\\\== ---->;GPIO8
                           ;\\\\\\\\\\\\==   ---->;GPIO9
                           ;\\\\\\\\\\==     ---->;GPIO10
                           ;\\\\\\\\==       ---->;GPIO11
                           ;\\\\\\==         ---->;GPIO12
                           ;\\\\==           ---->;GPIO13
                           ;\\==             ---->;GPIO14
                           ;==               ---->;GPIO15

		MOV		@GPAMUX2,#0000000000000000b		;Fuction of GPIO16~GPIO23
                         ;\\\\\\\\\\\\\\== ---->;GPIO16
                         ;\\\\\\\\\\\\==   ---->;GPIO17
                         ;\\\\\\\\\\==     ---->;GPIO18
                         ;\\\\\\\\==       ---->;GPIO19
                         ;\\\\\\==         ---->;GPIO20
                         ;\\\\==           ---->;GPIO21
                         ;\\==             ---->;GPIO22
                         ;==               ---->;GPIO23

	    MOV		@GPAMUX2+1,#0000000000000000b	  ;Fuction of GPIO24~GPIO31
                           ;\\\\\\\\\\\\\\== ---->;GPIO24
                           ;\\\\\\\\\\\\==   ---->;GPIO25
                           ;\\\\\\\\\\==     ---->;GPIO26
                           ;\\\\\\\\==       ---->;GPIO27
                           ;\\\\\\==         ---->;GPIO28
                           ;\\\\==           ---->;GPIO29
                           ;\\==             ---->;GPIO30
                           ;==               ---->;GPIO31 EVM板LED2 low動作

		MOVW	DP,#GPIOpageB					;GPIOpageB

		MOV		@GPBMUX1,#0000000000000000b		;Fuction of GPIO32~GPIO39
                         ;\\\\\\\\\\\\\\== ---->;GPIO32
                         ;\\\\\\\\\\\\==   ---->;GPIO33
                         ;\\\\\\\\\\==     ---->;GPIO34   EVM板LED3 low動作
                         ;\\\\\\\\==       ---->;GPIO35
                         ;\\\\\\==         ---->;GPIO36
                         ;\\\\==           ---->;GPIO37
                         ;\\==             ---->;GPIO38
                         ;==               ---->;GPIO39

        MOV		@GPBMUX1+1,#0000000000000000b	  ;Fuction of GPIO40~GPIO44
                           ;\\\\\\\\\\\\\\== ---->;GPIO40
                           ;\\\\\\\\\\\\==   ---->;GPIO41
                           ;\\\\\\\\\\==     ---->;GPIO42
                           ;\\\\\\\\==       ---->;GPIO43
                           ;\\\\\\==         ---->;GPIO44

;-----------------------GPIO Mux dierection------------------------------
;0:Input , 1:Output , defalt is 0:Input
		MOVW	DP,#GPIOpageA			;GPIOpage2
		MOV    	@GPADIR,#0x001F      	;0~15;GPIO0 is output
		MOV		@GPADIR+1,#0x8405		;16~31;GPIO16,18,26,31 are output

		MOVW	DP,#GPIOpageB					;GPIOpageB
		MOV		@GPBDIR,#0x1084			;32~44;GPIO39,44 are output

;-----------------------GPIO Mux initial value---------------------------
;0:initial value is 0(low), 1:initial value is 1(high)
		MOVW	DP,#GPIODatapage			;GPIOpage2
		MOV		@GPACLEAR,#0xFFFF
		MOV		@GPADAT,#0x0000		;GPIO0~GPIO15
		MOV		@GPADAT+1,#0x0000		;GPIO16~GPIO31

        MOV		@GPBDAT,#0x0000			;GPIO32~GPIO44

;=======================================================================================
;							End GPIO setting
;=======================================================================================
		EDIS							;寫完有保護之暫存器,打"EDIS"
;===========================================================================

;-------------main

		  EINT			 ;允許中斷

LOOP:                    ;等待進入中斷

           NOP
    	   NOP

		   B      LOOP,UNC


;===========================================================================
;開啟中斷時 須將該向量位置取消(如果有其他中斷被開啟會跑來這進入無限迴圈)
PVECTORS_01			B		PVECTORS_01,UNC      
PVECTORS_02			B		PVECTORS_02,UNC
PVECTORS_03			B		PVECTORS_03,UNC
PVECTORS_04			B		PVECTORS_04,UNC
PVECTORS_05			B		PVECTORS_05,UNC
PVECTORS_06			B		PVECTORS_06,UNC
PVECTORS_07			B		PVECTORS_07,UNC
PVECTORS_08			B		PVECTORS_08,UNC
PVECTORS_09			B		PVECTORS_09,UNC
PVECTORS_10			B		PVECTORS_10,UNC
PVECTORS_11			B		PVECTORS_11,UNC
PVECTORS_12			B		PVECTORS_12,UNC
;PVECTORS_13			B		PVECTORS_13,UNC ;CPU-Timer1
;PVECTORS_14			B		PVECTORS_14,UNC ;CPU-Timer2
PVECTORS_15			B		PVECTORS_15,UNC
PVECTORS_16			B		PVECTORS_16,UNC
PVECTORS_17			B		PVECTORS_17,UNC
PVECTORS_18			B		PVECTORS_18,UNC
PVECTORS_19			B		PVECTORS_19,UNC
PVECTORS_20			B		PVECTORS_20,UNC
PVECTORS_21			B		PVECTORS_21,UNC
PVECTORS_22			B		PVECTORS_22,UNC
PVECTORS_23			B		PVECTORS_23,UNC
PVECTORS_24			B		PVECTORS_24,UNC
PVECTORS_25			B		PVECTORS_25,UNC
PVECTORS_26			B		PVECTORS_26,UNC
PVECTORS_27			B		PVECTORS_27,UNC
PVECTORS_28			B		PVECTORS_28,UNC
PVECTORS_29			B		PVECTORS_29,UNC
PVECTORS_30			B		PVECTORS_30,UNC
PVECTORS_31			B		PVECTORS_31,UNC
PVECTORS_32			B		PVECTORS_32,UNC
PVECTORS_33			B		PVECTORS_33,UNC
PVECTORS_34			B		PVECTORS_34,UNC
PVECTORS_35			B		PVECTORS_35,UNC
PVECTORS_36			B		PVECTORS_36,UNC
PVECTORS_37			B		PVECTORS_37,UNC
PVECTORS_38			B		PVECTORS_38,UNC
PVECTORS_39			B		PVECTORS_39,UNC
PVECTORS_40			B		PVECTORS_40,UNC
PVECTORS_41			B		PVECTORS_41,UNC
PVECTORS_42			B		PVECTORS_42,UNC
PVECTORS_43			B		PVECTORS_43,UNC
PVECTORS_44			B		PVECTORS_44,UNC
PVECTORS_45			B		PVECTORS_45,UNC
PVECTORS_46			B		PVECTORS_46,UNC
PVECTORS_47			B		PVECTORS_47,UNC
PVECTORS_48			B		PVECTORS_48,UNC
PVECTORS_49	    	B		PVECTORS_49,UNC
PVECTORS_50			B		PVECTORS_50,UNC
PVECTORS_51			B		PVECTORS_51,UNC
PVECTORS_52			B		PVECTORS_52,UNC
PVECTORS_53			B		PVECTORS_53,UNC
PVECTORS_54			B		PVECTORS_54,UNC
PVECTORS_55			B		PVECTORS_55,UNC
PVECTORS_56			B		PVECTORS_56,UNC
PVECTORS_57			B		PVECTORS_57,UNC
PVECTORS_58			B		PVECTORS_58,UNC
PVECTORS_59			B		PVECTORS_59,UNC
PVECTORS_60			B		PVECTORS_60,UNC
PVECTORS_61			B		PVECTORS_61,UNC
PVECTORS_62			B		PVECTORS_62,UNC
PVECTORS_63			B		PVECTORS_63,UNC
PVECTORS_64			B		PVECTORS_64,UNC
PVECTORS_65			B		PVECTORS_65,UNC
PVECTORS_66			B		PVECTORS_66,UNC
PVECTORS_67			B		PVECTORS_67,UNC
PVECTORS_68			B		PVECTORS_68,UNC
PVECTORS_69			B		PVECTORS_69,UNC
PVECTORS_70			B		PVECTORS_70,UNC
PVECTORS_71			B		PVECTORS_71,UNC
PVECTORS_72			B		PVECTORS_72,UNC
PVECTORS_73			B		PVECTORS_73,UNC
PVECTORS_74			B		PVECTORS_74,UNC
PVECTORS_75			B		PVECTORS_75,UNC
PVECTORS_76			B		PVECTORS_76,UNC
PVECTORS_77			B		PVECTORS_77,UNC
PVECTORS_78			B		PVECTORS_78,UNC
PVECTORS_79			B		PVECTORS_79,UNC
PVECTORS_80			B		PVECTORS_80,UNC
PVECTORS_81			B		PVECTORS_81,UNC
PVECTORS_82			B		PVECTORS_82,UNC
PVECTORS_83			B		PVECTORS_83,UNC
PVECTORS_84			B		PVECTORS_84,UNC
PVECTORS_85			B		PVECTORS_85,UNC
PVECTORS_86			B		PVECTORS_86,UNC
PVECTORS_87			B		PVECTORS_87,UNC
PVECTORS_88			B		PVECTORS_88,UNC
PVECTORS_89			B		PVECTORS_89,UNC
PVECTORS_90			B		PVECTORS_90,UNC
PVECTORS_91			B		PVECTORS_91,UNC
PVECTORS_92			B		PVECTORS_92,UNC
PVECTORS_93			B       PVECTORS_93,UNC
PVECTORS_94			B		PVECTORS_94,UNC
PVECTORS_95			B		PVECTORS_95,UNC
PVECTORS_96			B		PVECTORS_96,UNC
PVECTORS_97			B		PVECTORS_97,UNC
PVECTORS_98			B		PVECTORS_98,UNC
PVECTORS_99			B		PVECTORS_99,UNC
PVECTORS_100		B		PVECTORS_100,UNC
PVECTORS_101		B		PVECTORS_101,UNC
PVECTORS_102		B		PVECTORS_102,UNC
PVECTORS_103		B		PVECTORS_103,UNC
PVECTORS_104		B		PVECTORS_104,UNC
PVECTORS_105		B		PVECTORS_105,UNC
PVECTORS_106		B		PVECTORS_106,UNC
PVECTORS_107		B		PVECTORS_107,UNC
PVECTORS_108		B		PVECTORS_108,UNC
PVECTORS_109		B		PVECTORS_109,UNC
PVECTORS_110		B		PVECTORS_110,UNC
PVECTORS_111		B		PVECTORS_111,UNC
PVECTORS_112		B		PVECTORS_112,UNC
PVECTORS_113		B		PVECTORS_113,UNC
PVECTORS_114		B		PVECTORS_114,UNC
PVECTORS_115		B		PVECTORS_115,UNC
PVECTORS_116		B		PVECTORS_116,UNC
PVECTORS_117		B		PVECTORS_117,UNC
PVECTORS_118		B		PVECTORS_118,UNC
PVECTORS_119		B		PVECTORS_119,UNC
PVECTORS_120		B		PVECTORS_120,UNC
PVECTORS_121		B		PVECTORS_121,UNC
PVECTORS_122		B		PVECTORS_122,UNC
PVECTORS_123		B		PVECTORS_123,UNC
PVECTORS_124		B		PVECTORS_124,UNC
PVECTORS_125		B		PVECTORS_125,UNC
PVECTORS_126		B		PVECTORS_126,UNC
PVECTORS_127		B		PVECTORS_127,UNC
PVECTORS_128		B		PVECTORS_128,UNC
PVECTORS_129		B		PVECTORS_129,UNC
PVECTORS_130		B		PVECTORS_130,UNC
PVECTORS_131		B		PVECTORS_131,UNC
PVECTORS_132		B		PVECTORS_132,UNC
PVECTORS_133		B		PVECTORS_133,UNC
PVECTORS_134		B		PVECTORS_134,UNC
PVECTORS_135		B		PVECTORS_135,UNC
PVECTORS_136		B		PVECTORS_136,UNC
PVECTORS_137		B		PVECTORS_137,UNC
PVECTORS_138		B		PVECTORS_138,UNC
PVECTORS_139		B		PVECTORS_139,UNC
PVECTORS_140		B		PVECTORS_140,UNC
PVECTORS_141		B		PVECTORS_141,UNC
PVECTORS_142		B		PVECTORS_142,UNC
PVECTORS_143		B		PVECTORS_143,UNC
PVECTORS_144		B		PVECTORS_144,UNC
PVECTORS_145		B		PVECTORS_145,UNC
PVECTORS_146		B		PVECTORS_146,UNC
PVECTORS_147		B		PVECTORS_147,UNC
PVECTORS_148		B		PVECTORS_148,UNC
PVECTORS_149		B		PVECTORS_149,UNC
PVECTORS_150		B		PVECTORS_150,UNC
PVECTORS_151		B		PVECTORS_151,UNC
PVECTORS_152		B		PVECTORS_152,UNC
PVECTORS_153		B		PVECTORS_153,UNC
PVECTORS_154		B		PVECTORS_154,UNC
PVECTORS_155		B		PVECTORS_155,UNC
PVECTORS_156		B		PVECTORS_156,UNC
PVECTORS_157		B		PVECTORS_157,UNC
PVECTORS_158		B		PVECTORS_158,UNC
PVECTORS_159		B		PVECTORS_159,UNC
PVECTORS_160		B		PVECTORS_160,UNC
PVECTORS_161		B		PVECTORS_161,UNC
PVECTORS_162		B		PVECTORS_162,UNC
PVECTORS_163		B		PVECTORS_163,UNC
PVECTORS_164		B		PVECTORS_164,UNC
PVECTORS_165		B		PVECTORS_165,UNC
PVECTORS_166		B		PVECTORS_166,UNC
PVECTORS_167		B		PVECTORS_167,UNC
PVECTORS_168		B		PVECTORS_168,UNC
PVECTORS_169		B		PVECTORS_169,UNC
PVECTORS_170		B		PVECTORS_170,UNC
PVECTORS_171		B		PVECTORS_171,UNC
PVECTORS_172		B		PVECTORS_172,UNC
PVECTORS_173		B		PVECTORS_173,UNC
PVECTORS_174		B		PVECTORS_174,UNC
PVECTORS_175		B		PVECTORS_175,UNC
PVECTORS_176		B		PVECTORS_176,UNC
PVECTORS_177		B		PVECTORS_177,UNC
PVECTORS_178		B		PVECTORS_178,UNC
PVECTORS_179		B		PVECTORS_179,UNC
PVECTORS_180		B		PVECTORS_180,UNC
PVECTORS_181		B		PVECTORS_181,UNC
PVECTORS_182		B		PVECTORS_182,UNC
PVECTORS_183		B		PVECTORS_183,UNC
PVECTORS_184		B		PVECTORS_184,UNC
PVECTORS_185		B		PVECTORS_185,UNC
PVECTORS_186		B		PVECTORS_186,UNC
PVECTORS_187		B		PVECTORS_187,UNC
PVECTORS_188		B		PVECTORS_188,UNC
PVECTORS_189		B		PVECTORS_189,UNC
PVECTORS_190		B		PVECTORS_190,UNC
PVECTORS_191		B		PVECTORS_191,UNC
PVECTORS_192		B		PVECTORS_192,UNC
PVECTORS_193		B		PVECTORS_193,UNC
PVECTORS_194		B		PVECTORS_194,UNC
PVECTORS_195		B		PVECTORS_195,UNC
PVECTORS_196		B		PVECTORS_196,UNC
PVECTORS_197		B		PVECTORS_197,UNC
PVECTORS_198		B		PVECTORS_198,UNC
PVECTORS_199		B		PVECTORS_199,UNC
PVECTORS_200		B		PVECTORS_200,UNC
PVECTORS_201		B		PVECTORS_201,UNC
PVECTORS_202		B		PVECTORS_202,UNC
PVECTORS_203		B		PVECTORS_203,UNC
PVECTORS_204		B		PVECTORS_204,UNC
PVECTORS_205		B		PVECTORS_205,UNC
PVECTORS_206		B		PVECTORS_206,UNC
PVECTORS_207		B		PVECTORS_207,UNC
PVECTORS_208		B		PVECTORS_208,UNC
PVECTORS_209		B		PVECTORS_209,UNC
PVECTORS_210		B		PVECTORS_210,UNC
PVECTORS_211		B		PVECTORS_211,UNC
PVECTORS_212		B		PVECTORS_212,UNC
PVECTORS_213		B		PVECTORS_213,UNC
PVECTORS_214		B		PVECTORS_214,UNC
PVECTORS_215		B		PVECTORS_215,UNC
PVECTORS_216		B		PVECTORS_216,UNC
PVECTORS_217		B		PVECTORS_217,UNC
PVECTORS_218		B		PVECTORS_218,UNC
PVECTORS_219		B		PVECTORS_219,UNC
PVECTORS_220		B		PVECTORS_220,UNC
PVECTORS_221		B		PVECTORS_221,UNC
PVECTORS_222		B		PVECTORS_222,UNC
PVECTORS_223		B		PVECTORS_223,UNC


