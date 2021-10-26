

#
CC := gcc
CC_FLAGS := -Wall -m64 -gdwarf-2 -c
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2
LINKER := gcc
LINKER_FLAGS := -no-pie -m64


#
BIN_NAME := my-program
BIN := ./$(BIN_NAME)


#
default: run


#
run:	$(BIN)
	$(BIN)


#
debug:	$(BIN)
	gdb $(BIN) -x gdb-commands.txt


#
$(BIN):	main.o
	$(LINKER) $(LINKER_FLAGS) *.o *.so -o $@


#
main.o:	main.asm
	$(ASM) $(ASM_FLAGS) $< -o $@


#
clean:
	-rm *.o
	-rm $(BIN_NAME)


