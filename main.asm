; Adriel Freud

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data
	display_msg db 0xa, " Calculator by Adriel ", 0xa, 0xa
	len_display equ $-display_msg

	first db "[+] Primeiro Numero: "
	len_f equ $-first

	second db "[+] Segundo Numero: "
	len_s equ $-second

	resultado_som db 0xa, "[!] Adicao: "
	len_sm equ $-resultado_som

	resultado_mult db 0xa, "[!] Multiplicação: "
	len_mt equ $-resultado_mult

	space db 0xa, 0xa, " ", 0xa, 0xd

segment .bss
	num1 resb 2
	num2 resb 2
	res_soma resb 1
	res_mult resb 1

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

	call soma
	call mult
	call quebra_linha
	call exit

soma:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, resultado_som
	mov edx, len_sm
	int 0x80
	
	; move o primeiro numero para eax, e o segundo para ebx
	; subtrai pelo caracter ascii '0' e converte para decimal

	mov eax, [num1]
	sub eax, '0'
	mov ebx, [num2]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'

	; Quarda a soma na variavel alocada, chamada res_soma
	mov [res_soma], eax

   	; mostra o resultado contido em res_soma
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res_soma
	mov edx, 1
	int 80h

mult:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, resultado_mult
	mov edx, len_mt
	int 80h

	mov	al, [num1]
	sub al, '0'
	mov bl, [num2]
	sub bl, '0'
	mul bl
	add	al, '0'
	mov [res_mult], al
	
	mov	ecx, res_mult
	mov	edx, 1
	mov	ebx, STDOUT
	mov	eax, SYS_WRITE
	int	80h

quebra_linha:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, space
	mov edx, 1
	int 80h

exit:
	mov eax, SYS_EXIT
	xor ebx, ebx
	int 80h
