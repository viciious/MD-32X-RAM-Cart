| SEGA MegaCD support code
| by Chilly Willy


|-----------------------------------------------------------------------|
|                            Sub-CPU code                               |
|-----------------------------------------------------------------------|

| Global Variable offsets - must match boot loader
        .equ    VBLANK_HANDLER, 0
        .equ    VBLANK_PARAM,   4
        .equ    INIT_CD,        8
        .equ    READ_CD,        12
        .equ    SET_CWD,        16
        .equ    FIRST_DIR_SEC,  20
        .equ    NEXT_DIR_SEC,   24
        .equ    FIND_DIR_ENTRY, 28
        .equ    NEXT_DIR_ENTRY, 32
        .equ    LOAD_FILE,      36
        .equ    DISC_TYPE,      40
        .equ    DIR_ENTRY,      42
        .equ    CWD_OFFSET,     44
        .equ    CWD_LENGTH,     48
        .equ    CURR_OFFSET,    52
        .equ    CURR_LENGTH,    56
        .equ    ROOT_OFFSET,    60
        .equ    ROOT_LENGTH,    64
        .equ    DENTRY_OFFSET,  68
        .equ    DENTRY_LENGTH,  72
        .equ    DENTRY_FLAGS,   76
        .equ    DENTRY_NAME,    78
        .equ    TEMP_NAME,      78+256
        .equ    SIZE_GLOBALVARS,78+256+256

| Disc Read Buffer
        .equ    DISC_BUFFER, 0x6800

| Program Load Buffer
        .equ    LOAD_BUFFER, 0x8000

| ISO directory offsets (big-endian where applicable)
        .equ    RECORD_LENGTH,  0
        .equ    EXTENT,         6
        .equ    FILE_LENGTH,    14
        .equ    FILE_FLAGS,     25
        .equ    FILE_NAME_LEN,  32
        .equ    FILE_NAME,      33

| Primary Volume Descriptor offset
        .equ    PVD_ROOT, 0x9C

| CDFS Error codes
        .equ    ERR_READ_FAILED,    -2
        .equ    ERR_NO_PVD,         -3
        .equ    ERR_NO_MORE_ENTRIES,-4
        .equ    ERR_BAD_ENTRY,      -5
        .equ    ERR_NAME_NOT_FOUND, -6
        .equ    ERR_NO_DISC,        -7

| XCMD Error codes
        .equ    ERR_UNKNOWN_CMD,    -1
        .equ    ERR_CMDDONE_TIMEOUT,-2
        .equ    ERR_CMDACK_TIMEOUT, -3

| MD Hardware Calls - keep in sync with the enums in hw_md.h

        .equ    MD_CMD_INIT_HW, 1
        .equ    MD_CMD_SET_SR, 2
        .equ    MD_CMD_GET_PAD, 3
        .equ    MD_CMD_CLEAR_B, 4
        .equ    MD_CMD_SET_VRAM, 5
        .equ    MD_CMD_NEXT_VRAM, 6
        .equ    MD_CMD_COPY_VRAM, 7
        .equ    MD_CMD_CLEAR_A, 8
        .equ    MD_CMD_PUT_STR, 9
        .equ    MD_CMD_PUT_CHR, 10
        .equ    MD_CMD_DELAY, 11
        .equ    MD_CMD_SET_PALETTE, 12
        .equ    MD_CMD_Z80_BUSREQUEST, 13
        .equ    MD_CMD_Z80_RESET, 14
        .equ    MD_CMD_Z80_MEMCLR, 15
        .equ    MD_CMD_Z80_MEMCPY, 16
        .equ    MD_CMD_DMA_SCREEN, 17
        .equ    MD_CMD_INIT_32X, 18
        .equ    MD_CMD_GET_COMM32X, 19
        .equ    MD_CMD_SET_COMM32X, 20
        .equ    MD_CMD_DMA_TO_32X, 21
        .equ    MD_CMD_CPY_TO_32X, 22
        .equ    MD_CMD_CPY_TO_MD, 23
        .equ    MD_CMD_END, 24

        .macro  CD_VCOUNT
0:
        move.l  0x801C.w,d0
        cmp.l   0x801C.w,d0
        bne.b   0b
        .endm

        .macro  MD_VCOUNT
0:
        move.l  0xA1201C,d0
        cmp.l   0xA1201C,d0
        bne.b   0b
        .endm

        .text

        .align  2

|-----------------------------------------------------------------------
| Global functions
|-----------------------------------------------------------------------

| int init_cd(void);
        .global init_cd
