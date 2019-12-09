; ESISAR - INPG              B. GLOSSI
; Fichier Alpha.e  a inclure dans le fichier de gestion...
; ... assembleur 68K de l'afficheur alphanumerique

; Table de valeurs de code pour les caracteres ASCII affichables
; date : 7 avril 2003 valeurs pour les codes ASCII de 30 a Z

Lespoints:
        DC.B      $41,$2E,$36,$3A,$41     ; zero    $30
        DC.B      $7F,$07E,$0,$5E,$6F     ; un      $31
        DC.B      $4E,$36,$3A,$3C,$5E     ; deux
        DC.B      $39,$16,$2E,$3E,$3D     ; trois
        DC.B      $7B,$00,$5B,$6B,$73     ; quatre
        DC.B      $31,$36,$36,$36,$05     ; cinq
        DC.B      $79,$36,$36,$56,$61     ; six
        DC.B      $1F,$2F,$37,$38,$3F     ; sept
        DC.B      $49,$36,$36,$36,$49     ; huit
        DC.B      $43,$35,$36,$36,$4F     ; neuf
        DC.B      $7f,$7f,$49,$49,$7f     ; :
        DC.B      $7f,$7f,$49,$4A,$7f     ; ;
        DC.B      $7F,$3E,$5D,$6B,$77     ; <
        DC.B      $6B,$6B,$6B,$6B,$6B     ; =
        DC.B      $77,$6B,$5D,$3E,$7F     ; >
        DC.B      $4F,$37,$32,$3F,$4F     ; ?
        DC.B      $42,$22,$2A,$32,$41     ; @   code ASCII 40
        DC.B      $40,$37,$37,$37,$40     ; A
        DC.B      $49,$36,$36,$36,$00     ; B
        DC.B      $5D,$3E,$3E,$3E,$41     ; C
        DC.B      $63,$5D,$3E,$3E,$00     ; D
        DC.B      $3E,$36,$36,$36,$00     ; E
        DC.B      $3F,$37,$37,$37,$00     ; F  code 46
        DC.B      $51,$36,$36,$3E,$41     ; G
        DC.B      $00,$77,$77,$77,$00     ; H
        DC.B      $7F,$3E,$00,$3E,$7F     ; I
        DC.B      $3F,$01,$3E,$7E,$7D     ; J
        DC.B      $3E,$5D,$6B,$77,$00     ; K
        DC.B      $7E,$7E,$7E,$7E,$00     ; L
        DC.B      $00,$5F,$67,$5F,$00     ; M
        DC.B      $00,$7b,$77,$6F,$00     ; N
        DC.B      $41,$3E,$3E,$3E,$41     ; O
        DC.B      $4F,$37,$37,$37,$00     ; P  code  50
        DC.B      $42,$3D,$3A,$3E,$41     ; Q
        DC.B      $4E,$35,$33,$37,$00     ; R
        DC.B      $39,$36,$36,$36,$4E     ; S
        DC.B      $3F,$3F,$00,$3F,$3F     ; T
        DC.B      $01,$7E,$7E,$7E,$01     ; U
        DC.B      $03,$7D,$7E,$7D,$03     ; V
        DC.B      $01,$7E,$71,$7E,$01     ; W
        DC.B      $1C,$6B,$77,$6B,$1C     ; X
        DC.B      $0F,$77,$78,$77,$0F     ; Y
        DC.B      $1E,$2E,$36,$3A,$3C     ; Z  code 5A  
        DC.B      $7F,$7F,$3E,$3E,$00     ; [
        DC.B      $3F,$55,$60,$55,$3F     ; Yen code 5C
        DC.B      $00,$3E,$3E,$7F,$7F     ; ]   code 5D
        DC.B      $6F,$5F,$3F,$5F,$6F     ; ^   code 5E 
        DC.B      $7E,$7E,$7E,$7E,$7E     ; _   code 5F
        DC.B      $7F,$7F,$7F,$7F,$7F     ;     code 60
