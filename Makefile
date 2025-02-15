all: os

os: fboot.bin fkernel.bin fwriter.bin collect.asm
	fasm collect.asm os

fboot.bin fkernel.bin fwriter.bin: %.bin: %.asm
	fasm $^ $@

clean:
	rm -f *.bin *.elf os

run: os
	qemu-system-x86_64 -hda os