init_cd:
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        lea     iso_pvd_magic,a5
        movea.l INIT_CD(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int read_cd(int lba, int len, void *buffer);
        .global read_cd
read_cd:
        move.l  4(sp),d0                /* lba */
        move.l  8(sp),d1                /* length */
        movea.l 12(sp),a0               /* buffer */
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l READ_CD(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int set_cwd(char *path);
        .global set_cwd
set_cwd:
        movea.l 4(sp),a0                /* path */
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l SET_CWD(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int first_dir_sec(void);
        .global first_dir_sec
first_dir_sec:
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l FIRST_DIR_SEC(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int next_dir_sec(void);
        .global next_dir_sec
next_dir_sec:
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l NEXT_DIR_SEC(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int find_dir_entry(char *name);
        .global find_dir_entry
find_dir_entry:
        movea.l 4(sp),a0
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l FIND_DIR_ENTRY(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int next_dir_entry(void)
        .global next_dir_entry
next_dir_entry:
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l NEXT_DIR_ENTRY(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int load_file(char *filename, void *buffer);
        .global load_file
load_file:
        movea.l 4(sp),a0                /* filename */
        movea.l 8(sp),a1                /* buffer */
        movem.l d2-d7/a2-a6,-(sp)
        movea.l global_vars,a6
        movea.l LOAD_FILE(a6),a2
        jsr     (a2)
        movem.l (sp)+,d2-d7/a2-a6
        rts

|-----------------------------------------------------------------------
| Cross console support
|-----------------------------------------------------------------------

sub_wait_done:
        moveq   #0,d0
        move.b  d0,0x800F.w             /* send md command ACK handshake (for MD_CMD_DMA_SCREEN) */
        move.w  #0xFFFF,d1
0:
        move.b  0x800E.w,d0
        bmi.b   1f                      /* MD resync request */
        dbeq    d1,0b                   /* wait on previous md command done */
        beq.b   2f
        /* timeout */
        moveq   #ERR_CMDDONE_TIMEOUT,d0
1:
        move.b  d0,0x800F.w             /* xcmd error */
2:
        rts

sub_wait_ack:
        move.w  #0xFFFF,d1
0:
        swap    d0
        move.b  0x800E.w,d0
        bmi.b   1f                      /* MD resync request */
        swap    d0
        cmp.b   0x800E.w,d0
        dbeq    d1,0b                   /* wait on previous md command done */
        beq.b   1f
        /* timeout */
        moveq   #ERR_CMDACK_TIMEOUT,d0
1:
        move.b  d0,0x800F.w             /* xcmd error */
2:
        rts

|-----------------------------------------------------------------------
| Cross console functions
|-----------------------------------------------------------------------

| int do_md_cmd0(int cmd);
        .global do_md_cmd0
do_md_cmd0:
        move.l  4(sp),d0
        bsr     send_md_cmd
        bpl     wait_md_cmd
        rts

| int do_md_cmd1(int cmd, int arg1);
        .global do_md_cmd1
do_md_cmd1:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        bsr     send_md_cmd
        bpl     wait_md_cmd
        rts

| int do_md_cmd2(int cmd, int arg1, int arg2);
        .global do_md_cmd2
do_md_cmd2:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        bsr     send_md_cmd
        bpl     wait_md_cmd
        rts

| int do_md_cmd3(int cmd, int arg1, int arg2, int arg3);
        .global do_md_cmd3
do_md_cmd3:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        move.l  16(sp),0x8028.w
        bsr     send_md_cmd
        bpl     wait_md_cmd
        rts

| int do_md_cmd4(int cmd, int arg1, int arg2, int arg3, int arg4);
        .global do_md_cmd4
do_md_cmd4:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        move.l  16(sp),0x8028.w
        move.l  20(sp),0x802C.w
        bsr     send_md_cmd
        bpl     wait_md_cmd
        rts

| void send_md_cmd0(int cmd);
        .global send_md_cmd0
send_md_cmd0:
        move.l  4(sp),d0
        bra.b   send_md_cmd

| void send_md_cmd1(int cmd, int arg1);
        .global send_md_cmd1
send_md_cmd1:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        bra.b   send_md_cmd

| void send_md_cmd2(int cmd, int arg1, int arg2);
        .global send_md_cmd2
send_md_cmd2:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        bra.b   send_md_cmd

| void send_md_cmd3(int cmd, int arg1, int arg2, int arg3);
        .global send_md_cmd3
send_md_cmd3:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        move.l  16(sp),0x8028.w
        bra.b   send_md_cmd

| void send_md_cmd4(int cmd, int arg1, int arg2, int arg3, int arg4);
        .global send_md_cmd4
send_md_cmd4:
        move.l  4(sp),d0
        move.l  8(sp),0x8020.w
        move.l  12(sp),0x8024.w
        move.l  16(sp),0x8028.w
        move.l  20(sp),0x802C.w

send_md_cmd:
        move.w  d0,-(sp)

        /* wait on previous md command done */
        bsr     sub_wait_done
        bmi.b   2f                      /* error - resync */

        move.w  (sp)+,d0
        move.b  d0,0x800F.w             /* send md command */

        /* wait on md command ACK */
        bsr     sub_wait_ack
        bmi.b   1f                      /* error - resync */

        cmpi.b  #MD_CMD_DMA_SCREEN,d0
        beq.b   1f                      /* no immediate command ACK handshake on MD_CMD_DMA_SCREEN! */
        move.b  #0,0x800F.w             /* send md command ACK handshake */
1:
        rts
2:
        addq.l  #2,sp
        rts

| int wait_md_cmd(void);
        .global wait_md_cmd
wait_md_cmd:
        bsr     sub_wait_done
        bmi.b   0f                      /* error */
        move.l  0x8010.w,d0             /* return value */
0:
        rts

| void switch_banks(void);
| Switch 1M Banks
        .global switch_banks
switch_banks:
        bchg    #0,0x8003.w             /* switch banks */
0:
        btst    #1,0x8003.w
        bne.b   0b                      /* bank switch not finished */
        rts

| void sub_delay(int count);
| wait count number of vertical blank periods - relies on vblank running
| entry: arg = count
        .global sub_delay
sub_delay:
        move.l  4(sp),d1                /* count */
        CD_VCOUNT
        add.l   d0,d1                   /* add current vblank count */
1:
        CD_VCOUNT
        cmp.l   d0,d1
        bgt.b   1b
        rts

| Initialize the SCD hardware & MD code and hardware (called from crt0)
        .global init_hardware
init_hardware:
| init any SCD hardware here

| copy MD code to Word RAM and signal MD side
        lea     md_init_start(pc),a0
        lea     0x080000,a1             /* word ram in 2M mode */
        lea     md_init_end(pc),a2
1:
        move.l  (a0)+,(a1)+
        cmpa.l  a0,a2
        bhi.b   1b
        bset    #0,0x8003.w             /* give Main-CPU Word RAM */

        move.b  #'M,0x800F.w            /* send MD Code command to MD */
2:
        cmpi.b  #'M,0x800E.w            /* wait for command ACK */
        bne.b   2b
        move.b  #0,0x800F.w             /* send command ACK handshake */
3:
        tst.b   0x800E.w
        bne.b   3b                      /* wait on command done */

        bset    #2,0x8003.w             /* switch to 1M mode */

        jsr     0x5F3A.w                /* SPNull - returns boot loader globals */
        move.l  d0,global_vars

        move    #0x2000,sr              /* allow interrupts */
        rts


|-----------------------------------------------------------------------|
|                           Main-CPU code                               |
|-----------------------------------------------------------------------|

| Copied to Word RAM for MD to execute
        .align  4
md_init_start:
        move.b  #'M,0xA1200E            /* md code command ACK */

        lea     md_start(pc),a0
        lea     0xFF1000,a1
        lea     md_init_end(pc),a2
1:
        move.l  (a0)+,(a1)+
        cmpa.l  a0,a2
        bhi.b   1b
        jmp     0xFF1000

        .align  4
md_start:
        move.l  #0,0xA12010
        move.l  #0,0xA12014
        move.l  #0,0xA12018
        move.l  #0,0xA1201C
        moveq   #0,d7                   /* 32X not initialized */
        bsr.w   md_init_hw
cmd_done:
        tst.b   0xA1200F
        bmi.b   1f                      /* error - resync */
        bne.b   cmd_done                /* wait on ACK handshake */
1:
        move.b  #0,0xA1200E             /* command done */

        /* main loop */
        moveq   #0,d0
cmd_loop:
        tst.b   d7
        beq.b   md_check                /* 32X not initialized */
        move.w  0xA15120,d0
        beq.b   md_check

        /* handle 32X command */
        cmpi.w  #1,d0
        beq.b   md_check                /* copy data to 32X */


| unknown command

mars_done:
        moveq   #0,d0
        move.w  d0,0xA15120             /* command done */
md_check:
        move.b  0xA1200F,d0
        beq.b   cmd_loop
        bmi.b   cmd_done                /* error - resync */

        move.b  d0,0xA1200E             /* command ack */

        /* push args on stack */
        move.l  0xA1202C,-(sp)
        move.l  0xA12028,-(sp)
        move.l  0xA12024,-(sp)
        move.l  0xA12020,-(sp)

        cmpi.b  #'M,d0
        bne.b   2f
1:
        btst    #0,0xA12003            /* Main-CPU has Word RAM? */
        beq.b   1b
        jmp     0x200000
2:
        cmpi.b  #'I,d0
        bne.b   3f
        bset    #1,0xA12003             /* give Sub-CPU Word RAM */
        bra.b   4f
3:
        move.l  #ERR_UNKNOWN_CMD,0xA12010
        cmpi.b  #MD_CMD_END,d0
        bhs.b   4f                      /* unknown command */
        add.w   d0,d0
        lea     cmd_table(pc),a0
        move.w  0(a0,d0.w),d0
        jsr     0(a0,d0.w)
        move.l  d0,0xA12010             /* return value */
4:
        lea     16(sp),sp
        bra     cmd_done

cmd_table:
        .word   cmd_done - cmd_table    /* 0 - not really a command */
        .word   md_init_hw - cmd_table
        .word   set_sr - cmd_table
        .word   get_pad - cmd_table
        .word   clear_b - cmd_table
        .word   set_vram - cmd_table
        .word   next_vram - cmd_table
        .word   copy_vram - cmd_table
        .word   clear_a - cmd_table
        .word   put_str - cmd_table
        .word   put_chr - cmd_table
        .word   delay - cmd_table
        .word   set_palette - cmd_table
        .word   z80_busrequest - cmd_table
        .word   z80_reset - cmd_table
        .word   z80_memclr - cmd_table
        .word   z80_memcpy - cmd_table
        .word   dma_screen - cmd_table
        .word   init_32x - cmd_table
        .word   get_comm32x - cmd_table
        .word   set_comm32x - cmd_table
        .word   dma_to_32x - cmd_table
        .word   cpy_to_32x - cmd_table
        .word   md_memcpy - cmd_table

| void md_init_hw(void);
| initialize MD hardware
md_init_hw:
        movem.l d2-d7/a2-a5,-(sp)
        move.w  #0x2700,sr              /* disallow interrupts */

| init joyports
        lea     0xA10000,a5
        move.b  #0x40,0x09(a5)
        move.b  #0x40,0x0B(a5)
        move.b  #0x40,0x03(a5)
        move.b  #0x40,0x05(a5)

        lea     0xC00000,a3             /* VDP data reg */
        lea     0xC00004,a4             /* VDP cmd/sts reg */

| wait on VDP DMA (in case we reset in the middle of DMA)
        move.w  #0x8114,(a4)            /* display off, dma enabled */
0:
        move.w  (a4),d0                 /* read VDP status */
        btst    #1,d0                   /* DMA busy? */
        bne.b   0b                      /* yes */

        moveq   #0,d0
        move.w  #0x8000,d5              /* set VDP register 0 */
        move.w  #0x0100,d7

| Set VDP registers
        lea     InitVDPRegs(pc),a5
        moveq   #18,d1
1:
        move.b  (a5)+,d5                /* lower byte = register data */
        move.w  d5,(a4)                 /* set VDP register */
        add.w   d7,d5                   /* + 0x0100 = next register */
        dbra    d1,1b

| clear VRAM
        move.w  #0x8F02,(a4)            /* set INC to 2 */
        move.l  #0x40000000,(a4)        /* write VRAM address 0 */
        move.w  #0x7FFF,d1              /* 32K - 1 words */
2:
        move.w  d0,(a3)                 /* clear VRAM */
        dbra    d1,2b

| The VDP state at this point is: Display disabled, ints disabled, Name Tbl A at 0xC000,
| Name Tbl B at 0xE000, Name Tbl W at 0xB000, Sprite Attr Tbl at 0xA800, HScroll Tbl at 0xAC00,
| H40 V28 mode, and Scroll size is 64x32.

| Clear CRAM
        lea     InitVDPRAM(pc),a5
        move.l  (a5)+,(a4)              /* set reg 1 and reg 15 */
        move.l  (a5)+,(a4)              /* write CRAM address 0 */
        moveq   #31,d3
3:
        move.l  d0,(a3)
        dbra    d3,3b

| Clear VSRAM
        move.l  (a5)+,(a4)              /* write VSRAM address 0 */
        moveq   #19,d4
4:
        move.l  d0,(a3)
        dbra    d4,4b

| halt Z80 and init FM chip
        /* Allow the 68k to access the FM chip */
        move.w  #0x100,0xA11100
        move.w  #0x100,0xA11200

| reset YM2612
        lea     FMReset(pc),a5
        lea     0xA00000,a0
        move.w  #0x4000,d1
        moveq   #26,d2
5:
        move.b  (a5)+,d1                /* FM reg */
        move.b  (a5)+,0(a0,d1.w)        /* FM data */
        nop
        nop
        dbra    d2,5b

        moveq   #0x30,d0
        moveq   #0x5F,d2
6:
        move.b  d0,0x4000(a0)           /* FM reg */
        nop
        nop
        move.b  #0xFF,0x4001(a0)        /* FM data */
        nop
        nop
        move.b  d0,0x4002(a0)           /* FM reg */
        nop
        nop
        move.b  #0xFF,0x4003(a0)        /* FM data */
        nop
        nop
        addq.b  #1,d0
        dbra    d2,6b

| reset PSG
        lea     PSGReset(pc),a5
        lea     0xC00000,a0
        move.b  (a5)+,0x0011(a0)
        move.b  (a5)+,0x0011(a0)
        move.b  (a5)+,0x0011(a0)
        move.b  (a5),0x0011(a0)

| load font tile data
        move.w  #0x8F02,(a4)            /* INC = 2 */
        move.l  #0x40000000,(a4)        /* write VRAM address 0 */
        lea     font_data(pc),a0
        move.w  #0x6B*8-1,d2
7:
        move.l  (a0)+,d0                /* font fg mask */
        move.l  d0,d1
        not.l   d1                      /* font bg mask */
        andi.l  #0x11111111,d0          /* set font fg color */
        andi.l  #0x00000000,d1          /* set font bg color */
        or.l    d1,d0
        move.l  d0,(a3)                 /* set tile line */
        dbra    d2,7b

| set the default palette for text
        move.l  #0xC0000000,(a4)        /* write CRAM address 0 */
        move.l  #0x00000CCC,(a3)        /* entry 0 (black) and 1 (lt gray) */
        move.l  #0xC0200000,(a4)        /* write CRAM address 32 */
        move.l  #0x000000A0,(a3)        /* entry 16 (black) and 17 (green) */
        move.l  #0xC0400000,(a4)        /* write CRAM address 64 */
        move.l  #0x0000000A,(a3)        /* entry 32 (black) and 33 (red) */

        lea     vblank_int(pc),a0
        move.l  a0,0xFFFD08             /* set level 6 int vector */

        move.w  #0x8174,(a4)            /* display on, vblank enabled */
        movem.l (sp)+,d2-d7/a2-a5
        move    #0x2000,sr              /* allow interrupts */
        rts

| VDP register initialization values
InitVDPRegs:
        .byte   0x04    /* 8004 => write reg 0 = /IE1 (no HBL INT), /M3 (enable read H/V cnt) */
        .byte   0x14    /* 8114 => write reg 1 = /DISP (display off), /IE0 (no VBL INT), M1 (DMA enabled), /M2 (V28 mode) */
        .byte   0x30    /* 8230 => write reg 2 = Name Tbl A = 0xC000 */
        .byte   0x2C    /* 832C => write reg 3 = Name Tbl W = 0xB000 */
        .byte   0x07    /* 8407 => write reg 4 = Name Tbl B = 0xE000 */
        .byte   0x54    /* 8554 => write reg 5 = Sprite Attr Tbl = 0xA800 */
        .byte   0x00    /* 8600 => write reg 6 = always 0 */
        .byte   0x00    /* 8700 => write reg 7 = BG color */
        .byte   0x00    /* 8800 => write reg 8 = always 0 */
        .byte   0x00    /* 8900 => write reg 9 = always 0 */
        .byte   0x00    /* 8A00 => write reg 10 = HINT = 0 */
        .byte   0x00    /* 8B00 => write reg 11 = /IE2 (no EXT INT), full scroll */
        .byte   0x81    /* 8C81 => write reg 12 = H40 mode, no lace, no shadow/hilite */
        .byte   0x2B    /* 8D2B => write reg 13 = HScroll Tbl = 0xAC00 */
        .byte   0x00    /* 8E00 => write reg 14 = always 0 */
        .byte   0x01    /* 8F01 => write reg 15 = data INC = 1 */
        .byte   0x01    /* 9001 => write reg 16 = Scroll Size = 64x32 */
        .byte   0x00    /* 9100 => write reg 17 = W Pos H = left */
        .byte   0x00    /* 9200 => write reg 18 = W Pos V = top */

        .align  2

| VDP Commands
InitVDPRAM:
        .word   0x8104, 0x8F01  /* set registers 1 (display off) and 15 (INC = 1) */
        .word   0xC000, 0x0000  /* write CRAM address 0 */
        .word   0x4000, 0x0010  /* write VSRAM address 0 */

FMReset:
        /* disable LFO */
        .byte   0,0x22
        .byte   1,0x00
        /* disable timer & set channel 6 to normal mode */
        .byte   0,0x27
        .byte   1,0x00
        /* all KEY_OFF */
        .byte   0,0x28
        .byte   1,0x00
        .byte   1,0x04
        .byte   1,0x01
        .byte   1,0x05
        .byte   1,0x02
        .byte   1,0x06
        /* disable DAC */
        .byte   0,0x2A
        .byte   1,0x80
        .byte   0,0x2B
        .byte   1,0x00
        /* turn off channels */
        .byte   0,0xB4
        .byte   1,0x00
        .byte   0,0xB5
        .byte   1,0x00
        .byte   0,0xB6
        .byte   1,0x00
        .byte   2,0xB4
        .byte   3,0x00
        .byte   2,0xB5
        .byte   3,0x00
        .byte   2,0xB6
        .byte   3,0x00

| PSG register initialization values
PSGReset:
        .byte   0x9f    /* set ch0 attenuation to max */
        .byte   0xbf    /* set ch1 attenuation to max */
        .byte   0xdf    /* set ch2 attenuation to max */
        .byte   0xff    /* set ch3 attenuation to max */

        .align  4

        .include "font.s"

        .align  4

| short set_sr(short new_sr);
| set SR, return previous SR
| entry: arg = SR value
| exit:  d0 = previous SR value
set_sr:
        moveq   #0,d0
        move.w  sr,d0
        move.l  4(sp),d1
        move.w  d1,sr
        rts

| short get_pad(short pad);
| return buttons for selected pad
| entry: arg = pad index (0 or 1)
| exit:  d0 = pad value (0 0 0 1 M X Y Z S A C B R L D U) or (0 0 0 0 0 0 0 0 S A C B R L D U)
get_pad:
        move.l  d2,-(sp)
        move.l  8(sp),d0        /* first arg is pad number */
        cmpi.w  #1,d0
        bhi     no_pad
        add.w   d0,d0
        addi.l  #0xA10003,d0    /* pad control register */
        movea.l d0,a0
        bsr.b   get_input       /* - 0 s a 0 0 d u - 1 c b r l d u */
        move.w  d0,d1
        andi.w  #0x0C00,d0
        bne.b   no_pad
        bsr.b   get_input       /* - 0 s a 0 0 d u - 1 c b r l d u */
        bsr.b   get_input       /* - 0 s a 0 0 0 0 - 1 c b m x y z */
        move.w  d0,d2
        bsr.b   get_input       /* - 0 s a 1 1 1 1 - 1 c b r l d u */
        andi.w  #0x0F00,d0      /* 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 */
        cmpi.w  #0x0F00,d0
        beq.b   common          /* six button pad */
        move.w  #0x010F,d2      /* three button pad */
common:
        lsl.b   #4,d2           /* - 0 s a 0 0 0 0 m x y z 0 0 0 0 */
        lsl.w   #4,d2           /* 0 0 0 0 m x y z 0 0 0 0 0 0 0 0 */
        andi.w  #0x303F,d1      /* 0 0 s a 0 0 0 0 0 0 c b r l d u */
        move.b  d1,d2           /* 0 0 0 0 m x y z 0 0 c b r l d u */
        lsr.w   #6,d1           /* 0 0 0 0 0 0 0 0 s a 0 0 0 0 0 0 */
        or.w    d1,d2           /* 0 0 0 0 m x y z s a c b r l d u */
        eori.w  #0x1FFF,d2      /* 0 0 0 1 M X Y Z S A C B R L D U */
        move.w  d2,d0
        move.l  (sp)+,d2
        rts

| 3-button/6-button pad not found
no_pad:
        .ifdef  HAS_SMS_PAD
        move.b  (a0),d0         /* - 1 c b r l d u */
        andi.w  #0x003F,d0      /* 0 0 0 0 0 0 0 0 0 0 c b r l d u */
        eori.w  #0x003F,d0      /* 0 0 0 0 0 0 0 0 0 0 C B R L D U */
        .else
        move.w  #0xF000,d0      /* SEGA_CTRL_NONE */
        .endif
        move.l  (sp)+,d2
        rts

| read single phase from controller
get_input:
        move.b  #0x00,(a0)
        nop
        nop
        move.b  (a0),d0
        move.b  #0x40,(a0)
        lsl.w   #8,d0
        move.b  (a0),d0
        rts

| void clear_b(void);
| clear the name table for plane B
clear_b:
        moveq   #0,d0
        lea     0xC00000,a0
        move.w  #0x8F02,4(a0)           /* set INC to 2 */
        move.l  #0x60000003,d1          /* VDP write VRAM at 0xE000 (scroll plane B) */
        move.l  d1,4(a0)                /* write VRAM at plane B start */
        move.w  #64*32-1,d1
1:
        move.w  d0,(a0)                 /* clear name pattern */
        dbra    d1,1b
        rts

| void set_vram(int offset, int val);
| store word to vram at offset
| entry: first arg = offset in vram
|        second arg = word to store
set_vram:
        lea     0xC00000,a1
        move.w  #0x8F02,4(a1)           /* set INC to 2 */
        move.l  4(sp),d1                /* vram offset */
        lsl.l   #2,d1
        lsr.w   #2,d1
        swap    d1
        ori.l   #0x40000000,d1          /* VDP write VRAM */
        move.l  d1,4(a1)                /* write VRAM at offset*/
        move.l  8(sp),d0                /* data word */
        move.w  d0,(a1)                 /* set vram word */
        rts

| void next_vram(int val);
| store word to vram at next offset
| entry: first arg = word to store
next_vram:
        move.l  4(sp),d0                /* data word */
        move.w  d0,0xC00000             /* set vram word */
        rts

| void copy_vram(int offset, void *src, int len);
| store word to vram at offset
| entry: first arg = offset in vram
|        second arg = address of data to copy
|        third arg = length of data to copy (in words)
copy_vram:
        lea     0xC00000,a1
        move.w  #0x8F02,4(a1)           /* set INC to 2 */
        move.l  4(sp),d1                /* vram offset */
        lsl.l   #2,d1
        lsr.w   #2,d1
        swap    d1
        ori.l   #0x40000000,d1          /* VDP write VRAM */
        move.l  d1,4(a1)                /* write VRAM at offset*/
        movea.l 8(sp),a0                /* source pointer */
        move.l  12(sp),d0               /* length in words */
        subq.w  #1,d0
0:
        move.w  (a0)+,(a1)              /* set vram word */
        dbra    d0,0b
        rts

| void clear_a(void);
| clear the name table for plane A
clear_a:
        moveq   #0,d0
        lea     0xC00000,a0
        move.w  #0x8F02,4(a0)           /* set INC to 2 */
        move.l  #0x40000003,d1          /* VDP write VRAM at 0xC000 (scroll plane A) */
        move.l  d1,4(a0)                /* write VRAM at plane A start */
        move.w  #64*32-1,d1
1:
        move.w  d0,(a0)                 /* clear name pattern */
        dbra    d1,1b
        rts

| void put_str(char *str, int color, int x, int y);
| put string characters to the screen
| entry: first arg = string address
|        second arg = 0 for normal color font, N * 0x0200 for alternate color font (use CP bits for different colors)
|        third arg = column at which to start printing
|        fourth arg = row at which to start printing
put_str:
        movea.l 4(sp),a0                /* string pointer */
        move.l  8(sp),d0                /* color palette */
        lea     0xC00000,a1
        move.w  #0x8F02,4(a1)           /* set INC to 2 */
        move.l  16(sp),d1               /* y coord */
        lsl.l   #6,d1
        or.l    12(sp),d1               /* cursor y<<6 | x */
        add.w   d1,d1                   /* pattern names are words */
        swap    d1
        ori.l   #0x40000003,d1          /* OR cursor with VDP write VRAM at 0xC000 (scroll plane A) */
        move.l  d1,4(a1)                /* write VRAM at location of cursor in plane A */
1:
        move.b  (a0)+,d0
        subi.b  #0x20,d0                /* font starts at space */
        move.w  d0,(a1)                 /* set pattern name for character */
        tst.b   (a0)
        bne.b   1b
        rts

| void put_chr(char chr, int color, int x, int y);
| put a character to the screen
| entry: first arg = character
|        second arg = 0 for normal color font, N * 0x0200 for alternate color font (use CP bits for different colors)
|        third arg = column at which to start printing
|        fourth arg = row at which to start printing
put_chr:
        movea.l 4(sp),a0                /* character */
        move.l  8(sp),d0                /* color palette */
        lea     0xC00000,a1
        move.w  #0x8F02,4(a1)           /* set INC to 2 */
        move.l  16(sp),d1               /* y coord */
        lsl.l   #6,d1
        or.l    12(sp),d1               /* cursor y<<6 | x */
        add.w   d1,d1                   /* pattern names are words */
        swap    d1
        ori.l   #0x40000003,d1          /* OR cursor with VDP write VRAM at 0xC000 (scroll plane A) */
        move.l  d1,4(a1)                /* write VRAM at location of cursor in plane A */

        move.l  a0,d1
        move.b  d1,d0
        subi.b  #0x20,d0                /* font starts at space */
        move.w  d0,(a1)                 /* set pattern name for character */
        rts

| void delay(int count);
| wait count number of vertical blank periods - relies on vblank running
| entry: arg = count
delay:
        move.l  4(sp),d1                /* count */
        MD_VCOUNT
        add.l   d0,d1                   /* add current vblank count */
1:
        MD_VCOUNT
        cmp.l   d0,d1
        bgt.b   1b
        rts

| void set_palette(short *pal, int start, int count)
| copy count entries pointed to by pal into the palette starting at the index start
| entry: pal = pointer to an array of words holding the colors
|        start = index of the first color in the palette to set
|        count = number of colors to copy
set_palette:
        movea.l 4(sp),a0                /* pal */
        move.l  8(sp),d0                /* start */
        move.l  12(sp),d1               /* count */
        add.w   d0,d0                   /* start*2 */
        swap    d0                      /* high word holds address */
        ori.l   #0xC0000000,d0          /* write CRAM address (0 + index*2) */
        subq.w  #1,d1                   /* for dbra */

        lea     0xC00000,a1
        move.w  #0x8F02,4(a1)           /* set INC to 2 */
        move.l  d0,4(a1)                /* write CRAM */
0:
        move.w  (a0)+,(a1)              /* copy color to palette */
        dbra    d1,0b
        rts

| void z80_busrequest(int flag)
| set Z80 bus request
| entry: flag = request/release
z80_busrequest:
        move.l  4(sp),d0                /* flag */
        andi.w  #0x0100,d0
        move.w  d0,0xA11100             /* set bus request */
0:
        move.w  0xA11100,d1
        and.w   d0,d1
        bne.b   0b
        rts

| void z80_reset(int flag)
| set Z80 reset
| entry: flag = assert/clear
z80_reset:
        move.l  4(sp),d0                /* flag */
        andi.w  #0x0100,d0
        move.w  d0,0xA11200             /* set reset */
        rts

| void z80_memclr(void *dst, int len)
| clear Z80 sram
| entry: dst = pointer to sram to clear
|        len = length of memory to copy
| note: you need to request the Z80 bus first
z80_memclr:
        movea.l 4(sp),a1                /* dst */
        move.l  8(sp),d0                /* len */
        subq.w  #1,d0
        moveq   #0,d1
0:
        move.b  d1,(a1)+
        dbra    d0,0b
        rts

| void z80_memcpy(void *dst, void *src, int len)
| copy memory to Z80 sram
| entry: dst = pointer to memory to copy to
|        src = pointer to memory to copy from
|        len = length of memory to copy
| note: you need to request the Z80 bus first
z80_memcpy:
        movea.l 4(sp),a1                /* dst */
        movea.l 8(sp),a0                /* src */
        move.l  12(sp),d0               /* len */
        subq.w  #1,d0
0:
        move.b  (a0)+,d1
        move.b  d1,(a1)+
        dbra    d0,0b
        rts

| void dma_screen(unsigned short *buffer, int wide);
| dma buffer to background cmap entry
dma_screen:
        move.l  4(sp),d0                /* buffer */
        move.l  8(sp),d1                /* wide flag */
        movem.l d2-d7/a2-a6,-(sp)
        move.w  #0x2700,sr              /* disallow interrupts */

        /* VDP commands for DMA  */
        move.l  #0x93E0948C,d2          /* DMALEN LO/HI = 0x8CE0 (161*224) */
        tst.b   d1
        beq.b   0f                      /* narrow screen */
        /* wide screen */
        move.l  #0x934094AD,d2          /* DMALEN LO/HI = 0xAD40 (198*224) */
0:
        move.l  #0x96009500,d3
        lsr.l   #1,d0                   /* word bus */
        move.b  d0,d3                   /* LOW address */
        swap    d3
        lsr.l   #8,d0
        move.b  d0,d3                   /* MID address */
        move.l  #0x81149700,d4
        lsr.l   #8,d0
        andi.w  #0x007F,d0
        move.b  d0,d4                   /* HI address and dma mode */
        swap    d4
        move.l  #0xC0000080,d5          /* dest = write cram => start DMA */

        /* clear palette */
        moveq   #0,d0
        lea     0xC00000,a2
        lea     0xC00004,a3
        moveq   #31,d1
        move.l  #0xC0000000,(a3)        /* write CRAM address 0 */
1:
        move.l  d0,(a2)                 /* clear palette */
        dbra    d1,1b

        /* init VDP regs */
        move.w  #0x8F00,(a3)            /*  clear INC register */
        cmpi.l  #0x934094AD,d2
        beq.b   dma_wide                /* wide screen display loop */
        move.w  #0x8C00,(a3)            /* H32 mode, no lace, no shadow/hilite */
        bra.w   dma_narrow              /* narrow screen display loop */

        /* loop - turn on display and wait for vblank */
dma_wide:
        moveq   #0,d0
        move.w  #0x8154,(a3)            /* turn on display (no VB int, V28 mode) */
        move.l  #0x40000000,(a3)        /* write vram address 0 */
1:
        btst    #3,1(a3)
        beq.b   1b                      /* wait for VB */
2:
        btst    #3,1(a3)
        bne.b   2b                      /* wait for not VB */

        move.l  d0,(a2)
        move.l  d0,(a2)
        move.l  d0,(a2)
        move.l  d0,(a2)
        move.l  d0,(a2)
        move.l  d0,(a2)
        move.w  d0,(a2)

        nop
        nop
        nop
        nop

        /* Execute DMA */
        nop
        nop
        move.l  d2,(a3)                 /* DMALEN LO/HI */
        nop
        nop
        move.l  d3,(a3)                 /* DMA SRC LO/MID */
        nop
        nop
        move.l  d4,(a3)                 /* DMA SRC HI/MODE, Turn off Display */
        nop
        nop
        move.l  d5,(a3)                 /* start DMA */
        /* CPU is halted until DMA is complete */

        /* display finished, check request switch ram banks */
        btst    #7,0xA1200F
        beq.b   4f
        nop
        bset    #1,0xA12003             /* request switch ram banks */
        nop
3:
        btst    #1,0xA12003
        bne.b   3b                      /* wait for bank switch */
4:
        /* do other tasks here */
        pea     0.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA12018

        pea     1.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA1201A

        move.l  0xA1201C,d0
        addq.l  #1,d0
        move.l  d0,0xA1201C             /* increment ticks */

        move.w  0xA12000,d0
        ori.w   #0x0100,d0
        move.w  d0,0xA12000             /* generate level 2 int for CD */

        moveq   #0x7F,d0
        and.b   0xA1200F,d0
        cmpi.b  #MD_CMD_DMA_SCREEN,d0
        bne.b   exit_wide                /* no longer requesting DMA color display */
        bra.w   dma_wide
exit_wide:
        bsr.w   md_init_hw
        movem.l (sp)+,d2-d7/a2-a6
        rts

        /* loop - turn on display and wait for vblank */
dma_narrow:
        moveq   #0,d0
        move.w  #0x8154,(a3)            /* turn on display (no VB int, V28 mode) */
        move.l  #0x40000000,(a3)        /* write vram address 0 */
1:
        btst    #3,1(a3)
        beq.b   1b                      /* wait for VB */
2:
        btst    #3,1(a3)
        bne.b   2b                      /* wait for not VB */

        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)
        move.w  d0,(a2)

        nop
        nop
        nop
        nop

        /* Execute DMA */
        nop
        nop
        move.l  d2,(a3)                 /* DMALEN LO/HI */
        nop
        nop
        move.l  d3,(a3)                 /* DMA SRC LO/MID */
        nop
        nop
        move.l  d4,(a3)                 /* DMA SRC HI/MODE, Turn off Display */
        nop
        nop
        move.l  d5,(a3)                 /* start DMA */
        /* CPU is halted until DMA is complete */

        /* display finished, check request switch ram banks */
        btst    #7,0xA1200F
        beq.b   4f
        nop
        bset    #1,0xA12003             /* request switch ram banks */
        nop
3:
        btst    #1,0xA12003
        bne.b   3b                      /* wait for bank switch */
4:
        /* do other tasks here */
        pea     0.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA12018

        pea     1.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA1201A

        move.l  0xA1201C,d0
        addq.l  #1,d0
        move.l  d0,0xA1201C             /* increment ticks */

        move.w  0xA12000,d0
        ori.w   #0x0100,d0
        move.w  d0,0xA12000             /* generate level 2 int for CD */

        moveq   #0x7F,d0
        and.b   0xA1200F,d0
        cmpi.b  #MD_CMD_DMA_SCREEN,d0
        bne.b   exit_narrow             /* no longer requesting DMA color display */
        bra.w   dma_narrow
exit_narrow:
        bsr.w   md_init_hw
        movem.l (sp)+,d2-d7/a2-a6
        rts

| int init_32x(void *data, int length);
| init 32x, return status
| entry: arg1 = 32X code/data (in word ram), arg2 = length of data
| exit:  d0 = status
init_32x:
        move.l  0xA130EC,d0
        cmpi.l  #0x4D415253,d0          /* 'MARS' */
        beq.b   0f
        moveq   #-2,d0                  /* no 32X detected */
        rts
0:
        move.w  #0x2700,sr              /* disable ints */
        lea     0xA15000,a0
        move.b  #1,0x0101(a0)           /* activate 32X, assert SH2 RESET */

        /* wait 10ms for 32X */
        move.w  #19170,d1
1:
        dbra    d1,1b

        moveq   #0,d0
        move.l  d0,0x0120(a0)           /* clear COMM0 */
        move.l  d0,0x0124(a0)           /* clear COMM4 */
        move.b  #3,0x0101(a0)           /* deassert SH2 RESET */
2:
        bclr    #7,0x0100(a0)           /* get access to 32X VDP resources */
        bne.b   2b
        move.w  d0,0x0102(a0)           /* clear interrupt reg */
        move.w  d0,0x0104(a0)           /* clear bank reg */
        move.w  d0,0x0106(a0)           /* clear dreq control reg */
        move.l  d0,0x0108(a0)           /* clear dreq src reg */
        move.l  d0,0x010C(a0)           /* clear dreq dst reg */
        move.w  d0,0x0110(a0)           /* clear dreq length reg */
        move.w  d0,0x0130(a0)           /* clear pwm control reg */
        move.w  d0,0x0132(a0)           /* clear pwm cycle reg */
        move.w  d0,0x0138(a0)           /* clear pwm mono reg */
        move.w  d0,0x0180(a0)           /* clear vdp mode reg */
        move.w  d0,0x0182(a0)           /* clear vdp shift reg */
3:
        bclr    #0,0x018B(a0)           /* switch to frame 0 */
        bne.b   3b
        moveq   #-1,d1
        lea     0x840000,a1             /* frame buffer */
4:
        move.w  d0,(a1)+                /* clear frame buffer */
        dbra    d1,4b
5:
        bset    #0,0x018B(a0)           /* switch to frame 1 */
        beq.b   5b
        moveq   #-1,d1
        lea     0x840000,a1             /* frame buffer */
6:
        move.w  d0,(a1)+                /* clear frame buffer */
        dbra    d1,6b

        moveq   #0x7F,d1
        lea     0xA15200,a1             /* palette cram */
7:
        move.l  d0,(a1)+                /* clear palette */
        dbra    d1,7b

        move.l  0x0120(a0),d0           /* check Master SH2 */
        cmpi.l  #0x53444552,d0          /* 'SDER' */
        bne.b   8f
        move.w  #0x2000,sr              /* enable ints */
        moveq   #-3,d0                  /* sdram error */
        rts
8:
        /* 32X initialized and ready, copy data/code to frame buffer */
        movea.l 4(sp),a0                /* data/code */
        move.l  8(sp),d0                /* length */
        lea     0x840000,a1             /* frame buffer */
9:
        move.l  (a0)+,(a1)+
        subq.l  #4,d0
        bgt.b   9b

        lea     0xA15000,a0
        move.l  #0x5F43445F,0x0120(a0)  /* Master SH2 CD handshake '_CD_' */

0:
        move.l  0x0120(a0),d0
        cmpi.l  #0x4D5F4F4B,d0          /* 'M_OK' */
        bne.b   0b
1:
        move.l  0x0124(a0),d0
        cmpi.l  #0x535F4F4B,d0          /* 'S_OK' */
        bne.b   1b

        moveq   #1,d7                   /* 32X initialized */
        moveq   #0,d0
        move.l  d0,0x0120(a0)           /* start Master SH2 (which should start Slave SH2) */

        move.w  #0x2000,sr              /* enable ints */
        rts

| int get_comm32x(int offs, int len);
| return communications register value of len at offset offs
| entry: arg1 = offset from 0xA15120, arg2 = length of data (2 or 4 only)
| exit:  d0 = communications register value or -1 (error)
get_comm32x:
        tst.b   d7
        bne.b   0f
        moveq   #-1,d0                  /* 32X not initialized */
        rts
0:
        move.l  8(sp),d1                /* length */
        cmpi.w  #2,d1
        beq.b   2f
        cmpi.w  #4,d1
        beq.b   4f
        moveq   #-1,d0                  /* bad parameter */
        rts
2:
        move.l  4(sp),d1                /* offset */
        moveq   #0,d0
        lea     0xA15120,a0             /* COMM0 */
        move.w  0(a0,d1.w),d0
        rts
4:
        move.l  4(sp),d1                /* offset */
        lea     0xA15120,a0             /* COMM0 */
        move.l  0(a0,d1.w),d0
        rts

| int set_comm32x(int offs, int len, int val);
| set communications register value of len at offset offs
| entry: arg1 = offset from 0xA15120, arg2 = length of data (2 or 4 only), arg3 = value
| exit:  d0 = 0 (okay) or -1 (error)
set_comm32x:
        tst.b   d7
        bne.b   0f
        moveq   #-1,d0                  /* 32X not initialized */
        rts
0:
        moveq   #0,d0
        move.l  8(sp),d1                /* length */
        cmpi.w  #2,d1
        beq.b   2f
        cmpi.w  #4,d1
        beq.b   4f
        moveq   #-1,d0                  /* bad parameter */
        rts
2:
        move.l  4(sp),d1                /* offset */
        lea     0xA15120,a0             /* COMM0 */
        move.w  14(sp),0(a0,d1.w)       /* val -> COMM0 + offset */
        rts
4:
        move.l  4(sp),d1                /* offset */
        lea     0xA15120,a0             /* COMM0 */
        move.l  12(sp),0(a0,d1.w)       /* val -> COMM0 + offset */
        rts

| int dma_to_32x(short *src, int len);
| DMA data from source to 32X
| entry: arg1 = source pointer, arg2 = length of data (in words)
| exit:  d0 = 0 (okay) or -1 (error) or -2 (DMA error)
dma_to_32x:
        tst.b   d7
        bne.b   0f
        moveq   #-1,d0                  /* 32X not initialized */
        rts
0:
        lea     0xA15000,a1
        move.b  #0x00,0x0107(a1)        /* clear 68S bit - stops SH DREQ */

        movea.l 4(sp),a0                /* source address */
        move.l  8(sp),d0                /* length in words */
        addq.l  #3,d0
        andi.w  #0xFFFC,d0              /* FIFO operates on units of four words */
        move.w  d0,0x0110(a1)           /* SH DREQ Length Reg */
        move.w  d0,0x0122(a1)           /* COMM2 = # words to dma */
        lsr.l   #2,d0
        subq.l  #1,d0                   /* for dbra */

        move.b  #0x04,0x0107(a1)        /* set 68S bit - starts SH DREQ */
        lea     0x0112(a1),a1
1:
        cmpi.w  #0x55AA,0xA15120        /* wait for SH2 to start DMA */
        bne.b   1b
2:
        move.w  (a0)+,(a1)              /* FIFO = next word */
        move.w  (a0)+,(a1)
        move.w  (a0)+,(a1)
        move.w  (a0)+,(a1)
3:
        btst    #7,0xA15107             /* check FIFO full flag */
        bne.b   3b
        dbra    d0,2b

        btst    #2,0xA15107
        bne.b   4f                      /* DMA not done? */
        moveq   #0,d0
        rts
4:
        moveq   #-2,d0
        rts

| int cpy_to_32x(short *src, int len);
| copy data from source to 32X through COMM registers
| entry: arg1 = source pointer, arg2 = length of data (in words)
| exit:  d0 = 0 (okay) or -1 (error)
cpy_to_32x:
        tst.b   d7
        bne.b   0f
        moveq   #-1,d0                  /* 32X not initialized */
        rts
0:
        movea.l 4(sp),a0                /* source pointer */
        move.l  8(sp),d0                /* length */
        subq.l  #1,d0                   /* for dbra */
1:
        move.w  (a0)+,0xA15122
        move.w  #3,0xA15120             /* xfer next word */
2:
        cmpi.w  #1,0xA15120
        bne.b   2b
        dbra    d0,1b

        move.w  #0xFFFF,0xA15120        /* xfer done */
3:
        cmpi.w  #0,0xA15120
        bne.b   3b

        moveq   #0,d0
        rts

| void md_memcpy(void *dst, void *src, int len)
| copy memory
| entry: dst = pointer to memory to copy to
|        src = pointer to memory to copy from
|        len = length of memory to copy
md_memcpy:
        movea.l 4(sp),a1                /* dst */
        movea.l 8(sp),a0                /* src */
        move.l  12(sp),d0               /* len */
0:
        move.b  (a0)+,d1
        move.b  d1,(a1)+
        subi.l  #1,d0
        bgt.b   0b
        moveq.l #0,d0
        rts

        .align  4

| Vertical blank handler
vblank_int:
        movem.l d0-d1/a0-a1,-(sp)

        pea     0.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA12018
        tst.b   d7
        beq.b   0f
        move.w  d0,0xA15128
0:
        pea     1.w
        bsr.w   get_pad
        addq.l  #4,sp
        move.w  d0,0xA1201A
        tst.b   d7
        beq.b   1f
        move.w  d0,0xA1512A
1:
        move.l  0xA1201C,d0
        addq.l  #1,d0
        move.l  d0,0xA1201C             /* increment ticks */
        tst.b   d7
        beq.b   2f
        move.l  d0,0xA1512C
2:
        move.w  0xA12000,d0
        ori.w   #0x0100,d0
        move.w  d0,0xA12000             /* generate level 2 int for CD */

        movem.l (sp)+,d0-d1/a0-a1
        rte

        .align  4
md_init_end:


        .data

        .align  4

        .global global_vars
global_vars:
        .long   0

iso_pvd_magic:
        .asciz  "\1CD001\1"

        .align  4

        .text
