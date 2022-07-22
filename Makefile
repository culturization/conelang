AS=nasm
ASFLAGS=-f elf64
LD=ld
LDFLAGS=

all: build

# Debug flags
debug: ASFLAGS += -F dwarf -g
debug: build

# Create executable
build:
	$(AS) src/conelang.asm $(ASFLAGS) -o bin/conelang.o
	$(LD) bin/conelang.o $(LDFLAGS) -o bin/conelang

# Clean bin folder
clean:
	rm -f bin/*
