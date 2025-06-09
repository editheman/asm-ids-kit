; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp
    ; sa-nceapa concursul
    ; numar magic
    mov eax, [ebp + 8]
    ; numar magic
    mov dword ecx, 0

while:
    movzx edi, byte [eax]
    ; numar magic
    cmp edi, 0
    je end_while
    ; numar magic
    add eax, 1
    cmp edi, '('
    je push_stack
    cmp edi, '['
    je push_stack
    cmp edi, '{'
    je push_stack
    cmp edi, ')'
    je pop_stack
    cmp edi, ']'
    je pop_stack
    cmp edi, '}'
    je pop_stack
    jmp while
push_stack:
    push edi
    inc ecx
    jmp while
pop_stack:
    ; numar magic
    cmp ecx, 0
    je leave
    pop edx
    dec ecx
    cmp edx, '('
    je is_1
    cmp edx, '['
    je is_2
    cmp edx, '{'
    je is_3
is_1:
    cmp edi, ')'
    jne leave
    jmp while
is_2:
    cmp edi, ']'
    jne leave
    jmp while
is_3:
    cmp edi, '}'
    jne leave

    jmp while
end_while:
    ; numar magic
    mov dword eax, 0
    jmp end
leave:
    ; numar magic
    mov dword eax, 1
    jmp end
end:
    leave
    ret