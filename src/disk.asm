DISK_ADDRESS_PACKET:
    db 0x10 ; size of the packet, 16 bytes by default
    db 0x00 ; unused, should always be 0

    dw IMAGE_SIZE ; number of sectors to read
    dw IMAGE_OFFSET ; pointer to the buffer
    dw 0x00 ; page number, 0 by default

    dd 0x01 ; offset of the sector to read (lower 32-bits)
    dd 0x00 ; unused here (upper 32-bits)

read_image:
    pusha ; save all of the registers to the stack

    mov ah, 0x42 ; 'Extended Read Sectors From Drive' function
    mov si, DISK_ADDRESS_PACKET ; load the address of the packet

    int 0x13 ; call the BIOS interrupt

    popa ; restore all of the registers from the stack
    ret ; return to caller

IMAGE_SIZE equ 125 ; 125 sectors (64,000 bytes) per image