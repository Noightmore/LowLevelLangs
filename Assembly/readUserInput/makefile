readInput: readInput.o
	ld readInput.o -o readInput

readInput.o: readInput.asm
	nasm -f elf64 readInput.asm -o readInput.o

clean:
	rm readInput