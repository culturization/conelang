struc dispatch_row
  .name_len resb 1
  .name resq 1
  .ptr resq 1
endstruc

%macro GENERATE_DISPATCH 1-*
  %define FUNC_NUM %0/3
  %define DISPATCH_SIZE dispatch_row_size*FUNC_NUM

  %rotate 1

  ; define labels
  %assign i 0
  %rep FUNC_NUM
    func_name_ %+ i db %1

    %assign i i+1
    %rotate 3
  %endrep

  %rotate 2

  ; define dispatch table
  dispatch:

  %assign i 0
  %rep FUNC_NUM
    istruc dispatch_row
      at dispatch_row.name_len, db %1
      at dispatch_row.name, dq func_name_ %+ i
      at dispatch_row.ptr, dq %3
    iend

    %assign i i+1
    %rotate 3
  %endrep

  %undef i
%endmacro

GENERATE_DISPATCH \
10, 'конус', cl_dup,\
14, 'кашолка', cl_pop
