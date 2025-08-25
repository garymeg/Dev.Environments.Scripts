BasicUpstart2(Start)
.encoding "petscii_mixed"

.const CHAROUT = $ffd2
Start:
        ldx #$00
    Loop:
            lda Hello,x
            beq Done
            jsr CHAROUT     // print using CHAROUT
            inx
            jmp Loop
Done:            
        rts

Hello:
    .byte $93               // Clear screen
    .text "hello world"     // Text to print
    .byte $0d, $00          // End of text 
