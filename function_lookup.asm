; IN: r11 (token), r12 (token length)
; OUT: r13 (function ptr)
function_lookup:
  ; prepare registers
  mov  r13, dispatch

.loop:
  ; compare the length of the token and the length of the function name
  ; search for the right function next, if they are not equal
  cmp  r12, (r13 + dispatch_row.name_len)
  jne  .next

  ; if they are equal, compare the token itself and the function name
  mov  rcx, r12 ; token length
  mov  rsi, r11 ; token
  lea  rdi, [r13 + dispatch_row.name] ; function name
  repe  cmpsb
  je  .next ; search for the right function next, if they are not equal

  ; return a pointer to the function if they are equal
  add  r13, dispatch_row.ptr
  ret

.next:
  ; rotate table
  add  r13, dispatch_row_size

  ; cause a syntax error if we have reached the table boundary
  cmp  r13, (dispatch + DISPATCH_SIZE)
  je  syntax_err

  ; continue
  jmp  .loop
