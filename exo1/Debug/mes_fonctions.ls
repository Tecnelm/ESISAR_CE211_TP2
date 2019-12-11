   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     	bsct
  16  0000               _counter:
  17  0000 00            	dc.b	0
  46                     ; 12 void initTimer(void)
  46                     ; 13 {
  48                     	switch	.text
  49  0000               _initTimer:
  53                     ; 14     TIM3 -> ARRL = TIMELOW;
  55  0000 3523532c      	mov	21292,#35
  56                     ; 15     TIM3 -> ARRH = TIMEHIGH;
  58  0004 35f4532b      	mov	21291,#244
  59                     ; 16     TIM3 ->PSCR = TIMER3PRESC;
  61  0008 3505532a      	mov	21290,#5
  62                     ; 17     TIM3->IER = 1;
  64  000c 35015321      	mov	21281,#1
  65                     ; 18 }
  68  0010 81            	ret
  91                     ; 20 u8 lireBP2(void)
  91                     ; 21 {
  92                     	switch	.text
  93  0011               _lireBP2:
  97                     ; 22     return GPIOE->IDR & BP2MASK;
  99  0011 c65015        	ld	a,20501
 100  0014 a480          	and	a,#128
 103  0016 81            	ret
 127                     ; 25 void initPort(void)
 127                     ; 26 {
 128                     	switch	.text
 129  0017               _initPort:
 133                     ; 27     init_Ports();
 135  0017 cd0000        	call	_init_Ports
 137                     ; 28     GPIOE ->DDR =0x00 ;
 139  001a 725f5016      	clr	20502
 140                     ; 29     GPIOE ->CR1 = BP2MASK;
 142  001e 35805017      	mov	20503,#128
 143                     ; 30 }
 146  0022 81            	ret
 193                     ; 34 void timing(void)
 193                     ; 35 {
 194                     	switch	.text
 195  0023               _timing:
 197  0023 89            	pushw	x
 198       00000002      OFST:	set	2
 201                     ; 36     u8 currentTime = 0;
 203  0024 0f02          	clr	(OFST+0,sp)
 204                     ; 37     char flag = 0;
 206  0026 0f01          	clr	(OFST-1,sp)
 207                     ; 38     initPort();
 209  0028 aded          	call	_initPort
 211                     ; 39     initTimer();
 213  002a add4          	call	_initTimer
 215                     ; 40     afficher_TIL321(currentTime);
 217  002c 7b02          	ld	a,(OFST+0,sp)
 218  002e cd0000        	call	_afficher_TIL321
 220  0031               L36:
 221                     ; 47         if((TIM3 -> SR1 & TIM3_SR1_UIF) )
 223  0031 c65322        	ld	a,21282
 224  0034 a501          	bcp	a,#1
 225  0036 2718          	jreq	L76
 226                     ; 49             currentTime++;
 228  0038 0c02          	inc	(OFST+0,sp)
 229                     ; 50 			currentTime %=10;  
 231  003a 7b02          	ld	a,(OFST+0,sp)
 232  003c ae000a        	ldw	x,#10
 233  003f 51            	exgw	x,y
 234  0040 5f            	clrw	x
 235  0041 97            	ld	xl,a
 236  0042 65            	divw	x,y
 237  0043 909f          	ld	a,yl
 238  0045 6b02          	ld	(OFST+0,sp),a
 239                     ; 51             afficher_TIL321(currentTime);
 241  0047 7b02          	ld	a,(OFST+0,sp)
 242  0049 cd0000        	call	_afficher_TIL321
 244                     ; 52             TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
 246  004c 72115322      	bres	21282,#0
 247  0050               L76:
 248                     ; 54         if(lireBP2() && !flag)
 250  0050 adbf          	call	_lireBP2
 252  0052 4d            	tnz	a
 253  0053 2714          	jreq	L17
 255  0055 0d01          	tnz	(OFST-1,sp)
 256  0057 2610          	jrne	L17
 257                     ; 56                 TIM3 ->CR1 ^= TIMER3CR1;
 259  0059 c65320        	ld	a,21280
 260  005c a801          	xor	a,	#1
 261  005e c75320        	ld	21280,a
 262                     ; 57                 currentTime = 0;
 264  0061 0f02          	clr	(OFST+0,sp)
 265                     ; 58             flag = 1;
 267  0063 a601          	ld	a,#1
 268  0065 6b01          	ld	(OFST-1,sp),a
 270  0067 20c8          	jra	L36
 271  0069               L17:
 272                     ; 59         }else if(!lireBP2() && flag )
 274  0069 ada6          	call	_lireBP2
 276  006b 4d            	tnz	a
 277  006c 26c3          	jrne	L36
 279  006e 0d01          	tnz	(OFST-1,sp)
 280  0070 27bf          	jreq	L36
 281                     ; 61             flag = 0;
 283  0072 0f01          	clr	(OFST-1,sp)
 284  0074 20bb          	jra	L36
 332                     ; 68 void intertiming(void)
 332                     ; 69 {
 333                     	switch	.text
 334  0076               _intertiming:
 336  0076 89            	pushw	x
 337       00000002      OFST:	set	2
 340                     ; 70     u8 currentTime = 0;
 342  0077 0f01          	clr	(OFST-1,sp)
 343                     ; 72     char flag =0;
 345  0079 0f02          	clr	(OFST+0,sp)
 346                     ; 73     initPort();
 348  007b ad9a          	call	_initPort
 350                     ; 74     initTimer();
 352  007d ad81          	call	_initTimer
 354                     ; 75     afficher_TIL321(currentTime);
 356  007f 7b01          	ld	a,(OFST-1,sp)
 357  0081 cd0000        	call	_afficher_TIL321
 359                     ; 76     enableInterrupts();
 362  0084 9a            rim
 364  0085               L121:
 365                     ; 82         if(lireBP2() && !flag)
 367  0085 ad8a          	call	_lireBP2
 369  0087 4d            	tnz	a
 370  0088 2712          	jreq	L521
 372  008a 0d02          	tnz	(OFST+0,sp)
 373  008c 260e          	jrne	L521
 374                     ; 84                 TIM3 ->CR1 ^= TIMER3CR1;
 376  008e c65320        	ld	a,21280
 377  0091 a801          	xor	a,	#1
 378  0093 c75320        	ld	21280,a
 379                     ; 85                 currentTime = 0;
 381                     ; 86             flag = 1;
 383  0096 a601          	ld	a,#1
 384  0098 6b02          	ld	(OFST+0,sp),a
 386  009a 20e9          	jra	L121
 387  009c               L521:
 388                     ; 87         }else if(!lireBP2() && flag )
 390  009c cd0011        	call	_lireBP2
 392  009f 4d            	tnz	a
 393  00a0 26e3          	jrne	L121
 395  00a2 0d02          	tnz	(OFST+0,sp)
 396  00a4 27df          	jreq	L121
 397                     ; 89             flag = 0;
 399  00a6 0f02          	clr	(OFST+0,sp)
 400  00a8 20db          	jra	L121
 425                     ; 95 void incrementCounter(void)
 425                     ; 96 {
 426                     	switch	.text
 427  00aa               _incrementCounter:
 431                     ; 97     TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
 433  00aa 72115322      	bres	21282,#0
 434                     ; 98     (counter) ++;
 436  00ae 3c00          	inc	_counter
 437                     ; 99     (counter)%=10;
 439  00b0 b600          	ld	a,_counter
 440  00b2 ae000a        	ldw	x,#10
 441  00b5 51            	exgw	x,y
 442  00b6 5f            	clrw	x
 443  00b7 97            	ld	xl,a
 444  00b8 65            	divw	x,y
 445  00b9 909f          	ld	a,yl
 446  00bb b700          	ld	_counter,a
 447                     ; 100     afficher_TIL321(counter);
 449  00bd b600          	ld	a,_counter
 450  00bf cd0000        	call	_afficher_TIL321
 452                     ; 102 }
 455  00c2 81            	ret
 479                     	xdef	_lireBP2
 480                     	xdef	_counter
 481                     	xdef	_intertiming
 482                     	xdef	_incrementCounter
 483                     	xdef	_initPort
 484                     	xdef	_timing
 485                     	xdef	_initTimer
 486                     	xref	_afficher_TIL321
 487                     	xref	_init_Ports
 506                     	end
