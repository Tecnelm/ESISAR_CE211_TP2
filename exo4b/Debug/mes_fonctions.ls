   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     	bsct
  16  0000               _counter:
  17  0000 00            	dc.b	0
  46                     ; 21 void initTimer(void)
  46                     ; 22 {
  48                     	switch	.text
  49  0000               _initTimer:
  53                     ; 23     TIM3 -> ARRL = TIMELOW;
  55  0000 3523532c      	mov	21292,#35
  56                     ; 24     TIM3 -> ARRH = TIMEHIGH;
  58  0004 35f4532b      	mov	21291,#244
  59                     ; 25     TIM3 ->PSCR = TIMER3PRESC;
  61  0008 3505532a      	mov	21290,#5
  62                     ; 26     TIM3->IER = 1;
  64  000c 35015321      	mov	21281,#1
  65                     ; 27 }
  68  0010 81            	ret
  91                     ; 29 char lireBP2(void)
  91                     ; 30 {
  92                     	switch	.text
  93  0011               _lireBP2:
  97                     ; 31     return GPIOE->IDR & BP2MASK;
  99  0011 c65015        	ld	a,20501
 100  0014 a480          	and	a,#128
 103  0016 81            	ret
 127                     ; 34 void initPort(void)
 127                     ; 35 {
 128                     	switch	.text
 129  0017               _initPort:
 133                     ; 36     init_Ports();
 135  0017 cd0000        	call	_init_Ports
 137                     ; 37     GPIOE ->DDR =0x00 ;
 139  001a 725f5016      	clr	20502
 140                     ; 38     GPIOE ->CR1 = BP2MASK;
 142  001e 35805017      	mov	20503,#128
 143                     ; 39 }
 146  0022 81            	ret
 186                     ; 41 void intertiming(void)
 186                     ; 42 {
 187                     	switch	.text
 188  0023               _intertiming:
 190  0023 88            	push	a
 191       00000001      OFST:	set	1
 194                     ; 43     char flag =0;
 196  0024 0f01          	clr	(OFST+0,sp)
 197                     ; 44     initPort();
 199  0026 adef          	call	_initPort
 201                     ; 45     initTimer();
 203  0028 add6          	call	_initTimer
 205                     ; 46     afficher_TIL321(counter);
 207  002a b600          	ld	a,_counter
 208  002c cd0000        	call	_afficher_TIL321
 210                     ; 47     enableInterrupts();
 213  002f 9a            rim
 215  0030               L75:
 216                     ; 51         if(lireBP2() && !flag)
 218  0030 addf          	call	_lireBP2
 220  0032 4d            	tnz	a
 221  0033 2714          	jreq	L36
 223  0035 0d01          	tnz	(OFST+0,sp)
 224  0037 2610          	jrne	L36
 225                     ; 53             TIM3 ->CR1 ^= TIMER3CR1;
 227  0039 c65320        	ld	a,21280
 228  003c a801          	xor	a,	#1
 229  003e c75320        	ld	21280,a
 230                     ; 54             counter = 0;
 232  0041 3f00          	clr	_counter
 233                     ; 55             flag = 1;
 235  0043 a601          	ld	a,#1
 236  0045 6b01          	ld	(OFST+0,sp),a
 238  0047 20e7          	jra	L75
 239  0049               L36:
 240                     ; 56         }else if(!lireBP2() && flag )
 242  0049 adc6          	call	_lireBP2
 244  004b 4d            	tnz	a
 245  004c 26e2          	jrne	L75
 247  004e 0d01          	tnz	(OFST+0,sp)
 248  0050 27de          	jreq	L75
 249                     ; 58             flag = 0;
 251  0052 0f01          	clr	(OFST+0,sp)
 252  0054 20da          	jra	L75
 276                     ; 63 void incrementCounter(void)
 276                     ; 64 {
 277                     	switch	.text
 278  0056               _incrementCounter:
 282                     ; 65     TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
 284  0056 72115322      	bres	21282,#0
 285                     ; 66     (counter) ++;
 287  005a 3c00          	inc	_counter
 288                     ; 67     (counter)%=10;
 290  005c b600          	ld	a,_counter
 291  005e ae000a        	ldw	x,#10
 292  0061 51            	exgw	x,y
 293  0062 5f            	clrw	x
 294  0063 97            	ld	xl,a
 295  0064 65            	divw	x,y
 296  0065 909f          	ld	a,yl
 297  0067 b700          	ld	_counter,a
 298                     ; 69 }
 301  0069 81            	ret
 349                     ; 71 void rightTimePush(void){
 350                     	switch	.text
 351  006a               _rightTimePush:
 353  006a 89            	pushw	x
 354       00000002      OFST:	set	2
 357                     ; 74     char ledRedOn = 0;
 359  006b 0f02          	clr	(OFST+0,sp)
 360                     ; 75     char flag =0;
 362  006d 0f01          	clr	(OFST-1,sp)
 363                     ; 76     initPort();
 365  006f ada6          	call	_initPort
 367                     ; 77     initTimer();
 369  0071 ad8d          	call	_initTimer
 371                     ; 78     enableInterrupts();
 374  0073 9a            rim
 376  0074               L321:
 377                     ; 83         if(lireBP2() && !flag)
 379  0074 ad9b          	call	_lireBP2
 381  0076 4d            	tnz	a
 382  0077 2724          	jreq	L721
 384  0079 0d01          	tnz	(OFST-1,sp)
 385  007b 2620          	jrne	L721
 386                     ; 85             GPIOD -> ODR &=~LEDGREEN ;
 388  007d 7211500f      	bres	20495,#0
 389                     ; 86             GPIOA -> ODR &=~LEDRED ;
 392  0081 c65000        	ld	a,20480
 393  0084 a487          	and	a,#135
 394  0086 c75000        	ld	20480,a
 395                     ; 87             TIM3 ->CR1 |= TIMER3CR1;
 398  0089 72105320      	bset	21280,#0
 399                     ; 88             if(counter >=BASETIME)
 401  008d b600          	ld	a,_counter
 402  008f a102          	cp	a,#2
 403  0091 2504          	jrult	L131
 404                     ; 90                 ledRedOn = 0;
 406  0093 0f02          	clr	(OFST+0,sp)
 408  0095 2012          	jra	L531
 409  0097               L131:
 410                     ; 94                 ledRedOn = 1;
 412  0097 a601          	ld	a,#1
 413  0099 6b02          	ld	(OFST+0,sp),a
 414  009b 200c          	jra	L531
 415  009d               L721:
 416                     ; 99             if(ledRedOn)
 418  009d 0d02          	tnz	(OFST+0,sp)
 419  009f 2704          	jreq	L731
 420                     ; 100                 flag = 1;   
 422  00a1 a601          	ld	a,#1
 423  00a3 6b01          	ld	(OFST-1,sp),a
 424  00a5               L731:
 425                     ; 102             GPIOD -> ODR |=LEDGREEN ;
 427  00a5 7210500f      	bset	20495,#0
 428  00a9               L531:
 429                     ; 106         if(ledRedOn && !lireBP2())
 431  00a9 0d02          	tnz	(OFST+0,sp)
 432  00ab 2720          	jreq	L141
 434  00ad cd0011        	call	_lireBP2
 436  00b0 4d            	tnz	a
 437  00b1 261a          	jrne	L141
 438                     ; 108             if(counter >= REDTIME)
 440  00b3 b600          	ld	a,_counter
 441  00b5 a108          	cp	a,#8
 442  00b7 252e          	jrult	L541
 443                     ; 110                 ledRedOn = 0;
 445  00b9 0f02          	clr	(OFST+0,sp)
 446                     ; 111                 flag = 0;
 448  00bb 0f01          	clr	(OFST-1,sp)
 449                     ; 112                 GPIOA -> ODR |=LEDRED ;
 451  00bd c65000        	ld	a,20480
 452  00c0 aa78          	or	a,#120
 453  00c2 c75000        	ld	20480,a
 454                     ; 113                 counter =0;
 457  00c5 3f00          	clr	_counter
 458                     ; 114                 TIM3 ->CR1 &= ~TIMER3CR1;
 460  00c7 72115320      	bres	21280,#0
 461  00cb 201a          	jra	L541
 462  00cd               L141:
 463                     ; 117         }else if(!ledRedOn && !lireBP2())
 465  00cd 0d02          	tnz	(OFST+0,sp)
 466  00cf 2616          	jrne	L541
 468  00d1 cd0011        	call	_lireBP2
 470  00d4 4d            	tnz	a
 471  00d5 2610          	jrne	L541
 472                     ; 119             GPIOA -> ODR |=LEDRED ;
 474  00d7 c65000        	ld	a,20480
 475  00da aa78          	or	a,#120
 476  00dc c75000        	ld	20480,a
 477                     ; 120             flag = 0;
 480  00df 0f01          	clr	(OFST-1,sp)
 481                     ; 121             counter =0;
 483  00e1 3f00          	clr	_counter
 484                     ; 122             TIM3 ->CR1 &= ~TIMER3CR1;
 486  00e3 72115320      	bres	21280,#0
 487  00e7               L541:
 488                     ; 126         if(ledRedOn || lireBP2())
 490  00e7 0d02          	tnz	(OFST+0,sp)
 491  00e9 2606          	jrne	L351
 493  00eb cd0011        	call	_lireBP2
 495  00ee 4d            	tnz	a
 496  00ef 2707          	jreq	L151
 497  00f1               L351:
 498                     ; 128           GPIOB->ODR = LETTRE_B; 
 500  00f1 357a5005      	mov	20485,#122
 502  00f5 cc0074        	jra	L321
 503  00f8               L151:
 504                     ; 131             GPIOB->ODR = LETTRE_A;
 506  00f8 35ee5005      	mov	20485,#238
 507  00fc ac740074      	jpf	L321
 531                     	xdef	_counter
 532                     	xdef	_rightTimePush
 533                     	xdef	_lireBP2
 534                     	xdef	_intertiming
 535                     	xdef	_incrementCounter
 536                     	xdef	_initPort
 537                     	xdef	_initTimer
 538                     	xref	_afficher_TIL321
 539                     	xref	_init_Ports
 558                     	end
