static void hello(void);

void _start(void)
{
	hello();
	asm volatile ("ljmpw $0,$0x500");
}

static void putc(char c)
{
	asm volatile ("mov $7, %%bl\n\t"
		      "mov $0xe, %%ah\n\t"
		      "int $0x10" :: "a"(c) : "ebx");
}

static void puts(const char *p)
{
	while (*p)
		putc(*p++);
}

static char getc(void)
{
	short tmp;
	asm volatile ("mov $0x10, %%ah\n\t"
		      "int $0x16" : "=A"(tmp));
	return tmp & 0xff;
}

static void hello(void)
{
	puts("hello world, press ESC to return to the kernel\n");
	while (getc() != 27)
		;
}
