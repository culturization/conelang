; IN, OUT: n
; Increases the value of the last element
cl_inc:
  inc  qword [r14]
  ret

; IN, OUT: n
; Decreases the value of the last element
cl_dec:
  dec  qword [r14]
  ret

; IN, OUT: n1, n2
; Summarises the last two elements from the stack
cl_add:
  call  cl_pop ; pop arg

  ; sum it with the last element
  add  [r14], rax
  ret

; IN, OUT: n1, n2
; Gets the difference of the last two elements
cl_sub:
  call  cl_pop ; pop arg

  ; subtract it from the last element
  sub  [r14], rax
  ret
