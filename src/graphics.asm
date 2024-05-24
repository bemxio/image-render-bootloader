draw_image:
    xor dx, dx ; set the row position to 0
    xor cx, cx ; set the column position to 0

    draw_image_loop:
        mov al, [ebx] ; get the next byte from the image

        mov ah, 0x0c ; 'Write Graphics Pixel' function
        int 0x10 ; call the BIOS interrupt

        inc cx ; increment the column position
        inc ebx ; increment the image address

        cmp cx, 320 ; compare the column position to 320
        jne draw_image_loop ; if it's not equal to the value, then loop back

    draw_image_line:
        xor cx, cx ; set the column position to 0
        inc dx ; increment the row position

        cmp dx, 200 ; compare the row position to 200
        jl draw_image_loop ; if it's less than the value, then jump back to the loop

    draw_image_end:
        ret ; return to caller