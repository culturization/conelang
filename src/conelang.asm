%include 'src/macros.asm'

section .bss
code resb MAX_FILE_SIZE + 1
stack resb STACK_SIZE

section .text
%include 'src/errors.asm'

%include 'src/functions/functions.asm'
%include 'src/parse/parse.asm'

global _start
_start:
  ; check how many arguments have been passed
  ; if there are no arguments, call an error
  pop  rax
  cmp  rax, 2
  jl  no_args_err

  ; ignore executable filename
  add  rsp, 8

  ; open file
  pop  rdi ; filename
  xor  rsi, rsi ; flags
  xor  rdx, rdx ; mode
  mov  rax, SYS_OPEN ; opcode
  syscall

  ; check for errors
  test  rax, rax
  js  open_err

  ; read file
  mov  rdi, rax ; fd
  mov  rsi, code ; buf
  mov  rdx, MAX_FILE_SIZE ; count
  mov  rax, SYS_READ
  syscall

  ; close file
  mov  rax, SYS_CLOSE
  syscall

  ; parse file
  jmp  parse

; IN, OUT: nothing
exit:
  EXIT 0
