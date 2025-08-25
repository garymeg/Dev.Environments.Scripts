.encoding "ascii" 
 
.const OSASCI = $ffe3

* = $1900

Start:
        ldx #$00
    Loop:
            lda Hello,x
            beq Done
            jsr OSASCI     // print using CHAROUT equivelant
            inx
            jmp Loop
Done:            
        rts

Hello:
    .text "hello world"     // Text to print
    .byte $0d, $00          // End of text 