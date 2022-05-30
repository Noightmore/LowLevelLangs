hello: hello.o
	ld ./out/hello.o -o	./out/hello

hello.o: hello.asm
	nasm -f elf64 hello.asm -o ./out/hello.o

clean:
	rm ./out/*