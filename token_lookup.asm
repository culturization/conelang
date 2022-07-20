; IN: rbx (code)
; OUT: r11 (token), r12 (token length)
token_lookup:
  ; prepare registers
  xor  r12, r12 ; reset r12 to zero 

  ; we must first find a pointer to the start of the token
.find_token_ptr:
  mov  al, [rbx] ; char

  ; exit on eof
  cmp  al, 0
  je  eof

  ; ignore spaces and line feeds
  cmp  al, ' '
  je  .ignore_char

  cmp  al, `\n`
  je  .ignore_char

  ; if the character is not a null byte, space or line feed, it is probably the start of a token
  mov  r11, rbx ; save token

  ; all we have to do now is count its length
.count_len:
  inc  rbx ; skip to the next char
  inc  r12

  ; looking for the end of a token
  cmp  al, 0
  je  .end

  cmp  al, ' '
  je  .end

  cmp  al, `\n`
  je  .end

  jmp  .count_len

  ; work done, return the values obtained
.end:
  ret

.ignore_char:
  inc  rbx
  jmp  read_token
