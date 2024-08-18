#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hw_md.h"

#define MAX_ENTRIES 256

typedef struct
{
    int offset;
    int length;
    char flags;
    char name[247];
} entry_t;

entry_t gDirTable[MAX_ENTRIES];

short gCount = 0;
short gFirst = 0;
short gCurrent = 0;
short gStage = 0;

char *temp = (char *)0x0C0000;
char *rom_start = (void*)0x400000;

//----------------------------------------------------------------------

int getCurrDir(void)
{
    int r = 0;
    int i = 0;

    while (!r)
    {
        r = next_dir_entry();
        if (!r && memcmp(global_vars->DENTRY_NAME, ".", 2))
        {
            gDirTable[i].offset = global_vars->DENTRY_OFFSET;
            gDirTable[i].length = global_vars->DENTRY_LENGTH;
            gDirTable[i].flags = global_vars->DENTRY_FLAGS >> 8;
            strcpy(gDirTable[i].name, global_vars->DENTRY_NAME);
            i++;
        }

        if (r == ERR_NO_MORE_ENTRIES)
            r = next_dir_sec();
    }

    return i;
}

void transfer(char *temp)
{
    int i, j;
    int length;
    int block, offset;

    length = gDirTable[gCurrent].length;
    offset = gDirTable[gCurrent].offset;

    for (i = 0; i < length; )
    {
        int chunk = 0x20000;
        int m68kchunk = 0x4000;

        if (i + chunk > length)
            chunk = length - i;

        sprintf(temp, "Loading %08X-%08X\n", i, i+chunk);
        switch_banks();
        do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);

        block = (i >> 11) + offset;
        read_cd(block, (chunk + 0x7FF) >> 11, temp);
#ifndef BUF_TEST
        switch_banks();
#endif
        for (j = 0; j < chunk; ) {
            if (j + m68kchunk > chunk)
                m68kchunk = chunk - j;
#ifndef BUF_TEST
            do_md_cmd3(MD_CMD_CPY_MD, (intptr_t)rom_start+i+j, 0x200000+j, m68kchunk);
#else
            memcpy(buf+i+j, temp+j, m68kchunk);
#endif
            j += m68kchunk;
        }

        i += chunk;
    }

    strcpy(temp, "OK                                     ");
    switch_banks();
    do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);
}

void verify(char *temp)
{
    int i, j;
    int mismatch = 0;
    int length, offset, block;

    length = gDirTable[gCurrent].length;
    offset = gDirTable[gCurrent].offset;

    for (i = 0; i < length; )
    {
        int chunk = 0x10000;
        int m68kchunk = 0x4000;
        volatile char *temp2 = temp + 0x10000;

        if (i + chunk > length)
            chunk = length - i;

        sprintf(temp, "Verifying %07X-%07X\n", i, i+chunk);
        switch_banks();
        do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);

        block = (i >> 11) + offset;
        read_cd(block, (chunk + 0x7FF) >> 11, temp);

        switch_banks();

        for (j = 0; j < chunk; ) {
            if (j + m68kchunk > chunk)
                m68kchunk = chunk - j;

            do_md_cmd3(MD_CMD_CPY_MD, 0x200000+0x10000+j, (intptr_t)rom_start+i+j, m68kchunk);

            j += m68kchunk;
        }

        switch_banks();

        for (j = 0; j < chunk; j++)
        {
            if (temp[j] != temp2[j])
            {
                int c1 = temp[j]&0xff;
                int c2 = temp2[j]&0xff;
                mismatch = 1;
                sprintf(temp, "Mismatch %07X %02X/%02X  \n", i+j, c1, c2);
                switch_banks();
                do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);
                break;
            }
        }

        if (mismatch)
            break;

        i += chunk;
    }

    if (!mismatch)
    {
        strcpy(temp, "OK                                     ");
        switch_banks();
        do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);
    }
}

