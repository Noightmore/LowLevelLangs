hello: hello.o
	ld	-m	elf_i386	hello.o	-o	hello

hello.o: hello.asm
	nasm -f elf32 hello.asm -o hello.o

clean:
	rm *.out hello