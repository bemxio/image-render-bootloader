[bits 16] ; 16-bit mode
[org 0x7c00] ; global offset

mov ax, 0x13 ; "Set Video Mode" function with 320x200 color mode
int 0x10 ; call the BIOS interrupt

mov ax, VIDEO_MEMORY_SEGMENT ; set the video memory segment
mov es, ax ; move the segment into the extra segment register
xor di, di ; clear the destination index

mov ah, 0x02 ; "Read Sectors Into Memory" function
mov al, IMAGE_SIZE ; set the sector amount

mov cl, 0x02 ; set the sector position (0x02 is the first "available" sector)
xor ch, ch ; set the cylinder (from 0x0 to 0x3ff)
xor dh, dh ; set the head number (from 0x0 to 0xf)

int 0x13 ; call the BIOS interrupt
jmp $ ; loop forever

; constants
VIDEO_MEMORY_SEGMENT equ 0xa000 ; segment pointing to the video memory buffer
IMAGE_SIZE equ 125 ; 125 sectors (64000 bytes) per image

; pad the rest of the sector with zeros
times 510 - ($ - $$) db 0x00

; boot signature
dw 0xaa55