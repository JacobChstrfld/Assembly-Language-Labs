;name: Jacob Chesterfield
;date: 5/17/2019
;id: 41455213
;CS:311-003
;honorcode: I promise this code is my own work.
segment .data
a       dd 14, 10, 23, 45, 17, 9, 54, 22, 1, 76 ;initialize array a of 10 double words
size    db 10                                   ;initialize size to 10
bool    dq 0                                    ;initialize bool to 0 (false)
b       dq 4                                    ;initialize variable b to 4
max     dq 9                                    ;initialize variable max to 9

lower   db 0                                    ;initialize variable lower to 0
upper   db 9                                    ;initialize variable upper to 9
middle  db 0                                    ;initialize variable middle to 0
needle  db 54                                   ;initialize variable needle to the value 54
loc     db 0                                    ;initialize variable loc to 0
two     db 2                                    ;initialize variable two to 2




segment .text
global  main

main:
        xor rax, rax                            ;clear rax
        xor rbx, rbx                            ;clear rbx
        xor rcx, rcx                            ;clear rcx
        mov rbx, 4                              ;move 4 into rbx for use with array index
        mov rcx, 0                              ;move 0 into rcx
        mov [bool], rax                         ;move rax (value of 0) to bool in memory
sort:
        xor rax, rax                            ;zero out rax
        xor r8, r8                              ;zero out r8
        xor r9, r9                              ;zero out r9
    
        mov eax, [a + 4 * rcx]                  ;move the value of a at the index of rcx into eax
        cmp eax, [a + rbx]                      ;compare the value of a at the index of rbx / 4 with the value of a at the index of rcx (eax)
        jg swap                                 ;jump to swap if greater
        jle noSwap                              ;jump to noSwap if less than or equal
swap:
        movsx r8, dword[a + 4 * rcx]            ;move the value of a at the index rcx into r8

        movsx r9, dword[a + rbx]                ;move the value of a at the index rbx / 4 into r9
        mov [a + 4 * rcx], r9d                  ;move the value in r9d into a at index rcx
        mov [a + rbx], r8d                      ;move r8d into a at index rbx / 4
        mov rax, 1                              ;move 1 into rax
        mov [bool], rax                         ;move value of rax into bool in memory
        inc rcx                                 ;increment rcx
        add rbx, [b]                            ;add value of b (4) to rbx
        cmp rcx, [max]                          ;compare rcx to value of max
        jge almost                              ;jump if greater than to almost
        jmp sort                                ;else jump to sort
    
noSwap:
        inc rcx                                 ;increment rcx
        add rbx, [b]                            ;add value of b (4) to rbx
        cmp rcx, [max]                          ;compare value of rcx to max
        jge almost                              ;jump if greater than to almost
        jmp sort                                ;else jump to sort
    
almost:
        mov rax, 0                              ;move 0 into rax
        cmp [bool], rax                         ;cmp value in rax to value of bool
        jnz main                                ;jump if not zero to main
        jz done                                 ;jump if zero to done
    
done:    
        xor rax, rax                            ;zero out rax
        xor rbx, rbx                            ;zero out rbx
        xor rcx, rcx                            ;zero out rcx
        xor r8, r8                              ;zero out r8
        xor r9, r9                              ;zero out r9
        xor r10, r10                            ;zero out r10
    
        movsx rax, byte[upper]                  ;move value of upper into rax
        cmp rax, [lower]                        ;compare value of lower with rax
        jg end                                  ;jump if greater than to end
    
        movsx rax, byte[upper]                  ;move value of upper into rax
        movsx r8, byte[lower]                   ;movevalue of lower into r8
        add rax, r8                             ;add r8 with rax
        div byte[two]                           ;div rax by value of two (2)
        mov [middle], al                        ;mov lower byte of rax into middle in memory                                                                                 
                                        
        movsx rax, byte[needle]                 ;move the value of needle into rax
        movsx r8, byte[middle]                  ;move the value of middle into r8
        imul r10, r8, 4                         ;multiply value in r8 by 4 and store result in rax
        movsx r9, dword[a + r10]                ;move value of a at index middle
        cmp rax, r9                             ;compare whats in rax with whats in r9
        jz end                                  ;jump if zero to end
        jl elseIf                               ;jump if less than to elseIf
        jmp else                                ;jump to else

elseIf:
        dec byte[middle]                        ;decrement value of middle
        movsx rax, byte[middle]                 ;move value of middle into rax
        mov [upper], al                         ;move lower byte of rax into upper in memory
        jmp done                                ;jump to done
    
else:
        inc byte[middle]                        ;increment value of middle
        movsx rax, byte[middle]                 ;move value of middle into rax
        mov [lower], al                         ;move lower byte of rax into lower in memory
        jmp done                                ;jump to done
    
end:    
        movsx rax, byte[middle]                 ;move value of middle into rax
        mov [loc], al                           ;move lower byte of rax into loc in memory
        ret                                     ;return

