[bits 16] ; 16-bit mode
[org 0x7c00] ; global offset

mov ax, 0x13 ; "Set Video Mode" function with 320x200 color mode
int 0x10 ; call the BIOS interrupt

mov ax, 0xa000 ; set the video memory address
mov es, ax ; move the address into the extra segment register

call read_image ; read the image into the video memory
jmp $ ; loop forever

; constants
IMAGE_SIZE equ 125 ; 125 sectors (64000 bytes) per image

; functions
read_image:
    pusha ; save registers

    mov ah, 0x02 ; "Read Sectors Into Memory" function
    mov al, IMAGE_SIZE ; sector amount

    mov cl, 0x02 ; sector (0x02 is the first "available" sector)
    mov ch, 0x00 ; cylinder (from 0x0 to 0x3ff)
    mov dh, 0x00 ; head number (from 0x0 to 0xf)

    int 0x13 ; call the BIOS interrupt

    popa ; restore registers
    ret ; return from function

; pad the rest of the sector with zeros
times 510 - ($ - $$) db 0x00

; boot signature
dw 0xaa55