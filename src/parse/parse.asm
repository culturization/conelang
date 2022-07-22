section .rodata
%include 'src/parse/dispatch.asm'

section .text
%include 'src/parse/token_lookup.asm'
%include 'src/parse/function_lookup.asm'

; IN: code, stack
; OUT: nothing
parse:
  ; prepare registers
  mov rbx,  code
  mov r9,  stack
  cld ; clear direction flag

.loop:
  call  token_lookup

  call  function_lookup

  ; call the found function
  call  r13

  jmp  parse
