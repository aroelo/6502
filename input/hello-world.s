PORTB = $6000 ; address of port b
PORTA = $6001 ; address of port a
DDRB = $6002 ; data direction registry portb
DDRA = $6003 ; data direction registry porta

E  = %10000000 ; enable signal
RW = %01000000 ; read/write bit
RS = %00100000 ; register select

  .org $8000

reset:
  ; set all pins on port B to output
  lda #%11111111 ; load in accumulator
  sta DDRB ; store in memory address linked to ddrb

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction

  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction

  lda #"H"       ; Send letter H
  jsr print_char
  lda #"e"       ; Send letter e
  jsr print_char
  lda #"l"       ; Send letter l
  jsr print_char
  lda #"l"       ; Send letter l
  jsr print_char
  lda #"o"       ; Send letter o
  jsr print_char
  lda #","       ; Send letter ,
  jsr print_char
  lda #" "       ; Send letter
  jsr print_char
  lda #"w"       ; Send letter w
  jsr print_char
  lda #"o"       ; Send letter o
  jsr print_char
  lda #"r"       ; Send letter r
  jsr print_char
  lda #"l"       ; Send letter l
  jsr print_char
  lda #"d"       ; Send letter d
  jsr print_char
  lda #"!"       ; Send letter !
  jsr print_char

loop:
  jmp loop

lcd_instruction:
  sta PORTB      ; Store the instruction from lda in portb
  lda #0         ; Clear RS/RW/E bits, necessary to load instruction
  sta PORTA      ; store rs/rw/e bits in porta
  lda #E         ; Set E bit to send instruction
  sta PORTA      ; store e bit in porta
  lda #0         ; Clear RS/RW/E bits, toggling this bit will tell display to accept instruction above
  sta PORTA      ; store rs/rw/e bits in porta
  rts

print_char:
  sta PORTB
  lda #RS        ; Set RS to 1; Clear RW/E bits
  sta PORTA
  lda #(RS | E)  ; Set RS and E bit to send instruction, toggle, set both bits RS and E
  sta PORTA
  lda #RS        ; Set RS
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000
