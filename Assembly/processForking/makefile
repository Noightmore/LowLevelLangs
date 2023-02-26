main: main.o
	ld ./out/main.o -o	./out/main

main.o: main.asm
	nasm -f elf64 main.asm -o ./out/main.o

clean:
	rm ./out/*