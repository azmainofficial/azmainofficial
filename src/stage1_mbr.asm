; ==============================================================================
;  AZMAIN-OS: Stage 1 Master Boot Record (MBR) [x86 16-bit Real Mode]
;  Developer: Azmain Sheikh (@azmainofficial)
;
;  Responsibilities:
;  - Normalize CS:IP, DS, ES, SS segment registers
;  - Save boot drive number passed in DL by BIOS
;  - Initialize COM1 Serial Port (0x3F8)
;  - Read Stage 2 Payload (Sectors 2..5) from disk into 0x0000:0x7E00 via INT 13h
;  - Far jump to Stage 2 Kernel Payload
; ==============================================================================

[BITS 16]
[ORG 0x7C00]

stage1_start:
    ; 1. Canonicalize segment registers & stack
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov [boot_drive], dl    ; Store boot drive number provided by BIOS

    ; 2. Initialize COM1 Serial Port (8250 UART @ 0x3F8)
    mov dx, 0x3F9           ; Interrupt Enable Register
    mov al, 0x00           ; Disable interrupts
    out dx, al

    mov dx, 0x3FB           ; Line Control Register
    mov al, 0x80           ; Enable DLAB (set baud rate divisor)
    out dx, al

    mov dx, 0x3F8           ; Divisor Low: 115200 baud
    mov al, 0x01
    out dx, al

    mov dx, 0x3F9           ; Divisor High
    mov al, 0x00
    out dx, al

    mov dx, 0x3FB           ; 8 bits, no parity, 1 stop bit
    mov al, 0x03
    out dx, al

    mov dx, 0x3FA           ; Enable & clear FIFO
    mov al, 0xC7
    out dx, al

    mov dx, 0x3FC           ; DTR + RTS
    mov al, 0x0B
    out dx, al

    ; 3. Notify MBR initialization over COM1
    mov si, mbr_notice
    call serial_puts

    ; 4. Read Stage 2 from Disk (Sector 2 onward) into 0x0000:0x7E00
    mov ah, 0x02            ; BIOS INT 13h: Read Sectors
    mov al, 4               ; Read 4 sectors (2048 bytes)
    mov ch, 0               ; Cylinder 0
    mov cl, 2               ; Sector 2 (1-indexed)
    mov dh, 0               ; Head 0
    mov dl, [boot_drive]    ; Drive number
    mov bx, 0x7E00          ; Destination ES:BX = 0x0000:0x7E00
    int 0x13
    jc disk_error

    ; 5. Jump to Stage 2 Payload
    jmp 0x0000:0x7E00

disk_error:
    mov si, err_msg
    call serial_puts
.halt:
    hlt
    jmp .halt

; ------------------------------------------------------------------------------
; Helper: Output null-terminated string at DS:SI to COM1
; ------------------------------------------------------------------------------
serial_puts:
    pusha
.next:
    lodsb
    test al, al
    jz .done
    mov dx, 0x3FD
.wait:
    in al, dx
    test al, 0x20
    jz .wait
    mov dx, 0x3F8
    mov al, [si-1]
    out dx, al
    jmp .next
.done:
    popa
    ret

; ------------------------------------------------------------------------------
; Data & MBR Signature
; ------------------------------------------------------------------------------
boot_drive db 0
mbr_notice db 0x1B, "[2J", 0x1B, "[H", "[  0.000000] MBR: Loading Stage 2 payload from disk...", 0x0D, 0x0A, 0
err_msg    db "[!] Disk Read Error! Halting CPU.", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xAA55

