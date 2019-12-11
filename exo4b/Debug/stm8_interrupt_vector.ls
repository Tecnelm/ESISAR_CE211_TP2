   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  45                     ; 12 @far @interrupt void NonHandledInterrupt (void)
  45                     ; 13 {
  46                     	switch	.text
  47  0000               f_NonHandledInterrupt:
  51                     ; 15 	return;
  54  0000 80            	iret
  77                     ; 17 @far @interrupt void myHandlerTIM3 (void)
  77                     ; 18 {
  78                     	switch	.text
  79  0001               f_myHandlerTIM3:
  81  0001 8a            	push	cc
  82  0002 84            	pop	a
  83  0003 a4bf          	and	a,#191
  84  0005 88            	push	a
  85  0006 86            	pop	cc
  86  0007 3b0002        	push	c_x+2
  87  000a be00          	ldw	x,c_x
  88  000c 89            	pushw	x
  89  000d 3b0002        	push	c_y+2
  90  0010 be00          	ldw	x,c_y
  91  0012 89            	pushw	x
  94                     ; 19 	incrementCounter();
  96  0013 cd0000        	call	_incrementCounter
  98                     ; 20 	return;
 101  0016 85            	popw	x
 102  0017 bf00          	ldw	c_y,x
 103  0019 320002        	pop	c_y+2
 104  001c 85            	popw	x
 105  001d bf00          	ldw	c_x,x
 106  001f 320002        	pop	c_x+2
 107  0022 80            	iret
 109                     .const:	section	.text
 110  0000               __vectab:
 111  0000 82            	dc.b	130
 113  0001 00            	dc.b	page(__stext)
 114  0002 0000          	dc.w	__stext
 115  0004 82            	dc.b	130
 117  0005 00            	dc.b	page(f_NonHandledInterrupt)
 118  0006 0000          	dc.w	f_NonHandledInterrupt
 119  0008 82            	dc.b	130
 121  0009 00            	dc.b	page(f_NonHandledInterrupt)
 122  000a 0000          	dc.w	f_NonHandledInterrupt
 123  000c 82            	dc.b	130
 125  000d 00            	dc.b	page(f_NonHandledInterrupt)
 126  000e 0000          	dc.w	f_NonHandledInterrupt
 127  0010 82            	dc.b	130
 129  0011 00            	dc.b	page(f_NonHandledInterrupt)
 130  0012 0000          	dc.w	f_NonHandledInterrupt
 131  0014 82            	dc.b	130
 133  0015 00            	dc.b	page(f_NonHandledInterrupt)
 134  0016 0000          	dc.w	f_NonHandledInterrupt
 135  0018 82            	dc.b	130
 137  0019 00            	dc.b	page(f_NonHandledInterrupt)
 138  001a 0000          	dc.w	f_NonHandledInterrupt
 139  001c 82            	dc.b	130
 141  001d 00            	dc.b	page(f_NonHandledInterrupt)
 142  001e 0000          	dc.w	f_NonHandledInterrupt
 143  0020 82            	dc.b	130
 145  0021 00            	dc.b	page(f_NonHandledInterrupt)
 146  0022 0000          	dc.w	f_NonHandledInterrupt
 147  0024 82            	dc.b	130
 149  0025 00            	dc.b	page(f_NonHandledInterrupt)
 150  0026 0000          	dc.w	f_NonHandledInterrupt
 151  0028 82            	dc.b	130
 153  0029 00            	dc.b	page(f_NonHandledInterrupt)
 154  002a 0000          	dc.w	f_NonHandledInterrupt
 155  002c 82            	dc.b	130
 157  002d 00            	dc.b	page(f_NonHandledInterrupt)
 158  002e 0000          	dc.w	f_NonHandledInterrupt
 159  0030 82            	dc.b	130
 161  0031 00            	dc.b	page(f_NonHandledInterrupt)
 162  0032 0000          	dc.w	f_NonHandledInterrupt
 163  0034 82            	dc.b	130
 165  0035 00            	dc.b	page(f_NonHandledInterrupt)
 166  0036 0000          	dc.w	f_NonHandledInterrupt
 167  0038 82            	dc.b	130
 169  0039 00            	dc.b	page(f_NonHandledInterrupt)
 170  003a 0000          	dc.w	f_NonHandledInterrupt
 171  003c 82            	dc.b	130
 173  003d 00            	dc.b	page(f_NonHandledInterrupt)
 174  003e 0000          	dc.w	f_NonHandledInterrupt
 175  0040 82            	dc.b	130
 177  0041 00            	dc.b	page(f_NonHandledInterrupt)
 178  0042 0000          	dc.w	f_NonHandledInterrupt
 179  0044 82            	dc.b	130
 181  0045 01            	dc.b	page(f_myHandlerTIM3)
 182  0046 0001          	dc.w	f_myHandlerTIM3
 183  0048 82            	dc.b	130
 185  0049 00            	dc.b	page(f_NonHandledInterrupt)
 186  004a 0000          	dc.w	f_NonHandledInterrupt
 187  004c 82            	dc.b	130
 189  004d 00            	dc.b	page(f_NonHandledInterrupt)
 190  004e 0000          	dc.w	f_NonHandledInterrupt
 191  0050 82            	dc.b	130
 193  0051 00            	dc.b	page(f_NonHandledInterrupt)
 194  0052 0000          	dc.w	f_NonHandledInterrupt
 195  0054 82            	dc.b	130
 197  0055 00            	dc.b	page(f_NonHandledInterrupt)
 198  0056 0000          	dc.w	f_NonHandledInterrupt
 199  0058 82            	dc.b	130
 201  0059 00            	dc.b	page(f_NonHandledInterrupt)
 202  005a 0000          	dc.w	f_NonHandledInterrupt
 203  005c 82            	dc.b	130
 205  005d 00            	dc.b	page(f_NonHandledInterrupt)
 206  005e 0000          	dc.w	f_NonHandledInterrupt
 207  0060 82            	dc.b	130
 209  0061 00            	dc.b	page(f_NonHandledInterrupt)
 210  0062 0000          	dc.w	f_NonHandledInterrupt
 211  0064 82            	dc.b	130
 213  0065 00            	dc.b	page(f_NonHandledInterrupt)
 214  0066 0000          	dc.w	f_NonHandledInterrupt
 215  0068 82            	dc.b	130
 217  0069 00            	dc.b	page(f_NonHandledInterrupt)
 218  006a 0000          	dc.w	f_NonHandledInterrupt
 219  006c 82            	dc.b	130
 221  006d 00            	dc.b	page(f_NonHandledInterrupt)
 222  006e 0000          	dc.w	f_NonHandledInterrupt
 223  0070 82            	dc.b	130
 225  0071 00            	dc.b	page(f_NonHandledInterrupt)
 226  0072 0000          	dc.w	f_NonHandledInterrupt
 227  0074 82            	dc.b	130
 229  0075 00            	dc.b	page(f_NonHandledInterrupt)
 230  0076 0000          	dc.w	f_NonHandledInterrupt
 231  0078 82            	dc.b	130
 233  0079 00            	dc.b	page(f_NonHandledInterrupt)
 234  007a 0000          	dc.w	f_NonHandledInterrupt
 235  007c 82            	dc.b	130
 237  007d 00            	dc.b	page(f_NonHandledInterrupt)
 238  007e 0000          	dc.w	f_NonHandledInterrupt
 289                     	xdef	__vectab
 290                     	xref	__stext
 291                     	xdef	f_myHandlerTIM3
 292                     	xdef	f_NonHandledInterrupt
 293                     	xref	_incrementCounter
 294                     	xref.b	c_x
 295                     	xref.b	c_y
 314                     	end
