all: os.iso

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -m32 -c kernel.c -o kernel.o

kernel.bin: kernel.o linker.ld
	i386-elf-ld -T linker.ld -o kernel.bin --oformat binary kernel.o

os.img: boot.bin kernel.bin
	dd if=/dev/zero of=os.img bs=1024 count=1440
	dd if=boot.bin of=os.img conv=notrunc
	dd if=kernel.bin of=os.img bs=512 seek=1 conv=notrunc

os.iso: os.img
	mkisofs -o os.iso -b os.img os.img

run: os.iso
	qemu-system-i386 -cdrom os.iso

clean:
	rm -f *.bin *.o os.img os.iso
