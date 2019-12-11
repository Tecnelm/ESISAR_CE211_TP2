   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     	bsct
  16  0000               _counter:
  17  0000 00            	dc.b	0
  46                     ; 16 void initTimer(void)
  46                     ; 17 {
  48                     	switch	.text
  49  0000               _initTimer:
  53                     ; 18     TIM3 -> ARRL = TIMELOW;
  55  0000 3523532c      	mov	21292,#35
  56                     ; 19     TIM3 -> ARRH = TIMEHIGH;
  58  0004 35f4532b      	mov	21291,#244
  59                     ; 20     TIM3 ->PSCR = TIMER3PRESC;
  61  0008 3505532a      	mov	21290,#5
  62                     ; 21     TIM3->IER = 1;
  64  000c 35015321      	mov	21281,#1
  65                     ; 22 }
  68  0010 81            	ret
  91                     ; 24 u8 lireBP2(void)
  91                     ; 25 {
  92                     	switch	.text
  93  0011               _lireBP2:
  97                     ; 26     return GPIOE->IDR & BP2MASK;
  99  0011 c65015        	ld	a,20501
 100  0014 a480          	and	a,#128
 103  0016 81            	ret
 127                     ; 29 void initPort(void)
 127                     ; 30 {
 128                     	switch	.text
 129  0017               _initPort:
 133                     ; 31     init_Ports();
 135  0017 cd0000        	call	_init_Ports
 137                     ; 32     GPIOE ->DDR =0x00 ;
 139  001a 725f5016      	clr	20502
 140                     ; 33     GPIOE ->CR1 = BP2MASK;
 142  001e 35805017      	mov	20503,#128
 143                     ; 34 }
 146  0022 81            	ret
 186                     ; 36 void intertiming(void)
 186                     ; 37 {
 187                     	switch	.text
 188  0023               _intertiming:
 190  0023 88            	push	a
 191       00000001      OFST:	set	1
 194                     ; 38     char flag =0;
 196  0024 0f01          	clr	(OFST+0,sp)
 197                     ; 39     initPort();
 199  0026 adef          	call	_initPort
 201                     ; 40     initTimer();
 203  0028 add6          	call	_initTimer
 205                     ; 41     afficher_TIL321(counter);
 207  002a b600          	ld	a,_counter
 208  002c cd0000        	call	_afficher_TIL321
 210                     ; 42     enableInterrupts();
 213  002f 9a            rim
 215  0030               L75:
 216                     ; 46         if(lireBP2() && !flag)
 218  0030 addf          	call	_lireBP2
 220  0032 4d            	tnz	a
 221  0033 2714          	jreq	L36
 223  0035 0d01          	tnz	(OFST+0,sp)
 224  0037 2610          	jrne	L36
 225                     ; 48             TIM3 ->CR1 ^= TIMER3CR1;
 227  0039 c65320        	ld	a,21280
 228  003c a801          	xor	a,	#1
 229  003e c75320        	ld	21280,a
 230                     ; 49             counter = 0;
 232  0041 3f00          	clr	_counter
 233                     ; 50             flag = 1;
 235  0043 a601          	ld	a,#1
 236  0045 6b01          	ld	(OFST+0,sp),a
 238  0047 20e7          	jra	L75
 239  0049               L36:
 240                     ; 51         }else if(!lireBP2() && flag )
 242  0049 adc6          	call	_lireBP2
 244  004b 4d            	tnz	a
 245  004c 26e2          	jrne	L75
 247  004e 0d01          	tnz	(OFST+0,sp)
 248  0050 27de          	jreq	L75
 249                     ; 53             flag = 0;
 251  0052 0f01          	clr	(OFST+0,sp)
 252  0054 20da          	jra	L75
 277                     ; 58 void incrementCounter(void)
 277                     ; 59 {
 278                     	switch	.text
 279  0056               _incrementCounter:
 283                     ; 60     TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
 285  0056 72115322      	bres	21282,#0
 286                     ; 61     (counter) ++;
 288  005a 3c00          	inc	_counter
 289                     ; 62     (counter)%=10;
 291  005c b600          	ld	a,_counter
 292  005e ae000a        	ldw	x,#10
 293  0061 51            	exgw	x,y
 294  0062 5f            	clrw	x
 295  0063 97            	ld	xl,a
 296  0064 65            	divw	x,y
 297  0065 909f          	ld	a,yl
 298  0067 b700          	ld	_counter,a
 299                     ; 63     afficher_TIL321(counter);
 301  0069 b600          	ld	a,_counter
 302  006b cd0000        	call	_afficher_TIL321
 304                     ; 64 }
 307  006e 81            	ret
 331                     	xdef	_lireBP2
 332                     	xdef	_counter
 333                     	xdef	_intertiming
 334                     	xdef	_incrementCounter
 335                     	xdef	_initPort
 336                     	xdef	_initTimer
 337                     	xref	_afficher_TIL321
 338                     	xref	_init_Ports
 357                     	end
