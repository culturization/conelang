; IN: opcode, arg0, arg1, arg2, arg3, arg4, arg5
; OUT: rax (stack)
cl_syscall:
  mov  rax, [r14]
  mov  rdi, [r14-1*8]
  mov  rsi, [r14-2*8]
  mov  rdx, [r14-3*8]
  mov  r10, [r14-4*8]
  mov  r8, [r14-5*8]
  mov  r9, [r14-6*8]
  sub  r14, 7*8
  syscall

  ; push rax to stack
  call  cl_push
  ret

