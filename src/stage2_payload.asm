; ==============================================================================
;  AZMAIN-OS: Stage 2 Profile Payload & Kernel Diagnostics
;  Developer: Azmain Sheikh (@azmainofficial)
;  Loaded at: 0x0000:0x7E00
; ==============================================================================

[BITS 16]
[ORG 0x7E00]

stage2_entry:
    ; Set segments
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Print Stage 2 profile banner
    mov si, profile_msg
    call print_string

    ; Finished boot sequence - halt CPU
halt_loop:
    hlt
    jmp halt_loop

; ------------------------------------------------------------------------------
; Helper: Write null-terminated string to COM1 and VGA Screen with delay
; ------------------------------------------------------------------------------
print_string:
    pusha
.next:
    lodsb
    test al, al
    jz .done

    ; Output to COM1
    push ax
    mov dx, 0x3FD
.wait_tx:
    in al, dx
    test al, 0x20
    jz .wait_tx
    pop ax
    mov dx, 0x3F8
    out dx, al

    ; Output to BIOS Video (INT 10h)
    push bx
    push ax
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x0A            ; Light green text
    int 0x10
    pop ax
    pop bx

    ; Cadence Delay (Wait CX:DX microseconds via BIOS INT 15h)
    push cx
    push dx
    push ax
    mov ah, 0x86
    mov cx, 0x0000
    mov dx, 0x2500          ; ~9.5ms delay per char for typewriter effect
    int 0x15
    pop ax
    pop dx
    pop cx

    jmp .next
.done:
    popa
    ret

; ------------------------------------------------------------------------------
; Data & ANSI Strings
; ------------------------------------------------------------------------------
CRLF equ 0x0D, 0x0A
ESC  equ 0x1B

profile_msg:
    ; Kernel initialization lines
    db ESC, "[38;5;244m[  0.012400] ", ESC, "[1;32mStage 2 Payload active @ 0x7E00", ESC, "[0m", CRLF
    db ESC, "[38;5;244m[  0.038000] ", ESC, "[0;36mInitializing COM1 115200 8N1 serial console ... OK", ESC, "[0m", CRLF
    db ESC, "[38;5;244m[  0.065000] ", ESC, "[0;36mTesting memory (640K Base / 64M Extended) ..... OK", ESC, "[0m", CRLF
    db ESC, "[38;5;244m[  0.095000] ", ESC, "[1;33mLoading target payload: developer.profile ...", ESC, "[0m", CRLF
    
    ; Cyber-styled Profile Table
    db ESC, "[38;5;39m+-------------------------------------------------------------------------+", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mIDENTIFIER : ", ESC, "[1;35mAzmain Sheikh (@azmainofficial)", ESC, "[38;5;39m                           |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mLOCATION   : ", ESC, "[0;32mDhaka, Bangladesh [UTC+6]", ESC, "[38;5;39m                                |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mROLE       : ", ESC, "[1;36mFull-Stack & ML Dev | Blending Software & AI", ESC, "[38;5;39m              |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mSTACK      : ", ESC, "[0;33mC, C++, Qt, Python, TensorFlow, React Native, Laravel", ESC, "[38;5;39m     |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mTAGLINE    : ", ESC, "[38;5;214m\"Powered by Code, Tea, and Kacchi\"", ESC, "[38;5;39m                        |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mDIAGNOSTIC : ", ESC, "[38;5;198m\"I debug faster than I eat biryani.\"", ESC, "[38;5;39m                      |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m+-------------------------------------------------------------------------+", ESC, "[0m", CRLF

    ; Ready prompt
    db ESC, "[38;5;244m[  0.210000] ", ESC, "[1;32mKernel ready.", ESC, "[0m Dropping to interactive userland shell...", CRLF, CRLF
    db ESC, "[1;32mazmain@bare-metal", ESC, "[0m:", ESC, "[1;34m~", ESC, "[0m$ cat /proc/status | grep FOCUS", CRLF
    db ">> High-performance systems, Machine Learning pipelines & modern full-stack apps.", CRLF
    db ESC, "[1;32mazmain@bare-metal", ESC, "[0m:", ESC, "[1;34m~", ESC, "[0m$ ", 0

; Pad to a clean 4 sectors (2048 bytes)
times 2048 - ($ - $$) db 0

