all: os

os: fboot.bin fkernel.bin fwriter.bin hello.bin collect.asm
	fasm collect.asm os

fboot.bin fkernel.bin fwriter.bin: %.bin: %.asm
	fasm $^ $@

hello.bin: %.bin: %.elf
	objcopy -O binary $^ $@

%.elf: %.c
	gcc -nostartfiles -nostdlib -ffreestanding -Ttext=0x700 -static -fno-PIE -m16 -Wl,--build-id=none $^ -o $@

clean:
	rm -f *.bin *.elf os

run: os
	qemu-system-x86_64 -hda os
