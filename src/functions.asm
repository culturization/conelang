; IN: r9 (stack), rax (element)
; OUT: r9 (stack)
; Pushes an element into the stack
; All functions defined below will only take arguments from the stack and will only modify the stack itself
cl_push:
  ; call an error if the stack is overflowing
  cmp r9, (stack + STACK_SIZE)
  je stack_overflow_err

  mov [r9], rax
  add r9, 8
  ret

; IN, OUT: nothing
; Removes the last element from the stack
cl_pop:
  ; call an error if the stack is underflowing
  cmp r9, stack
  je stack_overflow_err

  sub r9, 8
  ret

; IN, OUT: nothing
; Duplicates a stack frame
cl_dup:
  mov rax, [r9]
  call cl_push
  ret
