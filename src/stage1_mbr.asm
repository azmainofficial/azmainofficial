; ==============================================================================
;  AZMAIN-ROBOTICS: Stage 1 Master Boot Record (MBR) [x86 16-bit Real Mode]
;  Developer: Azmain Sheikh (@azmainofficial) - Robotics Engineer
;  Target: 512-byte Master Boot Record
; ==============================================================================

[BITS 16]
[ORG 0x7C00]

stage1_start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov [boot_drive], dl    ; BIOS boot drive

    ; 1. Initialize COM1 UART (0x3F8) for Robotics Telemetry @ 115200 baud
    mov dx, 0x3F9
    mov al, 0x00
    out dx, al

    mov dx, 0x3FB
    mov al, 0x80           ; DLAB on
    out dx, al

    mov dx, 0x3F8
    mov al, 0x01           ; 115200 Baud
    out dx, al

    mov dx, 0x3F9
    mov al, 0x00
    out dx, al

    mov dx, 0x3FB
    mov al, 0x03           ; 8N1
    out dx, al

    mov dx, 0x3FA
    mov al, 0xC7
    out dx, al

    mov dx, 0x3FC
    mov al, 0x0B
    out dx, al

    ; 2. Notify MBR initialization
    mov si, mbr_notice
    call serial_puts

    ; 3. Read Stage 2 Robotics Kernel from Disk (4 sectors) into 0x0000:0x7E00
    mov ah, 0x02
    mov al, 4
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x7E00
    int 0x13
    jc disk_error

    ; 4. Jump to Stage 2 Robotics Kernel Payload
    jmp 0x0000:0x7E00

disk_error:
    mov si, err_msg
    call serial_puts
.halt:
    hlt
    jmp .halt

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

boot_drive db 0
mbr_notice db 0x1B, "[2J", 0x1B, "[H", "[  0.000000] MBR: Booting Azmain Robotics Kernel from disk...", 0x0D, 0x0A, 0
err_msg    db "[!] Sensor & Disk Bus Error. Halting.", 0x0D, 0x0A, 0

times 510 - ($ - $$) db 0
dw 0xAA55
