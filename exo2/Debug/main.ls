   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  44                     ; 8 main()
  44                     ; 9 {
  46                     	switch	.text
  47  0000               _main:
  51                     ; 10 	intertiming();
  53  0000 cd0000        	call	_intertiming
  55                     ; 11 }
  58  0003 81            	ret
  71                     	xdef	_main
  72                     	xref	_intertiming
  91                     	end
