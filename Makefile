


build-and-run:
	yasm -f elf64 -gdwarf2 cpsc-240-lab.asm -o cpsc-240-lab.o
	ld cpsc-240-lab.o -o my-program
	@echo "Done"



