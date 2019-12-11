   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  44                     ; 34 void init_Ports(void) 
  44                     ; 35  {
  46                     	switch	.text
  47  0000               _init_Ports:
  51                     ; 36      GPIOA->DDR = PORT_A_DIRECTION; // lignes 3 à 6 en sortie
  53  0000 35785002      	mov	20482,#120
  54                     ; 37      GPIOA->CR1 = PORT_A_TECHNO_LIGNES; // open drain
  56  0004 35785003      	mov	20483,#120
  57                     ; 38      GPIOA->ODR = 0x78;  // extinction 4 leds	rouges
  59  0008 35785000      	mov	20480,#120
  60                     ; 40      GPIOB->DDR = PORT_B_DIRECTION; // 8 lignes en sortie
  62  000c 35ff5007      	mov	20487,#255
  63                     ; 41      GPIOB->CR1 = PORT_B_TECHNO_LIGNES; // 8 lignes en push pull
  65  0010 35ff5008      	mov	20488,#255
  66                     ; 42      GPIOB->ODR = 0x0; // extinction afficheur TIL321
  68  0014 725f5005      	clr	20485
  69                     ; 44      GPIOC->DDR = PORT_C_DIRECTION; // 7 lignes en entrée
  71  0018 725f500c      	clr	20492
  72                     ; 45      GPIOC->CR1 = PORT_C_TECHNO_LIGNES; // 7 lignes en pull up 
  74  001c 35ff500d      	mov	20493,#255
  75                     ; 47      GPIOD->DDR = PORT_D_DIRECTION;  // ligne 0 en sortie pour led verte
  77  0020 35095011      	mov	20497,#9
  78                     ; 48      GPIOD->CR1 = PORT_D_TECHNO_LIGNES; // ligne 7 en pull up pour BP1 extérieur
  80  0024 35885012      	mov	20498,#136
  81                     ; 50      GPIOD->ODR = GPIO_PIN_0; // extinction led verte
  83  0028 3501500f      	mov	20495,#1
  84                     ; 52      GPIOE->DDR = PORT_E_DIRECTION;  // 2 signaux WR pour HDLX
  86  002c 35285016      	mov	20502,#40
  87                     ; 53      GPIOE->CR1 = PORT_E_TECHNO_LIGNES;  // ligne 7 en pull up pour BP2 extérieur
  89  0030 35a85017      	mov	20503,#168
  90                     ; 55      GPIOG->DDR = PORT_G_DIRECTION;  // sortie pour signaux A0 et A1
  92  0034 35035020      	mov	20512,#3
  93                     ; 56      GPIOG->CR1 = PORT_G_TECHNO_LIGNES; // push pull
  95  0038 35035021      	mov	20513,#3
  96                     ; 58      GPIOD->ODR = HDLX_NBL;  // pas Blanking
  98  003c 3508500f      	mov	20495,#8
  99                     ; 59      GPIOE->ODR = HDLX_NWR1 + HDLX_NWR2; // 2 signaux /WR au repos
 101  0040 35285014      	mov	20500,#40
 102                     ; 60  }
 105  0044 81            	ret
 139                     ; 63 u8 lire_Etat_BP2(void)
 139                     ; 64 {
 140                     	switch	.text
 141  0045               _lire_Etat_BP2:
 143  0045 88            	push	a
 144       00000001      OFST:	set	1
 147                     ; 65 	u8 valeur = NON_ACTIF;
 149  0046 a601          	ld	a,#1
 150  0048 6b01          	ld	(OFST+0,sp),a
 151                     ; 66 		if ( GPIO_PIN_7 != (GPIOE->IDR & GPIO_PIN_7 ))
 153  004a c65015        	ld	a,20501
 154  004d a480          	and	a,#128
 155  004f a180          	cp	a,#128
 156  0051 2702          	jreq	L73
 157                     ; 68 		valeur = ACTIF;
 159  0053 0f01          	clr	(OFST+0,sp)
 160  0055               L73:
 161                     ; 69 		return valeur;
 163  0055 7b01          	ld	a,(OFST+0,sp)
 166  0057 5b01          	addw	sp,#1
 167  0059 81            	ret
 201                     ; 76 u8 afficher_TIL321(u8 valeur)
 201                     ; 77 {
 202                     	switch	.text
 203  005a               _afficher_TIL321:
 205  005a 88            	push	a
 206       00000000      OFST:	set	0
 209                     ; 78 	if( valeur < 0 || valeur > 9)
 211  005b a10a          	cp	a,#10
 212  005d 2509          	jrult	L301
 213                     ; 80 			GPIOB->ODR = LETTRE_E;
 215  005f 359e5005      	mov	20485,#158
 216                     ; 82 			return -1;
 218  0063 a6ff          	ld	a,#255
 221  0065 5b01          	addw	sp,#1
 222  0067 81            	ret
 223  0068               L301:
 224                     ; 86 		switch (valeur)
 226  0068 7b01          	ld	a,(OFST+1,sp)
 228                     ; 117 			break;
 229  006a 4d            	tnz	a
 230  006b 271d          	jreq	L14
 231  006d 4a            	dec	a
 232  006e 2720          	jreq	L34
 233  0070 4a            	dec	a
 234  0071 2723          	jreq	L54
 235  0073 4a            	dec	a
 236  0074 2726          	jreq	L74
 237  0076 4a            	dec	a
 238  0077 2729          	jreq	L15
 239  0079 4a            	dec	a
 240  007a 272c          	jreq	L35
 241  007c 4a            	dec	a
 242  007d 272f          	jreq	L55
 243  007f 4a            	dec	a
 244  0080 2732          	jreq	L75
 245  0082 4a            	dec	a
 246  0083 2735          	jreq	L16
 247  0085 4a            	dec	a
 248  0086 2738          	jreq	L36
 249  0088 203a          	jra	L111
 250  008a               L14:
 251                     ; 88 			case 0 :
 251                     ; 89 			GPIOB->ODR = ZERO;
 253  008a 35fc5005      	mov	20485,#252
 254                     ; 90 			break;
 256  008e 2034          	jra	L111
 257  0090               L34:
 258                     ; 91 			case 1 :
 258                     ; 92 			GPIOB->ODR = UN;
 260  0090 35605005      	mov	20485,#96
 261                     ; 93 			break;
 263  0094 202e          	jra	L111
 264  0096               L54:
 265                     ; 94 			case 2 :
 265                     ; 95 			GPIOB->ODR = DEUX;
 267  0096 35da5005      	mov	20485,#218
 268                     ; 96 			break;
 270  009a 2028          	jra	L111
 271  009c               L74:
 272                     ; 97 			case 3 :
 272                     ; 98 			GPIOB->ODR = TROIS;
 274  009c 35f25005      	mov	20485,#242
 275                     ; 99 			break;
 277  00a0 2022          	jra	L111
 278  00a2               L15:
 279                     ; 100 			case 4 :
 279                     ; 101 			GPIOB->ODR = QUATRE;
 281  00a2 35665005      	mov	20485,#102
 282                     ; 102 			break;
 284  00a6 201c          	jra	L111
 285  00a8               L35:
 286                     ; 103 			case 5 :
 286                     ; 104 			GPIOB->ODR = CINQ;
 288  00a8 35b65005      	mov	20485,#182
 289                     ; 105 			break;
 291  00ac 2016          	jra	L111
 292  00ae               L55:
 293                     ; 106 			case 6 :
 293                     ; 107 			GPIOB->ODR = SIX;
 295  00ae 35be5005      	mov	20485,#190
 296                     ; 108 			break;
 298  00b2 2010          	jra	L111
 299  00b4               L75:
 300                     ; 109 			case 7 :
 300                     ; 110 			GPIOB->ODR = SEPT;
 302  00b4 35e05005      	mov	20485,#224
 303                     ; 111 			break;
 305  00b8 200a          	jra	L111
 306  00ba               L16:
 307                     ; 112 			case 8 :
 307                     ; 113 			GPIOB->ODR = HUIT;
 309  00ba 35fe5005      	mov	20485,#254
 310                     ; 114 			break;
 312  00be 2004          	jra	L111
 313  00c0               L36:
 314                     ; 115 			case 9 :
 314                     ; 116 			GPIOB->ODR = NEUF;
 316  00c0 35f65005      	mov	20485,#246
 317                     ; 117 			break;
 319  00c4               L111:
 320                     ; 119 		return 1;
 322  00c4 a601          	ld	a,#1
 325  00c6 5b01          	addw	sp,#1
 326  00c8 81            	ret
 370                     ; 125 void afficher_Digit_HDLX1(u8 numero, u8 caractere)
 370                     ; 126 {
 371                     	switch	.text
 372  00c9               _afficher_Digit_HDLX1:
 374  00c9 89            	pushw	x
 375       00000000      OFST:	set	0
 378                     ; 127 GPIOB->ODR = caractere + DISPLAY_ASCII; // MSB = 1 pour ASCII
 380  00ca 9f            	ld	a,xl
 381  00cb ab80          	add	a,#128
 382  00cd c75005        	ld	20485,a
 383                     ; 128 GPIOG->ODR = numero ; //  numero digit
 385  00d0 7b01          	ld	a,(OFST+1,sp)
 386  00d2 c7501e        	ld	20510,a
 387                     ; 129 GPIOE->ODR = GPIOE->ODR & ~HDLX_NWR1; // activation WR1
 389  00d5 72175014      	bres	20500,#3
 390                     ; 130 GPIOE->ODR = GPIOE->ODR | HDLX_NWR1; // desactivation WR1
 392  00d9 72165014      	bset	20500,#3
 393                     ; 131 }
 396  00dd 85            	popw	x
 397  00de 81            	ret
 441                     ; 135 void afficher_Digit_HDLX2(u8 numero, u8 caractere)
 441                     ; 136 {
 442                     	switch	.text
 443  00df               _afficher_Digit_HDLX2:
 445  00df 89            	pushw	x
 446       00000000      OFST:	set	0
 449                     ; 137 GPIOB->ODR = caractere + DISPLAY_ASCII; // MSB = 1 pour ASCII
 451  00e0 9f            	ld	a,xl
 452  00e1 ab80          	add	a,#128
 453  00e3 c75005        	ld	20485,a
 454                     ; 138 GPIOG->ODR = numero ; //  numero digit
 456  00e6 7b01          	ld	a,(OFST+1,sp)
 457  00e8 c7501e        	ld	20510,a
 458                     ; 139 GPIOE->ODR = GPIOE->ODR & ~HDLX_NWR2; // activation WR2
 460  00eb 721b5014      	bres	20500,#5
 461                     ; 140 GPIOE->ODR = GPIOE->ODR | HDLX_NWR2; // desactivation WR2
 463  00ef 721a5014      	bset	20500,#5
 464                     ; 141 }
 467  00f3 85            	popw	x
 468  00f4 81            	ret
 524                     ; 146 void afficher_Module_HDLX2(u8* chaine) 
 524                     ; 147 {
 525                     	switch	.text
 526  00f5               _afficher_Module_HDLX2:
 528  00f5 5203          	subw	sp,#3
 529       00000003      OFST:	set	3
 532                     ; 150 pointeur = chaine;
 534  00f7 1f01          	ldw	(OFST-2,sp),x
 535                     ; 151 for ( numero = 3 ; numero > -1 ; numero -- )
 537  00f9 a603          	ld	a,#3
 538  00fb 6b03          	ld	(OFST+0,sp),a
 539  00fd               L502:
 540                     ; 153 	afficher_Digit_HDLX2(numero, *pointeur);
 542  00fd 1e01          	ldw	x,(OFST-2,sp)
 543  00ff f6            	ld	a,(x)
 544  0100 97            	ld	xl,a
 545  0101 7b03          	ld	a,(OFST+0,sp)
 546  0103 95            	ld	xh,a
 547  0104 add9          	call	_afficher_Digit_HDLX2
 549                     ; 154 	pointeur ++;
 551  0106 1e01          	ldw	x,(OFST-2,sp)
 552  0108 1c0001        	addw	x,#1
 553  010b 1f01          	ldw	(OFST-2,sp),x
 554                     ; 151 for ( numero = 3 ; numero > -1 ; numero -- )
 556  010d 0a03          	dec	(OFST+0,sp)
 559  010f 9c            	rvf
 560  0110 7b03          	ld	a,(OFST+0,sp)
 561  0112 a100          	cp	a,#0
 562  0114 2ee7          	jrsge	L502
 563                     ; 156 }
 566  0116 5b03          	addw	sp,#3
 567  0118 81            	ret
 623                     ; 161 void afficher_Module_HDLX1(u8* chaine)
 623                     ; 162 {
 624                     	switch	.text
 625  0119               _afficher_Module_HDLX1:
 627  0119 5203          	subw	sp,#3
 628       00000003      OFST:	set	3
 631                     ; 165 pointeur = chaine;
 633  011b 1f01          	ldw	(OFST-2,sp),x
 634                     ; 166 for ( numero = 3 ; numero > -1 ; numero -- )
 636  011d a603          	ld	a,#3
 637  011f 6b03          	ld	(OFST+0,sp),a
 638  0121               L142:
 639                     ; 168 	afficher_Digit_HDLX1(numero, *pointeur);
 641  0121 1e01          	ldw	x,(OFST-2,sp)
 642  0123 f6            	ld	a,(x)
 643  0124 97            	ld	xl,a
 644  0125 7b03          	ld	a,(OFST+0,sp)
 645  0127 95            	ld	xh,a
 646  0128 ad9f          	call	_afficher_Digit_HDLX1
 648                     ; 169 	pointeur ++;
 650  012a 1e01          	ldw	x,(OFST-2,sp)
 651  012c 1c0001        	addw	x,#1
 652  012f 1f01          	ldw	(OFST-2,sp),x
 653                     ; 166 for ( numero = 3 ; numero > -1 ; numero -- )
 655  0131 0a03          	dec	(OFST+0,sp)
 658  0133 9c            	rvf
 659  0134 7b03          	ld	a,(OFST+0,sp)
 660  0136 a100          	cp	a,#0
 661  0138 2ee7          	jrsge	L142
 662                     ; 171 }
 665  013a 5b03          	addw	sp,#3
 666  013c 81            	ret
 714                     ; 175 void afficher_Modules_HDLX(u8 *adresse)
 714                     ; 176 {
 715                     	switch	.text
 716  013d               _afficher_Modules_HDLX:
 718  013d 89            	pushw	x
 719       00000002      OFST:	set	2
 722                     ; 177 	u8 *pointeur = adresse;
 724  013e 1f01          	ldw	(OFST-1,sp),x
 725                     ; 178 	afficher_Module_HDLX2(pointeur);
 727  0140 1e01          	ldw	x,(OFST-1,sp)
 728  0142 adb1          	call	_afficher_Module_HDLX2
 730                     ; 179 	pointeur += 4;
 732  0144 1e01          	ldw	x,(OFST-1,sp)
 733  0146 1c0004        	addw	x,#4
 734  0149 1f01          	ldw	(OFST-1,sp),x
 735                     ; 180 	afficher_Module_HDLX1(pointeur);
 737  014b 1e01          	ldw	x,(OFST-1,sp)
 738  014d adca          	call	_afficher_Module_HDLX1
 740                     ; 181 }
 743  014f 85            	popw	x
 744  0150 81            	ret
 768                     ; 187 void init_Timer3_PWM_canal2(void)
 768                     ; 188 {
 769                     	switch	.text
 770  0151               _init_Timer3_PWM_canal2:
 774                     ; 189   TIM3-> CR1 |= TIM3_CR1_URS; // pour empecher UIF lors de UG
 776  0151 72145320      	bset	21280,#2
 777                     ; 192 	TIM3-> PSCR = 3;
 779  0155 3503532a      	mov	21290,#3
 780                     ; 193 	TIM3-> ARRH = 0x09; // pour période ...
 782  0159 3509532b      	mov	21291,#9
 783                     ; 194 	TIM3-> ARRL = 0xC4; // ... 10 ms
 785  015d 35c4532c      	mov	21292,#196
 786                     ; 197 	TIM3-> CCR2H = 0x00; //
 788  0161 725f532f      	clr	21295
 789                     ; 198 	TIM3-> CCR2L = 0x7D; // 1/20ème de T
 791  0165 357d5330      	mov	21296,#125
 792                     ; 200 	TIM3-> CCMR2 = 0x70; // PWM en mode 2 OC2 en sortie
 794  0169 35705326      	mov	21286,#112
 795                     ; 201 	TIM3-> CCER1 = TIM3_CCER1_CC2P | TIM3_CCER1_CC2E ; // canal2 actif bas
 797  016d 35305327      	mov	21287,#48
 798                     ; 204 	TIM3-> EGR = TIM3_EGR_UG; // chargement des registres
 800  0171 35015324      	mov	21284,#1
 801                     ; 205 }
 804  0175 81            	ret
 867                     ; 209 void conv_BCD_ASCII(u8 valeur_BCD, u8 *adresse)
 867                     ; 210 {
 868                     	switch	.text
 869  0176               _conv_BCD_ASCII:
 871  0176 88            	push	a
 872  0177 5203          	subw	sp,#3
 873       00000003      OFST:	set	3
 876                     ; 212 	u8 *pointeur = adresse;
 878  0179 1e07          	ldw	x,(OFST+4,sp)
 879  017b 1f01          	ldw	(OFST-2,sp),x
 880                     ; 214 	valeur = valeur_BCD; 
 882  017d 6b03          	ld	(OFST+0,sp),a
 883                     ; 215 	valeur = valeur & GPIO_PIN_HNIB; // conserve quartet fort
 885  017f 7b03          	ld	a,(OFST+0,sp)
 886  0181 a4f0          	and	a,#240
 887  0183 6b03          	ld	(OFST+0,sp),a
 888                     ; 216 	valeur = valeur >> 4; // decalage droite 4 positions
 890  0185 7b03          	ld	a,(OFST+0,sp)
 891  0187 4e            	swap	a
 892  0188 a40f          	and	a,#15
 893  018a 6b03          	ld	(OFST+0,sp),a
 894                     ; 217 	valeur += CODE_ASCII_0; // conversion ASCII
 896  018c 7b03          	ld	a,(OFST+0,sp)
 897  018e ab30          	add	a,#48
 898  0190 6b03          	ld	(OFST+0,sp),a
 899                     ; 218 	*pointeur = valeur; // mise en mémoire
 901  0192 7b03          	ld	a,(OFST+0,sp)
 902  0194 1e01          	ldw	x,(OFST-2,sp)
 903  0196 f7            	ld	(x),a
 904                     ; 219 	pointeur ++;
 906  0197 1e01          	ldw	x,(OFST-2,sp)
 907  0199 1c0001        	addw	x,#1
 908  019c 1f01          	ldw	(OFST-2,sp),x
 909                     ; 221 	valeur = valeur_BCD; 
 911  019e 7b04          	ld	a,(OFST+1,sp)
 912  01a0 6b03          	ld	(OFST+0,sp),a
 913                     ; 222 	valeur = valeur & GPIO_PIN_LNIB; // conserve quartet faible
 915  01a2 7b03          	ld	a,(OFST+0,sp)
 916  01a4 a40f          	and	a,#15
 917  01a6 6b03          	ld	(OFST+0,sp),a
 918                     ; 223 	valeur += CODE_ASCII_0; // conversion ASCII
 920  01a8 7b03          	ld	a,(OFST+0,sp)
 921  01aa ab30          	add	a,#48
 922  01ac 6b03          	ld	(OFST+0,sp),a
 923                     ; 224 	*pointeur = valeur; // mise en mémoire
 925  01ae 7b03          	ld	a,(OFST+0,sp)
 926  01b0 1e01          	ldw	x,(OFST-2,sp)
 927  01b2 f7            	ld	(x),a
 928                     ; 226 }
 931  01b3 5b04          	addw	sp,#4
 932  01b5 81            	ret
 995                     ; 230 void conv_Bin_ASCII(u8 valeur_binaire, u8 *adresse)
 995                     ; 231 {
 996                     	switch	.text
 997  01b6               _conv_Bin_ASCII:
 999  01b6 88            	push	a
1000  01b7 5203          	subw	sp,#3
1001       00000003      OFST:	set	3
1004                     ; 232 	u8 *pointeur = adresse;
1006  01b9 1e07          	ldw	x,(OFST+4,sp)
1007  01bb 1f01          	ldw	(OFST-2,sp),x
1008                     ; 234 	valeur = valeur_binaire; 
1010  01bd 6b03          	ld	(OFST+0,sp),a
1011                     ; 235 	valeur = valeur & GPIO_PIN_HNIB; // conserve quartet fort
1013  01bf 7b03          	ld	a,(OFST+0,sp)
1014  01c1 a4f0          	and	a,#240
1015  01c3 6b03          	ld	(OFST+0,sp),a
1016                     ; 236 	valeur = valeur >> 4; // decalage droite 4 positions
1018  01c5 7b03          	ld	a,(OFST+0,sp)
1019  01c7 4e            	swap	a
1020  01c8 a40f          	and	a,#15
1021  01ca 6b03          	ld	(OFST+0,sp),a
1022                     ; 237 	if (valeur > 9)
1024  01cc 7b03          	ld	a,(OFST+0,sp)
1025  01ce a10a          	cp	a,#10
1026  01d0 2506          	jrult	L563
1027                     ; 239 		valeur += 7; // pour affichage de lettres
1029  01d2 7b03          	ld	a,(OFST+0,sp)
1030  01d4 ab07          	add	a,#7
1031  01d6 6b03          	ld	(OFST+0,sp),a
1032  01d8               L563:
1033                     ; 241 	valeur += CODE_ASCII_0; // conversion ASCII
1035  01d8 7b03          	ld	a,(OFST+0,sp)
1036  01da ab30          	add	a,#48
1037  01dc 6b03          	ld	(OFST+0,sp),a
1038                     ; 242 	*pointeur = valeur; // mise en mémoire
1040  01de 7b03          	ld	a,(OFST+0,sp)
1041  01e0 1e01          	ldw	x,(OFST-2,sp)
1042  01e2 f7            	ld	(x),a
1043                     ; 243 	pointeur ++;
1045  01e3 1e01          	ldw	x,(OFST-2,sp)
1046  01e5 1c0001        	addw	x,#1
1047  01e8 1f01          	ldw	(OFST-2,sp),x
1048                     ; 245 	valeur = valeur_binaire; 
1050  01ea 7b04          	ld	a,(OFST+1,sp)
1051  01ec 6b03          	ld	(OFST+0,sp),a
1052                     ; 246 	valeur = valeur & GPIO_PIN_LNIB; // conserve quartet faible
1054  01ee 7b03          	ld	a,(OFST+0,sp)
1055  01f0 a40f          	and	a,#15
1056  01f2 6b03          	ld	(OFST+0,sp),a
1057                     ; 247 	if (valeur > 9)
1059  01f4 7b03          	ld	a,(OFST+0,sp)
1060  01f6 a10a          	cp	a,#10
1061  01f8 2506          	jrult	L763
1062                     ; 249 		valeur += 7; // pour affichage de lettres
1064  01fa 7b03          	ld	a,(OFST+0,sp)
1065  01fc ab07          	add	a,#7
1066  01fe 6b03          	ld	(OFST+0,sp),a
1067  0200               L763:
1068                     ; 251 	valeur += CODE_ASCII_0; // conversion ASCII
1070  0200 7b03          	ld	a,(OFST+0,sp)
1071  0202 ab30          	add	a,#48
1072  0204 6b03          	ld	(OFST+0,sp),a
1073                     ; 252 	*pointeur = valeur; // mise en mémoire
1075  0206 7b03          	ld	a,(OFST+0,sp)
1076  0208 1e01          	ldw	x,(OFST-2,sp)
1077  020a f7            	ld	(x),a
1078                     ; 253 }
1081  020b 5b04          	addw	sp,#4
1082  020d 81            	ret
1145                     ; 257 void conv1_BCD_ASCII(u16 valeur_BCD, u8 *adresse)
1145                     ; 258 {
1146                     	switch	.text
1147  020e               _conv1_BCD_ASCII:
1149  020e 89            	pushw	x
1150  020f 5204          	subw	sp,#4
1151       00000004      OFST:	set	4
1154                     ; 263 u8 *pointeur = adresse;
1156  0211 1e09          	ldw	x,(OFST+5,sp)
1157  0213 1f01          	ldw	(OFST-3,sp),x
1158                     ; 265 valeur = valeur_BCD;
1160  0215 1e05          	ldw	x,(OFST+1,sp)
1161  0217 1f03          	ldw	(OFST-1,sp),x
1162                     ; 266 valeur = valeur & 0x0F00;
1164  0219 0f04          	clr	(OFST+0,sp)
1165  021b 7b03          	ld	a,(OFST-1,sp)
1166  021d a40f          	and	a,#15
1167  021f 6b03          	ld	(OFST-1,sp),a
1168                     ; 267 valeur = valeur >> 8; // decalage pour traitement des 4 bits des centaines
1170  0221 7b03          	ld	a,(OFST-1,sp)
1171  0223 6b04          	ld	(OFST+0,sp),a
1172  0225 0f03          	clr	(OFST-1,sp)
1173                     ; 268 	valeur += CODE_ASCII_0; // conversion ASCII
1175  0227 1e03          	ldw	x,(OFST-1,sp)
1176  0229 1c0030        	addw	x,#48
1177  022c 1f03          	ldw	(OFST-1,sp),x
1178                     ; 269 	*pointeur = valeur; // mise en mémoire
1180  022e 7b04          	ld	a,(OFST+0,sp)
1181  0230 1e01          	ldw	x,(OFST-3,sp)
1182  0232 f7            	ld	(x),a
1183                     ; 270 	pointeur ++;
1185  0233 1e01          	ldw	x,(OFST-3,sp)
1186  0235 1c0001        	addw	x,#1
1187  0238 1f01          	ldw	(OFST-3,sp),x
1188                     ; 272 valeur = valeur_BCD; 
1190  023a 1e05          	ldw	x,(OFST+1,sp)
1191  023c 1f03          	ldw	(OFST-1,sp),x
1192                     ; 273 valeur = valeur & GPIO_PIN_HNIB; // conserve quartet fort
1194  023e 7b04          	ld	a,(OFST+0,sp)
1195  0240 a4f0          	and	a,#240
1196  0242 6b04          	ld	(OFST+0,sp),a
1197  0244 0f03          	clr	(OFST-1,sp)
1198                     ; 274 valeur = valeur >> 4; // decalage droite 4 positions
1200  0246 a604          	ld	a,#4
1201  0248               L43:
1202  0248 0403          	srl	(OFST-1,sp)
1203  024a 0604          	rrc	(OFST+0,sp)
1204  024c 4a            	dec	a
1205  024d 26f9          	jrne	L43
1206                     ; 276 	valeur += CODE_ASCII_0; // conversion ASCII
1208  024f 1e03          	ldw	x,(OFST-1,sp)
1209  0251 1c0030        	addw	x,#48
1210  0254 1f03          	ldw	(OFST-1,sp),x
1211                     ; 277 	*pointeur = valeur; // mise en mémoire
1213  0256 7b04          	ld	a,(OFST+0,sp)
1214  0258 1e01          	ldw	x,(OFST-3,sp)
1215  025a f7            	ld	(x),a
1216                     ; 278 	pointeur ++;
1218  025b 1e01          	ldw	x,(OFST-3,sp)
1219  025d 1c0001        	addw	x,#1
1220  0260 1f01          	ldw	(OFST-3,sp),x
1221                     ; 280 valeur = valeur_BCD; 
1223  0262 1e05          	ldw	x,(OFST+1,sp)
1224  0264 1f03          	ldw	(OFST-1,sp),x
1225                     ; 281 valeur = valeur & GPIO_PIN_LNIB; // conserve quartet faible
1227  0266 7b04          	ld	a,(OFST+0,sp)
1228  0268 a40f          	and	a,#15
1229  026a 6b04          	ld	(OFST+0,sp),a
1230  026c 0f03          	clr	(OFST-1,sp)
1231                     ; 283 	valeur += CODE_ASCII_0; // conversion ASCII
1233  026e 1e03          	ldw	x,(OFST-1,sp)
1234  0270 1c0030        	addw	x,#48
1235  0273 1f03          	ldw	(OFST-1,sp),x
1236                     ; 284 	*pointeur = valeur; // mise en mémoire
1238  0275 7b04          	ld	a,(OFST+0,sp)
1239  0277 1e01          	ldw	x,(OFST-3,sp)
1240  0279 f7            	ld	(x),a
1241                     ; 285 }
1244  027a 5b06          	addw	sp,#6
1245  027c 81            	ret
1297                     ; 287 u16 Ajustement_BCD(u16 valeur, u16 valeur_pre)
1297                     ; 288  {
1298                     	switch	.text
1299  027d               _Ajustement_BCD:
1301  027d 89            	pushw	x
1302  027e 5204          	subw	sp,#4
1303       00000004      OFST:	set	4
1306                     ; 289 	 short val = valeur;
1308  0280 1f03          	ldw	(OFST-1,sp),x
1309                     ; 290 	 if (((valeur & 0x000F )> 9) || ((valeur & 0x000F )<(valeur_pre & 0x000F ) ))
1311  0282 01            	rrwa	x,a
1312  0283 a40f          	and	a,#15
1313  0285 5f            	clrw	x
1314  0286 02            	rlwa	x,a
1315  0287 a3000a        	cpw	x,#10
1316  028a 2419          	jruge	L354
1318  028c 7b09          	ld	a,(OFST+5,sp)
1319  028e 97            	ld	xl,a
1320  028f 7b0a          	ld	a,(OFST+6,sp)
1321  0291 a40f          	and	a,#15
1322  0293 5f            	clrw	x
1323  0294 02            	rlwa	x,a
1324  0295 1f01          	ldw	(OFST-3,sp),x
1325  0297 01            	rrwa	x,a
1326  0298 7b05          	ld	a,(OFST+1,sp)
1327  029a 97            	ld	xl,a
1328  029b 7b06          	ld	a,(OFST+2,sp)
1329  029d a40f          	and	a,#15
1330  029f 5f            	clrw	x
1331  02a0 02            	rlwa	x,a
1332  02a1 1301          	cpw	x,(OFST-3,sp)
1333  02a3 2407          	jruge	L154
1334  02a5               L354:
1335                     ; 292 	  valeur = valeur + 6;
1337  02a5 1e05          	ldw	x,(OFST+1,sp)
1338  02a7 1c0006        	addw	x,#6
1339  02aa 1f05          	ldw	(OFST+1,sp),x
1340  02ac               L154:
1341                     ; 294 	 if ((valeur & 0x00F0) > 0x90)
1343  02ac 7b05          	ld	a,(OFST+1,sp)
1344  02ae 97            	ld	xl,a
1345  02af 7b06          	ld	a,(OFST+2,sp)
1346  02b1 a4f0          	and	a,#240
1347  02b3 5f            	clrw	x
1348  02b4 02            	rlwa	x,a
1349  02b5 a30091        	cpw	x,#145
1350  02b8 2507          	jrult	L554
1351                     ; 296 	  valeur = valeur + 0x60;
1353  02ba 1e05          	ldw	x,(OFST+1,sp)
1354  02bc 1c0060        	addw	x,#96
1355  02bf 1f05          	ldw	(OFST+1,sp),x
1356  02c1               L554:
1357                     ; 298 	return (valeur);
1359  02c1 1e05          	ldw	x,(OFST+1,sp)
1362  02c3 5b06          	addw	sp,#6
1363  02c5 81            	ret
1462                     ; 301 u16 Bin_BCD(u8 valeur)
1462                     ; 302  {
1463                     	switch	.text
1464  02c6               _Bin_BCD:
1466  02c6 88            	push	a
1467  02c7 520b          	subw	sp,#11
1468       0000000b      OFST:	set	11
1471                     ; 303 	 short reference_BCD = 1;
1473  02c9 ae0001        	ldw	x,#1
1474  02cc 1f0a          	ldw	(OFST-1,sp),x
1475                     ; 304 	 short reference_BCD_precedent = 0;
1477  02ce 5f            	clrw	x
1478  02cf 1f02          	ldw	(OFST-9,sp),x
1479                     ; 305 	 short resultat = 0;
1481  02d1 5f            	clrw	x
1482  02d2 1f07          	ldw	(OFST-4,sp),x
1483                     ; 306 	 short resultat_precedent = 0;
1485  02d4 5f            	clrw	x
1486  02d5 1f05          	ldw	(OFST-6,sp),x
1487                     ; 307 	 char masque_bit = 1;
1489  02d7 a601          	ld	a,#1
1490  02d9 6b09          	ld	(OFST-2,sp),a
1491                     ; 311 	 val=valeur;
1493                     ; 313 	 for ( numero_bit = 0; numero_bit < 8; numero_bit++)
1495  02db 0f04          	clr	(OFST-7,sp)
1496  02dd               L135:
1497                     ; 315 		 if ( (valeur & masque_bit) == masque_bit )
1499  02dd 7b0c          	ld	a,(OFST+1,sp)
1500  02df 1409          	and	a,(OFST-2,sp)
1501  02e1 1109          	cp	a,(OFST-2,sp)
1502  02e3 2616          	jrne	L735
1503                     ; 317 		 resultat = resultat_precedent + reference_BCD;
1505  02e5 1e05          	ldw	x,(OFST-6,sp)
1506  02e7 72fb0a        	addw	x,(OFST-1,sp)
1507  02ea 1f07          	ldw	(OFST-4,sp),x
1508                     ; 318 		 resultat = Ajustement_BCD(resultat,resultat_precedent);
1510  02ec 1e05          	ldw	x,(OFST-6,sp)
1511  02ee 89            	pushw	x
1512  02ef 1e09          	ldw	x,(OFST-2,sp)
1513  02f1 ad8a          	call	_Ajustement_BCD
1515  02f3 5b02          	addw	sp,#2
1516  02f5 1f07          	ldw	(OFST-4,sp),x
1517                     ; 319 		 resultat_precedent = resultat;
1519  02f7 1e07          	ldw	x,(OFST-4,sp)
1520  02f9 1f05          	ldw	(OFST-6,sp),x
1521  02fb               L735:
1522                     ; 321 	 reference_BCD = reference_BCD + reference_BCD;
1524  02fb 080b          	sll	(OFST+0,sp)
1525  02fd 090a          	rlc	(OFST-1,sp)
1526                     ; 322 	 reference_BCD = Ajustement_BCD(reference_BCD,reference_BCD_precedent);
1528  02ff 1e02          	ldw	x,(OFST-9,sp)
1529  0301 89            	pushw	x
1530  0302 1e0c          	ldw	x,(OFST+1,sp)
1531  0304 cd027d        	call	_Ajustement_BCD
1533  0307 5b02          	addw	sp,#2
1534  0309 1f0a          	ldw	(OFST-1,sp),x
1535                     ; 323 	 reference_BCD_precedent = reference_BCD;
1537  030b 1e0a          	ldw	x,(OFST-1,sp)
1538  030d 1f02          	ldw	(OFST-9,sp),x
1539                     ; 324 	 masque_bit = masque_bit + masque_bit;  // decalage gauche 
1541  030f 0809          	sll	(OFST-2,sp)
1542                     ; 313 	 for ( numero_bit = 0; numero_bit < 8; numero_bit++)
1544  0311 0c04          	inc	(OFST-7,sp)
1547  0313 7b04          	ld	a,(OFST-7,sp)
1548  0315 a108          	cp	a,#8
1549  0317 25c4          	jrult	L135
1550                     ; 326 	 return (resultat);
1552  0319 1e07          	ldw	x,(OFST-4,sp)
1555  031b 5b0c          	addw	sp,#12
1556  031d 81            	ret
1599                     ; 330 u16 lire_valeur_ADC1(void)
1599                     ; 331 {
1600                     	switch	.text
1601  031e               _lire_valeur_ADC1:
1603  031e 5205          	subw	sp,#5
1604       00000005      OFST:	set	5
1607                     ; 335 	ADC1-> CR1 |= ADC1_CR1_ADON;  // debut conversion
1609  0320 72105401      	bset	21505,#0
1610  0324               L365:
1611                     ; 338 	   templ = ADC1-> CSR; // lecture registre d'etat
1613  0324 c65400        	ld	a,21504
1614  0327 6b05          	ld	(OFST+0,sp),a
1615                     ; 340 	while ( ( templ & ADC1_CSR_EOC) !=  ADC1_CSR_EOC  ); // attente fin de conversion
1617  0329 7b05          	ld	a,(OFST+0,sp)
1618  032b a480          	and	a,#128
1619  032d a180          	cp	a,#128
1620  032f 26f3          	jrne	L365
1621                     ; 341 	templ = ADC1-> DRL; // lecture 8 bits faibles (en 1er d'après RM0016 chap.24.8)
1623  0331 c65405        	ld	a,21509
1624  0334 6b05          	ld	(OFST+0,sp),a
1625                     ; 342 	temph = ADC1-> DRH; // lecture 2 bits forts
1627  0336 c65404        	ld	a,21508
1628  0339 5f            	clrw	x
1629  033a 97            	ld	xl,a
1630  033b 1f03          	ldw	(OFST-2,sp),x
1631                     ; 343 	temph = ((u16) templ | (u16) (temph << (u8)8));
1633  033d 1e03          	ldw	x,(OFST-2,sp)
1634  033f 4f            	clr	a
1635  0340 02            	rlwa	x,a
1636  0341 1f01          	ldw	(OFST-4,sp),x
1637  0343 7b05          	ld	a,(OFST+0,sp)
1638  0345 5f            	clrw	x
1639  0346 97            	ld	xl,a
1640  0347 01            	rrwa	x,a
1641  0348 1a02          	or	a,(OFST-3,sp)
1642  034a 01            	rrwa	x,a
1643  034b 1a01          	or	a,(OFST-4,sp)
1644  034d 01            	rrwa	x,a
1645                     ; 345 	ADC1->CSR &= (~ ADC1_CSR_EOC ); // mise à 0 de EOC
1647  034e 721f5400      	bres	21504,#7
1648                     ; 346 }
1651  0352 5b05          	addw	sp,#5
1652  0354 81            	ret
1686                     ; 351 void init_ADC1(u8 canal)
1686                     ; 352 {
1687                     	switch	.text
1688  0355               _init_ADC1:
1692                     ; 353 	ADC1-> CSR = canal;  // configuration du canal
1694  0355 c75400        	ld	21504,a
1695                     ; 354 	ADC1-> CR2 = ADC1_CR2_ALIGN ;  // alignement à droite
1697  0358 35085402      	mov	21506,#8
1698                     ; 356 	ADC1-> CR1 |= ADC1_CR1_ADON;
1700  035c 72105401      	bset	21505,#0
1701                     ; 357 }
1704  0360 81            	ret
1749                     ; 363 u8 determiner_Correspondance_Valeur_ADC1(u16 valeur)
1749                     ; 364 {
1750                     	switch	.text
1751  0361               _determiner_Correspondance_Valeur_ADC1:
1753  0361 88            	push	a
1754       00000001      OFST:	set	1
1757                     ; 366 	 niveau = ((valeur / 57) +1) /2; // traitement pour 10 niveaux
1759  0362 90ae0039      	ldw	y,#57
1760  0366 65            	divw	x,y
1761  0367 5c            	incw	x
1762  0368 54            	srlw	x
1763  0369 01            	rrwa	x,a
1764  036a 6b01          	ld	(OFST+0,sp),a
1765  036c 02            	rlwa	x,a
1766                     ; 367 	 return niveau;
1768  036d 7b01          	ld	a,(OFST+0,sp)
1771  036f 5b01          	addw	sp,#1
1772  0371 81            	ret
1795                     ; 374 void init_UART2(void)
1795                     ; 375  {
1796                     	switch	.text
1797  0372               _init_UART2:
1801                     ; 376 	UART2->BRR2 = 0x0;
1803  0372 725f5243      	clr	21059
1804                     ; 377 	UART2->BRR1 = 0x0D;
1806  0376 350d5242      	mov	21058,#13
1807                     ; 379 	UART2->CR2 = UART2->CR2 | UART2_CR2_TEN;// activation emetteur 
1809  037a 72165245      	bset	21061,#3
1810                     ; 380 	UART2->CR2 = UART2->CR2 | UART2_CR2_REN;// activation recepteur
1812  037e 72145245      	bset	21061,#2
1813                     ; 382  }
1816  0382 81            	ret
1829                     	xdef	_determiner_Correspondance_Valeur_ADC1
1830                     	xdef	_init_ADC1
1831                     	xdef	_lire_valeur_ADC1
1832                     	xdef	_init_Timer3_PWM_canal2
1833                     	xdef	_Bin_BCD
1834                     	xdef	_Ajustement_BCD
1835                     	xdef	_conv_Bin_ASCII
1836                     	xdef	_conv1_BCD_ASCII
1837                     	xdef	_conv_BCD_ASCII
1838                     	xdef	_afficher_Modules_HDLX
1839                     	xdef	_afficher_Module_HDLX2
1840                     	xdef	_afficher_Module_HDLX1
1841                     	xdef	_afficher_Digit_HDLX2
1842                     	xdef	_afficher_Digit_HDLX1
1843                     	xdef	_afficher_TIL321
1844                     	xdef	_init_UART2
1845                     	xdef	_lire_Etat_BP2
1846                     	xdef	_init_Ports
1865                     	end
