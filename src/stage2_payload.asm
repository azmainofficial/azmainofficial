; ==============================================================================
;  AZMAIN-ROBOTICS: Stage 2 Kernel Diagnostics & Node Manager
;  Developer: Azmain Sheikh (@azmainofficial) - Robotics Engineer
;  Loaded at: 0x0000:0x7E00
; ==============================================================================

[BITS 16]
[ORG 0x7E00]

stage2_entry:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, robotics_banner
    call print_string

halt_loop:
    hlt
    jmp halt_loop

print_string:
    pusha
.next:
    lodsb
    test al, al
    jz .done

    ; Output to COM1 UART
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

    ; Microsecond delay for cadence
    push cx
    push dx
    push ax
    mov ah, 0x86
    mov cx, 0x0000
    mov dx, 0x2200          ; ~8.7ms per char
    int 0x15
    pop ax
    pop dx
    pop cx

    jmp .next
.done:
    popa
    ret

; ------------------------------------------------------------------------------
; Robotics Diagnostic Strings & ANSI Terminal Codes
; ------------------------------------------------------------------------------
CRLF equ 0x0D, 0x0A
ESC  equ 0x1B

robotics_banner:
    db ESC, "[38;5;244m[  0.012400] ", ESC, "[1;32mAZMAIN-ROBOTICS RTOS v2.0.0", ESC, "[0m (x86_64 Real Mode)", CRLF
    db ESC, "[38;5;244m[  0.038000] ", ESC, "[0;36mInitializing CAN Bus, I2C & SPI peripheral buses ... OK", ESC, "[0m", CRLF
    db ESC, "[38;5;244m[  0.065000] ", ESC, "[0;36mCalibrating IMU, Kinematics & Motor Encoders ........ OK", ESC, "[0m", CRLF
    db ESC, "[38;5;244m[  0.098000] ", ESC, "[1;33mStarting ROS 2 Daemon & Neural Vision Pipeline ...... OK", ESC, "[0m", CRLF
    
    ; Cyber-styled Robotics Profile Box
    db ESC, "[38;5;39m+-------------------------------------------------------------------------+", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mIDENTIFIER : ", ESC, "[1;35mAzmain Sheikh (@azmainofficial)", ESC, "[38;5;39m                           |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mDISCIPLINE : ", ESC, "[1;32mRobotics Engineer & Deep Learning Researcher", ESC, "[38;5;39m             |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mROBOTICS   : ", ESC, "[1;36mROS, ROS 2, Micro-ROS, Kinematics, SLAM, Actuators", ESC, "[38;5;39m       |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mHARDWARE   : ", ESC, "[0;33mCAD Modeling, 3D Printing, Rapid Prototyping, IoT", ESC, "[38;5;39m        |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mAI & VISION: ", ESC, "[38;5;214mComputer Vision, Neural Networks, PyTorch, OpenCV", ESC, "[38;5;39m         |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m| ", ESC, "[1;37mEMBEDDED   : ", ESC, "[38;5;198mC/C++, STM32, ESP32, FreeRTOS, Linux Kernel, I2C/SPI", ESC, "[38;5;39m      |", ESC, "[0m", CRLF
    db ESC, "[38;5;39m+-------------------------------------------------------------------------+", ESC, "[0m", CRLF

    db ESC, "[38;5;244m[  0.220000] ", ESC, "[1;32mRobotics Subsystems Online.", ESC, "[0m Dropping to interactive shell...", CRLF, CRLF
    db ESC, "[1;32mazmain@robotics-node", ESC, "[0m:", ESC, "[1;34m~", ESC, "[0m$ ros2 node list && ./inspect_actuators.sh", CRLF
    db ">> /vision/camera_stream  [30 FPS Active]", CRLF
    db ">> /control/inverse_kinematics  [Converged]", CRLF
    db ">> /sensors/imu_fusion  [Calibrated 0.001 deg]", CRLF
    db ESC, "[1;32mazmain@robotics-node", ESC, "[0m:", ESC, "[1;34m~", ESC, "[0m$ ", 0

times 2048 - ($ - $$) db 0
