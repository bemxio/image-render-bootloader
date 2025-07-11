[bits 16] ; 16-bit mode
[org 0x7c00] ; global offset

mov byte [DRIVE_NUMBER], dl ; save the drive number for later use
xor dx, dx ; clear the data register

mov ax, 0x4f02 ; "Set SVGA Video Mode" function
mov bx, 0x115 ; 800x600 24-bit color mode

int 0x10 ; BIOS interrupt

chunk_loop:
    call read_chunk ; read a chunk of data from the disk

    inc dx ; increment the bank number
    call switch_bank ; switch to the next bank

    cmp dx, 0x16 ; check if the bank number is 22
    jl chunk_loop ; if less, repeat the loop

jmp $ ; loop forever

; functions
read_chunk:
    pusha ; save registers

    mov ah, 0x42 ; "Extended Read Sectors from Drive" function
    mov dl, byte [DRIVE_NUMBER] ; set the drive number
    mov si, DISK_ADDRESS_PACKET ; set the address of the disk address packet

    int 0x13 ; BIOS interrupt
    add dword [SECTOR_OFFSET], CHUNK_SIZE ; increment the sector offset

    popa ; restore registers
    ret ; return from function

switch_bank:
    pusha ; save registers

    mov ax, 0x4f05 ; "CPU Video Memory Control" function
    xor bx, bx ; set the parameters (window A)

    int 0x10 ; BIOS interrupt

    popa ; restore registers
    ret ; return from function

; variables
DRIVE_NUMBER db 0x80 ; drive number (0x80 for the main hard drive)

DISK_ADDRESS_PACKET:
    db 0x10 ; size of the packet (16 bytes)
    db 0x00 ; unused byte, always 0

    dw CHUNK_SIZE ; sector amount
    dw 0x00 ; buffer offset
    dw VIDEO_MEMORY_SEGMENT ; buffer segment

    SECTOR_OFFSET dd 0x01 ; sector offset (lower 32-bits)
    dd 0x00 ; sector offset (upper 32-bits)

; constants
CHUNK_SIZE equ 128 ; 128 sectors (65535 bytes) per image chunk
VIDEO_MEMORY_SEGMENT equ 0xa000 ; segment for the video memory buffer

; pad the rest of the sector with zeros
times 510 - ($ - $$) db 0x00

; boot signature
dw 0xaa55