| SEGA CD support code
| by Chilly Willy

        .text

| CD startup at 0x8000

        .global _start
_start:
        move    #0x2700,sr              /* disable interrupts */

| Clear BSS
        lea     __bss_start,a0
        lea     __bss_end,a1
        moveq   #0,d0
1:
        move.l  d0,(a0)+
        cmpa.l  a0,a1
        bhi.b   1b

        move.l  sp,__stack_save         /* save BIOS stack pointer */
        lea     __stack,a0
        movea.l a0,sp                   /* set stack pointer to top of Program RAM */
        link.w  a6,#-8                  /* set up initial stack frame */

        jsr     init_hardware           /* initialize the console hardware */

        jsr     __INIT_SECTION__        /* do all program initializers */
        jsr     main                    /* call program main() */
        jsr     __FINI_SECTION__        /* do all program finishers */

        movea.l __stack_save,sp         /* restore BIOS stack pointer */
        moveq   #0,d0
        rts


        .data

        .align  4

__stack_save:
        .long   0

        .text

