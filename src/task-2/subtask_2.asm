; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0
    push edi
    push esi
    push ebx

    ;; save the preserved registers
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    
    ;; recursive bsearch implementation goes here
   
    cmp ebx, eax
    jl not_found
    mov edi, ebx
    sub edi, eax
    shr edi, 1
    mov esi, eax
    add esi, edi
    mov edi, [ecx + esi * 4]
    cmp edi, edx
    je found
    jl right
    jg left

    ;; restore the preserved registers

found:
    mov eax, esi
    jmp end
left:
    dec esi
    push esi
    push eax
    call binary_search
    add esp, 8
    jmp end

right:
    push ebx
    inc esi
    push esi
    call binary_search
    ; numar magic
    add esp, 8
    jmp end

not_found:
    mov eax, -1
end:
    pop ebx
    pop esi
    pop edi
    leave
    ret
