; Adriel Freud

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data
	display_msg db 0xa, " Calculator by Adriel ", 0xa ,0xa
	len_display equ $-display_msg

	first db "[+] Primeiro Numero: "
	len_f equ $-first

	second db 0xa, "[+] Segundo Numero: "
	len_s equ $-second

	resultado db 0xa, "[!] The sum is: "
	len_r equ $-resultado

	last db 0xa, 0xa, " ", 0xa, 0xd

segment .bss
	num1 resb 2
	num2 resb 2
	result resb 1

section	.text
	global _start

_start:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, display_msg
	mov edx, len_display
	int 80h

	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, first
	mov edx, len_f
	int 80h

	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 80h

	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, second
	mov edx, len_s
	int 80h

	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num2
	mov edx, 2
	int 80h

	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, resultado
	mov edx, len_r
	int 0x80

	; move o primeiro numero para eax, e o segundo para ebx
	; subtrai pelo caracter ascii '0' e converte para decimal

	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'

	; Quarda a soma na variavel alocada, chamada result
	mov [result], eax

   	; mostra o resultado contido em result
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, result
	mov edx, 1
	int 80h

	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, last
	mov edx, 1
	int 80h

exit:

	mov eax, SYS_EXIT
	xor ebx, ebx
	int 80h
