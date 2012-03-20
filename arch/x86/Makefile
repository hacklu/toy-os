all:
	gcc -Wall -nostdinc -fno-builtin -m32  -c -o b.out boot.S
	gcc -o b.exec b.out -m32 -Wl,--build-id=none -m32 -nostdlib -Wl,-N,-Ttext,0x0
	# -Wl,-Ttext,0x7C00 
	# -Wl,-Ttext,0x7C00 #-Wl,-N means not paged,not make text read-only
	objcopy -O binary --strip-unneeded b.exec b.img
.PHONY:all

clean:
	@rm -f a.out boot boot-* *.o *.out *.img *.d


test:
	gcc -Wall -W -nostdinc -fno-builtin -m32 -MD -c -o boot-hello-cppgp.o test.S
	gcc -o boot-hello-cppgp.exec boot-hello-cppgp.o -m32 -Wl,--build-id=none -m32 -nostdlib -Wl,-N  -Wl,-Ttext,0x7C00
	objcopy -O binary --strip-unneeded -R .note -R .comment -R .note.gnu.build-id -R .reginfo -R .rel.dyn boot-hello-cppgp.exec boot-hello-cppgp.img
