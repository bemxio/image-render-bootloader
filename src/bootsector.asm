[bits 16] ; 16-bit mode
[org 0x7c00] ; global offset

mov ax, 0x4f02 ; "Set SVGA Video Mode" function
mov bx, 0x10f ; 320x200 24-bit color mode

int 0x10 ; BIOS interrupt

call display_image ; display the image data
jmp $ ; loop forever

; functions
display_image:
    pusha ; save registers

    popa ; restore registers
    ret ; return from function

read_chunk:
    pusha ; save registers

    popa ; restore registers
    ret ; return from function

switch_bank:
    pusha ; save registers

    popa ; restore registers
    ret ; return from function

; constants
CHUNK_SIZE equ 125 ; 125 sectors (64000 bytes) per image chunk

; pad the rest of the sector with zeros
times 510 - ($ - $$) db 0x00

; boot signature
dw 0xaa55