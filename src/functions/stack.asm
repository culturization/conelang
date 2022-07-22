; IN: rax
; OUT: nothing
; Pushes an element into the stack
cl_push:
  ; call an error if the stack is overflowing
  cmp  r14, (stack + STACK_SIZE)
  je  stack_overflow_err
 
  mov  [r14], rax
  add  r14, 8
  ret

; IN: nothing
; OUT: rax
; Pops an element from stack
cl_pop:
  ; call an error if the stack is underflowing
  cmp  r14, stack
  je   stack_overflow_err

  mov  rax, [r14]
  sub  r14, 8
  ret

; IN: n
; OUT: nothing
; Removes an n-th element from the stack
cl_drop:
  ; get argument from stack
  mov  rax, [r14]

  ; call an error if the stack is underflowing
  cmp  r14, (stack - 8)
  jle  stack_overflow_err

  ; cause an error if we try to go beyond the stack
  cmp  rax, (STACK_SIZE/8)
  jge  stack_overflow_err

  mov  rdx, 8
  mul  rdx

  mov  rcx, rax ; count
  lea  rsi, [r14 - 8]; source
  lea  rdi, [r14 - 2*8] ; dest
  rep  movsb

  ; move the stack
  sub  r14, 2*8
  ret

; IN: n
; OUT: nothing
; Picks the nth element from the stack
; Works the same way as the pick from the Forth
cl_pick:
  call  cl_pop

  ; cause an error if we try to go beyond the stack
  cmp  rax, (STACK_SIZE/8)
  jge  stack_overflow_err

  ; pick item from the stack
  mov  rdx, 8
  mul  rdx
  
  mov  rdx, r14
  sub  rdx, rax
  mov  rax, rdx
  call  cl_push
  ret
