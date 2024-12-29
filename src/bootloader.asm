[bits 16] ; 16-bit mode
[org 0x7c00] ; global offset

xor ah, ah ; clear the AH register
mov al, 0x13 ; 320x200x256 color mode (VGA)

int 0x10 ; call the BIOS interrupt

mov ax, 0xa000 ; set the video memory address
mov es, ax ; move the address into the extra segment register

call read_image ; read the image into memory

jmp $ ; halt the bootloader

; includes
%include "./src/disk.asm"
%include "./src/print.asm"

; pad the rest of the sector with zeros
times 510 - ($ - $$) db 0x00

; boot signature
dw 0xaa55