int main(void)
{
    int i, j;
    unsigned short buttons, changed, previous = 0;

    strcpy(temp, "ROM Player");
    switch_banks();
    do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_WHITE, 15, 1);

    init_cd(); // init CD
    set_cwd("/"); // set current directory to root
    gCount = getCurrDir();

    gStage = 0;

    while (1)
    {

        if (gStage == 0)
        {
 
            char *p = temp;

            // update display with directory entries
            memset(p, 0, 20*64*2);
            if (gCount)
                for (i = 0; i < 20; i++)
                {
                    if ((gFirst + i) >= gCount)
                        break;

                    p = &temp[i*64*2 + 2]; // left justified
                    if (gDirTable[gFirst + i].flags & 2)
                    {
                        // directory
                        *p++ = ((gFirst + i) == gCurrent) ? TEXT_WHITE >> 8 : TEXT_GREEN >> 8;
                        *p++ = '[' - 0x20;
                        for (j = 0; j < 36; j++)
                        {
                            if (gDirTable[gFirst + i].name[j] == '\0')
                                break;
                            *p++ = ((gFirst + i) == gCurrent) ? TEXT_WHITE >> 8 : TEXT_GREEN >> 8;
                            *p++ = gDirTable[gFirst + i].name[j] - 0x20;
                        }
                        *p++ = ((gFirst + i) == gCurrent) ? TEXT_WHITE >> 8 : TEXT_GREEN >> 8;
                        *p++ = ']' - 0x20;
                    }
                    else
                    {
                        for (j = 0; j < 38; j++)
                        {
                            if (gDirTable[gFirst + i].name[j] == '\0')
                                break;
                            *p++ = ((gFirst + i) == gCurrent) ? TEXT_WHITE >> 8 : TEXT_GREEN >> 8;
                            *p++ = gDirTable[gFirst + i].name[j] - 0x20;
                        }
                    }
                }
            switch_banks();
            sub_delay(1); // wait until vblank to update vram
            i = do_md_cmd3(MD_CMD_COPY_VRAM, 0xC000 + 3*64*2, 0x200000, 20*64); // update plane A name table (20 lines of text)
            if (i < 0)
            {
                if (i == -1)
                    strcpy(temp, "unknown command");
                else if (i == -2)
                    strcpy(temp, "wait cmd done timeout");
                else if (i == -3)
                    strcpy(temp, "wait cmd ack timeout");
                else
                    strcpy(temp, "unknown error");
                switch_banks();
                do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_RED, 1, 24);
                sub_delay(120);
                strcpy(temp, "                                       ");
                switch_banks();
                do_md_cmd4(MD_CMD_PUT_STR, 0x200000, TEXT_GREEN, 1, 24);
            }

            sub_delay(7);

            gStage = 1;

        } 
        else if (gStage == 1)
        {

            buttons = GET_PAD(0);

            changed = (buttons & SEGA_CTRL_BUTTONS) ^ previous;

            if (buttons & SEGA_CTRL_DOWN)
            {
                // DOWN pressed
                gCurrent++;
                if ((gCurrent - gFirst) >= 20)
                    gFirst = gCurrent;

                if (gCurrent >= gCount)
                    gFirst = gCurrent = 0; // wrap around to first entry

                gStage = 0;

            }

            if (buttons & SEGA_CTRL_UP)
            {

                // UP pressed
                gCurrent--;
                if (gCurrent < gFirst)
                {
                    gFirst = gCurrent - 19;
                    if (gFirst < 0)
                        gFirst = 0;
                }

                if (gCurrent < 0)
                {
                    gCurrent = gCount - 1; // wrap around to last entry
                    gFirst = gCurrent - 19;
                    if (gFirst < 0)
                        gFirst = 0;
                }

                gStage = 0;

            }

            if (!changed)
                continue; // no change in buttons
            previous = buttons & SEGA_CTRL_BUTTONS;

            if (changed & SEGA_CTRL_A)
            {
                if (!(buttons & SEGA_CTRL_A))
                {
                    // A just released
                    if (gDirTable[gCurrent].flags & 2)
                    {
                        // directory
                        global_vars->CWD_OFFSET = gDirTable[gCurrent].offset;
                        global_vars->CWD_LENGTH = gDirTable[gCurrent].length;
                        global_vars->CURR_OFFSET = -1;
                        first_dir_sec();
                        gCount = getCurrDir();
                        gFirst = gCurrent = 0;
                        gStage = 0;
                    }
                    else
                    {
                        transfer(temp);
                    }
                }
            }

            if (changed & SEGA_CTRL_B)
            {
                if (!(buttons & SEGA_CTRL_B))
                {
                    // B just released
                    if (gDirTable[gCurrent].flags & 2)
                    {
                        // directory
                    }
                    else
                    {
                        verify(temp);
                    }
                }
            }
        }
    
    }

    return 0;
}

