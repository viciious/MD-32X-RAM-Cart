ifdef $(GENDEV)
ROOTDIR = $(GENDEV)
else
ROOTDIR = /opt/toolchains/sega
endif

LDSCRIPTSDIR = $(ROOTDIR)/ldscripts

BOOTBLOCKDIR = $(ROOTDIR)/bootblocks
BOOTBLOCK = $(BOOTBLOCKDIR)/US_BOOT.BIN
#BOOTBLOCK = $(BOOTBLOCKDIR)/EU_BOOT.BIN
#BOOTBLOCK = $(BOOTBLOCKDIR)/JP_BOOT.BIN

LIBPATH = -L$(ROOTDIR)/m68k-elf/lib -L$(ROOTDIR)/m68k-elf/lib/gcc/m68k-elf/4.6.2 -L$(ROOTDIR)/m68k-elf/m68k-elf/lib
INCPATH = -I. -I../include -I$(ROOTDIR)/m68k-elf/include -I$(ROOTDIR)/m68k-elf/m68k-elf/include

CCFLAGS = -m68000 -Wall -O1 -c -fomit-frame-pointer
HWFLAGS = -m68000 -Wall -O1 -c -fomit-frame-pointer
LDFLAGS = -T $(LDSCRIPTSDIR)/cd.ld -Wl,-Map=output.map -nostdlib
ASFLAGS = -m68000 --register-prefix-optional

PREFIX = $(ROOTDIR)/m68k-elf/bin/m68k-elf-
CC = $(PREFIX)gcc
AS = $(PREFIX)as
LD = $(PREFIX)ld
OBJC = $(PREFIX)objcopy

ASMZ80 = $(ROOTDIR)/bin/zasm
FLAGSZ80 = -vb2

DD = dd
RM = rm -rf

TARGET = CDROMPlayer
LIBS = $(LIBPATH) -lc -lgcc -lnosys
OBJS = crt0.o main.o hw_md.o
FILES =

all: $(TARGET).bin

$(TARGET).bin: $(TARGET).elf
	$(OBJC) -O binary $< temp.bin
	$(DD) if=temp.bin of=$@ bs=2048 conv=sync

$(TARGET).elf: $(OBJS) $(FILES)
	$(CC) $(LDFLAGS) $(OBJS) $(LIBS) $(FILES) -o $(TARGET).elf

%.o80: %.s80
	$(ASMZ80) $(FLAGSZ80) -o $@ $<

%.o: %.c
	$(CC) $(CCFLAGS) $(INCPATH) $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $(INCPATH) $< -o $@

cd: $(TARGET).bin
	mkdir -p cd
	mkdir -p cd/ROMs
	cp $(TARGET).bin cd/APP.BIN
	cp -r ROMs/* cd/ROMs/
	genisoimage -sysid "SEGA SEGACD" -volid "CDROMPLAYER" -generic-boot $(BOOTBLOCK) -full-iso9660-filenames -o $(TARGET).iso cd

clean:
	$(RM) *.o *.o80 *.bin *.elf *.map *.log *.iso cd
