   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     	bsct
  16  0000               _counter:
  17  0000 00            	dc.b	0
  46                     ; 18 void initTimer(void)
  46                     ; 19 {
  48                     	switch	.text
  49  0000               _initTimer:
  53                     ; 20     TIM3 -> ARRL = TIMELOW;
  55  0000 3523532c      	mov	21292,#35
  56                     ; 21     TIM3 -> ARRH = TIMEHIGH;
  58  0004 35f4532b      	mov	21291,#244
  59                     ; 22     TIM3 ->PSCR = TIMER3PRESC;
  61  0008 3505532a      	mov	21290,#5
  62                     ; 23     TIM3->IER = 1;
  64  000c 35015321      	mov	21281,#1
  65                     ; 24 }
  68  0010 81            	ret
  91                     ; 26 u8 lireBP2(void)
  91                     ; 27 {
  92                     	switch	.text
  93  0011               _lireBP2:
  97                     ; 28     return GPIOE->IDR & BP2MASK;
  99  0011 c65015        	ld	a,20501
 100  0014 a480          	and	a,#128
 103  0016 81            	ret
 127                     ; 31 void initPort(void)
 127                     ; 32 {
 128                     	switch	.text
 129  0017               _initPort:
 133                     ; 33     init_Ports();
 135  0017 cd0000        	call	_init_Ports
 137                     ; 35 }
 140  001a 81            	ret
 180                     ; 37 void intertiming(void)
 180                     ; 38 {
 181                     	switch	.text
 182  001b               _intertiming:
 184  001b 88            	push	a
 185       00000001      OFST:	set	1
 188                     ; 39     char flag =0;
 190  001c 0f01          	clr	(OFST+0,sp)
 191                     ; 40     initPort();
 193  001e adf7          	call	_initPort
 195                     ; 41     initTimer();
 197  0020 adde          	call	_initTimer
 199                     ; 42     afficher_TIL321(counter);
 201  0022 b600          	ld	a,_counter
 202  0024 cd0000        	call	_afficher_TIL321
 204                     ; 43     enableInterrupts();
 207  0027 9a            rim
 209  0028               L75:
 210                     ; 47         if(lireBP2() && !flag)
 212  0028 ade7          	call	_lireBP2
 214  002a 4d            	tnz	a
 215  002b 2714          	jreq	L36
 217  002d 0d01          	tnz	(OFST+0,sp)
 218  002f 2610          	jrne	L36
 219                     ; 49             TIM3 ->CR1 ^= TIMER3CR1;
 221  0031 c65320        	ld	a,21280
 222  0034 a801          	xor	a,	#1
 223  0036 c75320        	ld	21280,a
 224                     ; 50             counter = 0;
 226  0039 3f00          	clr	_counter
 227                     ; 51             flag = 1;
 229  003b a601          	ld	a,#1
 230  003d 6b01          	ld	(OFST+0,sp),a
 232  003f 20e7          	jra	L75
 233  0041               L36:
 234                     ; 52         }else if(!lireBP2() && flag )
 236  0041 adce          	call	_lireBP2
 238  0043 4d            	tnz	a
 239  0044 26e2          	jrne	L75
 241  0046 0d01          	tnz	(OFST+0,sp)
 242  0048 27de          	jreq	L75
 243                     ; 54             flag = 0;
 245  004a 0f01          	clr	(OFST+0,sp)
 246  004c 20da          	jra	L75
 270                     ; 59 void incrementCounter(void)
 270                     ; 60 {
 271                     	switch	.text
 272  004e               _incrementCounter:
 276                     ; 61     TIM3 -> SR1 =TIM3 -> SR1& ~(TIM3_SR1_UIF);
 278  004e 72115322      	bres	21282,#0
 279                     ; 62     (counter) ++;
 281  0052 3c00          	inc	_counter
 282                     ; 63     (counter)%=10;
 284  0054 b600          	ld	a,_counter
 285  0056 ae000a        	ldw	x,#10
 286  0059 51            	exgw	x,y
 287  005a 5f            	clrw	x
 288  005b 97            	ld	xl,a
 289  005c 65            	divw	x,y
 290  005d 909f          	ld	a,yl
 291  005f b700          	ld	_counter,a
 292                     ; 64 }
 295  0061 81            	ret
 329                     ; 66 void allumLed(u8 value)
 329                     ; 67 {
 330                     	switch	.text
 331  0062               _allumLed:
 333  0062 88            	push	a
 334       00000000      OFST:	set	0
 337                     ; 68     if(value == 0)
 339  0063 4d            	tnz	a
 340  0064 2606          	jrne	L711
 341                     ; 70         GPIOB-> ODR = 0;
 343  0066 725f5005      	clr	20485
 345  006a 2011          	jra	L121
 346  006c               L711:
 347                     ; 73         GPIOB-> ODR = 1<< value-1;
 349  006c 7b01          	ld	a,(OFST+1,sp)
 350  006e 4a            	dec	a
 351  006f 5f            	clrw	x
 352  0070 97            	ld	xl,a
 353  0071 a601          	ld	a,#1
 354  0073 5d            	tnzw	x
 355  0074 2704          	jreq	L02
 356  0076               L22:
 357  0076 48            	sll	a
 358  0077 5a            	decw	x
 359  0078 26fc          	jrne	L22
 360  007a               L02:
 361  007a c75005        	ld	20485,a
 362  007d               L121:
 363                     ; 77 }
 366  007d 84            	pop	a
 367  007e 81            	ret
 418                     ; 79 void chenillardLed(void)
 418                     ; 80 {
 419                     	switch	.text
 420  007f               _chenillardLed:
 422  007f 89            	pushw	x
 423       00000002      OFST:	set	2
 426                     ; 84     initPort();
 428  0080 ad95          	call	_initPort
 430                     ; 85     initTimer();
 432  0082 cd0000        	call	_initTimer
 434                     ; 86     enableInterrupts();
 437  0085 9a            rim
 439                     ; 88     flag = 0;
 442                     ; 89     chenOn = 0;
 444  0086 0f02          	clr	(OFST+0,sp)
 445                     ; 91     afficher_Modules_HDLX(WAIT);
 447  0088 ae0012        	ldw	x,#L541
 448  008b cd0000        	call	_afficher_Modules_HDLX
 450  008e               L741:
 451                     ; 96         if(!chenOn && getButtonStart())
 453  008e 0d02          	tnz	(OFST+0,sp)
 454  0090 2615          	jrne	L351
 456  0092 ad37          	call	_getButtonStart
 458  0094 4d            	tnz	a
 459  0095 2710          	jreq	L351
 460                     ; 98             afficher_Modules_HDLX(CHENIL);
 462  0097 ae0009        	ldw	x,#L551
 463  009a cd0000        	call	_afficher_Modules_HDLX
 465                     ; 99             TIM3 ->CR1 |= TIMER3CR1;
 467  009d 72105320      	bset	21280,#0
 468                     ; 100             counter = 0;
 470  00a1 3f00          	clr	_counter
 471                     ; 101             chenOn =1;
 473  00a3 a601          	ld	a,#1
 474  00a5 6b02          	ld	(OFST+0,sp),a
 475  00a7               L351:
 476                     ; 104         if(chenOn && getButtonStop()){
 478  00a7 0d02          	tnz	(OFST+0,sp)
 479  00a9 2716          	jreq	L751
 481  00ab ad2b          	call	_getButtonStop
 483  00ad 4d            	tnz	a
 484  00ae 2711          	jreq	L751
 485                     ; 106             afficher_Modules_HDLX(STOP);
 487  00b0 ae0000        	ldw	x,#L161
 488  00b3 cd0000        	call	_afficher_Modules_HDLX
 490                     ; 107             TIM3 ->CR1 &= ~TIMER3CR1;
 492  00b6 72115320      	bres	21280,#0
 493                     ; 108             counter = 0;
 495  00ba 3f00          	clr	_counter
 496                     ; 109             chenOn = 0;
 498  00bc 0f02          	clr	(OFST+0,sp)
 499                     ; 110             allumLed(counter);
 501  00be 4f            	clr	a
 502  00bf ada1          	call	_allumLed
 504  00c1               L751:
 505                     ; 113         if(chenOn)
 507  00c1 0d02          	tnz	(OFST+0,sp)
 508  00c3 27c9          	jreq	L741
 509                     ; 115             allumLed(counter);
 511  00c5 b600          	ld	a,_counter
 512  00c7 ad99          	call	_allumLed
 514  00c9 20c3          	jra	L741
 537                     ; 120 u8 getButtonStart(void)
 537                     ; 121 {
 538                     	switch	.text
 539  00cb               _getButtonStart:
 543                     ; 122     return !(GPIOC->IDR & BP3MASK);
 545  00cb c6500b        	ld	a,20491
 546  00ce a504          	bcp	a,#4
 547  00d0 2604          	jrne	L03
 548  00d2 a601          	ld	a,#1
 549  00d4 2001          	jra	L23
 550  00d6               L03:
 551  00d6 4f            	clr	a
 552  00d7               L23:
 555  00d7 81            	ret
 579                     ; 126 u8 getButtonStop(void)
 579                     ; 127 {
 580                     	switch	.text
 581  00d8               _getButtonStop:
 585                     ; 128     return lireBP2() ;
 587  00d8 cd0011        	call	_lireBP2
 591  00db 81            	ret
 615                     	xdef	_counter
 616                     	xdef	_lireBP2
 617                     	xdef	_getButtonStop
 618                     	xdef	_getButtonStart
 619                     	xdef	_allumLed
 620                     	xdef	_chenillardLed
 621                     	xdef	_intertiming
 622                     	xdef	_incrementCounter
 623                     	xdef	_initPort
 624                     	xdef	_initTimer
 625                     	xref	_afficher_Modules_HDLX
 626                     	xref	_afficher_TIL321
 627                     	xref	_init_Ports
 628                     .const:	section	.text
 629  0000               L161:
 630  0000 415252455420  	dc.b	"ARRET   ",0
 631  0009               L551:
 632  0009 4348454e494c  	dc.b	"CHENIL. ",0
 633  0012               L541:
 634  0012 574149542020  	dc.b	"WAIT    ",0
 654                     	end
