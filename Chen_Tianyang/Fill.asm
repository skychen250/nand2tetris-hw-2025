// Fill.asm - Fill screen black when key is pressed, white otherwise

(LOOP)
@KBD
D=M
@DRAW_BLACK
D;JNE        // If key pressed, go draw black
@DRAW_WHITE
0;JMP        // Else, draw white

// ---------------------
// Draw black pixels
(DRAW_BLACK)
@SCREEN
D=A
@addr
M=D          // addr = SCREEN base
@8192
D=A
@counter
M=D          // counter = 8192 words (16 x 512 rows)

(BLACK_LOOP)
@counter
D=M
@LOOP
D;JEQ        // if counter == 0, go back to main loop

@addr
A=M
M=-1         // write black (all bits 1)

@addr
M=M+1        // addr++
@counter
M=M-1        // counter--
@BLACK_LOOP
0;JMP

// ---------------------
// Draw white pixels
(DRAW_WHITE)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@counter
M=D

(WHITE_LOOP)
@counter
D=M
@LOOP
D;JEQ        // if counter == 0, go back to main loop

@addr
A=M
M=0          // write white (all bits 0)

@addr
M=M+1
@counter
M=M-1
@WHITE_LOOP
0;JMP
