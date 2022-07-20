%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 0x3c

%define STDIN 0
%define STDOUT 1
%define STDERR 2

%define MAX_FILE_SIZE 8096
%define STACK_SIZE 1024

%macro EXIT 1
  mov  rdi, %1 ; exit code
  mov  rax, SYS_EXIT
  syscall
%endmacro

%macro SWRITE 2
  [section .rodata]
  
  %%str db %1
  %%end_str:
    __?SECT?__
    
    mov  rdi, %2 ; fd
    mov  rsi, %%str ; buf
    mov  rdx, %%end_str - %%str ; count
    mov  rax, SYS_WRITE
    syscall
%endmacro

%macro ERROR 1
  %strcat %%msg 'error: ' %1 `\n`
  SWRITE %%msg, 1
  EXIT 1
%endmacro
