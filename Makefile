CC	= c99
CFLAGS	= -m32 -nostdlib -nostdinc -fno-builtin -fno-pie

SRCS	= $(wildcard *.c)

OBJS	= $(SRCS:.c=.o)

os.img: boot.bin kernel.bin
	dd if=boot.bin of=os.img bs=512 count=1 seek=0
	dd if=kernel.bin of=os.img bs=512 seek=1
	truncate -s 1440K os.img

boot.bin: boot.o
	ld -Tboot.ld -o $@ $^
	chmod -x $@
kernel.bin: $(OBJS)
	ld -Tkernel.ld -m elf_i386 -o $@ $(OBJS)
	chmod -x $@

%.o: %.c
	$(CC) -o $@ -c $^ $(CFLAGS)
%.o: %.S
	$(CC) -o $@ -c $^

clean:
	rm -f *.o
	rm -f *.d
	rm -f *.bin
	rm -f *.img
test: os.img
	qemu-system-x86_64 -drive file=os.img,if=ide,index=0,format=raw
