

#
CC := gcc
C_FLAGS := -Wall -m64 -gdwarf-2
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2
LINKER := gcc
LINKER_FLAGS := -no-pie -m64


#
BIN_NAME := my-program
BIN := ./$(BIN_NAME)


#
default: build-and-run


#
build-and-run:
	$(ASM) $(ASM_FLAGS) main.asm -o main.o
	$(LINKER) $(LINKER_FLAGS) *.o *.so -o $(BIN)
	$(BIN)



clean:
	-rm *.o


