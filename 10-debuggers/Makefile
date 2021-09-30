

#
CC := gcc
C_FLAGS := -Wall -m64 -gdwarf-2
ASM := yasm
ASM_FLAGS := -f elf64 -gdwarf2
LINKER := gcc
LINKER_FLAGS := -no-pie -m64 -gdwarf-2 


# Binary name (suffix a dash to support multiple names)
BIN_NAME := my-program-
BIN := ./$(BIN_NAME)


#
default: menu


#
menu:
	@echo
	@echo "***** Debugger Demo Menu *****"
	@echo
	@echo "make run1         ==> Build and execute the first demo"
	@echo "make run2         ==> Build and execute the second demo"
	@echo "make run3         ==> Build and execute the third demo"
	@echo
	@echo "make debug1       ==> Build and debug the first demo"
	@echo "make debug2       ==> Build and debug the second demo"
	@echo "make debug3       ==> Build and debug the third demo"
	@echo
	@echo "make clean        ==> Clean this repository"


#	Trying wildcards so all three programs can work with just one set of targets
run%:	$(BIN)%
	@echo "Running $@ ($<)"
	./$<
debug%:	$(BIN)%
	@echo "Debugging $@"
	gdb "$<" -x gdb-commands-$*.txt
$(BIN)%:	main%.o
	@echo "Linking $@"
	$(LINKER) $(LINKER_FLAGS) $< *.so -o $@
main%.o:	main%.asm
	@echo "Building $@"
	$(ASM) $(ASM_FLAGS) $< -o $@


#	Clean
clean:
	@echo "Cleaning"
	@-rm *.o
	@-rm $(BIN)*


# ".SECONDARY with no prerequisites causes all targets to be treated as secondary (i.e., no target is removed because it is considered intermediate)."
# https://www.gnu.org/software/make/manual/html_node/Special-Targets.html
.SECONDARY:




