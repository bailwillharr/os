CC	= c99
CFLAGS	= -m32 -nostdlib -nostdinc -fno-builtin -fno-pie -c
os.img: bootloader.bin kernel.bin
	dd if=bootloader.bin of=os.img bs=512 count=1 seek=0
	dd if=kernel.bin of=os.img bs=512 seek=1
	truncate -s 64K os.img
bootloader.bin: bootloader.o
	ld -o bootloader.bin -Ttext 0x7C00 --oformat=binary bootloader.o
	chmod -x bootloader.bin
kernel.bin: kernel.o video.o
	ld -Tlink.ld -m elf_i386 -o kernel.bin kernel.o video.o
	chmod -x kernel.bin
bootloader.o: bootloader.S
	$(CC) -c -o bootloader.o bootloader.S
kernel.o: kernel.c video.h
	$(CC) $(CFLAGS) -o kernel.o kernel.c
video.o: video.c video.h
	$(CC) $(CFLAGS) -o video.o video.c
clean:
	rm -f *.o
	rm -f *.bin
	rm -f *.img
test: os.img
	qemu-system-x86_64 -drive file=os.img,if=ide,index=0,format=raw
	make clean
install: os.img
	sudo dd if=os.img of=/dev/sdb bs=439 count=1
	sudo dd if=os.img of=/dev/sdb bs=512 seek=1 skip=1
	# preserves the MBR
