[bits 16] ; set the code to 16-bit mode
[org 0x7c00] ; set the global offset (0x7c00 is where the BIOS loads the bootloader)

; set the appropriate video mode
mov ah, 0x00 ; 'Set Video Mode' function
mov al, 0x13 ; 320x200x256 color mode (VGA)

int 0x10 ; call the BIOS interrupt

; render the image
mov ebx, IMAGE_OFFSET ; set the offset to the image

call read_image ; read the image into memory
call draw_image ; call the function for drawing the image

jmp $ ; halt the bootloader

; import required modules
%include "./src/disk.asm"
%include "./src/display.asm"

; constants
IMAGE_OFFSET equ 0x7e00 ; the address where the image is loaded

times 510 - ($ - $$) db 0 ; pad the rest of the sector with null bytes
dw 0xaa55 ; set the magic number