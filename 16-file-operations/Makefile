

#
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2


#
LINKER := gcc
LINKER_FLAGS := -m64 -gdwarf-2 -std=c++17 -no-pie


#
BIN_NAME := my-program
BIN := ./$(BIN_NAME)


#
OUTFILE_NAME := out-file.txt
OUTFILE := ./$(CREATEME_FILE_NAME)


#
default: run


#
run:	build
	-rm $(OUTFILE)
	$(BIN)


#
build:	$(BIN)


#
$(BIN):	main.o
	$(LINKER) $^ $(LINKER_FLAGS) *.so -o "$@"


#
main.o:	main.asm
	$(ASM) $(ASM_FLAGS) $< -o "$@"


#
clean:
	-rm $(BIN)
	-rm $(OUTFILE)
	-rm *.o








