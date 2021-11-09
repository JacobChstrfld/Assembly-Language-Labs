;name: Jacob Chesterfield
;date: 5/25/2019
;id: 41455213
;CS:311-003
;honorcode: I promise this code is my own work.

                segment .data
x               dq      0                       ;initialize x to 0
scanf_format    db    "%ld",0                   ;create variable for scanf formatting 
printf_format   db    "The number closest to the fib(%ld) is = %ld",0x0a,0  ;create variable for printf formatting 

                segment .text
                global  main                    ;let the linker know about main
                global  fibonacci               ;declare function called fibonacci
                extern  scanf                   ;declare external function called scanf
                extern  printf                  ;declare external function called printf
main:
                xor r8, r8                      ;clear out r8
                xor r9, r9                      ;clear out r9
                push    rbp                     ;push rbp onto stack
                mov     rbp, rsp                ;move rsp into rbp
                sub     rsp, 32                 ; subtract 32 from rsp
                lea     rcx, [scanf_format]     ; set arg 1 for scanf call
                lea     rdx, [x]                ; set arg 2 for scanf call
                call    scanf                   ;call external scanf function
                mov rax, 1                      ;move 1 into rax
                mov rbx, 1                      ;move 1 into rbx
                call fibonacci                  ;call fibonacci function
                leave                           ;leave
                ret                             ;return
        
fibonacci:
                push    rbp                     ;push rbp onto stack
                mov     rbp, rsp                ;move rsp into rbp
                sub     rsp, 32                 ;subtract 32 from rsp
                push rax                        ;push rax onto the stack
                push rbx                        ;push rbx onto the stack
                cmp rax, [x]                    ;compare rax with x
                jl n1                           ; jump if less than to n1
                jmp n2                          ;else jump to n2

n1:                                             ;create label n1 for the loop to find the higher and lower fibonacci numbers using the stack
                pop r8                          ;pop last inserted stack value into r8
                pop r9                          ;pop last inserted stack value into r9
                add rax, r8                     ;add r8 with rax 
                push rax                        ;push rax onto the stack
                push r9                         ;push r9 onto the stack
                cmp rax, [x]                    ;compare rax with x
                jl n1                           ;jump if less than to n1
                jmp n2                          ;else jump to n2

n2:                                             ;create label n2 for deciding which fibonacci number is closer to x
                pop r8                          ;pop last inserted stack value into r8
                pop r9                          ;pop last inserted stack value into r9
                mov rax, [x]                    ;mov x into rax
                sub rax, r8                     ;subtract r8 from rax
                mov r10, r9                     ;move r9 into r10 so that fibonacci number isn't lost
                sub r9, [x]                     ;subtract x from r9
                cmp r9, rax                     ;compare r9 with rax
                jle higher                      ;jump if less than or equal to higher
                jg lower                        ;jump if greater than to higher


higher:                                         ;create label higher for printing the higher fibonacci number
                lea     rcx, [printf_format]    ;load address of printf _format into rcx for arg 1
                mov     rdx, [x]                ;move x into rdx for arg 2
                mov r8, r10                     ;move r10 into r8 for arg 3
                call printf                     ;call printf
                leave                           ;leave
                ret                             ;return


lower:                                          ;create label lower for printing the lower fibonacci number
                lea     rcx, [printf_format]    ;load address of printf _format into rcx for arg 1
                mov     rdx, [x]                ;move x into rdx for arg 2
                call printf                     ;call printf
                leave                           ;leave
                ret                             ;return
