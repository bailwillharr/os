os.img: bootloader.bin kernel.bin
	dd if=bootloader.bin of=os.img bs=512 count=1 seek=0
	dd if=kernel.bin of=os.img bs=512 count=16 seek=1
bootloader.bin: bootloader.o
	ld -o bootloader.bin bootloader.o -Ttext 0x7C00 --oformat=binary
	chmod -x bootloader.bin
kernel.bin: kernel.o
	ld -o kernel.bin kernel.o -Ttext 0x10000 --oformat=binary
	chmod -x kernel.bin
bootloader.o: bootloader.S
	as -o bootloader.o bootloader.S
kernel.o: kernel.S
	as -o kernel.o kernel.S
clean:
	rm -f *.o
	rm -f *.bin
	rm -f *.img
test: os.img
	qemu-system-x86_64 -drive file=os.img,if=ide,index=0,format=raw
install: os.img
	sudo dd if=os.img of=/dev/sdb bs=439 count=1
	sudo dd if=os.img of=/dev/sdb bs=512 seek=1 skip=1
	# preserves the MBR
