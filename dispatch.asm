struc dispatch_row
  .name_len resb 1
  .name resq 1
  .ptr resq 1
endstruc

%macro GENERATE_DISPATCH 1-*
  %define DISPATCH_SIZE 17*%0/2

  ; define labels
  %assign %%i %0/2
  %rep %0/2
    %assign %%i %%i-1
    %rotate -2

    word_ptr_ %+ %%i db %1
  %endrep

  [section .rodata]

  ; define dispatch table
  dispatch:
  %rep %0/2
    %strlen %%word_len %1

    istruc dispatch_row
      at dispatch_row.name_len, db %[%%word_len]
      at dispatch_row.name, dq word_ptr_ %+ %%i
      at dispatch_row.ptr, dq %2
    iend

    %assign %%i %%i+1
    %rotate 2
  %endrep

  __?SECT?__
%endmacro

GENERATE_DISPATCH \
'конус', 'cl_dup'
