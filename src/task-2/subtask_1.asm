; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:

    enter 0, 0

    push edi
    push esi
    push ebx

    mov esi, dword [ebp + 8]  ; store pointer to first element in esi
    mov eax, dword [ebp + 12]  ; store start index,  = i
    mov ebx, dword [ebp + 16] ; store end index

    cmp eax, ebx
    jge qsort_done

    mov ecx, eax                        ; ecx = j, = sid
    mov edx, dword [esi + (4 * ebx)]  ; pivot element, elems[eid], edx = pivot
qsort_part_loop:
    ; for j = sid; j < eid; j++
    cmp ecx, ebx                    ; if ecx < end index
    jge qsort_end_part
    ; if elems[j] <= pivot
    cmp edx, dword [esi + (4*ecx)]
    jl qsort_cont_loop
    ; do swap, elems[i], elems[j]
    push edx ; save pivot for now
    mov edx, dword [esi + (4 * ecx)]        ; edx = elems[j]
    mov edi, dword [esi + (4 * eax)]        ; edi = elems[i]
    mov dword [esi + (4 * eax)], edx        ; elems[i] = elems[j]
    mov dword [esi + (4 * ecx)], edi        ; elems[j] = elems[i]
    pop edx ; restore pivot
    ; i++
    inc eax
qsort_cont_loop:
    inc ecx
    jmp qsort_part_loop
qsort_end_part:
    ; do swap, elems[i], elems[eid]
    mov edx, dword [esi + (4 * eax)]        ; edx = elems[i]
    mov edi, dword [esi + (4 * ebx)]        ; edi = elems[eid]
    mov dword [esi + (4 * ebx)], edx        ; elems[eidx] = elems[i]
    mov dword [esi + (4 * eax)], edi        ; elems[i] = elems[eidx]

    ; qsort(elems, sid, i - 1)
    ; qsort(elems, i + 1, eid)
    dec eax
    push eax
    push dword [ebp + 12]  ; push start idx
    push dword [ebp + 8]  ; push elems vector
    call quick_sort
    add esp, 8
    pop eax
    inc eax
    push dword [ebp + 16] ; push end idx
    push eax
    push dword [ebp + 8]  ; push elems vector
    call quick_sort
    add esp, 12
qsort_done:
    pop ebx
    pop esi
    pop edi
    leave
    ret
