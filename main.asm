; AdrielFreud

section .data
   first DB 0x0a, "Digite um número: "
   len_f equ $-first

   second DB "Digite o segundo número: "
   len_s equ $-second

   result DB "Resultado: "
   len_r equ $-result

   msg_exit DB " ", 0xa
   len_exit equ $-msg_exit

section .bss
   primeiro RESB 5
   resultado RESB 5
   segundo RESB 5

section .text
   global _start

sair:
   mov eax, 4
   mov ebx, 1
   mov edx, msg_exit
   mov ecx, len_exit
   int 80h

   mov eax, 1
   int 80h

_start:
   mov edx, len_f
   mov ecx, first
   mov eax, 4
   mov ebx, 1
   int 80h

   mov eax, 3
   mov ebx, 2
   mov edx, 2
   mov ecx, primeiro
   int 80h

   mov edx, len_s
   mov ecx, second
   mov eax, 4
   mov ebx, 1
   int 80h

   mov eax, 3
   mov ebx, 2
   mov edx, 2
   mov ecx, segundo
   int 80h

   mov edx, len_r
   mov ecx, result
   mov eax, 4
   mov ebx, 1
   int 80h

   mov bl, [segundo]
   mov al, [primeiro]
   sub bl, '0'
   add al, bl
   mov [resultado], al 

   mov ecx, resultado
   mov edx, 2
   mov eax, 4
   mov ebx, 1
   int 80h

   call sair
