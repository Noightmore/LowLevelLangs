; Compile with: nasm -f elf testc.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 testc.o -o testc
; Run with: ./testc

section .data
    ; neresime zde dynamickou alokaci

    pole_longu: dd 21,3,1,46,443,23 ; pole pointeru na 32bitova cisla
    delka_pole: dd 6 ; delka pole

    ; u me v testu to bylo 2D pole plne pointeru bud na maska_licha, nebo maska_suda
    ; pocet pointeru na masku == pocet prvku v poli pole_longu
    ; maska mela byt nezavisla na zbytku programu, proto byla takto implementovana v testu

    maska_suda: db 0h, FFFFh, 0h, FFFFh ; maska pro sude bity
    maska_licha: db FFFFh, 0h, FFFFh, 0h ; maska pro liche bity

    ; id masky, ktera se ma pouzit 0 = suda, 1 (nebo cokoliv jineho) = licha,
    ; idealnejsi by bylo, kdyby to zadaval uzivatel, pro jednoduchost nastaveno staticky v programu
    prave_pouzivana_maska_id: dd 0

section .bss
    pole_intu16: resw 6 ; pointer na pole pro 16bitova cisla
    pouzivana_maska_ptr: resd 1 ; pointer na prave pouzivanou masku

section .text
    global _start
_start:
    ;
    ; nacteni adresy prave pouzivane masky do pouzivana_maska_ptr
    mov ebx, [prave_pouzivana_maska_id]
    cmp ebx, 0
    je suda
    jmp licha

    licha:
        mov eax, maska_licha
        mov [pouzivana_maska_ptr], eax
        jmp aplikace_masky
    suda:
        mov eax, maska_suda
        mov [pouzivana_maska_ptr], eax
        jmp aplikace_masky

    ; projde se cyklicky kazdy long a vymaskuji se byty, ty se rovnou nahraji do pole intu16
    aplikace_masky:
        ; nacteni pointeru
        mov esi, pole_longu
        mov edi, pole_intu16

        foreachLong:
            mov ecx, [pouzivana_maska_ptr]

            ; vymaskovani jednotlivych bytu
            mov eax, [esi]
            and ah, [ecx]
            inc ecx
            and al, [ecx]
            inc ecx

            cmp ah, 0
            jne push_upper
            jmp push_lower

            push_lower:
                push al
                jmp next_part

            push_upper:
                push ah
                jmp next_part

            next_part:
                shr eax, 16 ; presuneme si pravych 16 bitu do ax
                and ah, [ecx]
                inc ecx
                and al, [ecx]

                cmp ah, 0
                jne push_upper1
                jmp push_lower1

            push_lower1:
               push al
               jmp nacteni_platnych_bajtu

            push_upper1:
               push ah
               jmp nacteni_platnych_bajtu

            ; bajty, co prezily vymaskovani byly ulozeny na zasobnik
            ; popnou se, nejdriv ty, co byly v longu nejvic na pravo (princip zasobniku/LIFO)
            ; po te ty, co byly nejvice v levo, cili byly v algoritmu zpracovavany nejdrive
            nacteni_platnych_bajtu:
                pop al
                pop ah
                mov [edi], ax

            ; zjisteni konce pole, prosli vsechny longy
            mov eax, [delka_pole]
            add eax, pole_longu
            cmp eax, esi ;(ptr == ptr_konec_pole)
            je konec

            ; posunuti pointeru na dalsi long a dalsi ulozny prostor pro int16
            inc esi
            inc edi
            jmp foreachLong
    konec:
        ; print all values in pole_intu16
        mov esi, pole_intu16


        ; konec programu
        mov eax, 1
        mov ebx, 0
        int 0x80
