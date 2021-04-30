CC	= c99
CFLAGS	= -m32 -nostdlib -nostdinc -fno-builtin -fno-pie -MD

OBJS	= kernel.o video.o

os.img: boot.bin kernel.bin
	dd if=boot.bin of=os.img bs=512 count=1 seek=0
	dd if=kernel.bin of=os.img bs=512 seek=1
	truncate -s 1440K os.img

boot.bin: boot.o
	ld -Ttext 0x7C00 --oformat=binary -o $@ $<
	chmod -x $@
kernel.bin: kernel.o video.o
	ld -Tkernel.ld -m elf_i386 -o $@ $(OBJS)
	chmod -x $@

%.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)
%.o: %.S
	$(CC) -o $@ -c $<

clean:
	rm -f *.o
	rm -f *.d
	rm -f *.bin
	rm -f *.img
test: os.img
	qemu-system-x86_64 -drive file=os.img,if=ide,index=0,format=raw
	make clean
