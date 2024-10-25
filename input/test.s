  .org $8000
  lda #$ff
  sta $6002

  lda #$ff
  sta $6000

  jmp $8005

  .org $fffc
  .word $8000
  .word $0000
